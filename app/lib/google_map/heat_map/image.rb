require 'RMagick'
require 'rvg/rvg'

module GoogleMap::HeatMap
  class Image < GoogleMap::HeatMap::Definition
    
    include Magick
    
    def initialize(name, path, width = 64)
      super(width)
      @name = name
      @dots = Dot.parse(path, width)
      @opacity = 0.50
    end
    
    def write(path)
      
      base = base_image
      spot = spot_image
      
      @dots.each{|dot|
        puts "plot. #{dot.x}, #{dot.y}, #{dot.count}"
        composite(base, spot, dot)
      }
      
      base.negate.write("tmp/#{@name}.full.png")
      
      system("/usr/local/bin/convert tmp/#{@name}.full.png -type TruecolorMatte 'data/heatmap/colors.png' -fx 'v.p{0,u*v.h}' tmp/#{@name}.colorized.png")
      system("/usr/local/bin/convert tmp/#{@name}.colorized.png -channel A -fx 'A*#{@opacity.to_s}' #{path}")
    end
    
    private
    
    def base_image
      img = Magick::Image.new(@image_w, @image_h)
      img.background_color = 'transparent'
      img.alpha = ActivateAlphaChannel
      img
    end
    
    def spot_image
      img = Magick::Image.read(@spot_file_name).first
      img.alpha = ActivateAlphaChannel
      img
    end
    
    def max_count
      @dots.collect{|dot| dot.count}.max
    end
    
    def composite(image, spot, dot)
      spot.opacity = dot.opacity(max_count)
      image.composite!(spot, NorthWestGravity, dot.center_x, dot.center_y, MultiplyCompositeOp)
    end
    
  end
end
