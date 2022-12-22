#!/bin/zsh
targets=targets.txt
base=https://github.com/crossplane-contrib
array=("${(@f)$(< $targets)}")

for entry in $array;  do
  provider="$(echo $entry | awk -F ' ' '{print $1}')"
  echo "$provider"
  release="$(echo $entry | awk -F ' ' '{print $2}')";
  echo "$release"
  suf="_cue"
  dest="${provider}${suf}"
  src="$dest/package/crds"

  git clone --branch $release --single-branch $base/$provider.git $dest
  mkdir -p $provider

  crds=($(ls $src))
  for c in  "${crds[@]}"; do
    new_name=$(echo "$c" | sed -e 's/\.yaml//g' | sed -e 's/\./\_/g')
    cue import -f -o "$provider/$new_name.cue" -l 'strings.ToLower(kind)' -l 'metadata.name' -p $new_name $src/$c;
  done

  rm -rf $dest
done