class Location < ActiveRecord::Base
  
  extend SqlDateHelper
  
  has_one :sentence
  
  #
  # この場所の出現回数をあらわす数字です。
  #
  attr_accessor :count
  
  #
  # 東京を中心したX座標を返します。これは日本地図上にプロットするときに使われます。
  #
  def plot_x
    x - 3459
  end
  
  #
  # 東京を中心したY座標を返します。これは日本地図上にプロットするときに使われます。
  #
  def plot_y
    y +  820 
  end
  
  #
  # 最新のTimelineを返します。
  #
  def timeline
    #
    # 24時間以内とかにすれば高速に動作する。
    #
    Sentence.find(:first, :conditions => ["text = ?", name]).timelines.last
  end
  
  #
  # ヒートマップのプロット場所を配列で返します。
  #
  def to_plot_items
    
    return [] if (plot_x < 0 || plot_y < 0)
    
    result = []
    Math.sqrt(count).to_i.times{
      result << "#{plot_x},#{plot_y},#{name}"
    }
    result
    
  end
  
  def self.wirte_popular_plot(output_file_path)
    
    lines = popular_locations.collect{|location| 
      location.to_plot_items
    }.flatten
    
    File.open(output_file_path, "w"){|file|
      file.write(lines.join("\n"))
    }
    
  end
  
  def self.popular_locations(count = 5, days = 21)
    
    find_by_sql("
      select
        sentence_id as id,
        count(sentence_id) as count 
      from 
       (select
          sentence_id
        from
          timeline_diagnoses
        where
          created_at > '#{sql_date_of_days_ago(days)}'
        ) as timeline_diagnoses
      group by
        sentence_id 
      having
        count(sentence_id) >= #{count}").collect{|result| 
      
      sentence = Sentence.find(result["id"])
      if (sentence.blank? || sentence.location.blank?)
        nil
      else
        sentence.location.count = result["count"].to_i
        sentence.location
      end
      
    }.reject{|location| 
      location.nil?
    }
    
  end
  
end