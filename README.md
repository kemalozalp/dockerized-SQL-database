This repo demonstrates creating a database using MySQL. This is not my original work except the containerazation of the repository. You can find the original work on the  [Giraffe Academy website](https://www.giraffeacademy.com/databases/sql/creating-company-database/). That being said, I created the entity relationship (ER) diagram and database schema on my own and added some original queries in addition to the ones given in the course.

In this example, you'll find how a database is created from a document describing the database requirements and entity relationships. From this document, I created the ER diagram and database schema. Based on the database schema, I created the tables and inserted information into the tables. Finally, I queried the database using MySQL. In addition to the queries given in the course, I added some original queries to demonstrate a few extra things.

Finally, I created a Docker image to run database and query it on your own machine.


To run the Docker image on your machine, please follow the steps below:

1. If you don't have MySQL installed on your machine, please go to the [MySQL website](https://dev.mysql.com/downloads/mysql/) and install MySQL Community on your machine. If you already have MySQL on your machine, please move on to the Step 2.During the installation, you'll be asked to create a MySQL root user password. Note it somewhere because you'll need it later. You have to add the MySQL path to your bash or zsh profile. To do that, open a terminal window and type:

> export PATH={$PATH}:/usr/local/mysql/bin

Next type:

> mysql -u root -p

You'll be prompted to enter your root password that you've noted during the installation. Type your password and you should be in.

2. If you don't have Docker installed on your machine, please go to the [Docker website](https://www.docker.com/products/docker-desktop/) and install Docker Desktop on your machine. If you already have Docker on your machine, please move on to the Step 3.

3. Clone this Github repo to your machine. Open terminal and navigate to, or 'cd' into the Github repo. Then, type:

> docker run -d mysql_db

The Docker image started running on your machine. 

4. Next, type:

> docker container ls

and copy the docker "container ID".

5. Type:

> docker exec -it <docker-container-id> /bin/bash

This will start a new shell in your docker container.

6. Then, type:

> mysql -proot

You started MySQL in your Docker container.

7. To see the existing databases, type:

> SHOW DATABASES;

Select "the_office" databaes by typing:

> USE the_office;

Now, you can copy-paste any SQL query from the "query.sql" file to your terminal and query the database. Try:

> SELECT * FROM employee;
