Pod::Spec.new do |s|
    s.name         = "react-native-atomic-button"
    s.version      = "1.0.0"
    s.summary      = "A React Native native atomic button that prevents duplicate clicks."
    s.description  = <<-DESC
      A native module for React Native that provides an atomic button to prevent duplicate clicks.
    DESC
    s.homepage     = "https://github.com/BlueRacoon/react-native-atomic-button"
    s.license      = "MIT"
    s.author       = { "Zachary Owen" => "your.email@example.com" }
    s.source       = { :git => "https://github.com/BlueRacoon/react-native-atomic-button.git", :tag => s.version.to_s }
    s.platform     = :ios, "10.0"
    s.source_files = "ios/**/*.{h,m}"
    s.dependency "React-Core"
    # Include any other React Native subspecs you need (for example, if you are using RCTViewManager, etc.)
  end
  