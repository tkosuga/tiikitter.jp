Dir.chdir(File.dirname(__FILE__) + "/../../")

require "app/script/bootstrapper"

log = File.basename(__FILE__)

bootstrap("Bot.update_recent_timelines_all", log)
bootstrap("Area.update", log)
bootstrap("Area.diagnoses", log)
bootstrap("Area.japanese_states_diagnoses", log)
