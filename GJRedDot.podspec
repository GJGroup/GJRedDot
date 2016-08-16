
Pod::Spec.new do |s|
    s.name         = "GJRedDot"
    s.version      = "1.0-alpha"
    s.summary      = "Show red dot, associate and refresh."
    s.description  = <<-DESC
                        Show red dot, associate and refresh.
                        DESC
    s.homepage     = "https://github.com/GJGroup/GJRedDot"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author       = { "wangyutao" => "https://github.com/wangyutao0424" }
    s.platform     = :ios ,"7.0"
    s.source       = { :git => "https://github.com/GJGroup/GJRedDot.git", :branch => "master", :tag => '1.0-alpha' }
    s.requires_arc = true
    s.source_files  =  'GJRedDot/*.{h,m}'
    s.frameworks = 'Foundation'
end