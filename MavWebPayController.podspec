Pod::Spec.new do |s|
  # 1
  s.platform = :ios
  s.ios.deployment_target = '11.0'
  s.name  = "MavWebPayController"
  s.summary = "Webpay Controller"
  s.requires_arc = true

  # 2
  s.version      = "0.0.1"

  # 3
  s.license = { :type => "MIT", :file => "LICENSE" }

  # 4
  s.author = { "alfredolucomav" => "alfredo.luco@mavericks.cool" }

  # 5
  s.homepage = "https://github.com/alfredolucomav/MAVWalktrough"

  # 6
  s.source = { :git => "https://github.com/alfredolucomav/MAVWalktrough", :tag => "0.0.5" }

  # 7
  s.ios.frameworks = 'UIKit', 'Foundation'
  s.dependency 'MaterialComponents/Buttons'
  s.dependency 'SVDismissableProgressHUD'
  s.dependency 'IQKeyboardManagerSwift'
  s.dependency 'Alamofire'
  s.dependency 'Firebase/Firestore'
  s.dependency 'Firebase/Auth'
  s.dependency 'Promises'
  s.dependency 'ObjectMapper'
  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
  s.dependency 'MaterialComponents/Snackbar'
  s.dependency 'MaterialComponents/Snackbar+ColorThemer'

  # 8
  s.ios.source_files = 'MavWebPayController/Sources/**/*.*'
  s.resources = ['MavWebPayController/Assets/**/*.*']
  

end

