#!/bin/bash

# Usage: ./origin_mapper.sh ips.txt
IP_LIST=$1
OUTPUT="origin_results.txt"

# Stealth & Config
USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"

if [[ ! -f "$IP_LIST" ]]; then
    echo "❌ Usage: $0 <ips.txt>"
    exit 1
fi

echo "🕶️ Starting Autonomous Discovery..."
echo "------------------------------------------------"

while read -r ip; do
    echo -e "\n🌐 [Scanning IP: $ip]"
    
    # 1. Pull Hostnames from Reverse DNS and SSL Certificate
    echo "   [*] Harvesting hostnames..."
    
    # Get PTR record
    PTR=$(dig +short -x "$ip" | sed 's/\.$//')
    
    # Extract domains from SSL Certificate (Subject Alternative Names)
    # This is the most reliable way to see what the server is supposed to host
    SANS=$(timeout 5 openssl s_client -connect "${ip}:443" -servername "$ip" < /dev/null 2>/dev/null | \
           openssl x509 -noout -text 2>/dev/null | \
           grep -A1 "Subject Alternative Name" | tail -n1 | \
           sed 's/DNS://g; s/,//g; s/[[:space:]]\+/\n/g' | grep "\.")

    # Combine all found names into a unique list
    FOUND_NAMES=$(echo -e "$PTR\n$SANS" | sort -u | grep -v "^$")

    if [[ -z "$FOUND_NAMES" ]]; then
        echo "   [-] No hostnames found for this IP."
        continue
    fi

    for name in $FOUND_NAMES; do
        echo -n "   [*] Checking association with $name... "

        # 2. Check if the IP serves this domain and if a WAF is present
        # We look for a 200/300 status code when forcing the Host header
        HTTP_STATUS=$(curl -skL -o /dev/null -w "%{http_code}" -H "Host: $name" -A "$USER_AGENT" --max-time 5 "https://$ip")

        if [[ "$HTTP_STATUS" == "200" || "$HTTP_STATUS" == "301" || "$HTTP_STATUS" == "302" ]]; then
            
            # 3. WAF Check (Stealthy/Passive)
            # If the IP responds with the site but wafw00f says it's clear, it's an Origin IP
            WAF_RES=$(wafw00f "$ip" 2>/dev/null | grep -i "is behind")
            
            if [[ -z "$WAF_RES" ]]; then
                echo -e "\e[32m[ORIGIN FOUND]\e[0m"
                echo "[!] $ip is the ORIGIN for $name (Status: $HTTP_STATUS)" | tee -a "$OUTPUT"
            else
                echo "[WAF PROTECTED]"
            fi
        else
            echo "[No Response]"
        fi
        
        # Stealth jitter
        sleep $((RANDOM % 3 + 1))
    done

done < "$IP_LIST"
