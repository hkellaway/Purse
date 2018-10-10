Pod::Spec.new do |s|

  s.name             = "Purse"
  s.version          = "0.0.1"
  s.summary          = "A fashionable accessory to persist data to disk"
  s.description      = "A fashionable accessory to persist data to disk."
  s.homepage         = "https://github.com/hkellaway/Purse"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "Harlan Kellaway" => "hello@harlankellaway.com" }
  s.source           = { :git => "https://github.com/hkellaway/Purse.git", :tag => s.version.to_s }
  
  s.platforms     = { :ios => "11.0" }
  s.requires_arc = true
  s.source_files = "Sources/*.swift"

end
