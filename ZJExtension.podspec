#
# Be sure to run `pod lib lint ZJExtension.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    
  s.name             = 'ZJExtension'
  s.version          = '0.1.0'
  s.summary          = 'A short description of ZJExtension.'
  s.homepage         = 'https://github.com/zhang232425/ZJExtension'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhang232425' => '519301084@qq.com' }
  s.source           = { :git => 'https://github.com/zhang232425/ZJExtension.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.source_files = 'ZJExtension/Classes/**/*'
  s.resource_bundles = {
      'ZJExtension' => ['ZJExtension/Assets/*.png']
  }
  
  s.dependency 'SDWebImage'
  s.dependency 'CryptoSwift'

end
