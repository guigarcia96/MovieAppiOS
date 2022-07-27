update-pods: 
	@echo "Updating Cocoapods"
	pod install --repo-update
run:
	@echo "Generating Project"
	xcodegen generate 
	@echo "Downloading Cocoapods"
	pod install 
	@echo "Open Project"
	open TheMovieApp.xcworkspace