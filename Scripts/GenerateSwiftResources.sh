#!/bin/sh
set -e

"${PODS_ROOT}/SwiftGen/bin/swiftgen" colors "${SRCROOT}/ComicList/Colors.txt" --output "${SRCROOT}/ComicList/Color.swift" -t swift3
"${PODS_ROOT}/SwiftGen/bin/swiftgen" images "${SRCROOT}/ComicList/Assets.xcassets" --output "${SRCROOT}/ComicList/Asset.swift" -t swift3
