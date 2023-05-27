CREATE OR REPLACE TRIGGER trg_update_order_value
AFTER INSERT ON order_details
FOR EACH ROW
DECLARE
    v_price_per_unit NUMBER;
BEGIN
   
    SELECT price_per_unit INTO v_price_per_unit
    FROM products
    WHERE product_id = :NEW.product_id;
    
    
    UPDATE orders
    SET order_value = NVL(order_value, 0) + (:NEW.quantity * v_price_per_unit)
    WHERE order_id = :NEW.order_id;
	
EXCEPTION
    WHEN OTHERS THEN
        -- Obsługa innych wyjątków
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END trg_update_order_value;
/
