platform :ios, '10.0'

target 'Donkey' do
  use_frameworks!

  target 'DonkeyTests' do
    inherit! :search_paths
  end

end

target 'DonkeyFramework' do
  use_frameworks!

  pod 'SwiftLint', '~> 0.27'
  pod 'Alamofire', '~> 4.7'
  
  target 'DonkeyFrameworkTests' do
    inherit! :search_paths
  end

end
