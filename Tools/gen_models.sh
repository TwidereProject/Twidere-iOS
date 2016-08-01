#!/bin/bash

for f in ../Twidere/Templates/Models/*.model.py; do
	model_template_name=`basename $f`
	class_file_name=${model_template_name%.model.py}
	gyb/gyb  --line-directive '' -D modelPath="$f"  -o ../Twidere/Models/$class_file_name.swift ../Twidere/Templates/Models/SQLiteModel.swift.gyb
done
