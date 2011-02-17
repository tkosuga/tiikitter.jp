class Area
  
  def self.update
    Timeline.find(:all, :limit => 2000, :order => "id desc").each{|timeline|
      timeline.generate_sentences
    }
  end
  
  #
  # タイムラインを診断し、発言の多かった地域情報を返します。
  #　以下の形式のマップを返します。
  # {"国道"=>1, "伊豆"=>1, "沖縄"=>1}
  #
  def self.japanese_states_diagnoses
    
    sentence_counts = TimelineDiagnosis.sentence_counts_of_japanease_states
    location_name_counts = to_location_name_counts(sentence_counts)
    
    CacheServer.instance.put("japanese_states_diagnoses", location_name_counts, 0)
    
    location_name_counts
    
  end
  
  #
  # キャッシュしている{japanese_states_diagnoses}を返します。
  #
  def self.cached_japanese_states_diagnoses
    result = CacheServer.instance.get("japanese_states_diagnoses")
    result.blank?? diagnoses : result
  end
  
  #
  # タイムラインを診断し、発言の多かった地域情報を返します。
  #　以下の形式のマップを返します。
  # {"国道"=>1, "伊豆"=>1, "沖縄"=>1}
  #
  def self.diagnoses
    
    sentence_counts = TimelineDiagnosis.sentence_counts
    location_name_counts = to_location_name_counts(sentence_counts)
    
    CacheServer.instance.put("diagnoses", location_name_counts, 0)
    
    location_name_counts
    
  end
  
  #
  # キャッシュしている{diagnoses}を返します。
  #
  def self.cached_diagnoses
    result = CacheServer.instance.get("diagnoses")
    result.blank?? diagnoses : result
  end
  
  #
  # 指定したセンテンスのカウントが格納されているマップのキーを、
  #　地名に変換したマップを返します。
  #
  def self.to_location_name_counts(sentence_counts)
    Sentence.find(sentence_counts.keys).inject({}){|result, sentence|
      result[sentence.text] = sentence_counts[sentence.id]
      result
    }
  end
  
end
