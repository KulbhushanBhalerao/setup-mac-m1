#!/bin/bash

echo "🔍 Scanning installed applications for Intel-based (x86_64) binaries..."

# Define locations to scan
APP_LOCATIONS=(
  "/Applications"
  "/usr/local/bin"
)

# Temp file for results
RESULTS_FILE="/tmp/intel_apps.txt"
> "$RESULTS_FILE"

# Function to check binary architecture
check_arch() {
  local file="$1"
  if [ -f "$file" ] && lipo -archs "$file" 2>/dev/null | grep -q "x86_64"; then
    echo "❌ Intel-based app found: $file" | tee -a "$RESULTS_FILE"
  fi
}

# Scan application directories
for dir in "${APP_LOCATIONS[@]}"; do
  echo "📂 Checking $dir..."
  find "$dir" -type f -perm +111 -exec bash -c 'check_arch "$0"' {} \;
done

# Summary
if [ -s "$RESULTS_FILE" ]; then
  echo -e "\n⚠️ The following Intel-based applications were found:"
  cat "$RESULTS_FILE"
  echo -e "\n🔹 Consider reinstalling them with their Apple Silicon versions."
else
  echo -e "\n✅ No Intel-based applications found. Your system is optimized!"
fi

# Cleanup
rm -f "$RESULTS_FILE"
