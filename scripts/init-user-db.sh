#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	CREATE USER sql-ledger;
	CREATE DATABASE sql-ledger;
	GRANT ALL PRIVILEGES ON DATABASE sql-ledger TO sql-ledger;
EOSQL
