#!/bin/bash

gitRepoRootDir="$(git rev-parse --show-toplevel)"  # Git repo root
filesToConcatDir="${gitRepoRootDir}/goblinscript" # default script folder

# Check if an argument is provided
if [ "$#" -eq 1 ]; then
  # Assign the first argument to a variable
  filesToConcatDir="${gitRepoRootDir}/$1"
fi

manifestFile="${gitRepoRootDir}/manifest.md"
output_file="${gitRepoRootDir}/100_GoblinGPT_FULL.md"
headerFilePattern='00*Header.md'
headerFile=$(find "${filesToConcatDir}" -name "$headerFilePattern" -print -quit)

# Generate manifest
{
  echo "| Active Files | Size (bytes) |"
  echo "| :--------------------------------------- | :----------- |"

  # Iterate over files to create manifest entries
  for file in "${filesToConcatDir}"/*; do
    if [[ -f "$file" && "$file" != "$output_file" ]]; then
      filename=$(basename "$file")
      filesize=$(wc -c <"$file" | tr -d ' ')
      echo "| $filename | $filesize |"
    fi
  done
} > "$manifestFile"

# Insert manifest into the header file
headerWithManifest=$(mktemp)
{
  while IFS= read -r line; do
    # Check for the placeholder line to insert the manifest
    if [[ "$line" == *"{INSERT_MANIFEST_HERE}"* ]]; then
      cat "$manifestFile"
    else
      echo "$line"
    fi
  done < "$headerFile"
} > "$headerWithManifest"

# Combine files
{
  cat "$headerWithManifest"
  for file in "${filesToConcatDir}"/*; do
    if [[ -f "$file" && "$file" != "$output_file" && "$file" != "$headerFile" ]]; then
      cat "$file"
      echo
    fi
  done
} > "$output_file"

# Clean up temporary files
rm "$headerWithManifest"

echo "GoblinScript files were compiled to: $output_file"
