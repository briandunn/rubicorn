framework 'Cocoa'
framework 'QuartzCore'
require 'json/pure'
require 'net/http'

Imgur = Struct.new(:json) do
  def url
    "http://i.imgur.com/#{image}#{ext}"
  end

  private

  def image
    json["hash"]
  end

  def ext
    json["ext"]
  end
end

NSApplication.sharedApplication

def window
  @window ||= NSWindow.alloc.initWithContentRect(NSScreen.mainScreen.frame, styleMask: NSTexturedBackgroundWindowMask, backing: NSBackingStoreBuffered, defer: false).tap do |window|
    # window.setBackgroundColor NSColor.colorWithCalibratedHue 0, saturation:0, brightness:0, alpha:0.0
    # window.setOpaque false
    window.setLevel NSFloatingWindowLevel
  end
end

def image_view
  funnies = JSON.parse Net::HTTP.get URI 'http://imgur.com/r/funny.json'
  image = Imgur.new funnies["data"].sample
  ns_image = NSImage.alloc.initWithContentsOfURL NSURL.alloc.initWithString p image.url
  imageview = NSImageView.alloc.initWithFrame window.frame
  imageview.setImage ns_image
  imageview
end

window.contentView.addSubview image_view
window.contentView.setNeedsDisplay true
window.makeKeyAndOrderFront nil

# window.contentView.setWantsLayer true
# layer = CALayer.layer
# window.contentView.setLayer layer

# p "window's view: ", window.contentView
# p "window's view: ", window.contentView.frame


# layer.setBackgroundColor NSColor.colorWithCalibratedHue 999, saturation:0, brightness: 0.6, alpha:0.5
# layer.opaque = true
# window.display
# window.contentView.setDelegate self
sleep 1


# unicornRect = NSMakeRect W / 2.0 - (UW / 2.0), H / 2.0 - (UH / 2.0), UW, UH
# window.setContentView unicornView

# x = -100.0
# while x < W
#   x += 18
#   y = UH / 40.0 - ((x-W_HALF) ** 2 / W_HALF / 2.0)
#   unicornRect = NSMakeRect x - UW_HALF, y, UW, UH
#   window.setFrame unicornRect, display: true, animate: false
#   window.makeKeyAndOrderFront nil
# end
