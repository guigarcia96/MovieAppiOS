if [[ -f "Pods/SwiftGen/bin/swiftgen" ]]; then
  "Pods/SwiftGen/bin/swiftgen"
else
  echo "warning: SwiftGen is not installed. Run 'pod install --repo-update' to install it."
fi