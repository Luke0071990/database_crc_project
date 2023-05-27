CREATE OR REPLACE PROCEDURE p_check_seller_performance(p_start_date IN DATE, p_end_date IN DATE)
IS
    CURSOR c_seller_performance IS
        SELECT e.employee_id, SUM(o.order_value) AS total_sales
        FROM orders o
        JOIN employees e ON e.employee_id = o.employee_id
        JOIN order_payments op ON o.order_id = op.order_id
        WHERE op.payment_date >= p_start_date AND op.payment_date <= p_end_date
        GROUP BY e.employee_id;

    v_employee_id employees.employee_id%TYPE;
    v_quarter_sales NUMBER;
    v_department_salary departments.salary%TYPE;
BEGIN
    FOR rec IN c_seller_performance LOOP
        v_employee_id := rec.employee_id;
        v_quarter_sales := rec.total_sales;

        SELECT salary INTO v_department_salary
        FROM departments
        WHERE department_id = (SELECT department_id FROM employees WHERE employee_id = v_employee_id);
        
        DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('Total sales for employee number: #' || v_employee_id || ' in the first quarter were ' || v_quarter_sales || ' PLN');

        IF v_quarter_sales >= 250000 THEN
            DBMS_OUTPUT.PUT_LINE('The employee receives a bonus!');
            p_add_bonus(v_employee_id, v_department_salary);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Unfortunately, the employee does not receive a bonus');
        END IF;
    END LOOP;
END;