#
#  Be sure to run `pod spec lint IBCustomFonts.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|


  s.name         = "IBCustomFonts"
  s.version      = "1.0.1"
  s.summary      = "IBCustomFonts category allows you to use custom fonts from Interface Builder (IB) when building your iOS apps."

  s.description  = <<-DESC
    IBCustomFonts category allows you to use custom fonts from Interface Builder (IB) when building your iOS apps.
    Apps using IBCustomFonts category are approved by Apple App Store (check readme.md on latest info).
                   DESC

  s.homepage     = "https://github.com/deni2s/IBCustomFonts"
  s.license      = "MIT"
  s.author             = { "Deniss Fedotovs" => "deni2s@hc.lv" }
  s.social_media_url   = "http://linkedin.com/in/deni2s"
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/deni2s/IBCustomFonts.git", :tag => s.version.to_s, :commit => "ac641303eae01953cba1dcdbac6719a6b7c3f22a" }
  s.source_files  = "UIFont+IBCustomFonts.m"
  s.requires_arc = false

end
