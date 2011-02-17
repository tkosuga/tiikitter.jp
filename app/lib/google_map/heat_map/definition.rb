module GoogleMap::HeatMap
  class Definition
    def initialize(width = 64)
      @image_w = 768
      @image_h = 640
      @spot_width = width
      @spot_file_name = "data/heatmap/spot#{@spot_width}.png"
    end
  end
end