Dir.chdir(File.dirname(__FILE__) + "/../../")

require "app/script/bootstrapper"

log = File.basename(__FILE__)

bootstrap('Location.wirte_popular_plot("tmp/popular.log")', log)
bootstrap('GoogleMap::HeatMap::Image.new("popular", "tmp/popular.log", 32).write("public/images/heatmaps/popular.png")', log)