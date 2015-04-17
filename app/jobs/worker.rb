require 'open-uri'
require 'zlib'
require 'yajl'

require_relative '../models/event'

class Worker
  @queue = :archive

  def self.perform
    time = Date.today.prev_day.to_s
  	#time = Time.now.to_s
		time = DateTime.parse(time).strftime("%Y-%m-%d")

		link = "http://data.githubarchive.org/"
		link.concat(time)
		link.concat("-12.json.gz")
		gz = open("http://data.githubarchive.org/2015-01-01-12.json.gz")
  		js = Zlib::GzipReader.new(gz).read
  
  		events = []
  		Yajl::Parser.parse(js) do |event|
  			#add in database
        currentEvent = Event.all(:_id => event['id'])
        
        if currentEvent != []
          events.push(currentEvent[0])
        else  
          event = Event.create(
              :_id => event['id'],
              :type => event['type'],
              :public => event['public'],
              :created_at => event['created_at'])
          events.push(event)
        end
  		end
      print 'done!'
  end
end
#gz = open('http://data.githubarchive.org/2015-01-01-12.json.gz')
  #js = Zlib::GzipReader.new(gz).read
  #
  #events = []
  #Yajl::Parser.parse(js) do |event|
  #    currentEvent = Event.all(:_id => event['id'])
  #
  #    if currentEvent
  #        events.push(currentEvent[0])
  #    else
  #        actor = Actor.new(
  #           :_id => event['actor']['id'],
  #           :login => event['actor']['login'],
  #           :gravatar_id => event['actor']['gravatar_id'],
  #           :url => event['actor']['url'],
  #           :avatar_url => event['actor']['avatar_url']
  #           )
  #
  #        repo = Repo.new(
  #           :_id => event['repo']['id'],
  #           :name => event['repo']['name'],
  #           :url => event['repo']['url'])
  #
  #        ## payload
  #
  #        events.push(Event.new(
  #            :_id => event['id'],
  #            :type => event['type'],
  #            :actor => actor,
  #            :repo => repo,
  #            :public => event['public'],
  #            :created_at => event['created_at']))
  #
  #    end
  #
  #        #    break # to delete
  #        #
  #end