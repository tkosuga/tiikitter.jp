#
# これの 移植。
# http://wiki.forum.nokia.com/index.php/Google_Maps_API_in_Java_ME%EF%BC%88%E6%97%A5%E6%9C%AC%E8%AA%9E%EF%BC%89 
#
class GoogleMap::GeoCoder
  
  include Math
  
  OFFSET = 2 ** 28
  RADIUS = OFFSET / Math::PI
  
  #
  # 経度を指定したピクセルで移動します
  #
  def move_lng_by_pixel(x, delta, zoom)
   (((lng_to_x(x)+(delta << (21 - zoom))) - OFFSET) / RADIUS) * 180 / Math::PI
  end
  
  #
  # 経度と経度の距離をピクセルで返します
  #
  def lng_to_pixel(from, to, zoom)
   ((lng_to_x(from) - lng_to_x(to)) >> (21 - zoom))
  end
  
  def lng_to_x(lng)
   (OFFSET + RADIUS * lng * Math::PI / 180).round
  end
  
  #
  # 緯度を指定したピクセルで移動します
  #
  def move_lat_by_pixel(y, delta, zoom)
   (Math::PI / 2 - 2 * atan(exp(((lat_to_y(y)+(delta << (21-zoom))) - OFFSET) / RADIUS))) * 180 / Math::PI
  end
  
  #
  # 緯度と緯度の距離をピクセルで返します
  #
  #  def lat_to_pixel(lat = 0, zoom = 5)
  #    
  #    exp = sin(lat*Math::PI/180)
  #    
  #    exp = -0.9999 if (exp < -0.9999)
  #    exp =  0.9999 if (exp >  0.9999)
  #    
  #     (256*(2^(zoom-1)))+(0.5*log((1+exp)/(1-exp)))*((-256*(2 ** zoom))/(2*Math::PI))
  #  end 
  
  #
  # 緯度と緯度の距離をピクセルで返します
  #
  def lat_to_pixel(from, to, zoom)
   ((lat_to_y(from) - lat_to_y(to)) >> (21 - zoom)) * -1
  end
  
  def lat_to_y(lng)
   ((OFFSET - RADIUS * log((1 + sin(lng * Math::PI / 180)) / (1 - sin(lng * Math::PI / 180))) / 2)).round
  end
  
end