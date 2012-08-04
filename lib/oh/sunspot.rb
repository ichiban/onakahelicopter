require 'sunspot/data_mapper'

module OnakaHelicopter
  class Dajare
    include Sunspot::DataMapper
  end

  module Sunspot
    ::Sunspot.setup(OH::Dajare) do
      text :text
      boolean :deta
    end
  end
end
