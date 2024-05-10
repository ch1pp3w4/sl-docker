# Dockerized SQL-Ledger 

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## Description

SQL-Ledger is a effortless business management application: intuitive and powerful. Seamlessly handle orders, invoices, inventory, and more with precision and ease.

Revolutionize your business management with SQL-Ledger, the dynamic web-based solution. Whether you're on a Mac, Windows or Linux system, experience seamless integration and unparalleled functionality.

Effortlessly streamline your operations with SQL-Ledger's comprehensive suite of features. From managing customer orders, shipments, and billing to handling purchase orders, vendor invoices, inventory, and general ledger tasks – it's all at your fingertips.

Say goodbye to steep learning curves. SQL-Ledger boasts an intuitive interface designed to empower users of all levels. Spend less time figuring out complex software and more time focusing on what matters most – growing your business.

Ready to take the leap? Try SQL-Ledger now and discover the efficiency and ease it brings to your business operations. Unlock the potential of your enterprise with a solution built for success.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Prerequisites

- docker
- git

## Installation

Provide instructions on how to install and run your project. Include any prerequisites and steps for setup.

```bash
git clone https://github.com/ch1pp3w4/sl-docker.git
cd sl-docker
docker compose -f config.yml up
```

## Usage

Now, in the web broser point to http://localhost/sql-ledger/admin.pl, to create the database, enter these data:
- Server: db
- Port: 5432    
- User: sql-ledger
- Password: sql-ledger
- Database: template1

# Additional setup commands
Finally, let's enter your company data (the below data is just for ilustrative purposes):
- Company id: demo
- Company name: My Demo Company LLC
- Admin: admin
- Admin password: admin (only numbers and letters, uppercase and lowercase)
- Charset: 
- Chart of Accounts: US General (this is a template, you can add/change/delete whatever you want)

Feel free to customize this template to fit your project's specific needs. You can add more sections, such as "Features", "Documentation", or "Support", depending on what's relevant for your project. Additionally, you can include badges, such as license badges or build status badges, to provide additional information to users.

Point your web browser to http://localhost/sql-ledger, use your admin user and password previously created.

This is an overview of usage per function: https://sql-ledger.com/cgi-bin/nav.pl?page=feature/index.html&title=Features

If you want to get a user guide, you can buy the official version here: https://sql-ledger.com/cgi-bin/nav.pl?page=misc/documentation.html&title=documentation

## Contributing


## License

--------------------------------------

Enable "Experimental Features" in docker ==
export DOCKER_CLI_EXPERIMENTAL=enabled

Push sql-ledger container to hub.docker.com ===
docker buildx build --file Dockerfile.app  --platform linux/amd64 --tag ch1pp3w4/sl-app:v0.0.1 --output type=registry .

Push postgresql database for sql-ledger container to hub.docker.com ===
docker buildx build --file Dockerfile.psql  --platform linux/amd64 --tag ch1pp3w4/sl-psql:v0.0.1 --output type=registry .
