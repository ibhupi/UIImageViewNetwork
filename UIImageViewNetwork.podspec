Pod::Spec.new do |s|
  s.name             = "UIImageViewNetwork"
  s.version          = "0.1.0"
  s.summary          = "UIImageViewNetwork is Swift extension of UIImageView to download image from server asynchronously."
  s.description      = <<-DESC

                      UIImageViewNetwork is easy to use Swift UIImageView extension to download image from network asynchronously in background thred. 
                      UIImageViewNetwork also caches downloaded image to reuse. 
                      Purge cached images for memory warning.  

                       DESC
  s.homepage         = "https://github.com/ibhupi/UIImageViewNetwork"
  s.license          = 'MIT'
  s.author           = { "Bhupendra Singh" => "ibhupi@gmail.com" }
  s.source           = { :git => "https://github.com/ibhupi/UIImageViewNetwork.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ibhupi'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'UIImageViewNetwork/Classes/**/*'

end
