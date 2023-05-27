CREATE OR REPLACE FUNCTION f_generate_invoice_number(p_order_date IN DATE, p_employee_id IN employees.employee_id%TYPE)
  RETURN VARCHAR2 IS
  v_invoice_id  invoices.invoice_id%TYPE;
  v_invoice_number VARCHAR2(100);
BEGIN
  SELECT invoice_id_seq.NEXTVAL INTO v_invoice_id FROM dual;
  
  v_invoice_number := TO_CHAR(p_order_date, 'YYYYMMDD') || '/' || v_invoice_id || '/' || p_employee_id;
  
  RETURN v_invoice_number;
END f_generate_invoice_number;
/