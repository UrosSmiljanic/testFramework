Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '9.0'
s.name = "BadinFramework"
s.summary = "Badin Framework make sure that you make your app easy :)"
s.requires_arc = true

# 2
s.version = "0.1.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Uros Smiljanic" => "smiljanic.uros@gmail.com" }

# 5 - Replace this URL with your own Github page's URL (from the address bar)
s.homepage = "https://github.com/UrosSmiljanic/testFramework"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/UrosSmiljanic/testFramework.git", :tag => "#{s.version}"}

# 7
s.framework = "UIKit"

s.dependency 'Firebase/Core'
s.dependency 'Firebase/Messaging'
s.dependency 'Firebase/Database'
s.dependency 'Firebase/Crash'
s.dependency 'Firebase/RemoteConfig'
s.dependency 'Firebase/Auth'
s.dependency 'Firebase/Storage'
s.dependency 'Alamofire', '~> 4.3'
s.dependency 'AlamofireObjectMapper', '~> 4.0'
s.dependency 'UIColor_Hex_Swift', '~> 3.0.2'
s.dependency 'QRCode'
s.dependency 'UICircularProgressRing'
s.dependency 'GoogleMaps'
s.dependency 'SideMenu'
s.dependency 'SwiftLocation'
s.dependency 'JWTDecode'
s.dependency 'SwiftyJSON'
s.dependency 'DatePickerDialog'
s.dependency 'DropDown'

# 8
s.source_files = "BadinFramework/**/*.{swift}"

# 9
s.resources = "BadinFramework/**/*.{png,jpeg,jpg,storyboard,xib}"
end
