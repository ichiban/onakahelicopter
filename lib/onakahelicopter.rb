require 'data_mapper'
require 'sunspot'
require 'sunspot/data_mapper'

require 'oh/dajare'

module OnakaHelicopter
  DataMapper.setup :default, ENV['DATABASE_URL'] || 'sqlite3:oh.db'
  DataMapper.finalize
end

OH = OnakaHelicopter
