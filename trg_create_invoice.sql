create or replace TRIGGER trg_create_invoice
BEFORE UPDATE OF status ON orders
FOR EACH ROW
DECLARE
  v_invoice_id  invoices.invoice_id%TYPE;
  v_invoice_number VARCHAR2(100);
  is_invoice_created BOOLEAN := FALSE; -- Zmienna flagowa
BEGIN
  IF :NEW.status = 'SHIPPED' THEN
    v_invoice_number := generate_invoice_number(:NEW.order_date, :NEW.employee_id);

    INSERT INTO invoices (invoice_id, customer_id, first_name, last_name, nip, company_name, order_value, vat_value)
    VALUES (v_invoice_number,
            (SELECT customer_id FROM customers WHERE customer_id = :NEW.customer_id),
            (SELECT first_name FROM customers WHERE customer_id = :NEW.customer_id),
            (SELECT last_name FROM customers WHERE customer_id = :NEW.customer_id),
            (SELECT nip FROM customers WHERE customer_id = :NEW.customer_id),
            (SELECT company_name FROM customers WHERE customer_id = :NEW.customer_id),
            :NEW.order_value,
            :NEW.order_value * 0.05);

    DBMS_OUTPUT.PUT_LINE('New invoice created with number: ' || v_invoice_number);
    is_invoice_created := TRUE;
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END trg_create_invoice;
