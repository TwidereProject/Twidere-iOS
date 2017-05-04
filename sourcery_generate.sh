#!/bin/bash

for project in TwidereCore TwidereCore/Mastodon TwidereCore/MicroBlog Twidere; do
  ./Pods/Sourcery/bin/sourcery --templates Templates/ --sources $project/Sources --output $project/Generated
done
