CREATE OR REPLACE PROCEDURE p_sales_report_for_all(
                                           pin_date_start IN DATE,
                                           pin_date_end IN DATE)
IS
  CURSOR c_sales_report IS
    SELECT o.customer_id, SUM(o.order_value) AS total_sales
    FROM orders o
    JOIN order_payments op ON o.order_id = op.order_id
    WHERE op.payment_date BETWEEN pin_date_start AND pin_date_end
    GROUP BY o.customer_id
    ORDER BY total_sales DESC;

  v_customer_id customers.customer_id%TYPE;
  v_total_sales NUMBER;
  v_count_customer NUMBER := 0;
BEGIN
  FOR rec IN c_sales_report LOOP
    v_customer_id := rec.customer_id;
    v_total_sales := rec.total_sales;
    v_count_customer := v_count_customer + 1;
    DBMS_OUTPUT.PUT_LINE('Total sales for customer ' || v_customer_id || ' between ' || pin_date_start || ' and ' || pin_date_end || ': ' || v_total_sales);
    IF c_sales_report%NOTFOUND THEN
    RAISE_APPLICATION_ERROR(-20001, 'No sales found for the specified date range. SQLCODE: ' || SQLCODE || ', SQLERRM: ' || SQLERRM);
    END IF;
 
  END LOOP;

DBMS_OUTPUT.PUT_LINE('You have ' || v_count_customer ||' active customers!');  

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20002, 'No data found for the specified date range. SQLCODE: ' || SQLCODE || ', SQLERRM: ' || SQLERRM);
  WHEN OTHERS THEN
    --RAISE_APPLICATION_ERROR(-20003, 'An error occurred while retrieving sales data. SQLCODE: ' || SQLCODE || ', SQLERRM: ' || SQLERRM);
    DBMS_OUTPUT.PUT_LINE('Wystąpił błąd: SQLCODE: ' || SQLCODE || ', SQLERRM: ' || SQLERRM);
END p_sales_report_for_all;

/
Begin 
p_sales_report_for_all(TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-05-31', 'YYYY-MM-DD'));
END;
