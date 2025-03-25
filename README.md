# Setup Mac M1

This repository was created to document the process of migrating from a 2019 Intel-based Mac to an ARM-based M1 Mac. It includes scripts and instructions to recreate the setup from scratch, with some scripts generated using GenAI.

---

## Scripts Overview

### `export-app-setting.sh`

This script exports all the homebrew apps into brewfile, exports zsh customizations and generate scripts to be run and install and configure all of this onto a new mac. It does not matter which hardware arch is on the target mac. It will work

To run, 
chmod +x export-app-setting.sh
In migrate-apps folder it will generate all the files

Transfer the folder ./migrate-apps to your new MacBook and run ./migrate-apps/setup-new-mac.sh to set it up.
Get rid of formulae which you do not need. 

---

### `check_intel_apps.sh`

This script helps identify Intel-based (x86_64) applications on your system and suggests replacing them with Apple Silicon versions.

#### Features:
- ✅ Scans all installed applications in `/Applications` and `/usr/local/bin`.
- ✅ Detects Intel-only binaries.
- ✅ Lists applications that need to be replaced with Apple Silicon versions.

#### How to Use:
1. Save the script as `check_intel_apps.sh`:
    ```bash
    vi check_intel_apps.sh
    ```
2. Grant execution permission:
    ```bash
    chmod +x check_intel_apps.sh
    ```
3. Run the script:
    ```bash
    ./check_intel_apps.sh
    ```

#### Example Output:
```plaintext
🔍 Scanning installed applications for Intel-based (x86_64) binaries...
📂 Checking /Applications...
❌ Intel-based app found: /Applications/Postman.app/Contents/MacOS/Postman
❌ Intel-based app found: /Applications/Docker.app/Contents/MacOS/Docker
📂 Checking /usr/local/bin...

⚠️ The following Intel-based applications were found:
❌ /Applications/Postman.app/Contents/MacOS/Postman
❌ /Applications/Docker.app/Contents/MacOS/Docker
```

#### Next Steps:
- 🔹 Manually download Apple Silicon versions of the detected Intel-based apps from their official websites.
- 🔹 Universal apps (showing both `arm64` and `x86_64`) are fine to use.
- 🔹 If unsure, delete the app and reinstall it using Homebrew or official sources.

---
