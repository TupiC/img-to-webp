#!/bin/bash

OUTPUT_FOLDER="/output"


for IMAGE in /input/*.{jpg,jpeg,png,gif,bmp,tiff,tif}; do
    [ -e "$IMAGE" ] || continue

    FILENAME=$(basename "$IMAGE")
    BASENAME="${FILENAME%.*}"

    cwebp -q 80 "$IMAGE" -o "$OUTPUT_FOLDER/$BASENAME.webp"

    if [ $? -eq 0 ]; then
        echo "Converted: $IMAGE -> $OUTPUT_FOLDER/$BASENAME.webp"
    else
        echo "Failed to convert: $IMAGE"
    fi
done

echo "Conversion completed. WebP images are in '$OUTPUT_FOLDER'."
