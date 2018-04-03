platform :ios, '11.0'
use_frameworks!

target 'FashionStore' do
  
  pod 'Alamofire'
  pod 'AlamofireObjectMapper'
  pod 'Kingfisher'
  pod 'ObjectMapper'
	
  target 'FashionStoreTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

# Disable Code Coverage for Pods projects
post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
        end
    end
end