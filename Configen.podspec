#
# Be sure to run `pod lib lint Capture.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Configen'
  s.version          = '1.1.0'
  s.summary          = 'A command line tool to auto-generate configuration file code, for use in Xcode projects.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
The configen tool is used to auto-generate configuration code from a property list. It is intended to create the kind of configuration needed for external URLs or API keys used by your app. Currently supports both Swift and Objective-C code generation.
                       DESC

  s.platform = :ios, '9.0'
  # s.ios.deployment_target = "9.0"
  # s.osx.deployment_target = "10.10"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"

  s.homepage         = 'https://github.com/manishb24/ConfigGenerator'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'manishb24' => 'Manish.Sanwal@gmail.com' }
  s.source           = { :git => 'https://github.com/manishb24/ConfigGenerator.git', :tag => s.version.to_s }
  #s.source           = { :git => "https://github.com/manishb24/Capture.git", :commit => "3db1fcc725823c456404b9d260d028e7479e7b3c" }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'Configen/*', 'Configen/CommandLineKit/*'

  # s.resource_bundles = {
  #   'Capture' => ['Capture/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.requires_arc = true
  s.framework  = 'Foundation'
end
