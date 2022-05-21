platform :ios, '15.0'

def reactive_libs
  pod 'RxSwift', '~> 6.5'
  pod 'RxCocoa', '~> 6.5'
  pod 'RxDataSources', '~> 5.0'
end

def ui_libs
  pod 'SnapKit', '~> 5.0'
  pod 'MBProgressHUD', '~> 1.2.0'
end

target 'TodoApp' do
  use_frameworks!

  # Pods for TodoApp

  reactive_libs
  ui_libs

  target 'TodoAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'TodoAppUITests' do
    # Pods for testing
  end

end
