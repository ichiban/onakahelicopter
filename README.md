```shell
rake sunspot:solr:run &
rake db:migrate
sqlite3 oh.db < he.sql
rake index:update
rackup
```