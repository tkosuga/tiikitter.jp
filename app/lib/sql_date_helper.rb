module SqlDateHelper
  
  def sql_date_of_days_ago(days)
   (Date.today - days).strftime("%Y/%m/%d")
  end  
  
end
