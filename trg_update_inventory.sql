create or replace TRIGGER trg_update_inventory
AFTER INSERT ON order_details
FOR EACH ROW
DECLARE
  v_product_id        order_details.product_id%TYPE := :NEW.product_id;
  v_quantity          order_details.quantity%TYPE := :NEW.quantity;
  v_current_quantity  products.quantity_in_stock%TYPE; 
BEGIN

  UPDATE products
  SET quantity_in_stock = quantity_in_stock - v_quantity
  WHERE product_id = v_product_id;

  SELECT quantity_in_stock
  INTO v_current_quantity
  FROM products
  WHERE product_id = v_product_id;

  DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------');
  DBMS_OUTPUT.PUT_LINE('Stock updated for product ID: ' || v_product_id || ' current value: ' || v_current_quantity);

  IF v_current_quantity <= 2 THEN
    DBMS_OUTPUT.PUT_LINE('Warning: Low quantity of product ID: ' || v_product_id || ' in stock!');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END trg_update_inventory;




Begin
p_add_orders(67, 5, TO_DATE('20-05-2023', 'DD-MM-YYYY'), TO_DATE('22-05-2023','DD-MM-YYYY'), TO_DATE('23-05-2023','DD-MM-YYYY'), null, 1);
END;
/
Begin
p_add_order_details(1043,1,2);
p_add_order_details(1043,2,2);
END;

/
BEGIN
p_add_payment(1041, 'APPROVED');
END;