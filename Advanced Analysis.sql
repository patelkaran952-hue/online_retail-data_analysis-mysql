-- Advance Analysis

-- RFM Analysis
SELECT 
    CustomerID,
    MAX(InvoiceDate) AS last_purchase,
    COUNT(DISTINCT InvoiceNo) AS frequency,
    SUM(TotalPrice) AS monetary
FROM online_retail3
GROUP BY CustomerID
ORDER BY monetary DESC;
-- Gives high value customers


-- Sales Trend
SELECT DATE(InvoiceDate), SUM(TotalPrice) as STP
FROM online_retail3
GROUP BY DATE(InvoiceDate)
ORDER BY STP DESC;

SELECT DATE(InvoiceDate), SUM(TotalPriceReturn) as STPR
FROM online_retail3
GROUP BY DATE(InvoiceDate)
ORDER BY STPR ASC;

SELECT DATE(InvoiceDate), SUM(TotalPrice) as STP, SUM(TotalPriceReturn) as STPR
FROM online_retail3
GROUP BY DATE(InvoiceDate)
ORDER BY STP DESC;


-- Normalization

-- Customer Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    country VARCHAR(50)
);

INSERT IGNORE INTO customers (customer_id, country)
SELECT DISTINCT CustomerID, Country
FROM online_retail3
WHERE CustomerID != 0;

select * from customers;


-- Products Table
CREATE TABLE products (
    stock_code VARCHAR(20) PRIMARY KEY,
    description TEXT
);

INSERT IGNORE INTO products (stock_code, description)
SELECT DISTINCT StockCode, Description
FROM online_retail3;

SELECT * FROM products;


-- Orders Table
CREATE TABLE orders (
    invoice_no VARCHAR(20) PRIMARY KEY,
    invoice_date DATETIME,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT IGNORE INTO orders (invoice_no, invoice_date, customer_id)
SELECT DISTINCT InvoiceNo, InvoiceDate, CustomerID
FROM online_retail3;


-- Orders details table
CREATE TABLE order_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    invoice_no VARCHAR(20),
    stock_code VARCHAR(20),
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (invoice_no) REFERENCES orders(invoice_no),
    FOREIGN KEY (stock_code) REFERENCES products(stock_code)
);

INSERT IGNORE INTO orders (invoice_no, invoice_date, customer_id)
SELECT DISTINCT InvoiceNo, InvoiceDate, CustomerID
FROM online_retail3
WHERE CustomerID != 0;



























