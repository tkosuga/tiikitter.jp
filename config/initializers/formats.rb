ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!({
  :default => "%Y/%m/%d %H:%M:%S",
})

ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!({
  :default => "%Y/%m/%d",
})

