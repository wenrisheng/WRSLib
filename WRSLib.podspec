#
# Be sure to run `pod lib lint WRSLib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WRSLib'
  s.version          = '0.0.2'
  s.summary          = 'A short description of WRSLib.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/jack/WRSLib'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jack' => '252797991@qq.com' }
  s.source           = { :git => 'https://github.com/wenrisheng/WRSLib.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.subspec 'NetworkSpeed' do |networkSpeed|
    networkSpeed.source_files = 'WRSLib/Classes/NetworkSpeed/**/*'
    networkSpeed.dependency 'Reachability', '~> 3.2'
  end
  
  s.subspec 'NetworkType' do |networkType|
    networkType.source_files = 'WRSLib/Classes/NetworkType/**/*'

  end
  
#  s.source_files = 'WRSLib/Classes/**/*'
  
  # s.resource_bundles = {
  #   'WRSLib' => ['WRSLib/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
