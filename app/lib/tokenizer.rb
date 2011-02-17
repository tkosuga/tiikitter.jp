class Tokenizer
  
  include StateConstants
  include StringSequence
  
  def analize(text)
    
    mecab = MeCab::Tagger.new    
    return if text.blank?
    
    result = []
    
    # 空白文字で区切る
    text.split(/[\s　]+/).each{|text_node|
      
      tokens = []
      n = mecab.parseToNode(text_node)
      
      index = 0
      while n
        if (necessary?(n.surface, n.feature))
          tokens[index] ||= []
          tokens[index] << n.surface
        end
        n = n.next
      end
      
      result << tokens
    }
    result.flatten.reject{|value| 
      value.blank?
    }
  end
  
  def necessary?(surface, feature)
    
    #p surface + ", feature:" + feature
    
    #
    # 1文字だけで地名になるもので、一般的すぎるものは除外する。
    # その他にも期待しないものを除外。
    #
    return false if %w(中 上 下 右 左 赤 青 緑 大 山 日 森 県 東 西 南 北 光 学 米 綾 里 蓮 乙女 ちの).include?(surface)
    
    if (/^名詞,(一般|代名詞|固有名詞)/ =~ feature)
      return true if (/^名詞,(一般|代名詞|固有名詞),地域/ =~ feature)
      return true if (include_place_name?(surface) || include_station_name?(surface) || include_japanese_states?(surface))
    end
    
    false
  end
  
end
