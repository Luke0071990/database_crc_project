CREATE OR REPLACE PROCEDURE p_add_payment(
  pin_payment_date order_payments.payment_date%TYPE,
  pin_order_id  order_payments.order_id%TYPE,
  pin_status    order_payments.status%TYPE
)
IS
  v_order_count  INTEGER;
BEGIN
  SELECT COUNT(*)
  INTO v_order_count
  FROM orders
  WHERE order_id = pin_order_id;

  IF v_order_count = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Error: Invalid order_id. The order_id #' || pin_order_id ||' does not exist in the orders table.');
  ELSE
    INSERT INTO order_payments(payment_date,order_id, status)
    VALUES (pin_payment_date,pin_order_id, pin_status);
    
    DBMS_OUTPUT.PUT_LINE('Payment added for order_id: ' || pin_order_id);
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END p_add_payment;

/

BEGIN
	p_add_payment(TO_DATE('25-04-2023', 'DD-MM-YYYY'), 1101, 'PENDING' );
END;