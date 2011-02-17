class TimelineDiagnosis < ActiveRecord::Base
  
  belongs_to :timeline
  belongs_to :sentence
  
  #
  # センテンスの出現回数を返します。以下のようにキーがid、値が出現回数です。
  # {775=>1, 786=>1, 753=>1, 764=>2, 781=>1,}
  #
  def self.sentence_counts
    
    sql = "
      select
        sentence_id as id, 
        count(sentence_id) as count 
      from 
        timeline_diagnoses
      where
        created_at > (now() - interval '60 days')
      group by 
        sentence_id
      order by
        count desc
      limit
        3000"
    
    find_by_sql(sql).inject({}){|result, diagnosis|
      result[diagnosis["id"]] = diagnosis["count"].to_i
      result
    }
    
  end
  
  #
  # 勢いのあるセンテンスの出現回数を返します。以下のようにキーがid、値が出現回数です。
  # {775=>1, 786=>1, 753=>1, 764=>2, 781=>1,}
  #
  def self.growing_sentence_counts
    
    sql = "
      select 
        sentence_id as id, 
        count(sentence_id) as count 
      from
        timeline_diagnoses
      where
        created_at > (now() - interval '1 days')
      group by 
        sentence_id
      order by
        count desc
      limit
        14"
    
    find_by_sql(sql).inject({}){|result, diagnosis|
      result[diagnosis["id"]] = diagnosis["count"].to_i
      result
    }
    
  end
  
  #
  # 47都道府県のセンテンス出現回数を返します。以下のようにキーがid、値が出現回数です。
  # {775=>1, 786=>1, 753=>1, 764=>2, 781=>1,}
  #
  def self.sentence_counts_of_japanease_states
    
    location_ids = Location.find(:all, :select => "id, name", :conditions => ["name in (?)", StateConstants.japanese_states_names]).collect{|m|
      m.id
    }
    sql = "
      select
        sentences.id as id, 
        count(sentences.id) as count 
      from 
        timeline_diagnoses, sentences
      where
        timeline_diagnoses.sentence_id = sentences.id
      and      
        sentences.location_id in (select id from locations where id in (?))
      and
        timeline_diagnoses.created_at > (now() - interval '60 days')
      group by 
        sentences.id
      order by
        count desc
      limit
        3000"
    
    find_by_sql([sql, location_ids]).inject({}){|result, diagnosis|
      result[diagnosis["id"]] = diagnosis["count"].to_i
      result
    }
    
  end
  
end
