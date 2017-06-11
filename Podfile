# Uncomment this line to define a global platform for your project
platform :ios, '9.0'
# Uncomment this line if you're using Swift
use_frameworks!

$AlamofireVersion = '~> 4.4.0'
$PromiseKitVersion = '~> 4.2.2'

target 'Twidere' do
  workspace 'Twidere'
  project 'Twidere/Twidere'
  pod 'LayoutKit'
  pod 'Sourcery', '~> 0.6'
  pod 'PMJSON', '~> 2.0.2'
  pod 'PMJackson', '~> 1.1.4'
  pod 'SQLite.swift', '~> 0.11.0'
  pod 'CryptoSwift', '~> 0.6.0'
  pod 'Alamofire', $AlamofireVersion
  pod 'PromiseKit/Alamofire', $PromiseKitVersion
  pod 'JVFloatLabeledTextField', '~> 1.1' # Obj-C
  pod 'ActionSheetPicker-3.0', '~> 2.0' # Obj-C
  pod 'StaticDataTableViewController', '~> 2.0.5' # Obj-C
  pod 'IQKeyboardManagerSwift', '~> 4.0.6' # Swift 3
  pod 'Kanna', '~> 2.0' # Swift 3
  pod 'SwiftyUserDefaults', '~> 3.0' # Swift 3
  pod 'PromiseKit', $PromiseKitVersion # Swift 3
  pod 'STPopup', '~> 1.8.0' # Obj-C
  pod 'UITextView+Placeholder', '~> 1.2' # Obj-C
  pod 'twitter-text', '~> 1.14' # Obj-C
  pod 'UIView+TouchHighlighting', '~> 1.1' # Obj-C
  pod 'SDWebImage', '~> 4.0.0' # Obj-C
  pod 'JDStatusBarNotification', '~> 1.5.5' # Obj-C
  pod 'UITableView+FDTemplateLayoutCell', '~> 1.5.beta' # Obj-C
  pod 'DateTools', '~> 2.0' # Obj-C
  pod 'ALSLayouts', '~> 2.0' # Swift 3
  pod 'ThumborURL', '~> 0.0' # Obj-C
  pod 'MXPagerView', '~> 0.1'
  pod 'MXParallaxHeader', '~> 0.6.0'
  pod 'FXBlurView', '~> 1.6'
  pod 'FXImageView', '~> 1.3'
  pod 'YYText', '~> 1.0'
  pod 'DeviceKit', '~> 1.0'
  pod 'SwiftHEXColors', '~> 1.1.0'
  pod 'SnapKit', '~> 3.2.0'

  pod 'Fabric'
  pod 'Crashlytics'
end

target 'TwidereCore' do
  workspace 'Twidere'
  project 'TwidereCore/TwidereCore'

  pod 'Alamofire', $AlamofireVersion
  pod 'PMJackson', '~> 1.1.4'
  pod 'PromiseKit', $PromiseKitVersion
  pod 'Kanna', '~> 2.0'
end

target 'MicroBlog' do
  workspace 'Twidere'
  project 'TwidereCore/MicroBlog/MicroBlog'

  pod 'Alamofire', $AlamofireVersion
  pod 'PMJackson', '~> 1.1.4'
  pod 'PromiseKit', $PromiseKitVersion
end

target 'Mastodon' do
  workspace 'Twidere'
  project 'TwidereCore/Mastodon/Mastodon'

  pod 'Alamofire', $AlamofireVersion
  pod 'PMJackson', '~> 1.1.4'
  pod 'PromiseKit', $PromiseKitVersion
end

target 'RestClient' do
  workspace 'Twidere'
  project 'RestClient/RestClient'

  pod 'Alamofire', $AlamofireVersion
  pod 'PromiseKit/Alamofire', $PromiseKitVersion
  pod 'PromiseKit', $PromiseKitVersion
  pod 'CryptoSwift', '~> 0.6.0'
end

target 'RestCommons' do
  workspace 'Twidere'
  project 'RestCommons/RestCommons'

  pod 'Alamofire', $AlamofireVersion
  pod 'PromiseKit/Alamofire', $PromiseKitVersion
  pod 'PromiseKit', $PromiseKitVersion
  pod 'PMJackson', '~> 1.1.4'
end

target 'TwidereTests' do
  workspace 'Twidere'
  project 'Twidere/Twidere'
end

target 'TwidereUITests' do
  workspace 'Twidere'
  project 'Twidere/Twidere'
end
