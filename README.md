# Tree Suppliers Database

##  Description
This project is a SQL database designed to manage tree suppliers, including trees, suppliers, prices, and stock.

It demonstrates the use of SQL queries, functions, stored procedures, and triggers.

##  Features
- Simple and advanced SQL queries
- Aggregations (COUNT, SUM, AVG, MIN, MAX)
- CASE WHEN conditions
- Data filtering (WHERE, HAVING)
- SQL functions
- Stored procedures
- Triggers with history tracking
- CSV dataset for testing

##  Project Structure
- 01_requetes_simples.sql → basic and advanced queries  
- 02_functions.sql → SQL functions (PaysNom, ListeFournisseurs)  
- 03_procedures.sql → stored procedures  
- 04_triggers.sql → triggers and history table  

### Data
- data/Arbres.csv  
- data/Fournisseurs.csv  
- data/CodePostal.csv  
- data/LienArbresFournisseurs.csv  
- data/Pays.csv  

##  Technologies
- MySQL

##  How to Use
1. Create the database in MySQL  
2. Import the tables  
3. Import data from the `data/` folder  
4. Execute SQL files in this order:
   - 01_requetes_simples.sql  
   - 02_functions.sql  
   - 03_procedures.sql  
   - 04_triggers.sql  

##  Purpose
This project was created to practice advanced SQL concepts:
- joins
- grouping
- aggregations
- cursors
- triggers
- stored procedures
