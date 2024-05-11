# Dockerized SQL-Ledger 

[![License](https://img.shields.io/badge/License-GPL_V3.0.0-blue.svg)](LICENSE) 


## Description

[SQL-Ledger](https://sql-ledger.com) is a effortless business management application: intuitive and powerful. Seamlessly handle orders, invoices, inventory, and more with precision and ease.

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

### Setting up your Company data

1. Now, in the web broser point to http://localhost/sql-ledger/admin.pl, to create the database, enter these data:

<img src="images/sl02.png" alt="Admin login screen" width="400">

hit the <<Loging>> button, at this point, there is no password.

2. In the "SQL-Ledger Administration" screen:

<img src="images/sl03.png" alt="SQL-Ledger Administration" width="400">

click over the "Add Dataset" button.

3. Enter the connection data to the database:

<img src="images/sl04.png" alt="SQL-Ledger / Add Dataset" width="400">

- Host: db
- Port: 5432    
- User: sql-ledger
- Password: sql-ledger
- Database: template1

Note: those are values that should be used, if you try with others, SQL-Ledger won't get connected to the database container.

4. Finally, let's enter your company data (the below data is just for ilustrative purposes):

<img src="images/sl06.png" alt="SQL-Ledger / Create Dataset" width="400">

- Dataset: demo (this will be the database identificator for your company)
- Company: My Demo Company LLC (your company's name)
- Administrator: admin (system administration user, tipically admin, superuser, sysadmin, it is up to you...)
- E-mail: admin@gmail.com (system administrator email address)
- Password: admin (only numbers and letters, uppercase and lowercase)
- Templates: Default (these are documents templates in different languages, Default is English) 
- Multibyte Encoding: Unicode (UTF-8) (in this global world, there are multiple symbols, this technical piece supports that)
- Create Chart of Accounts: US General (this is a template, click over the dropdown list, you can change it to whatever you want)

Click over the <<Continue>> button. 

Control will be back into the "SQL-Ledger Administration" screen, just click on <<Logout>>

5. Point your web browser to http://localhost/sql-ledger, use your administrative user and password previously created.

<img src="images/sl08.png" alt="SQL-Ledger Login screen" width="400">

Hit the <<Login>> button, **there you go!**

<img src="images/sl09.png" alt="Logo" width="400">

## Support

For an overview of usage of each SQL-Ledger feature, click [here](https://sql-ledger.com/cgi-bin/nav.pl?page=feature/index.html&title=Features)

If you want to get a user guide, you can buy the official version [here](https://sql-ledger.com/cgi-bin/nav.pl?page=misc/documentation.html&title=documentation)

These some experts that can provide support:

- Company Name 01
- Company Name 03
- Company Name 03

## Contributing

Contributions to this repository are welcome, create yuor pull request [here](http://localhost/pull_request)

## License
