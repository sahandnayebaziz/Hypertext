Pod::Spec.new do |s|
  s.name             = "Hypertext"
  s.version          = "2.1.0"
  s.summary          = "Compose valid HTML in Swift any way you want to."
  s.description      = "Hypertext provides a simple, powerful set of classes for composing HTML, including all standard HTML elements, and rendering composed HTML to a string. Best used with a Swift Server."

  s.homepage         = "https://github.com/sahandnayebaziz/Hypertext"
  s.license          = 'MIT'
  s.author           = { "sahandnayebaziz" => "sahand@sahand.me" }
  s.source           = { :git => "https://github.com/sahandnayebaziz/Hypertext.git", :tag => s.version.to_s }

  s.ios.deployment_target  = '10.0'
  s.osx.deployment_target  = '10.12'

  s.source_files = 'Sources/*.swift'
end
