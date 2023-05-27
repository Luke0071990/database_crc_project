CREATE OR REPLACE PROCEDURE p_add_bonus(p_employee_id IN employees.employee_id%TYPE, p_salary IN departments.salary%TYPE)
IS
    v_bonus_amount NUMBER := p_salary * 0.3;
BEGIN
    DECLARE
        v_existing_bonus NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_existing_bonus
        FROM bonuses
        WHERE employee_id = p_employee_id
            AND b_year = EXTRACT(YEAR FROM SYSDATE)
            AND b_quarter = 1;

        IF v_existing_bonus = 0 THEN
            INSERT INTO bonuses (bonus_id, employee_id, bonus_amount, b_year, b_quarter)
            VALUES (bonus_id_seq.NEXTVAL, p_employee_id, v_bonus_amount, EXTRACT(YEAR FROM SYSDATE), 1);
        
            DBMS_OUTPUT.PUT_LINE('Bonus added for employee number: #' || p_employee_id || ' in the amount of ' || v_bonus_amount || ' PLN');
        ELSE
            DBMS_OUTPUT.PUT_LINE('A bonus has already been assigned to employee number: #' || p_employee_id || ' in this quarter.');
        END IF;
    END;
END p_add_bonus;
/
