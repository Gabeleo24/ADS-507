const fs = require('fs');
const mysql = require('mysql2/promise');

// Define configuration objects for each user
const configUserA = {
  host: 'team-shared-mysql.cjwa24wuisi8.us-east-1.rds.amazonaws.com',
  user: 'PipelineUser1',
  password: 'StrongPassword1!',
  database: 'Sales',
  localInfile: true
};

const configUserB = {
  host: 'team-shared-mysql.cjwa24wuisi8.us-east-1.rds.amazonaws.com',
  user: 'PipelineUser2',
  password: 'StrongPassword2!',
  database: 'Sales',
  localInfile: true
};

const configUserC = {
  host: 'team-shared-mysql.cjwa24wuisi8.us-east-1.rds.amazonaws.com',
  user: 'PipelineUser3',
  password: 'StrongPassword3!',
  database: 'Sales',
  localInfile: true
};

// Select the configuration based on an environment variable (DB_USER)
let chosenConfig;
switch (process.env.DB_USER) {
  case 'PipelineUser1':
    chosenConfig = configUserA;
    break;
  case 'PipelineUser2':
    chosenConfig = configUserB;
    break;
  case 'PipelineUser3':
    chosenConfig = configUserC;
    break;
  default:
    // Default to PipelineUser1 if no valid environment variable is provided
    chosenConfig = configUserA;
    break;
}

// Create a connection pool using the chosen configuration
const pool = mysql.createPool({
  ...chosenConfig,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
  // Using streamFactory for local file access if needed
  streamFactory: (filePath) => {
    console.log(`Attempting to read file at: ${filePath}`);
    return fs.createReadStream(filePath);
  }
});

// Example function to perform a query using the pool
async function runQuery() {
  let connection;
  try {
    connection = await pool.getConnection();
    console.log('Connected to MySQL server.');
    
    // Example query: Load data from a CSV file into the ProductCategory table
    const loadQuery = `
      LOAD DATA LOCAL INFILE '/Users/home/Downloads/ProductCategory.csv'
      INTO TABLE ProductCategory
      FIELDS TERMINATED BY '\t'
      LINES TERMINATED BY '\n'
      IGNORE 1 LINES
      (Name, Description);
    `;
    const [results] = await connection.query(loadQuery);
    console.log('Data loaded successfully. Results:', results);
    
    // Optionally, run a SELECT query to verify the data was inserted
    const [selectResults] = await connection.query('SELECT * FROM ProductCategory LIMIT 5;');
    console.log('Sample data from ProductCategory:', selectResults);
    
  } catch (error) {
    console.error('Error during query execution:', error);
  } finally {
    if (connection) connection.release();
  }
}

// Execute the example query
runQuery();