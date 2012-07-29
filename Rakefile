# -*- coding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))
require 'app'
require 'sunspot_solr'
require 'sunspot/solr/tasks'
require 'pp'

task :environment

namespace :db do
  task :migrate do
    DataMapper.auto_migrate!
  end

  task :upgrade do
    DataMapper.auto_upgrade!
  end
end

namespace :index do
  task :update do
    Sunspot.remove_all
    OnakaHelicopter::Dajare.all.each do |dajare|
      Sunspot.index dajare
    end
    Sunspot.commit
  end
end

task :onaka, [:text] do |t, args|
  OH::Dajare.create :text => args.text
end

task :suggest, [:text] do |t, args|
  search = Sunspot.search(OH::Dajare) do
    fulltext args.text
  end

  search.results.each do |dajare|
    puts [dajare.deta ? 'たぶん出た' : 'たぶん出てない', dajare.text].join("\t")
  end
end
