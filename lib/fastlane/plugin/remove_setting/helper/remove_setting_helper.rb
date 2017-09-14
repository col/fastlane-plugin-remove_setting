# Copyright (c) 2016-17 Colin Harris
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

require 'plist'

module Fastlane
  module Helper
    class RemoveSettingHelper
      class << self
        # Takes an open Xcodeproj::Project, extracts the settings bundle
        # and removes the specified setting key in the specified file.
        # Raises on error.
        #
        # :project: An open Xcodeproj::Project, obtained from Xcodeproj::Project.open, e.g.
        # :bundle_name: (String) Regex to identify the bundle to look for, usually Settings.bundle.
        # :file: A settings plist file in the Settings.bundle, usually "Root.plist"
        # :key: A valid NSUserDefaults key in the Settings.bundle
        def remove_setting(project, bundle_name, file, key)
          settings_bundle = project.files.find { |f| f.path =~ /#{bundle_name}/ }

          raise "#{bundle_name} not found in project" if settings_bundle.nil?

          # The #real_path method returns the full resolved path to the Settings.bundle
          settings_bundle_path = settings_bundle.real_path

          plist_path = File.join settings_bundle_path, file

          # raises IOError
          settings_plist = File.open(plist_path) { |f| Plist.parse_xml f }

          raise "Could not parse #{plist_path}" if settings_plist.nil?

          preference_specifiers = settings_plist['PreferenceSpecifiers']
          raise "#{file} is not a settings plist file" if preference_specifiers.nil?

          original_count = preference_specifiers.length

          raise "#{file} is not a settings plist file" if preference_specifiers.nil?

          # Remove the specifier matching the supplied key
          settings_plist['PreferenceSpecifiers'] = preference_specifiers.reject do |specifier|
            specifier['Key'] == key
          end

          raise "preference specifier for key #{key} not found in #{file}" if settings_plist['PreferenceSpecifiers'].length == original_count

          # Save (raises)
          Plist::Emit.save_plist settings_plist, plist_path
        end
      end
    end
  end
end
