
Pod::Spec.new do |s|
    s.name         = "GJRedDot"
    s.version      = "1.3"
    s.summary      = "Show red dot, associate and refresh."
    s.description  = <<-DESC
                        U can use GJRedDot to show or hide the red dot on UIView and UITabBarItem.
                        U can regist red dot's association, and refresh it that it will refreshed through all association nodes.
                        Red dot will through its asscocation nodes to decide it that show or hide.
                        DESC
    s.homepage     = "https://github.com/GJGroup/GJRedDot"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author       = { "wangyutao" => "https://github.com/wangyutao0424" }
    s.platform     = :ios ,"7.0"
    s.source       = { :git => "https://github.com/GJGroup/GJRedDot.git", :branch => "master", :tag => '1.3' }
    s.requires_arc = true
    s.source_files  =  'GJRedDot/*.{h,m}'
    s.frameworks = 'Foundation'
    s.subspec 'GJDeallocBlockExecutor' do |ss|
        ss.source_files = 'GJRedDot/GJDeallocBlockExecutor/**/*.{h,m}'
        ss.public_header_files = 'GJRedDot/GJDeallocBlockExecutor/**/*.{h}'
    end
end
