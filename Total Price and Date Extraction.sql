-- Create total price column

ALTER TABLE online_retail3 ADD TotalPrice DECIMAL(10,2);

UPDATE online_retail3
SET TotalPrice = Quantity * UnitPrice
where Quantity >= 0 and UnitPrice >= 0;

ALTER TABLE online_retail3 ADD TotalPriceReturn DECIMAL(10,2);

UPDATE online_retail3
SET TotalPriceReturn = Quantity * UnitPrice
where Quantity < 0;

select * from online_retail3 limit 10;

select sum(TotalPrice)
from online_retail3;

-- Extract Date Parts

ALTER TABLE online_retail3 ADD Year INT, ADD Month INT;

UPDATE online_retail3
SET 
    Year = YEAR(InvoiceDate),
    Month = MONTH(InvoiceDate);
    


