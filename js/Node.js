const fs = require('fs');
const mysql = require('mysql2');

// Create a connection to the MySQL server with localInfile enabled
const connection = mysql.createConnection({
  host: 'team-shared-mysql.cjwa24wuisi8.us-east-1.rds.amazonaws.com',
  user: 'Ads507',
  password: 'Gabrielleo24',
  database: 'production',
  localInfile: true,
  // The streamFactory option returns a readable stream for the file path provided by the driver
  streamFactory: (filePath) => {
    console.log(`Attempting to read file at: ${filePath}`);
    return fs.createReadStream(filePath);
  }
});

// Connect to the MySQL server
connection.connect((err) => {
  if (err) {
    console.error('Connection error:', err);
    process.exit(1);
  }
  console.log('Connected to MySQL server.');
  
  // SQL query to load data from the CSV file into the ProductCategory table
  const loadQuery = `
    LOAD DATA LOCAL INFILE '/Users/home/Downloads/ProductCategory.csv'
    INTO TABLE ProductCategory
    FIELDS TERMINATED BY '\t'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (Name, Description);
  `;
  
  // Execute the LOAD DATA query
  connection.query(loadQuery, (error, results) => {
    if (error) {
      console.error('Error executing LOAD DATA query:', error);
    } else {
      console.log('Data loaded successfully. Results:', results);
    }
    
    // Optionally, run a SELECT query to verify the data was inserted:
    connection.query('SELECT * FROM ProductCategory LIMIT 5;', (selectErr, selectResults) => {
      if (selectErr) {
        console.error('Error executing SELECT query:', selectErr);
      } else {
        console.log('Sample data from ProductCategory:', selectResults);
      }
      
      // Close the connection
      connection.end((endErr) => {
        if (endErr) {
          console.error('Error closing the connection:', endErr);
        } else {
          console.log('Connection closed.');
        }
      });
    });
  });
});