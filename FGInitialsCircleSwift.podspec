Pod::Spec.new do |s|
  s.name             = "FGInitialsCircleSwift"
  s.version          = "0.1.0"
  s.summary          = "Dynamic Initial Circle"
  s.description      = 'One line code to generate a custom circle with initial by using Swift'
  s.homepage         = "https://github.com/fg0815/initials-circle-swift"
  s.license          = 'MIT'
  s.author           = { "Feng Guo" => "feng.guo.aus@gmail.com" }
  s.source           = { :git => "https://github.com/fg0815/initials-circle-swift.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'FGInitialCircleImage/FGInitialCircleImage/FGInitialCircleImage.swift'
end
