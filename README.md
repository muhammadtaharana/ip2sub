<p align="center">
<img width="1024" height="484" alt="image" src="https://github.com/user-attachments/assets/26980094-0ec6-439d-832f-eec2503dc851" />
</p>
</br>

> [!NOTE]
> **Origin Mapper** is a high-stealth reconnaissance tool designed to unmask the real backend servers (Origin IPs) behind Cloud WAFs and CDNs by correlating IP addresses with SSL certificates and DNS records.

> [!TIP]
> **Scanning Tip:**
>
> - Use this tool after harvesting potential IP ranges from Shodan, Censys, or FOFA.
> - Ensure `openssl`, `dig`, and `wafw00f` are installed and available in your PATH.
> - If you receive too many "No Response" errors, consider increasing the `timeout` value in the `openssl` command.

> [!CAUTION]
> **Use Origin Mapper only on assets you have explicit permission to test. Unauthorized scanning or bypassing of security controls is strictly prohibited. The authors are not responsible for any misuse.**## Origin Mapper (ip2sub)

</br>

### 1. Features

* **SSL SAN Extraction:** Automatically harvests all domains hosted on a server by parsing Subject Alternative Names from the SSL certificate[cite: 2].
* **Reverse DNS Intelligence:** Leverages `dig` to pull PTR records and identify server ownership[cite: 2].
* **WAF Verification:** Integrates with `wafw00f` to confirm if a target IP is a direct origin or a protected edge server[cite: 2].
* **Stealth Jitter:** Implements randomized sleep intervals between requests to evade behavioral detection[cite: 2].

</br>

### 2. Installation
```bash
# Clone the repository
git clone https://github.com/muhammadtaharana/ip2sub

# Navigate to the directory
cd ip2sub

# Grant execution permissions
chmod +x ip2sub.sh
```

</br>

### 3. Logic Flow

The engine processes each IP through a sequential verification pipeline[cite: 2]:

1.  **Harvesting:** Pulls hostnames from Reverse DNS and SSL certificates[cite: 2].
2.  **Association Check:** Attempts to access the IP using forced `Host` headers[cite: 2].
3.  **WAF Analysis:** Checks the identified IP for the presence of a Firewall[cite: 2].
4.  **Reporting:** Logs confirmed Origin-to-Domain mappings to a results file[cite: 2].

</br>

### 4. Usage

To begin the discovery process, provide a file containing a list of target IP addresses:

```bash
./ip2sub.sh ips.txt
```

Where `ips.txt` is a newline-separated list of IP addresses to scan. The script will output findings in real-time and save them to `origin_results.txt` for later review.
</br>

### 5. Output structure

Results are streamed to the terminal in real-time and saved to `origin_results.txt` for further analysis[cite: 2]:

```text
🌐 [Scanning IP: 1.2.3.4]
    [*] Harvesting hostnames...
    [*] Checking association with target.com... [ORIGIN FOUND]
[!] 1.2.3.4 is the ORIGIN for target.com (Status: 200)
```

</br>

> [!TIP]
> **Scanning Tip:**
>
> - Use this tool after harvesting potential IP ranges from Shodan, Censys, or FOFA.
> - Ensure `openssl`, `dig`, and `wafw00f` are installed and available in your PATH.
> - If you receive too many "No Response" errors, consider increasing the `timeout` value in the `openssl` command.

</br>

### 6. Future Enhancements.

* [ ] Add JSON output format for easier integration with other tools.
* [ ] Implement CIDR range expansion for scanning entire subnets.
* [ ] Add support for custom User-Agent lists.
* [ ] Implement concurrent scanning for faster processing of large IP lists.
* [ ] Add IPv6 support for next-generation IP scanning.
* [ ] Export results in multiple formats (CSV, XML, JSON Lines).
* [ ] Implement caching mechanism to avoid re-scanning known IPs.
* [ ] Add verbosity levels for detailed logging and debugging.
* [ ] Integrate with Shodan/Censys API for automatic IP harvesting.
* [ ] Proxy/VPN detection for identified origin servers.
* [ ] Add performance metrics and scanning statistics reporting.
* [ ] Create a configuration file for customizable scan parameters.
* [ ] Implement retry logic for failed requests with exponential backoff.
* [ ] Add support for scanning from a list of CIDR ranges.
* [ ] Geolocation mapping and geographic clustering of origin servers.
* [ ] ASN enumeration and network topology reconstruction.
* [ ] Historical DNS records retrieval and analysis (Certificate Transparency logs).
* [ ] SSL/TLS certificate chain analysis and historical tracking.
* [ ] Technology stack fingerprinting (CMS, frameworks, server software).
* [ ] Aggressive port scanning and service enumeration on discovered origins.
* [ ] Subdomain enumeration via certificate transparency and DNS brute-forcing.
* [ ] DNS zone transfer attempts (AXFR/IXFR).
* [ ] WHOIS data extraction and registrant correlation.
* [ ] Threat intelligence integration (Shodan, Censys, URLhaus, etc.).
* [ ] Real-time malware/reputation checking via VirusTotal API.
* [ ] Email harvesting from certificate transparency logs.
* [ ] GitHub repository discovery from certificate transparency emails.
* [ ] Hidden API endpoint discovery and mapping.
* [ ] Advanced rate limiting evasion and anti-bot bypass techniques.
* [ ] Session hijacking vector detection and cookie analysis.
* [ ] DNS tunneling and covert channel detection.
* [ ] BGP hijacking and route anomaly detection.
* [ ] Autonomous System (AS) graph visualization and traversal.
* [ ] Certificate pinning bypass analysis and detection.
* [ ] Distributed scanning network support for massive scale.
* [ ] Machine learning-based anomaly detection for origin identification.
* [ ] Real-time threat feed integration (abuse.ch, alienvault, etc.).
* [ ] Botnet C&C detection on discovered IPs.
* [ ] Compromised credential checking (Have I Been Pwned integration).
* [ ] HTTP/2 and HTTP/3 protocol analysis and fingerprinting.
* [ ] TLS fingerprinting and JA3 hash correlation.
* [ ] WAF bypass technique library and exploitation.
* [ ] Reverse proxy detection and header analysis.
* [ ] CDN evasion and de-anonymization techniques.
* [ ] Network timing analysis for origin detection.

</br>

> [!CAUTION]
> **Use Origin Mapper only on assets you have explicit permission to test. Unauthorized scanning or bypassing of security controls is strictly prohibited. The authors are not responsible for any misuse.**