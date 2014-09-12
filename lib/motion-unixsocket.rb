require 'unix/version'
require 'motion.h'

unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

Motion::Project::App.setup do |app|
  Dir.glob(File.join(File.dirname(__FILE__), "unix/**/*.rb")).each do |file|
    app.files.unshift(file)
  end

  app.include 'sys/socket.h'
  app.include 'sys/un.h'
end
