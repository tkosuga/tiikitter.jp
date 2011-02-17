Dir.chdir(File.dirname(__FILE__) + "/../../")

require "app/script/bootstrapper"

bootstrap("Bot.refollow_all", File.basename(__FILE__))