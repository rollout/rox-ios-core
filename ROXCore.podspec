Pod::Spec.new do |s|

  s.name         = "ROXCore"
  s.version      = "4.9.13"
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

  s.requires_arc = true

  s.ios.vendored_frameworks = 'RoxSdk/ROXCore.framework'
  s.tvos.vendored_frameworks = 'RoxSdk/ROXCore.framework'

  s.xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '$(inherited)' }

  s.source       = { :git => "https://0e8d19fe366d02ba028b5ef4c5b207abb7f28569@github.com/rollout/rox-ios-core.git", :tag => "4.9.13" }
  s.preserve_paths = "lib/**/*", "install/**/*"

  s.ios.deployment_target  = '8.0'
  s.tvos.deployment_target  = '10.0'
end
