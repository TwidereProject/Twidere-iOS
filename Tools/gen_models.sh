#!/bin/bash

for f in ../Twidere/Templates/Models/*.model.yml; do
	model_template_name=`basename $f`
	class_file_name=${model_template_name%.model.yml}
	gyb/gyb  --line-directive '' -D modelPath="$f"  -o ../Twidere/Utils/Extensions/SQLite/$class_file_name+SQLite.swift ../Twidere/Templates/Models/SQLiteModelExtension.swift.gyb
done
