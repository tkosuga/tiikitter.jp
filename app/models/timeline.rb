class Timeline < ActiveRecord::Base
  
  named_scope :recents, :order => "id desc", :limit => 8
  
  has_many :timeline_diagnoses
  has_many :sentences, :through => :timeline_diagnoses, :order => "id desc"
  
  #
  #　部分一致から完全一致に。
  # 
  def self.query(word)
    
    sentence_ids = Sentence.find(:all, :select => "id", :conditions => ["text = ?", word]).collect{|sentence| 
      sentence.id
    }
    timeline_ids = TimelineDiagnosis.find(:all, :select => "timeline_id", :conditions => {:sentence_id => sentence_ids}, :order => "id desc", :limit => 300).collect{|item| 
      item.timeline_id
    }
    Timeline.find(timeline_ids, :order => "id desc")
    
  end
  
  #
  # 指定したtwitterのポストデータに一致するタイムラインが存在しなければ、新しく追加します。
  # 既に存在していれば何も行ないません。
  #　メッセージに地名が含まれているタイムラインのみ収集するため、メッセージに地名が含まれていなければ何も行ないません。
  #
  def self.generate_timeline(data)
    
    return if(Timeline.exists?(:time_line_id => data.id))
    
    timeline = Timeline.new({
      :time_line_id           => data.id,
      :time_line_created_at   => data.created_at,
      :in_reply_to_status_id  => data.in_reply_to_status_id,
      :text                   => data.text,
      :source                 => Hpricot.XML(data.source).innerText,
      :user_name              => data.user.name,
      :user_screen_name       => data.user.screen_name,
      :profile_image_uri      => data.user.profile_image_url
    })
    timeline.save! if (Tokenizer.new.analize(timeline.text).present?)
    
  end
  
  #
  # 最後に取得したタイムラインのsince_idを取得します。
  # 取得したタイムラインがなければ1を返します。
  #
  def self.since_id
    recent_item = Timeline.find(:first, :order => "id desc")
    recent_item.blank?? 1 : recent_item.time_line_id
  end
  
  #
  # このタイムラインからセンテンスを生成します。
  #　既に作られている場合には何も行ないません。
  #
  def generate_sentences
    
    return if (self.sentences.present?)
    
    self.sentences = Tokenizer.new.analize(text).collect{|location_text|
      Sentence.find_or_create_by_location_text(location_text)
    }
    self.save!
    
  end
  
end
