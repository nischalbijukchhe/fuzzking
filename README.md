```markdown
# FFUF Fuzzing Toolkit

**Made by NEPAX - Thanks to [COFFIN](https://x.com/coffinxp7)!**

This Bash script serves as a menu-driven wrapper for [ffuf](https://github.com/ffuf/ffuf) (Fuzz Faster U Fool), streamlining various web fuzzing techniques into one easy-to-use tool. It automatically checks for `ffuf` installation, installs it if necessary, and then provides a range of fuzzing options to suit your testing needs.

---

## Features

- **Automatic ffuf Installation:**  
  Checks if `ffuf` is installed. If not, it installs the latest version using Go.
  
- **Comprehensive Fuzzing Options:**  
  Offers 21 different fuzzing modes, including:
  - Directory/File Brute Force
  - POST Request Fuzzing
  - Case Insensitive Search
  - File Extension Fuzzing
  - Recursive Fuzzing
  - Subdomain Fuzzing
  - Virtual Host Fuzzing
  - Fuzzing GET and POST Parameters
  - Login Bypass Fuzzing
  - PUT Request Fuzzing
  - Clusterbomb and Pitchfork Attacks
  - Setting Cookies, Using Proxies, Custom Header Fuzzing, Custom User-Agent Fuzzing, Rate Limiting Bypass
  - Output results in HTML, JSON, or CSV formats

---

## Requirements

- **Bash:** The script is written in Bash.
- **Go:** Needed for installing `ffuf` if it is not already present.
- **ffuf:** [Fuzz Faster U Fool](https://github.com/ffuf/ffuf) (the script will auto-install it if missing).
- **Wordlists:** Custom wordlists for directories, files, usernames, passwords, etc., based on your testing requirements.

---

## Installation

1. **Clone or Download the Repository:**
   ```bash
   git clone https://github.com/nischalbijukchhe/fuzzking.git
   cd fuzzking
   ```

2. **Make the Script Executable:**
   ```bash
   chmod +x fuzzking.sh
   ```

3. **Ensure Go is Installed:**  
   Verify that Go is installed on your system as it is required for installing `ffuf`.  
   [Download Go](https://golang.org/dl/)

---

## Usage

Run the script from your terminal:
```bash
./fuzzking.sh
```

### What to Expect

- **Initial Check:**  
  The script will check if `ffuf` is installed. If not, it will install it and update your PATH accordingly.

- **Interactive Menu:**  
  A menu displaying 21 fuzzing options will be shown. Each option represents a different fuzzing mode, from simple directory brute forcing to complex attack modes like clusterbomb and pitchfork.

- **User Prompts:**  
  You will be prompted to enter:
  - A number corresponding to the desired fuzzing option.
  - The target domain (e.g., `https://example.com`).
  - The path to your main wordlist.
  - Additional inputs for options such as username/password wordlists, cookies, or proxy settings.
  - Your choice of HTTP status codes to match during fuzzing.

- **Execution:**  
  The script constructs and runs the appropriate `ffuf` command based on your selections.

---

## Fuzzing Options Overview

1. **Directory/File Brute Force:**  
   Scans for hidden directories or files.
2. **POST Request Fuzzing:**  
   Fuzzes endpoints using POST requests.
3. **Case Insensitive Search:**  
   Performs a case insensitive search.
4. **File Extension Fuzzing:**  
   Tries common file extensions (e.g., `.php`, `.bak`, `.db`, `.asp`).
5. **Recursive Fuzzing:**  
   Automatically recurses into discovered directories.
6. **Subdomain Fuzzing:**  
   Discovers subdomains by fuzzing the URL.
7. **Virtual Host Fuzzing:**  
   Tests virtual host configurations.
8. **Fuzzing GET Parameters:**  
   Fuzzes query parameters in GET requests.
9. **Fuzzing POST Parameters:**  
   Fuzzes data fields in POST requests.
10. **Login Bypass Fuzzing:**  
    Attempts login bypass using provided username and password wordlists.
11. **PUT Request Fuzzing:**  
    Fuzzes endpoints with PUT requests using cookie-based authentication.
12. **Clusterbomb Attack:**  
    Combines multiple wordlists to perform a clusterbomb attack.
13. **Pitchfork Attack:**  
    Utilizes parallel wordlists for a pitchfork attack.
14. **Setting Cookies:**  
    Uses custom cookies during fuzzing.
15. **Using Proxies:**  
    Routes requests through a proxy server.
16. **Custom Header Fuzzing:**  
    Injects custom HTTP headers into requests.
17. **Fuzzing with Custom User-Agent:**  
    Fuzzes with a specified User-Agent string.
18. **Rate Limiting Bypass:**  
    Adjusts rate and concurrency to bypass rate limiting.
19. **Output to HTML:**  
    Saves results in HTML format.
20. **Output to JSON:**  
    Saves results in JSON format.
21. **Output to CSV:**  
    Saves results in CSV format.

---

## Customization

- **Adjust Base Parameters:**  
  The script uses base flags (e.g., `-t 50` for threading). You can modify these settings directly in the script to suit your testing environment.

---

## Credits

- **NEPAX:** Author of the script.
- **LOSTSEC:** Special thanks for inspiration and amazing article you can find on his [MEDIUM](https://osintteam.blog/ffuf-mastery-the-ultimate-web-fuzzing-guide-f7755c396b92).

---

## Disclaimer

This tool is intended solely for authorized security testing and research purposes. Unauthorized testing or scanning of networks or systems without explicit permission is illegal and unethical. Use responsibly and at your own risk.

---

## License

This project is licensed under the MIT License.
```
