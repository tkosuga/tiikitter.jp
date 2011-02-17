module StringSequence
  
  #
  # ZENKAKU_MARKSから、[～, ー, ・]は除外
  #
  EXCLUDED_MARKS  = %w{～ ー ・}
  ASCII_ART_MARKS = %w{ﾟ ﾉ Д 冫}
  ASCII_MARKS   = %w{… ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ ^ _ ` { | } ~ > <}
  ZENKAKU_MARKS = %w{　 、 。 ， ． ： ； ？ ！ ゛ ゜ ´ ｀ ¨ ＾ ￣ ＿ ヽ ヾ ゝ ゞ 〃 仝 々 〆 〇  ― ‐ ／ ＼  ∥ ｜ … ‥ ‘ ’ “ ” （ ） 〔 〕 ［ ］ ｛ ｝ 〈 〉 《 》 「 」 『 』 【 】 ＋ － ± × ÷ ＝ ≠ ＜ ＞ ≦ ≧ ∞ ∴ ♂ ♀ ° ′ ″ ℃ ￥ ＄ ￠ ￡ ％ ＃ ＆ ＊ ＠ § ☆ ★ ○ ● ◎ ◇ ◆ □ ■ △ ▲ ▽ ▼ ※ 〒 → ← ↑ ↓ 〓 ∈ ∋ ⊆ ⊇ ⊂ ⊃ ∪ ∩ ∧ ∨ ￢ ⇒ ⇔ ∀ ∃ ∠ ⊥ ⌒ ∂ ∇ ≡ ≒ ≪ ≫ √ ∽ ∝ ∵ ∫ ∬ Å ‰ ＃ ♭ ♪ † ‡ ¶ ◯ ─ │ ┌ ┐ ┘ └ ├ ┬ ┤ ┴ ┼ ━ ┃ ┏ ┓ ┛ ┗ ┣ ┳ ┫ ┻ ╋ ┠ ┯ ┨ ┷ ┿ ┝ ┰ ┥ ┸ ╂ ∮ ∑ ∟ ⊿ ￤ ＇ ＂ }
  MARKS = ZENKAKU_MARKS + ASCII_ART_MARKS
  
  def building_by_alphabets_or_marks_string?(str)
    str.split(//u).collect{|c| (ASCII_MARKS + MARKS + ['～', 'ー'] + ("0".."9").to_a + ('a'..'z').to_a + ('A'..'Z').to_a).include?(c)}.all?
  end
  
  def building_by_short_japanese_hiragana_string?(str)
    str.split(//u).collect{|c| %w(あ い う え お か き く け こ さ し す せ そ た ち つ て と な に ぬ ね の は ひ ふ へ ほ ま み む め も や ゆ よ ら り る れ ろ わ を ん っ ぁ ぉ).include?(c)}.all? && str.split(//u).size < 3
  end
  
  def building_by_marks_string?(str)
    str.split(//u).collect{|c| MARKS.include?(c)}.all?
  end
  
end