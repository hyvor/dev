#!/bin/bash

# @source: https://github.com/mrts/docker-postgresql-multiple-databases/blob/master/create-multiple-postgresql-databases.sh

set -e
set -u

function create_user_and_database() {
	local database=$1
	echo "  Creating user and database '$database'"
	psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
	    CREATE USER $database;
	    CREATE DATABASE $database;
	    GRANT ALL PRIVILEGES ON DATABASE $database TO $database;
EOSQL
}

base_dbs="hyvor hyvor_blogs hyvor_talk hyvor_post hyvor_reader"

for db in $base_dbs; do
  echo "Creating DB variants for $db"
  create_user_and_database $db
  create_user_and_database $db"_testing"
  create_user_and_database $db"_e2e"
done