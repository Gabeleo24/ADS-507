const mysql = require('mysql2');
const fs = require('fs');

const connection = mysql.createConnection({
  host: 'team-shared-mysql.cjwa24wuisi8.us-east-1.rds.amazonaws.com',
  user: 'Ads507',
  password: 'Gabrielleo24',
  database: 'production',
  localInfile: true,
  streamFactory: (filePath) => {
    // This function is called when a LOCAL INFILE command is issued.
    // It must return a readable stream for the file.
    return fs.createReadStream(filePath);
  }
});

// Test the connection (optional)
connection.connect(err => {
  if (err) {
    console.error('Connection error:', err);
    return;
  }
  console.log('Connected to MySQL server.');
});