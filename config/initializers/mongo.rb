@dbhost = 'ds045907.mongolab.com'
@dbport = '45907'
@dbuser = 'user'
@dbpass = 'ingesup'
@db = 'dashboard'

MongoMapper.connection = Mongo::Connection.new(@dbhost, @dbport)
MongoMapper.database = @db
MongoMapper.database.authenticate(@dbuser, @dbpass)
