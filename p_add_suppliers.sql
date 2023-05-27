CREATE OR REPLACE PROCEDURE p_add_suppliers (
	pin_supplier_name in suppliers.supplier_name%TYPE
	) AS 

v_supplier_id suppliers.supplier_id%TYPE;
v_supplier_count NUMBER;
BEGIN
SELECT count(*)
INTO v_supplier_count
FROM suppliers
WHERE supplier_name = pin_supplier_name;

IF v_supplier_count > 0 THEN
	RAISE_APPLICATION_ERROR(-20001, 'The supplier with that name already exists in the database');
END IF;

 INSERT INTO suppliers 
	(supplier_name)
 VALUES 
	(pin_supplier_name)
	
	RETURNING supplier_id INTO v_supplier_id;

	DBMS_OUTPUT.PUT_LINE('Added supplier with ID: ' || v_supplier_id);
    DBMS_OUTPUT.PUT_LINE('Supplier Name: ' || pin_supplier_name);
	
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred while adding supplier: ' || SQLERRM);
		
END p_add_suppliers;

/


BEGIN
    p_add_suppliers('InPost');
    p_add_suppliers('GLS');
    p_add_suppliers('DHL');
    p_add_suppliers('UPS');
    p_add_suppliers('Poczta_Polska');    
END;