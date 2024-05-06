SQL-Ledger =

Tagline ==

Effortless business management with SQL-Ledger: intuitive, powerful, and now on Umbrel. Seamlessly handle orders, invoices, inventory, and more with precision and ease.

Long description ==

Revolutionize your business management with SQL-Ledger, the dynamic web-based solution now available on the versatile Umbrel platform. Whether you're on a Mac or Windows system, experience seamless integration and unparalleled functionality.

Effortlessly streamline your operations with SQL-Ledger's comprehensive suite of features. From managing customer orders, shipments, and billing to handling purchase orders, vendor invoices, inventory, and general ledger tasks – it's all at your fingertips.

Say goodbye to steep learning curves. SQL-Ledger boasts an intuitive interface designed to empower users of all levels. Spend less time figuring out complex software and more time focusing on what matters most – growing your business.

Ready to take the leap? Try SQL-Ledger now and discover the efficiency and ease it brings to your business operations. Unlock the potential of your enterprise with a solution built for success.

Technical details ==

sql-ledger database conn params in http://umbrel.local/sql-ledger/admin.pl

host: db
port: 5432
user: sql-ledger
password: sql-ledger
connect to: template1

Enable "Experimental Features" in docker ==
export DOCKER_CLI_EXPERIMENTAL=enabled

Push sql-ledger container to hub.docker.com ===
docker buildx build --file Dockerfile.app  --platform linux/amd64 --tag ch1pp3w4/sl-app:v0.0.1 --output type=registry .

Push postgresql database for sql-ledger container to hub.docker.com ===
docker buildx build --file Dockerfile.psql  --platform linux/amd64 --tag ch1pp3w4/sl-psql:v0.0.1 --output type=registry .
