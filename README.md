# flutter-in-ios
Example on how to integrate a Flutter module into an existing iOS application

# Build and Run

This sample uses the CocoaPods strategy in order to embebbed a Flutter module into an existing iOS application, as described [here[(https://flutter.dev/docs/development/add-to-app/ios/project-setup).

1. Navigate to `FlutteriOS` folder and run:
```bash
$ pod install
``` 
2. Open `FlutteriOS.xcworkspace` file and build it normally.

# Troubleshooting

If you see a *Permission denied* error while building the application, try the solution of editing `xcode_backend.sh` file, as described in [here](https://github.com/flutter/flutter/issues/40146)

