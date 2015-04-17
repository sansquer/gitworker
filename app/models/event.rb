class Event
	include MongoMapper::Document

	key :_id, String, :null => false
	key :type, String, :null => false

	#one :actor, :null => true
	#one :repo, :null => true

	key :public, Boolean, :null => false
	key :created_at, String, :null => false

end