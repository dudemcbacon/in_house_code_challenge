README
======

Add Instructions for:

* running your application

Run the following commands to start the application the first time:

```
$ bin/rake db:migrate db:seed
$ bin/rails server
```

The applications can then be reached by pointing a browser at ```http://localhost:3000```.

To reset the database and start the application again, use the following command:

```
$ bin/rake db:reset db:drop db:create db:migrate db:seed
$ bin/rails server
```

* interacting with the application as a user

Open a web browser and browse to ```http://localhost:3000```. You will be displayed a listing of all orders currently available. To import a datafile containing new orders you must login. You can use the login link on the top-right of the page with the following credentials:

```
Username: admin@drdealaday.org
Password: lakeslakeslakes
```

Upload a file by clicking on the 'Choose File' button next to the 'Import Merchant Data' label. Files can be in CSV or TSV format. Clicking the upload button will upload the file. Once the file is uploaded your data will be loaded into the table and you will be presented with a notification showing the total number of orders added, the revenue for those orders, and the total revenue of all of the orders in the system currently.

Attempting to upload an unsupported filetype, a file with missing or invalid data, or no file will result in an alert notification being displayed. Attempting to upload a file that has already been uploaded will also result in an alert notification.

* running tests

Tests can be run with the following command:

```
bin/rake test
```
