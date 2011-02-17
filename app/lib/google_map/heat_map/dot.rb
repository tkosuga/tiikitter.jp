module GoogleMap::HeatMap
  class Dot < GoogleMap::HeatMap::Definition
    
    attr_reader :x, :y
    
    def self.parse(name, width = 64)
      parse_lines(IO.readlines(name), width)
    end
    
    def self.parse_lines(lines, width = 64)
      
      dots = lines.collect{|line| self.new(line, width)}
      dots.inject({}){|hash, dot|
        key = dot.x.to_s + "," + dot.y.to_s
        if (hash[key].blank?)
          hash[key] = dot.do_count(dots)
        else
          dot.count = hash[key]
        end
        hash
      }
      dots.uniq
    end
    
    def initialize(line, witdh = 64)
      super(witdh)
      @x, @y = line.strip.split(",")[0..1].collect{|v| v.to_i.to_f}
    end
    
    def hash
      result = 23
      result = 37 * result + x.to_i
      result = 37 * result + y.to_i
      result
    end
    
    def eql?(other)
      other.x == x && other.y == y
    end
    
    def do_count(dots)
      @count = dots.count{|v| v.x == self.x && v.y == self.y}
    end
    
    def count=(count)
      @count = count
    end
    
    def count
      @count
    end
    
    def center_x
      @x - half_w
    end
    
    def center_y
      transform_y - half_w
    end
    
    def opacity(max_count)
     (1 - count.to_f / max_count) * 255
    end
    
    private
    
    #
    # 指定したy座標の拡大縮小を行ないます。
    # 縮尺を加えるのは、heightからtopを除いた下部分です。
    #
    def google_maps_scale_y(height, top, supplementary = 0)
      scale = height / @image_h
      under = @y - top
      scaled_y = top + scale * under
       (@y * (@y / scaled_y) + supplementary).round.to_f
    end
    
    #
    # Google maps の座標に合わせるために、y座標の拡大縮小を行ないます。
    # これはmap#addOverlayを使い表示された画像が、y軸に分割され、かつ縮尺が変更されるためです。
    #
    #　これは東京を中心とした縮尺のされ方に合せています。
    # 中心を変更した場合には分割のされ方が変更されるため、このコードは修正が必要です。
    #
    #　以下画像ファイルに適用されるスタイル。heightが元画像サイズと異なっています。
    #
    # border: 0px none ; margin: 0px; padding: 0px; position: absolute; left: 0px; top:    0px; width: 768px; height: 728.331px; -moz-user-select: none;
    # border: 0px none ; margin: 0px; padding: 0px; position: absolute; left: 0px; top: -114px; width: 768px; height: 682.266px; -moz-user-select: none;
    # border: 0px none ; margin: 0px; padding: 0px; position: absolute; left: 0px; top: -224px; width: 768px; height: 640.779px; -moz-user-select: none;
    # border: 0px none ; margin: 0px; padding: 0px; position: absolute; left: 0px; top: -335px; width: 768px; height: 603.719px; -moz-user-select: none;
    # border: 0px none ; margin: 0px; padding: 0px; position: absolute; left: 0px; top: -450px; width: 768px; height: 573.805px; -moz-user-select: none;
    #
    #　以下分割されたdivに適用されるスタイル。
    #
    # overflow: hidden; position: absolute; left: -27px; top: -119px; width: 768px; height: 121px;
    # overflow: hidden; position: absolute; left: -27px; top:    2px; width: 768px; height: 125px;
    # overflow: hidden; position: absolute; left: -27px; top:  127px; width: 768px; height: 131px;
    # overflow: hidden; position: absolute; left: -27px; top:  258px; width: 768px; height: 139px;
    # overflow: hidden; position: absolute; left: -27px; top:  397px; width: 768px; height: 124px;
    #
    def transform_y
      case
      when (@y <= 121)
        google_maps_scale_y(728.331, 0, 16)
      when (@y <= 183.5)
        google_maps_scale_y(705.2985, 60, 8)
      when (@y <= 246)
        google_maps_scale_y(682.266, 121)
      when (@y <= 311)
        google_maps_scale_y(680.779, 186)
      when (@y <= 377)
        google_maps_scale_y(680.779, 246)
      when (@y <= 516)
        google_maps_scale_y(603.719, 377, -6)
      else
        google_maps_scale_y(573.805, 516, 4)
      end
    end
    
    def half_w
      @spot_width / 2
    end
    
  end
end
