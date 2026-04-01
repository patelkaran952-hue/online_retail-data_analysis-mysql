select * from online_retail2 where UnitPrice = 0;

delete from online_retail2 where UnitPrice = 0;

-- Remove Duplicate Values

select *,
row_number() over(partition by InvoiceNo, StockCode, Description, Quantity, InvoiceDate, UnitPrice, CustomerID, Country) as row_num
from online_retail2;

with duplicate_cte as 
(
select *,
row_number() over(partition by InvoiceNo, StockCode, Description, Quantity, InvoiceDate, UnitPrice, CustomerID, Country) as row_num
from online_retail2
)
select * 
from duplicate_cte
where row_num > 1;

CREATE TABLE online_retail3 (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description TEXT,
    Quantity INT,
    InvoiceDate DATETIME,
    UnitPrice DECIMAL(10,2),
    CustomerID INT,
    Country VARCHAR(50),
    row_num INT
);

INSERT INTO online_retail3
SELECT 
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    STR_TO_DATE(InvoiceDate, '%d-%m-%Y %H:%i') AS InvoiceDate,
    UnitPrice,
    CustomerID,
    Country,
    ROW_NUMBER() OVER (
        PARTITION BY InvoiceNo, StockCode, Description, Quantity, InvoiceDate, UnitPrice, CustomerID, Country
    ) AS row_num
FROM online_retail2;

delete from online_retail3 where row_num > 1;

alter table online_retail3
drop row_num;








