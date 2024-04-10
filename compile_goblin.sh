#!/bin/bash

# Init vars
manifest="manifest.md"
output_file="compiled_goblingpt.md"
max_length=0
files=()

# Document Body
echo "# 👹 Prompt Start \n\n" > "$output_file"

for file in ./"Experimental GoblinGPT Packs"/*; do
  if [[ -f "$file" ]]; then
  filename=$(basename "$file")
    echo "<--👹FILE: $filename-->\n\n" >> "$output_file"
    
    cat "$file" >> "$output_file"
    echo "" >> "$output_file" 

    filename=$(basename "$file")
    files+=("$filename")
    length=${#filename}
    if [[ $length -gt $max_length ]]; then
      max_length=$length
    fi
  fi
done

echo "GoblinScript was succesfully compiled to: $output_file"

# Header
echo "| Active Modules $(printf '%.s-' $(seq 1 $max_length)) |" > "$manifest"
echo "| :------------- $(printf '%.s-' $(seq 1 $max_length)) |" >> "$manifest"

Add filenames to the table
for filename in "${files[@]}"; do
 echo "| $filename |" >> "$manifest"
done

awk -v manifest_content="$(cat "$manifest")" '/{{\$Manifest}}/ {print manifest_content; next} 1' "$header_file" > "updated_header.md"

echo "File manifest inserted into: updated_header.md"
