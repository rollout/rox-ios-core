Pod::Spec.new do |s|

  s.name         = "ROXCore"
  s.version      = "6.0.0"
  s.summary      = "Continuous Feature Rollouts for Mobile"
  s.description  = "Release mobile features quickly and safely with fully controlled rollouts, measure impact, and react as needed without waiting for your next code release."

  s.homepage     = "https://rollout.io"
  s.license      = {
                      "type" => "Commercial",
                      "text" => "See http://www.rollout.io/"
                   }
  s.authors      = {
                      "Rollout.io" => "support@rollout.io"
                   }
  s.documentation_url = "http://support.rollout.io/"

  s.source       = { :git => "https://github.com/rollout/rox-core-spm.git", :tag => "#{s.version}" }

  s.vendored_frameworks = "ROXCore.xcframework"

  s.platform = :ios

  s.swift_version = '4.0'

  s.ios.deployment_target  = '8.0'
  s.ios.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64', }
  s.ios.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

end
