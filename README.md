Building postgresql database to be used by sql-ledger application

docker compose -f stack.yml up

sql-ledger db conn pararms 

host: db <-- db service in stack.yml
port: 5432 <--- visible within app container
user: sqlledger
password: sqlledger
connect to: sqlledger

