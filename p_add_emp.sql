CREATE OR REPLACE PROCEDURE add_employee (
    p_first_name     IN employees.first_name%TYPE,
    p_last_name      IN employees.last_name%TYPE,
    p_pesel          IN employees.pesel%TYPE,
    p_city           IN employees.city%TYPE,
    p_postal_code    IN employees.postal_code%TYPE,
    p_adress_street  IN employees.adress_street%TYPE,
    p_adress_number  IN employees.adress_number%TYPE,
    p_phone          IN employees.phone%TYPE,
    p_department_id  IN employees.department_id%TYPE
) AS
    v_employee_id  employees.employee_id%TYPE;
    v_e_mail       employees.e_mail%TYPE;
    v_phone         employees.phone%TYPE;
    v_pesel         employees.pesel%TYPE;
BEGIN
    v_e_mail := LOWER(p_last_name) || '@dataverse.com';

    IF LENGTH(p_pesel) <> 11 THEN
        RAISE_APPLICATION_ERROR(-20001, 'The PESEL number has the wrong length of characters');
    END IF;

    IF LENGTH(p_phone) <> 9 THEN
        RAISE_APPLICATION_ERROR(-20002, 'The phone number has the wrong length of characters');
    END IF;

    IF LENGTH(p_postal_code) <> 5 THEN
        RAISE_APPLICATION_ERROR(-20003, 'The postal code has the wrong length of characters');
    END IF;

    -- Sprawdź, czy istnieje pracownik o podanym numerze PESEL
    BEGIN
    SELECT count(*) INTO v_pesel
    FROM employees
    WHERE pesel = p_pesel;

    IF v_pesel > 0  THEN
        RAISE_APPLICATION_ERROR(-20004, 'An employee with the same PESEL number already exists');
    END IF;
    END;
    
    BEGIN
    -- Sprawdź, czy istnieje pracownik o podanym numerze telefonu
    SELECT count(*) INTO v_phone
    FROM employees
    WHERE phone = p_phone;

    IF v_phone > 0  THEN
        RAISE_APPLICATION_ERROR(-20005, 'An employee with the same phone number already exists');
    END IF;
    END;
    -- Dodaj nowego pracownika
    INSERT INTO employees (
        first_name,
        last_name,
        pesel,
        city,
        postal_code,
        adress_street,
        adress_number,
        phone,
        e_mail,
        department_id
    ) VALUES (
        p_first_name,
        p_last_name,
        p_pesel,
        p_city,
        p_postal_code,
        p_adress_street,
        p_adress_number,
        p_phone,
        v_e_mail,
        p_department_id
    );

    DBMS_OUTPUT.PUT_LINE('Added employee successfully');

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred while adding employee: ' || SQLERRM);

END;



BEGIN
    add_employee('Marek', 'Mnich',59062889827, 'Katowice', 40018, 'Paderewskiego', '7', 144026748, 1);	
    add_employee('Jarosław','Władysław',77021766716,'Będzin',41250,'Lipowa','2',775080961,1);
    add_employee('Wioletta','Cebula',73060634449,'Chorzów',40110,'Porcelonwa','7',732561367,1);
    add_employee('Katarzyna','Wieczorek',80081277667,'Ruda Śląśka',41506,'Rubinowa','2',663271278,2);
    add_employee('Paweł','Gancarek',94112895535,'Katowice',40001,'Armi Krajowej','44',656803940,2);
    add_employee('Łukasz','Malorny',98091891757,'Katowice',40016,'Graniczna','23',166365733,3);
    add_employee('Daniela','Jeleń',01230852481,'Piekary Śląskie',41948,'Andrzeja Wajdy','4',944256280,4);
    add_employee('Jessica','Konieczna',02321677592,'Siemianowice Śląskie',40151,'Szpitalna','4',836462035,5);
    add_employee('Marek', 'Cebula', 90061512478, 'Piekary Śląskie', 41948, 'Matejki', '60', 589745397, 2);
END;

