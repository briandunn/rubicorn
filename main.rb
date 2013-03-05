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

class NSImage
  def CGImage
    source = CGImageSourceCreateWithData(self.TIFFRepresentation, nil)
    CGImageSourceCreateImageAtIndex(source, 0, nil)
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

def ns_image
  @ns_image ||= begin
    funnies = JSON.parse Net::HTTP.get URI 'http://imgur.com/r/funny.json'
    image = Imgur.new funnies["data"].sample
    NSImage.alloc.initWithContentsOfURL NSURL.alloc.initWithString p image.url
  end
end

def main_view
  @main_view ||= window.contentView
end

def image_layer
  CALayer.layer.tap do |layer|
    layer.setContents ns_image.CGImage
    layer.setBounds CGRectMake(0.0, 0.0, ns_image.size.width, ns_image.size.height)
    layer.setPosition CGPointMake(ns_image.size.width, ns_image.size.height)
  end
end

main_view.setWantsLayer true
layer = CALayer.layer
main_view.setLayer layer

layer.addSublayer image_layer
layer.setNeedsDisplay

# p "window's view: ", window.contentView
# p "window's view: ", window.contentView.frame


# layer.setBackgroundColor NSColor.colorWithCalibratedHue 999, saturation:0, brightness: 0.6, alpha:0.5
# layer.opaque = true
# window.display
# window.contentView.setDelegate self
window.makeKeyAndOrderFront nil
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
#
__END__
    [super viewDidLoad];
    
    {   // Create a path to animate a layer on. We will also draw the path.
        _path = CGPathCreateMutable();
        CGPoint origin = CGPointMake(-30.0, 480.0);
        CGPoint destination = CGPointMake(350.0, origin.y);
        CGFloat midpoint = (destination.x + origin.x) / 2.0;
        CGFloat peak = 350.0;
        CGPathMoveToPoint(_path, NULL, origin.x, origin.y);
        
        CGPathAddCurveToPoint(_path, NULL, midpoint, peak,
                              midpoint, peak,
                              destination.x, destination.y);

    }
    
    // This is the layer that animates along the path. 
    CALayer *layer = [CALayer layer];
    
    [layer setShadowColorUIColor blackColor].CGColor];
    [layer setContents:(__bridge id)[UIImage imageNamed:@"american-flag.png"].CGImage];
    [layer setBounds:CGRectMake(0.0, 0.0, 75.0, 75.0)];
    [layer setPosition:CGPointMake(15.0, 15.0)];
    [layer setShadowPathUIBezierPath bezierPathWithRectlayer bounds]].CGPath];
    [layer setShadowOpacity:0.8];
    [layer setShadowOffset:CGSizeMake(5.0, 5.0)];
    
    [[[self view] layer] addSublayer:layer];
    
    [self addPathAnimationToLayer:layer shouldRepeat:YES];
    
    // Set the view layer's delegate to the view controller. The delegate simply draws the path.
    [[[self view] layer] setContentsScale[UIScreen mainScreen] scale]];
    [[[self view] layer] setDelegate:self];
    [[[self view] layer] setNeedsDisplay];
