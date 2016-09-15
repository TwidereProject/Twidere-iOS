# Uncomment this line to define a global platform for your project
platform :ios, '9.0'
# Uncomment this line if you're using Swift
use_frameworks!

target 'Twidere' do
  # Available in Carthage
  # pod 'SwiftyJSON', :git => 'https://github.com/SwiftyJSON/SwiftyJSON.git', :branch => 'swift3' # Swift 3
  # Available in Carthage
  # pod 'SQLite.swift', :git => 'https://github.com/stephencelis/SQLite.swift.git', :branch => 'swift3' # Swift 3
  # Available in Carthage
  # pod 'CryptoSwift', :git => 'https://github.com/krzyzanowskim/CryptoSwift.git', :tag => '0.6.0'  # Swift 3
  # Available in Carthage
  # pod 'Alamofire', '~> 4.0' # Swift 3
  # Available in Carthage
  # pod 'JVFloatLabeledTextField', '1.1.1' # Obj-C
  # Available in Carthage
  #pod 'ActionSheetPicker-3.0', '2.2.0' # Obj-C
  pod 'StaticDataTableViewController', '2.0.5' # Obj-C
  pod 'IQKeyboardManager', '~> 4.0' # Obj-C
  # Available in Carthage
  # pod 'Kanna', :git => 'https://github.com/tid-kijyun/Kanna.git', :branch => 'swift3.0' # Swift 3
  #pod 'CrossroadRegex', '~> 0.8' # Swift 2.2
  # Available in Carthage
  # pod 'SwiftyUserDefaults', :git => 'https://github.com/radex/SwiftyUserDefaults.git', :tag => '3.0.0' # Swift 3
  # Available in Carthage
  # pod 'PromiseKit', '~> 4.0' # Swift 3
  # Available in Carthage
  # pod 'STPopup', '~> 1.8' # Obj-C
  # Available in Carthage
  # pod 'UITextView+Placeholder', '~> 1.2' # Obj-C
  pod 'twitter-text', '~> 1.14' # Obj-C
  pod 'UIView+TouchHighlighting', '~> 1.1' # Obj-C
  # Available in Carthage
  # pod 'SDWebImage', '~> 3.8.2' # Obj-C
  pod 'JDStatusBarNotification', '1.5.4' # Obj-C
  # Available in Carthage
  # pod 'UIView+FDCollapsibleConstraints', '~> 1.1' # Obj-C
  # Available in Carthage
  pod 'UITableView+FDTemplateLayoutCell', '~> 1.5.beta' # Obj-C
  # Available in Carthage
  # pod 'DateTools', '~> 1.7.0' # Obj-C
  # Available in Carthage
  # pod 'ALSLayouts', :git => 'https://github.com/mariotaku/ALSLayouts.git', :branch => 'swift3' # Swift 3
  # Available in Carthage
  # pod 'ThumborURL', '0.0.4' # Obj-C
  # Available in Carthage
  #pod 'StringExtensionHTML', '~> 0.1'
  # Available in Carthage
  # pod 'AttributedLabel', :git => 'https://github.com/KyoheiG3/AttributedLabel.git', :tag => '0.5.0' # Swift 3
  #pod 'KDInteractiveNavigationController', '~> 0.1.2' # Swift 2.2
  # Available in Carthage
  # pod 'ObjectMapper', :git => 'https://github.com/Hearst-DD/ObjectMapper.git', :tag => '2.0.0' # Swift 3
end

target 'TwidereTests' do

end

target 'TwidereUITests' do

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |configuration|
            configuration.build_settings['SWIFT_VERSION'] = "3.0"
        end
    end
end
