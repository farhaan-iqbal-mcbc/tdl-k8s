tag=$(cat "zz_version")
image_name=$(cat "zz_image_name")
if [ "$tag" = "" ]; then tag="latest"; fi