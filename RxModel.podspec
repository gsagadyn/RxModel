Pod::Spec.new do |s|
  s.name             = 'RxModel'
  s.version          = '0.2.4'
  s.summary          = 'Set of extensions to RxSwift.'
  s.homepage         = 'https://github.com/gsagadyn/RxModel'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Grzegorz Sagadyn' => 'sagadyn@gmail.com' }
  s.source           = { :git => 'https://github.com/gsagadyn/RxModel.git', :tag => s.version.to_s }

  s.swift_version = "4.1"
  s.ios.deployment_target = '9.3'
  s.frameworks = 'Foundation'
  s.requires_arc = true
  s.dependency 'RxSwift', '~> 4.0'
  s.source_files = 'RxModel/Classes/**/*'
end
