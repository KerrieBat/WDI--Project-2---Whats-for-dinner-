require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'dinners'
}

# ActiveRecord::Base.establish_connection(options)
# ApplicationRecord.establish_connection(options)
ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)
