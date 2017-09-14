### RemoveSettingExample

This is a simple example project that makes use of the remove_setting action.

First build and run the sample project on a simulator or device. Tap 'Open Settings' to view the settings for RemoveSettingExample in the Settings app. You'll see the version number
as well as a development mode switch.

Now run Fastlane:

```bash
bundle install
bundle exec fastlane test
```

Run the sample app again. Tap 'Open Settings' again to see the updated settings. The development mode switch should no longer be visible.
