CREATE OR REPLACE FUNCTION get_customer_rental_details (p_customer_id INT) 
RETURN VARCHAR IS
    v_rental_count INT;
    v_total_duration INT;
    v_result VARCHAR(4000);
BEGIN
    -- Compter le nombre de voitures louées par le client
    SELECT COUNT(*) INTO v_rental_count
    FROM location
    WHERE customer_id = p_customer_id;

    -- Initialiser la variable du résultat
    v_result := 'Client ID: ' || p_customer_id || ' - Total Cars Rented: ' || v_rental_count || CHR(10);

    -- Calculer la durée totale de location pour chaque voiture
    FOR rec IN (
        SELECT carReg, SUM(DATEDIFF(return_day, rent_day)) AS total_duration
        FROM location
        WHERE customer_id = p_customer_id
        GROUP BY carReg
    ) LOOP
        v_result := v_result || 'Car Registration: ' || rec.carReg || ' - Total Duration: ' || rec.total_duration || ' days' || CHR(10);
    END LOOP;

    -- Retourner le résultat
    RETURN v_result;
END;
/
