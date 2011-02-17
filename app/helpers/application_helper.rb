module ApplicationHelper
  
  def states_linked_text(timeline)
    
    #
    # 後でちゃんと直す！これおかしいコード
    #　分かった。例えば大阪という単語が複数回タイムラインに含まれていた場合、２つとしてカウントされるからだ。関連テーブルに同じ組が２つ作られる。
    #
    words = []
    
    s = timeline.text.dup
    timeline.sentences.each{|sentence|
      
      unless (words.include?(sentence.text))
        words << sentence.text
        s.gsub!(/#{sentence.text}/){link_to(sentence.text, "/show/#{sentence.text}")}
      end
      
    }
    s
  end
  
  def item_cloud(items, total_count)
    
    s = "<ul class='tagCloud'>"
    items.each_with_index{|item, index|
      s += %(<li>#{link_to item[0], "/show/" + item[0]}<span>(#{item[1].to_s})</span></li>)
    }
    s += "</ul>"
    
  end
  
end
