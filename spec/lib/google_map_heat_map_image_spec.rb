require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GoogleMap::HeatMap::Image do
  
  before(:each) do
    force_delete("tmp/spec_test_plots.log")
    force_delete("tmp/spec_test_image32.png")
    force_delete("tmp/spec_test_image64.png")
  end
  
  it "ヒートマップを生成。witdh-64" do
    
    plot_file_name = "spec_test_plots.log"
    prefix = "spec_test_image64"
    
    create_test_plot_file(plot_file_name)
    image_pre_condition(prefix)
    
    GoogleMap::HeatMap::Image.new(prefix, "tmp/#{plot_file_name}").write("tmp/#{prefix}.png")
    
    image_post_condition(prefix)
  end
  
  it "ヒートマップを生成。witdh-32" do
    
    plot_file_name = "spec_test_plots.log"
    prefix = "spec_test_image32"
    
    create_test_plot_file(plot_file_name)
    image_pre_condition(prefix)
    
    GoogleMap::HeatMap::Image.new(prefix, "tmp/#{plot_file_name}", 32).write("tmp/#{prefix}.png")
    
    image_post_condition(prefix)
  end
  
  def create_test_plot_file(plot_file_name = "spec_test_plots.log")
    File.open("tmp/#{plot_file_name}", "w"){|file|
      file.write(["100, 100, 東京", "100, 200, 大阪"].join("\n"))
    }
  end
  
  def image_pre_condition(prefix)
    File.exists?("tmp/spec_test_plots.log").should be_true
    File.exists?("tmp/#{prefix}.png").should be_false
  end
  
  def image_post_condition(prefix)
    File.exists?("tmp/spec_test_plots.log").should be_true
    File.exists?("tmp/#{prefix}.png").should be_true
  end
  
  def force_delete(file_name)
    begin
      File.delete(file_name)
    rescue
      # ignores.  
    end
  end
  
end
