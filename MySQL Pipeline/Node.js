const mysql = require('mysql2');
const fs = require('fs');

const connection = mysql.createConnection({
  host: 'team-shared-mysql.cjwa24wuisi8.us-east-1.rds.amazonaws.com',
  user: 'Ads507',
  password: 'Gabrielleo24',
  database: 'my_pipelineADS507_5',
  localInfile: true,
  streamFactory: (filePath) => {
    // This function is called when a LOCAL INFILE command is issued.
    // It must return a readable stream for the file.
    return fs.createReadStream(filePath);
  }
});

// Now you can execute your query that uses LOAD DATA LOCAL INFILE
connection.query(
  `LOAD DATA LOCAL INFILE '/Users/home/Documents/GitHub/ADS-507/Repo/MySQL Pipeline/data/PurchaseOrderHeader.csv'
   INTO TABLE SalesOrderHeader
   FIELDS TERMINATED BY ',' 
   OPTIONALLY ENCLOSED BY '"'
   LINES TERMINATED BY '\n'
   IGNORE 1 ROWS;`,
  (error, results, fields) => {
    if (error) {
      console.error('Error loading data:', error);
      return;
    }
    console.log('Data loaded successfully:', results);
  }
);

