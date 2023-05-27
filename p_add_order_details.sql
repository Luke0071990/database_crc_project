CREATE OR REPLACE PROCEDURE p_add_order_details (
    pin_order_id IN order_details.order_id%TYPE,
    pin_product_id IN order_details.product_id%TYPE,
    pin_quantity IN order_details.quantity%TYPE
)
IS
    v_quantity_in_stock products.quantity_in_stock%TYPE;
    v_product_name products.product_name%TYPE;
BEGIN
    SELECT quantity_in_stock, product_name
    INTO v_quantity_in_stock, v_product_name
    FROM products
    WHERE product_id = pin_product_id;
    
    IF v_quantity_in_stock >= pin_quantity THEN
        INSERT INTO order_details(order_id, product_id, quantity)
        VALUES (pin_order_id, pin_product_id, pin_quantity);
        
        DBMS_OUTPUT.PUT_LINE('Order details added for order_id: ' || pin_order_id);
    ELSE
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient quantity in stock for product: ' || v_product_name);
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'Product not found with product_id: ' || pin_product_id);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END p_add_order_details;
/

BEGIN
  
p_add_order_details(1,12,2);
p_add_order_details(1,23,3);
p_add_order_details(1,28,1);
p_add_order_details(1,17,2);
p_add_order_details(1,21,3);
p_add_order_details(2,19,1);
p_add_order_details(2,8,3);
p_add_order_details(2,14,3);
p_add_order_details(2,18,3);
p_add_order_details(2,13,2);
p_add_order_details(3,3,3);
p_add_order_details(3,14,1);
p_add_order_details(3,2,1);
p_add_order_details(3,25,2);
p_add_order_details(3,24,2);
p_add_order_details(4,29,2);
p_add_order_details(4,6,3);
p_add_order_details(4,3,2);
p_add_order_details(4,23,1);
p_add_order_details(4,25,2);
p_add_order_details(5,23,3);
p_add_order_details(5,19,3);
p_add_order_details(5,6,2);
p_add_order_details(5,24,2);
p_add_order_details(5,17,1);
p_add_order_details(6,21,1);
p_add_order_details(6,1,3);
p_add_order_details(6,4,3);
p_add_order_details(6,5,3);
p_add_order_details(6,24,3);
p_add_order_details(7,16,2);
p_add_order_details(7,20,3);
p_add_order_details(7,28,3);
p_add_order_details(7,10,3);
p_add_order_details(7,29,3);
p_add_order_details(8,9,1);
p_add_order_details(8,15,2);
p_add_order_details(8,3,3);
p_add_order_details(8,19,2);
p_add_order_details(8,1,1);
p_add_order_details(9,10,2);
p_add_order_details(9,4,3);
p_add_order_details(9,19,1);
p_add_order_details(9,5,3);
p_add_order_details(9,15,3);
p_add_order_details(10,9,2);
p_add_order_details(10,23,2);
p_add_order_details(10,26,3);
p_add_order_details(10,14,2);
p_add_order_details(10,5,1);


end;