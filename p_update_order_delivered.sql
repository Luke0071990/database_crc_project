CREATE OR REPLACE PROCEDURE p_update_order_delivered(p_order_id IN orders.order_id%TYPE)
AS
BEGIN
  UPDATE orders
  SET status = 'DELIVERED',
      delivery_date = TRUNC(SYSDATE)
  WHERE order_id = p_order_id;

  DBMS_OUTPUT.PUT_LINE('Order ' || p_order_id || ' updated to DELIVERED.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END p_update_order_delivered;

/
BEGIN
    p_update_order_delivered(1161);
END;



/

BEGIN
p_add_orders(41, 4, TO_DATE('24-04-2023', 'DD-MM-YYYY'), null, null, null, 4);
END;
/
BEGIN
p_add_order_details(1161,1,1);
END;
/
BEGIN
	p_add_payment(TO_DATE('25-04-2023', 'DD-MM-YYYY'), 1161, 'PENDING' );
END;
/
UPDATE order_payments
SET status = 'APPROVED'
WHERE order_id = 1161;
/
UPDATE orders
SET status = 'APPROVED'
WHERE order_id = 1161;
/
UPDATE orders
SET status = 'DELIVERED'
WHERE order_id = 1161;



BEGIN
    p_update_order_delivered(1161);
END;