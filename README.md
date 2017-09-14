# remove_setting plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg?style=flat-square)](https://rubygems.org/gems/fastlane-plugin-remove_setting)
[![Gem](https://img.shields.io/gem/v/fastlane-plugin-remove_setting.svg?style=flat)](https://rubygems.org/gems/fastlane-plugin-remove_setting)
[![Downloads](https://img.shields.io/gem/dt/fastlane-plugin-remove_setting.svg?style=flat)](https://rubygems.org/gems/fastlane-plugin-remove_setting)
[![License](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/col/fastlane-plugin-remove_setting/blob/master/LICENSE)
[![CircleCI](https://img.shields.io/circleci/project/github/col/remove_setting.svg)](https://circleci.com/gh/col/remove_setting)

## Getting Started

This project is a [fastlane](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-remove_setting`, run the following command:
```
fastlane add_plugin remove_setting
```

## About settings_bundle

Fastlane plugin to remove settings in an iOS settings bundle

### remove_setting

This action removes a specified NSUserDefaults key in the project's
`Settings.bundle`. 

```ruby
remove_setting(
  key: "DevelopmentMode"  
)
```

This removes the key named `DevelopmentMode` in the `Root.plist` in the
`Settings.bundle`.

#### Specifying the project file

By default, the action looks for a single .xcodeproj file in the repo,
excluding any under Pods. If more than one is present, use the `:xcodeproj`
parameter:

```ruby
remove_setting(
  xcodeproj: "./MyProject.xcodeproj",
  key: "DevelopmentMode"  
)
```

#### Files other than Root.plist

```ruby
remove_setting(
  file: "About.plist",
  key: "DevelopmentMode"  
)
```

The `file` argument specifies a file other than `Root.plist` in the
`Settings.bundle`. If you have multiple projects, keys or files,
run the action multiple times.

#### Bundle name parameter

By default, this action looks for a file called `Settings.bundle` in the project. To
specify a different name for your settings bundle, use the `:bundle_name` option:
```ruby
remove_setting(
  key: "DevelopmentMode",
  bundle_name: "MySettings.bundle"
)
```

Also see the [example app](./examples) and [example Fastfile](./fastlane/Fastfile) in the repo.

## Examples

[RemoveSettingExample]: ./examples/RemoveSettingExample

### RemoveSettingExample

See the `examples/RemoveSettingExample` subdirectory for a simple example project that
makes use of this action.

First build and run the sample project on a simulator or device. Tap 'Open Settings' to view the settings for RemoveSettingExample in the Settings app. You'll see the version number
as well as a development mode switch.

Now run Fastlane:

```bash
bundle install
bundle exec fastlane test
```

Run the sample app again. Tap 'Open Settings' again to see the updated settings. The development mode switch should no longer be visible.

## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://github.com/fastlane/fastlane/blob/master/fastlane/docs/PluginsTroubleshooting.md) doc in the main `fastlane` repo.

## Using `fastlane` Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Plugins.md).

## About `fastlane`

`fastlane` is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
