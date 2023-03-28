#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "${PG_USER}" --dbname "template1" <<-EOSQL
    SELECT 'CREATE DATABASE ${PG_DATABASE}' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = '${PG_DATABASE}')\gexec
    \c ${PG_DATABASE};
    CREATE SCHEMA IF NOT EXISTS ${PG_SCHEMA};
	GRANT ALL PRIVILEGES ON DATABASE ${PG_DATABASE} TO ${PG_USER};
EOSQL