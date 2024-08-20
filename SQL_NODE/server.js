const express = require("express");
const sql = require("mssql");
require("dotenv").config();

const app = express();
const port = 3000;

// Database configuration
const dbConfig = {
  server: process.env.DB_SERVER,
  database: process.env.DB_DATABASE,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  pool: {
    max: 10,
    min: 0,
    idleTimeoutMillis: 30000,
  },
  options: {
    trustServerCertificate: true, // Bypass SSL certificate validation
    connectTimeout: 30000, // Increase connection timeout to 30 seconds
  },
};

// Establish connection pool when the server starts
sql
  .connect(dbConfig)
  .then((pool) => {
    console.log("Connected successfully!");
    app.locals.db = pool; // Save the pool to app.locals for reuse
  })
  .catch((err) => {
    console.error("Connection failed:", err);
  });

// Route to get data
app.get("/data", async (req, res) => {
  try {
    const pool = req.app.locals.db; // Reuse the existing connection pool
    const result = await pool.request().query("SELECT * FROM ExOrders"); // Adjust this to match your table name

    // Send the results as JSON
    res.json(result.recordset);
  } catch (err) {
    console.error("SQL error", err);
    res.status(500).send("Server Error");
  }
});

// Start the server
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
