module OnakaHelicopter
  class Dajare
    include DataMapper::Resource
    include Sunspot::DataMapper

    property :id, Serial
    property :text, String, :required => true, :key => true, :unique => true
    property :deta, Boolean, :required => true, :default => false
  end

  Sunspot.setup(OnakaHelicopter::Dajare) do
    text :text
    boolean :deta
  end
end
