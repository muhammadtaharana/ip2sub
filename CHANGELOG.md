# Changelog

All notable changes to this project will be documented in this file.

## [1.1.0] - 2026-05-06

### Fixed
- **DNS parsing errors**: Fixed issue where DNS error messages and comment lines were being treated as valid hostnames
  - Added filtering to exclude DNS comment lines starting with `;`
  - Implemented regex validation pattern `^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$` to ensure only valid domain names are processed
  - Added stderr suppression (`2>/dev/null`) to `dig` command
  - Prevents garbage output like ";;", "communications error", "timed out" from being checked against IPs

### Changed
- Improved hostname extraction robustness by validating domain format before processing

## [1.0.0] - Initial Release

### Added
- Autonomous IP scanning for origin server discovery
- Reverse DNS (PTR record) harvesting
- SSL Certificate Subject Alternative Name extraction
- WAF detection using wafw00f
- Origin IP identification via HTTP status codes and Host header spoofing
- Stealth jitter between requests
- Results logging to origin_results.txt
