# setup-mac-m1
Recently migrated my 2019 intel based mac to arm based m1 and created this repo to recreate everything from scratch. Of course generated scripts using genai. 


## setup-macm1-brew-apps-item-zsh.sh
This will work on intel based (macbook 2018, 2019) and arm based. It installs basic apps for a developer working in kubernetes, devops, platform engineering. 
It installs lots of utilities and starting with OS upgrade and brew install. 
Then installs via brew all the packages. (You can check the script and remove most of them if not needed) 
Then installs items2 terminal and zsh. 
For normal default terminal it installs starship. 

## check_intel_apps.sh

This script will:
✅ Scan all installed applications in /Applications and /usr/local/bin.
✅ Detect if they are Intel (x86_64) only.
✅ List which apps need to be replaced with Apple Silicon versions.


How to Use the Script
Save the script as check_intel_apps.sh:

vi check_intel_apps.sh

Give execution permission:

chmod +x check_intel_apps.sh

Run the script:

./check_intel_apps.sh

🔍 Example Output

🔍 Scanning installed applications for Intel-based (x86_64) binaries...
📂 Checking /Applications...
❌ Intel-based app found: /Applications/Postman.app/Contents/MacOS/Postman
❌ Intel-based app found: /Applications/Docker.app/Contents/MacOS/Docker
📂 Checking /usr/local/bin...

⚠️ The following Intel-based applications were found:
❌ /Applications/Postman.app/Contents/MacOS/Postman
❌ /Applications/Docker.app/Contents/MacOS/Docker

🔹 Consider reinstalling them with their Apple Silicon versions.
✅ What to Do Next?
🔹 If any Intel-based apps are detected, manually download their Apple Silicon versions from their official websites.
🔹 If an app is universal (shows both arm64 x86_64), it’s fine.
🔹 If unsure, you can delete the app and reinstall using Homebrew or official sources.
