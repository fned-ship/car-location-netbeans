CREATE OR REPLACE FUNCTION get_customer_rental_details(p_customer_id INT)
RETURNS TEXT AS
$$
DECLARE
    v_rental_count INT;
    v_total_duration INT;
    v_result TEXT := '';
    rec RECORD; -- Declare rec as a RECORD type to store each row in the loop
BEGIN
    -- Count the number of cars rented by the customer
    SELECT COUNT(*) INTO v_rental_count
    FROM location
    WHERE customer_id = p_customer_id;

    -- Add the number of rented cars to the result
    v_result := 'Client ID: ' || p_customer_id || ' - Total Cars Rented: ' || v_rental_count || E'\n';

    -- Calculate the total duration of rentals for each car
    FOR rec IN 
        SELECT carReg, SUM(return_day - rent_day) AS total_duration
        FROM location
        WHERE customer_id = p_customer_id
        GROUP BY carReg


    LOOP
        v_result := v_result || 'Car Registration: ' || rec.carReg || ' - Total Duration: ' || rec.total_duration || ' days' || E'\n';
    END LOOP;

    -- Return the result
    RETURN v_result;
END;
$$ LANGUAGE plpgsql;
