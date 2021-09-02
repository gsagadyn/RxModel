Pod::Spec.new do |s|
  s.name  = 'RxModel'
  s.version = '0.11.0'
  s.summary = 'Set of extensions to RxSwift.'
  s.homepage = 'https://github.com/gsagadyn/RxModel'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = { 'Grzegorz Sagadyn' => 'sagadyn@gmail.com' }
  s.source = { :git => 'https://github.com/gsagadyn/RxModel.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.source_files = 'RxModel/**/*'
  s.swift_versions = ['5.0', '5.1', '5.2', '5.3', '5.4']
  s.dependency 'RxSwift', '~> 6.2'
end
