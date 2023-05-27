CREATE OR REPLACE PROCEDURE p_sales_report(pin_customer_id IN customers.customer_id%TYPE,
                                           pin_date_start IN DATE,
                                           pin_date_end IN DATE)
IS
  v_total_sales NUMBER;
BEGIN
  SELECT SUM(o.order_value)
    INTO v_total_sales
    FROM orders o
    JOIN order_payments op ON o.order_id = op.order_id
    WHERE o.customer_id = pin_customer_id
      AND op.payment_date BETWEEN pin_date_start AND pin_date_end;

  IF v_total_sales IS NULL THEN
    RAISE_APPLICATION_ERROR(-20001, 'No sales found for the specified customer and date range. SQLCODE: ' || SQLCODE || ', SQLERRM: ' || SQLERRM);
  ELSE
    DBMS_OUTPUT.PUT_LINE('Total sales for customer ' || pin_customer_id || ' between ' || pin_date_start || ' and ' || pin_date_end || ': ' || v_total_sales);
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20003, 'An error occurred while retrieving sales data. SQLCODE: ' || SQLCODE || ', SQLERRM: ' || SQLERRM);
    DBMS_OUTPUT.PUT_LINE('Wystąpił błąd: SQLCODE: ' || SQLCODE || ', SQLERRM: ' || SQLERRM);
    RAISE;
END p_sales_report;

/

BEGIN
  p_sales_report(1, TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-05-31', 'YYYY-MM-DD'));
END;
/
BEGIN
  p_sales_report(10000, TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-05-31', 'YYYY-MM-DD'));
END;
/

BEGIN
  p_sales_report(1, TO_DATE('2023-05-30', 'YYYY-MM-DD'), TO_DATE('2023-05-31', 'YYYY-MM-DD'));
END;
