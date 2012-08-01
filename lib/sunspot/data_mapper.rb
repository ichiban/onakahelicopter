require 'sunspot/rails'

#module Rails
#  def self.root
#    File.expand_path(File.dirname(__FILE__))
#  end
#  def self.env
#    'local'
#  end
#  def self.logger
#    nil
#  end
#end

module Sunspot
  module DataMapper
    def self.included(base)
      base.class_eval do
        alias new_record? new?
      end

      base.extend Sunspot::Rails::Searchable::ActsAsMethods

      Sunspot::Adapters::DataAccessor.register(DataAccessor, base)
      Sunspot::Adapters::InstanceAdapter.register(InstanceAdapter, base)

      def base.before_save(*args, &block)
        before(:save, *args, &block)
      end

      def base.after_save(*args, &block)
        after(:save, *args, &block)
      end

      def base.after_destroy(*args, &block)
        after(:destroy, *args, &block)
      end
    end

    class InstanceAdapter < Sunspot::Adapters::InstanceAdapter
      def id
        @instance.id
      end
    end

    class DataAccessor < Sunspot::Adapters::DataAccessor
      def load(id)
        @clazz.get(id)
      end

      def load_all(ids)
        @clazz.all(:id => ids)
      end
    end
  end
end
