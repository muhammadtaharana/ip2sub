<p align="center">
  <img src="https://i.imgur.com/your-terminal-screenshot.png" alt="output" width="800">
</p>

</br>
</br>

> [!TIP]
> **Operational Guidance:**
>
> - Feed this tool with massive lists of IPs harvested from Shodan or Censys for optimal results in bug bounty hunting.
> - Ensure you have `wafw00f` and `dig` installed in your environment before running the scan.
> - Adjust the `sleep` duration in Phase III if you detect aggressive blocking from your scanning source.

</br>
</br>

### TO-DO

* [ ] Add multi-threading support for parallel processing of IP lists.
* [ ] Integrate automated Shodan/Censys lookup for potential origin IPs.
* [ ] Add automated screenshots of confirmed origin endpoints.

</br>
</br>

> [!CAUTION]
> **Use Origin Mapper only on assets you have explicit permission to test. Unauthorized bypassing of security measures is strictly prohibited. The authors and project accept no responsibility for misuse of this tool.**

---

### **Generated Banner Image**

<p align="center">
  <img src="https://i.imgur.com/your-generated-banner.png" alt="GeneratedHere is the professional `README.md` for the provided tool, followed by the requested banner image.

---

### **Origin Mapper (ip2sub)**

<p align="center">
  <img src="https://i.imgur.com/G5iM8B4.png" alt="banner" width="600">
</p>

> [!NOTE]
> **Origin Mapper** is an autonomous intelligence tool designed to bypass Cloud WAF/CDN services by identifying a domain's real **Origin IP address** via passive SSL examination, forced HTTP status checks, and stealthy WAF detection.

</br>
</br>

### Features

* **Autonomous Discovery:** Automatically harvests potential hostnames associated with an IP via Reverse DNS (PTR records).
* **SSL/TLS SAN Extraction:** Robustly extracts Subject Alternative Names from SSL certificates, identifying all domains the server intends to host.
* **WAF Bypass Verification:** Uses `wafw00f` to passively verify if the identified IP is a protected CDN/Proxy edge or the direct backend origin.
* **HTTP Force Checking:** Validates the association between the IP and extracted domains by forcing the `Host` header via HTTPS.
* **Built-in Stealth:** Features adjustable jitter and custom User-Agents to remain undetected during large-scale scans.

</br>
</br>

### Installation

Clone the repository and ensure the script `origin_mapper.sh` has execution permissions:
```bash
git clone [https://github.com/muhammadtaharana/ip2sub](https://github.com/muhammadtaharana/ip2sub)
cd ip2sub
chmod +x ip2sub.sh
```

</br>
</br>

### Execution Workflow

The script operates in a three-phase detection cycle for every IP address input:

| Phase | Description |
| :--- | :--- |
| **I: Harvesting** | Pulls domains from Reverse DNS (PTR) and the SSL Certificate (SAN). |
| **II: Validation** | Executes a `curl` request, forcing the Host header, looking for 200/300 status codes. |
| **III: Verification** | If successful, runs `wafw00f` to confirm the target is unprotected by a Cloud WAF. |

</br>
</br>

### Usage Examples

- ###### Run the mapper on a list of IPs
```bash
./ip2sub.sh ips.txt
```

- ###### Map results and count hits
```bash
./ip2sub.sh raw_ips.txt && wc -l origin_results.txt
```

</br>
</br>

### Output Structure

Confirmed Origin IPs are saved to `origin_results.txt` in the following format:

```text
[!] 93.184.216.34 is the ORIGIN for example.com (Status: 200)
[!] 1.1.1.1 is the ORIGIN for one.one.one.one (Status: 301)
```

Terminal output is color-coded to highlight successful matches:

<p align="center">
  <img src="https://i.imgur.com/your-terminal-screenshot.png" alt="output" width="800">
</p>

</br>
</br>

> [!TIP]
> **Operational Guidance:**
>
> - Feed this tool with massive lists of IPs harvested from Shodan or Censys for optimal results in bug bounty hunting.
> - Ensure you have `wafw00f` and `dig` installed in your environment before running the scan.
> - Adjust the `sleep` duration in Phase III if you detect aggressive blocking from your scanning source.

</br>
</br>

### TO-DO

* [ ] Add multi-threading support for parallel processing of IP lists.
* [ ] Integrate automated Shodan/Censys lookup for potential origin IPs.
* [ ] Add automated screenshots of confirmed origin endpoints.

</br>
</br>

> [!CAUTION]
> **Use Origin Mapper only on assets you have explicit permission to test. Unauthorized bypassing of security measures is strictly prohibited. The authors and project accept no responsibility for misuse of this tool.**

---

### **Generated Banner Image**

<p align="center">
  <img src="https://i.imgur.com/your-generated-banner.png" alt="Generated Banner" width="600">
</p>

This banner matches the requested pixelated, dark-mode aesthetic.
```
