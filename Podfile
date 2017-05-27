# Uncomment the next line to define a global platform for your project
platform :ios, ‘8.0’

target 'IVP Luncheon' do
use_frameworks!
    pod 'Alamofire', '~> 4.4'
    pod 'AlamofireObjectMapper', '~> 4.0'
    pod 'RealmSwift'

end

target 'IVP LuncheonTests' do
    inherit! :search_paths
    # Pods for testing
end

target 'IVP LuncheonUITests' do
    inherit! :search_paths
    # Pods for testing
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
