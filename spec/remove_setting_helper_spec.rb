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
require 'spec_helper'

describe Fastlane::Helper::RemoveSettingHelper do
  let(:helper) { Fastlane::Helper::RemoveSettingHelper }

  describe 'remove_setting' do
    it 'removes the item from the Settings.bundle as specified' do
      # Contents of Root.plist
      preferences = {
        'PreferenceSpecifiers' => [
          {
            'Type' => 'PSTitleValueSpecifier',
            'Key' => 'ItemToRemove'
          }
        ]
      }

      # mock file
      settings_bundle = double(
        'file',
        path: 'Settings.bundle',
        real_path: '/path/to/Settings.bundle'
      )

      # mock project
      project = double 'project',
                       files: [settings_bundle],
                       path: '/a/b/c/MyProject.xcodeproj'

      # mock out the file read
      mock_file = double 'File'
      expect(File).to receive(:open).and_yield mock_file
      expect(Plist).to receive(:parse_xml) { preferences }

      # and write
      expect(Plist::Emit).to receive(:save_plist)

      # code under test
      helper.remove_setting project, 'Settings.bundle', 'Root.plist',
                            'ItemToRemove'
    end

    it 'finds a custom settings bundle by name' do
      # Contents of Root.plist
      preferences = {
        'PreferenceSpecifiers' => [
          {
            'Type' => 'PSTitleValueSpecifier',
            'Key' => 'ItemToRemove'
          }
        ]
      }

      # mock file
      settings_bundle = double(
        'file',
        path: 'MySettings.bundle',
        real_path: '/path/to/MySettings.bundle'
      )

      # mock project
      project = double 'project',
                       files: [settings_bundle],
                       path: '/a/b/c/MyProject.xcodeproj'

      # mock out the file read
      mock_file = double 'File'
      expect(File).to receive(:open).and_yield mock_file
      expect(Plist).to receive(:parse_xml) { preferences }

      # and write
      expect(Plist::Emit).to receive(:save_plist)

      # code under test
      helper.remove_setting project, 'MySettings.bundle', 'Root.plist',
                            'ItemToRemove'
    end

    it 'raises if no Settings.bundle in project' do
      project = double 'project', files: []

      expect do
        helper.remove_setting project, 'Settings.bundle', 'Root.plist',
                              'ItemToRemove'
      end.to raise_error RuntimeError
    end

    it 'raises if the settings plist file cannot be parsed' do
      # mock file
      settings_bundle = double(
        'file',
        path: 'Settings.bundle',
        real_path: '/path/to/Settings.bundle'
      )

      # mock project
      project = double 'project',
                       files: [settings_bundle],
                       path: '/a/b/c/MyProject.xcodeproj'

      # mock nil return
      mock_file = double 'File'
      expect(File).to receive(:open).and_yield mock_file
      expect(Plist).to receive(:parse_xml) { nil }

      expect do
        helper.remove_setting project, 'Settings.bundle', 'Root.plist',
                              'ItemToRemove'
      end.to raise_error RuntimeError
    end

    it 'raises if PreferenceSpecifiers not found in plist' do
      # mock file
      settings_bundle = double(
        'file',
        path: 'Settings.bundle',
        real_path: '/path/to/Settings.bundle'
      )

      # mock project
      project = double 'project',
                       files: [settings_bundle],
                       path: '/a/b/c/MyProject.xcodeproj'

      # mock out the file read
      mock_file = double 'File'
      expect(File).to receive(:open).and_yield mock_file
      expect(Plist).to receive(:parse_xml) { {} }

      expect do
        helper.remove_setting project, 'Settings.bundle', 'Root.plist',
                              'ItemToRemove'
      end.to raise_error RuntimeError
    end

    it 'raises if specified key not found' do
      # Contents of Root.plist
      preferences = { 'PreferenceSpecifiers' => [] }

      # mock file
      settings_bundle = double(
        'file',
        path: 'Settings.bundle',
        real_path: '/path/to/Settings.bundle'
      )

      # mock project
      project = double 'project',
                       files: [settings_bundle],
                       path: '/a/b/c/MyProject.xcodeproj'

      # mock out the file read
      mock_file = double 'File'
      expect(File).to receive(:open).and_yield mock_file
      expect(Plist).to receive(:parse_xml) { preferences }

      expect do
        helper.remove_setting project, 'Settings.bundle', 'Root.plist',
                              'ItemToRemove'
      end.to raise_error RuntimeError
    end
  end
end
