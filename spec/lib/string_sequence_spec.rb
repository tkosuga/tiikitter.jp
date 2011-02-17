require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StringSequence do
  
  include StringSequence
  
  it "building_by_alphabets_or_marks_string?" do
    
    building_by_alphabets_or_marks_string?("kiyo78").should be_true
    building_by_alphabets_or_marks_string?("32kiyo").should be_true
    building_by_alphabets_or_marks_string?("ki*yo").should be_true
    building_by_alphabets_or_marks_string?("@ki*yo").should be_true
    
    building_by_alphabets_or_marks_string?("@kiあyo").should be_false
    
  end
  
  it "building_by_short_japanese_hiragana_string?" do
    
    building_by_short_japanese_hiragana_string?("ああ").should be_true
    building_by_short_japanese_hiragana_string?("はか").should be_true
    building_by_short_japanese_hiragana_string?("よし").should be_true
    building_by_short_japanese_hiragana_string?("ある").should be_true
    building_by_short_japanese_hiragana_string?("あれ").should be_true
    building_by_short_japanese_hiragana_string?("あぁ").should be_true
    building_by_short_japanese_hiragana_string?("あっ").should be_true
    building_by_short_japanese_hiragana_string?("あぉ").should be_true
    
    building_by_short_japanese_hiragana_string?("あああ").should be_false
    building_by_short_japanese_hiragana_string?("あばば").should be_false
    building_by_short_japanese_hiragana_string?("ごちそうさま").should be_false
    building_by_short_japanese_hiragana_string?("@kiあyo").should be_false
    
  end
  
end
