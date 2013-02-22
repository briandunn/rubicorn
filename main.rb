framework 'Cocoa'
size = NSScreen.mainScreen.frame.size
W, H = size.width, size.height
UW = W / 4.0
UH = UW
W_HALF = W / 2.0
UW_HALF = UW / 2.0

NSApplication.sharedApplication
unicornRect = NSMakeRect W / 2.0 - (UW / 2.0), H / 2.0 - (UH / 2.0), UW, UH
window = NSWindow.alloc.initWithContentRect unicornRect, styleMask: NSBorderlessWindowMask, backing: NSBackingStoreBuffered, defer: false
window.setBackgroundColor NSColor.colorWithCalibratedHue 0, saturation:0, brightness:0, alpha:0.0
window.setOpaque false
window.setLevel NSFloatingWindowLevel
unicornImage = NSImage.alloc.initWithContentsOfFile File.expand_path '~/Downloads/unicorn.jpg'
unicornView = NSImageView.alloc.initWithFrame unicornRect
unicornView.setImage unicornImage
window.setContentView unicornView

x = -100.0
while x < W
  x += 20
  y = UH / 40.0 - ((x-W_HALF) ** 2 / W_HALF / 2.0)
  unicornRect = NSMakeRect x - UW_HALF, y, UW, UH
  window.setFrame unicornRect, display: true, animate: false;
  window.makeKeyAndOrderFront nil
end
