require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name             = 'FiuuxdkCapacitorPlugin'
  s.version          = package['version']
  s.summary          = package['description']
  s.license          = package['license']
  s.homepage         = package['repository']['url']
  s.author           = package['author']
  s.platform         = :ios, '11.0'
  s.swift_version    = '5.1'

  s.source           = { :git => package['repository']['url'], :tag => s.version.to_s }
  s.source_files     = 'ios/Plugin/**/*.{swift,h,m,c,cc,mm,cpp}'

  # Ensure Capacitor is installed
  s.dependency 'Capacitor'

  s.dependency 'fiuu-mobile-xdk-cocoapods', '3.34.3'  # Ensure correct version

  # If the SDKs are static, add `vendored_frameworks`
  s.vendored_frameworks = 'Pods/fiuu-mobile-xdk-cocoapods/*.framework'  # Adjust the path if needed
end
