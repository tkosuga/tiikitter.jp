class TiikitterController < ApplicationController
  
  def index
    
    buzz = Area.cached_diagnoses.to_order_sorted_array
    max_item_length = buzz.size < 100 ? buzz.size : 100
    
    @items = buzz[0..max_item_length]
    
    @total_count = @items.inject(0){|result, item| 
      result += item[1]
      result
    }
    
  end
  
  def show
    @word = params[:word]
    @timelines = Timeline.query(@word)
  end
  
  def user
    @screen_name = params[:screen_name]
    if (@screen_name.blank?)
      @screen_name = "全員"
      @timelines = Timeline.find(:all, :conditions => ["user_screen_name IS NOT NULL"], :limit => 500, :order => "id desc")
    else
      @timelines = Timeline.find(:all, :conditions => ["user_screen_name = ?", @screen_name], :limit => 500, :order => "id desc")
    end
  end
  
  def date
    
    if (params[:date].blank?)
      redirect_to "/date/" + Date.today.strftime("%Y-%m-%d")
      return
    end 
    
    @date = Date.parse(params[:date])
    #
    # paginationを追加する。
    #
    @timelines = Timeline.find(:all, :conditions => ["date_trunc('day', (time_line_created_at + '9 hours')) = ?", @date], :limit => 200, :order => "id desc")
  end
  
  def about
    
  end
  
end
