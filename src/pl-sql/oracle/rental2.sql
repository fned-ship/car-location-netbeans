CREATE OR REPLACE FUNCTION get_customer_rental_details2(p_customer_id IN INT)
RETURN AS
  result_cursor SYS_REFCURSOR;
BEGIN
  OPEN result_cursor FOR
    SELECT location.carReg, 
           SUM(location.return_day - location.rent_day) AS total_duration
    FROM location
    WHERE location.customer_id = p_customer_id
    GROUP BY location.carReg;

  RETURN result_cursor;
END get_customer_rental_details2;
