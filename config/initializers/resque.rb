#require 'resque/task'

ENV["REDISTOGO_URL"] ||= "redis://redistogo:21034520ef96c80e16859c93c8413fd3@angelfish.redistogo.com:11366/"

uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)

Dir["/app/app/jobs/*.rb"].each { |file| require file }



#task "resque:setup" => :environment