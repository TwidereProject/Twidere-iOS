#!/bin/bash
cd Generated
../Pods/Sourcery/bin/sourcery --sources ../Sources/ --templates ../Templates/ --disableCache
