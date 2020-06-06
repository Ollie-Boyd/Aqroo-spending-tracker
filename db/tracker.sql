DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS merchants;
DROP TABLE IF EXISTS categories;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  savings_goal FLOAT(8), 
  monthly_income FLOAT(8),
  email VARCHAR
);

CREATE TABLE categories (    
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    icon VARCHAR(255),
    css_colour_1 VARCHAR(255),
    css_colour_2 VARCHAR(255)
);

CREATE TABLE merchants (    
    id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE transactions (
  id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(id) ON DELETE SET NULL,
  transaction_date DATE, --yyyy-mm-dd
  merchant_id INT REFERENCES merchants(id) ON DELETE SET NULL,
  category_id INT REFERENCES categories(id),
  amount FLOAT(8)
);


