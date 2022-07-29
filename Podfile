# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'
source 'https://github.com/CocoaPods/Specs.git'

def testing_pods
  pod 'SnapshotTesting', '~> 1.8.1'
end

target 'TheMovieApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TheMovieApp
  pod 'SwiftGen', '~> 6.0'
  pod 'SnapKit', '~> 5.6.0'
  pod 'Alamofire', '~> 5.6.0'

end

target 'TheMovieAppUITests' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TheMovieAppUITests
  testing_pods

end
