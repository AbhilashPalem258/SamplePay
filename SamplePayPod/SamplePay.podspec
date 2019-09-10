Pod::Spec.new do |s|
  s.name             = 'SamplePay'
  s.version          = '0.1.1'
  s.summary          = 'A short description of SamplePay.'
 
  s.homepage         = 'https://github.com/AbhilashPalem258/SamplePay'
  s.license          = { :type => 'Copyright', :text => <<-LICENSE
                  	 Copyright 2018
                  	 Permission is granted to...
                  	 LICENSE
               		}
  s.author           = { 'Abhilash' => 'abhilashkumar258@gmail.com' }
  s.source           = { :git => 'https://github.com/AbhilashPalem258/SamplePay.git', :tag => s.version.to_s }

  s.platform = :ios
  s.ios.deployment_target = '10.0'
  s.source            = { :http => 'https://github.com/AbhilashPalem258/SamplePay/raw/master/SamplePayUniversalFramework.zip' }
  s.ios.vendored_frameworks = 'SamplePayUniversalFramework/SamplePay.framework'
 
end