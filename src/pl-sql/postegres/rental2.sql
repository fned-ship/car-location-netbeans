CREATE OR REPLACE FUNCTION get_customer_rental_details2(p_customer_id INT)
RETURNS TABLE(carReg TEXT, total_duration INT) AS
$$
BEGIN
    RETURN QUERY
    SELECT location.carReg::TEXT,  -- Cast carReg to TEXT explicitly
           SUM(location.return_day - location.rent_day)::INTEGER AS total_duration  -- Cast SUM result to INTEGER
    FROM location
    WHERE location.customer_id = p_customer_id
    GROUP BY location.carReg;
END;
$$ LANGUAGE plpgsql;
