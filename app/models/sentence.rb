class Sentence < ActiveRecord::Base
  
  #
  # この場所の出現回数をあらわす数字です。
  #
  attr_accessor :count
  
  has_many :timeline_diagnoses
  has_many :timelines, :through => :timeline_diagnoses
  
  belongs_to :location
  
  #
  # 指定したロケーションに一致するセンテンスを返します。
  # 既にあればそれを返し、なければ新しく作りそれを返します。
  #
  def self.find_or_create_by_location_text(location_text)
    sentence = Sentence.find(:first, :conditions => {:text => location_text})
    if (sentence.blank?)
      sentence = Sentence.new(:text => location_text, :location => Location.find_by_name(location_text))
      sentence.save! 
    end
    sentence
  end
  
end
