#
# Be sure to run `pod lib lint GIChainLib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GIChainLib'
  s.version          = '0.3.12'
  s.summary          = 'GIChainLib是北京创世智链信息技术研究所iOS项目核心库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                       GIChainLib是北京创世智链信息技术研究所iOS项目核心库
                       包含基础的工具类、分类、网络框架及界面组件等
                       DESC

  s.homepage         = 'http://114.242.31.175:8090/6xniu-app/gichainlib_ios'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zt7623869' => 'zt7623694@sina.com' }
  s.source           = { :git => 'http://zhengtong@114.242.31.175:8090/6xniu-app/gichainlib_ios.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  
  s.subspec 'TZNetwork' do|net|
      net.source_files = 'GIChainLib/TZNetwork/*','GIChainLib/GICategory/NSObject+Swizzle.{h,m}'
      net.dependency 'AFNetworking'
  end
  
  s.subspec 'LengthFit' do|fit|
      fit.source_files = 'GIChainLib/LengthFit/*'
  end
  
  s.subspec 'GICategory' do|cate|
      cate.source_files = 'GIChainLib/GICategory/*'
  end
  
  s.subspec 'GITools' do|tools|
      
      tools.subspec 'GITools' do|bioAuthTools|
          bioAuthTools.source_files = 'GIChainLib/Tools/BioAuthTools/*'
      end
  end
  
  s.subspec 'XModel' do|model|
      model.source_files = 'GIChainLib/XModel/*'
      model.dependency 'YYModel'
  end
  
  s.subspec 'GIUI' do|giui|
      # giui.source_files = 'GIChainLib/GIUI/**/*'
      
      giui.subspec 'GITabCollectionView' do|tabCollection|
          tabCollection.source_files = 'GIChainLib/GIUI/GITabCollectionView/*'
          tabCollection.dependency 'Masonry'
      end
      
      giui.subspec 'GITabControlView' do|tabControl|
          tabControl.source_files = 'GIChainLib/GIUI/GITabControlView/*','GIChainLib/GICategory/UIViewExt.{h,m}','GIChainLib/GICategory/UIView+Ext.{h,m}'
          tabControl.dependency 'Masonry'
          tabControl.dependency 'GIChainLib/GIUI/GITabCollectionView'
      end
      
  end
  
  # s.resource_bundles = {
  #   'GIChainLib' => ['GIChainLib/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
