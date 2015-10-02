# Taken from: https://gist.github.com/jpastika/4fa9e02ffafcb6aae949
# Load plugins (only those I whitelist)
Pry.config.should_load_plugins = false
require 'pry-byebug'

# Launch Pry with access to the entire Rails stack.
# If you have Pry in your Gemfile, you can pass: ./script/console --irb=pry instead.
# If you don't, you can load it through the lines below :)
rails = File.join Dir.getwd, 'config', 'environment.rb'

if File.exist?(rails) && ENV['SKIP_RAILS'].nil?
  require rails

  begin
    require 'awesome_print'
    AwesomePrint.pry!
    #Pry.config.print = proc { |output, value| output.puts value.ai }
  rescue LoadError => err
    puts "no awesome_print :("
  end

  if Rails.version[0..0] == "2"
    require 'console_app'
    require 'console_with_helpers'
  elsif Rails.version[0..0] == "3" || Rails.version[0..0] == "4"
    require 'rails/console/app'
    require 'rails/console/helpers'
  else
    warn "[WARN] cannot load Rails console commands (Not on Rails2 or Rails3?)"
  end
end

if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

Pry::Commands.command /^$/, "repeat last command" do
  _pry_.run_command Pry.history.to_a.last
end

# Idea from: http://stackoverflow.com/questions/15536815/opening-the-pry-console-in-sandbox-mode
def sandbox
  require 'active_record/railties/console_sandbox'
end

