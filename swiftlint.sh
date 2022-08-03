if which ${PODS_ROOT}/SwiftLint/swiftlint > /dev/null; then
  ${PODS_ROOT}/SwiftLint/swiftlint --fix
else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi