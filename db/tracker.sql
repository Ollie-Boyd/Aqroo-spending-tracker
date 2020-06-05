DROP TABLE users IF EXISTS;
DROP TABLE transactions IF EXISTS;
DROP TABLE merchants IF EXISTS;
DROP TABLE categories IF EXISTS;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255)
  savings_goal INT, 
  monthly_income INT,
  email VARCHAR
);

CREATE TABLE categories (    
    id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE merchants (    
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    icon VARCHAR(255),
    css_colour VARCHAR(255)
);

CREATE TABLE transactions (
  id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(id) SET NULL ON DELETE,
  transaction_date DATE, --yyyy-mm-dd
  merchant_id INT REFERENCES merchants(id) SET NULL ON DELETE,
  category_id INT REFERENCES catagories(id),
  amount INT
);


