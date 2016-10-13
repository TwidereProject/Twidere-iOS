#!/bin/bash

do_gyb() {
	gyb/gyb  --line-directive '' -D modelPath="$1"  -o $2 $3
	if [ $? -ne 0 ]; then
		rm $2
	fi
}

for f in ../Twidere/Templates/Models/*.model.yml; do
	model_template_name=`basename $f`
	class_file_name=${model_template_name%.model.yml}
	do_gyb $f ../Twidere/Models/$class_file_name.swift ../Twidere/Templates/Models/Model.swift.gyb
	do_gyb $f ../Twidere/Generated/Extensions/$class_file_name+SQLite.swift ../Twidere/Templates/Models/Model+SQLite.swift.gyb
#	do_gyb $f ../Twidere/Generated/Extensions/$class_file_name+ObjectMapper.swift ../Twidere/Templates/Models/Model+ObjectMapper.swift.gyb
	do_gyb $f ../Twidere/Generated/Extensions/$class_file_name+Freddy.swift ../Twidere/Templates/Models/Model+Freddy.swift.gyb
done
