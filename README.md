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
</br>

### 6. TO-DO

* [ ] Add JSON output format for easier integration with other tools.
* [ ] Implement CIDR range expansion for scanning entire subnets.
* [ ] Add support for custom User-Agent lists.

</br>
</br>

</br>
</br>

### 1. Features

* **SSL SAN Extraction:** Automatically harvests all domains hosted on a server by parsing Subject Alternative Names from the SSL certificate[cite: 2].
* **Reverse DNS Intelligence:** Leverages `dig` to pull PTR records and identify server ownership[cite: 2].
* **WAF Verification:** Integrates with `wafw00f` to confirm if a target IP is a direct origin or a protected edge server[cite: 2].
* **Stealth Jitter:** Implements randomized sleep intervals between requests to evade behavioral detection[cite: 2].

</br>
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
</br>

### 3. Logic Flow

The engine processes each IP through a sequential verification pipeline[cite: 2]:

1.  **Harvesting:** Pulls hostnames from Reverse DNS and SSL certificates[cite: 2].
2.  **Association Check:** Attempts to access the IP using forced `Host` headers[cite: 2].
3.  **WAF Analysis:** Checks the identified IP for the presence of a Firewall[cite: 2].
4.  **Reporting:** Logs confirmed Origin-to-Domain mappings to a results file[cite: 2].

</br>
</br>

### 4. Usage

To begin the discovery process, provide a file containing a list of target IP addresses:

```bash
./ip2sub.sh ips.txt
```

</br>
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
</br>

> [!TIP]
> **Scanning Tip:**
>
> - Use this tool after harvesting potential IP ranges from Shodan, Censys, or FOFA.
> - Ensure `openssl`, `dig`, and `wafw00f` are installed and available in your PATH.
> - If you receive too many "No Response" errors, consider increasing the `timeout` value in the `openssl` command.

</br>
</br>

### 6. TO-DO

* [ ] Add JSON output format for easier integration with other tools.
* [ ] Implement CIDR range expansion for scanning entire subnets.
* [ ] Add support for custom User-Agent lists.

</br>
</br>

> [!CAUTION]
> **Use Origin Mapper only on assets you have explicit permission to test. Unauthorized scanning or bypassing of security controls is strictly prohibited. The authors are not responsible for any misuse.**