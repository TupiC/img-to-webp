#!/bin/bash

OUTPUT_FOLDER="/output"

find /input -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.bmp" -o -iname "*.tiff" -o -iname "*.tif" \) | while read IMAGE; do
    [ -e "$IMAGE" ] || continue

    RELATIVE_PATH="${IMAGE#/input/}"
    OUTPUT_PATH="$OUTPUT_FOLDER/$(dirname "$RELATIVE_PATH")"
    FILENAME=$(basename "$IMAGE")
    BASENAME="${FILENAME%.*}"

    mkdir -p "$OUTPUT_PATH"
    cwebp -q 80 "$IMAGE" -o "$OUTPUT_PATH/$BASENAME.webp"

    if [ $? -eq 0 ]; then
        echo "Converted: $IMAGE -> $OUTPUT_PATH/$BASENAME.webp"
    else
        echo "Failed to convert: $IMAGE"
    fi
done

echo "Conversion completed. WebP images are in '$OUTPUT_FOLDER'."
