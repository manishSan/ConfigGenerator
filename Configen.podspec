
#
# Be sure to run `pod lib lint Configen.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Configen'
  s.version          = '1.2.0'
  s.summary          = 'A command line tool to auto-generate configuration file code, for use in Xcode projects.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
The configen tool is used to auto-generate configuration code from a property list. It is intended to create the kind of configuration needed for external URLs or API keys used by your app. Currently supports both Swift and Objective-C code generation.
                       DESC


  # s.ios.deployment_target = "9.0"
  s.osx.deployment_target = '10.10'
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"

  s.homepage         = 'https://github.com/manishb24/ConfigGenerator'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'manishb24' => 'Manish.Sanwal@gmail.com' }

  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.source = { http: "https://github.com/manishb24/ConfigGenerator/releases/download/#{s.version}/configen-#{s.version}.zip" }
  s.preserve_paths = '*'
end
