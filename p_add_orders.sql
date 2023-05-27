CREATE OR REPLACE PROCEDURE p_add_orders (
    pin_customer_id orders.customer_id%TYPE,
    pin_employee_id orders.employee_id%TYPE,
    pin_order_date orders.order_date%TYPE,
    pin_shipped_date orders.shipped_date%TYPE,
    pin_delivery_date orders.delivery_date%TYPE,
    pin_order_value orders.order_value%TYPE,
    pin_supplier_id orders.supplier_id%TYPE
    )
IS
BEGIN
    IF pin_delivery_date < pin_order_date THEN
        RAISE_APPLICATION_ERROR(-20002, 'The order date cannot be later than the required date.');
    END IF;

    IF pin_shipped_date > pin_delivery_date THEN
        RAISE_APPLICATION_ERROR(-20003, 'The shipping date cannot be later than the delivery date.');
    END IF;

    DECLARE
        v_customer_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_customer_count
        FROM customers
        WHERE customer_id = pin_customer_id;

        IF v_customer_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20004, 'The specified client ID does not exist.');
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20004, 'The specified client ID does not exist.');
    END;

    DECLARE
        v_employee_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_employee_count
        FROM employees
        WHERE employee_id = pin_employee_id;

        IF v_employee_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20005, 'The specified employee ID does not exist.');
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20005, 'The specified employee ID does not exist.');
    END;

    BEGIN
        INSERT INTO orders (    
            customer_id, 
            employee_id,
            order_date,
            shipped_date,
            delivery_date,
            order_value,
            supplier_id)
        VALUES (
            pin_customer_id,
            pin_employee_id,
            pin_order_date,
            pin_shipped_date,
            pin_delivery_date,
            pin_order_value,
            pin_supplier_id
        );


        EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20006, 'An error occurred while adding an order. ' || SQLERRM);
    END;



END p_add_orders;

BEGIN
p_add_orders(41, 4, TO_DATE('24-04-2023', 'DD-MM-YYYY'), TO_DATE('28-04-2023','DD-MM-YYYY'), TO_DATE('30-04-2023','DD-MM-YYYY'), null, 4);
END;

BEGIN
p_add_orders(90, 9, TO_DATE('11-01-2023', 'DD-MM-YYYY'), TO_DATE('14-01-2023','DD-MM-YYYY'), TO_DATE('15-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(8, 5, TO_DATE('30-04-2023', 'DD-MM-YYYY'), TO_DATE('03-05-2023','DD-MM-YYYY'), TO_DATE('04-05-2023','DD-MM-YYYY'), null, 1);

p_add_orders(83, 4, TO_DATE('29-01-2023', 'DD-MM-YYYY'), TO_DATE('31-01-2023','DD-MM-YYYY'), TO_DATE('01-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(11, 4, TO_DATE('24-03-2023', 'DD-MM-YYYY'), TO_DATE('26-03-2023','DD-MM-YYYY'), TO_DATE('28-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(49, 9, TO_DATE('24-01-2023', 'DD-MM-YYYY'), TO_DATE('27-01-2023','DD-MM-YYYY'), TO_DATE('29-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(56, 5, TO_DATE('21-03-2023', 'DD-MM-YYYY'), TO_DATE('25-03-2023','DD-MM-YYYY'), TO_DATE('26-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(66, 4, TO_DATE('15-04-2023', 'DD-MM-YYYY'), TO_DATE('16-04-2023','DD-MM-YYYY'), TO_DATE('18-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(9, 4, TO_DATE('17-02-2023', 'DD-MM-YYYY'), TO_DATE('19-02-2023','DD-MM-YYYY'), TO_DATE('20-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(59, 9, TO_DATE('26-03-2023', 'DD-MM-YYYY'), TO_DATE('27-03-2023','DD-MM-YYYY'), TO_DATE('28-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(78, 4, TO_DATE('01-03-2023', 'DD-MM-YYYY'), TO_DATE('05-03-2023','DD-MM-YYYY'), TO_DATE('07-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(85, 9, TO_DATE('09-05-2023', 'DD-MM-YYYY'), TO_DATE('10-05-2023','DD-MM-YYYY'), TO_DATE('14-05-2023','DD-MM-YYYY'), null, 4);

p_add_orders(8, 9, TO_DATE('01-04-2023', 'DD-MM-YYYY'), TO_DATE('03-04-2023','DD-MM-YYYY'), TO_DATE('04-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(41, 5, TO_DATE('18-04-2023', 'DD-MM-YYYY'), TO_DATE('21-04-2023','DD-MM-YYYY'), TO_DATE('23-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(60, 5, TO_DATE('16-02-2023', 'DD-MM-YYYY'), TO_DATE('19-02-2023','DD-MM-YYYY'), TO_DATE('21-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(2, 9, TO_DATE('02-02-2023', 'DD-MM-YYYY'), TO_DATE('03-02-2023','DD-MM-YYYY'), TO_DATE('06-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(83, 5, TO_DATE('29-01-2023', 'DD-MM-YYYY'), TO_DATE('31-01-2023','DD-MM-YYYY'), TO_DATE('04-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(89, 5, TO_DATE('28-01-2023', 'DD-MM-YYYY'), TO_DATE('29-01-2023','DD-MM-YYYY'), TO_DATE('30-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(68, 4, TO_DATE('23-04-2023', 'DD-MM-YYYY'), TO_DATE('25-04-2023','DD-MM-YYYY'), TO_DATE('26-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(44, 9, TO_DATE('20-01-2023', 'DD-MM-YYYY'), TO_DATE('23-01-2023','DD-MM-YYYY'), TO_DATE('27-01-2023','DD-MM-YYYY'), null, 1);

p_add_orders(39, 9, TO_DATE('17-01-2023', 'DD-MM-YYYY'), TO_DATE('20-01-2023','DD-MM-YYYY'), TO_DATE('24-01-2023','DD-MM-YYYY'), null, 5);

p_add_orders(5, 9, TO_DATE('17-03-2023', 'DD-MM-YYYY'), TO_DATE('19-03-2023','DD-MM-YYYY'), TO_DATE('20-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(19, 9, TO_DATE('19-01-2023', 'DD-MM-YYYY'), TO_DATE('20-01-2023','DD-MM-YYYY'), TO_DATE('21-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(68, 4, TO_DATE('04-01-2023', 'DD-MM-YYYY'), TO_DATE('06-01-2023','DD-MM-YYYY'), TO_DATE('08-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(98, 9, TO_DATE('26-02-2023', 'DD-MM-YYYY'), TO_DATE('28-02-2023','DD-MM-YYYY'), TO_DATE('01-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(20, 5, TO_DATE('16-02-2023', 'DD-MM-YYYY'), TO_DATE('20-02-2023','DD-MM-YYYY'), TO_DATE('24-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(4, 5, TO_DATE('08-04-2023', 'DD-MM-YYYY'), TO_DATE('10-04-2023','DD-MM-YYYY'), TO_DATE('13-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(34, 4, TO_DATE('20-03-2023', 'DD-MM-YYYY'), TO_DATE('22-03-2023','DD-MM-YYYY'), TO_DATE('23-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(4, 4, TO_DATE('09-02-2023', 'DD-MM-YYYY'), TO_DATE('10-02-2023','DD-MM-YYYY'), TO_DATE('14-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(67, 9, TO_DATE('31-03-2023', 'DD-MM-YYYY'), TO_DATE('03-04-2023','DD-MM-YYYY'), TO_DATE('04-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(26, 9, TO_DATE('19-01-2023', 'DD-MM-YYYY'), TO_DATE('20-01-2023','DD-MM-YYYY'), TO_DATE('21-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(13, 5, TO_DATE('09-03-2023', 'DD-MM-YYYY'), TO_DATE('12-03-2023','DD-MM-YYYY'), TO_DATE('15-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(6, 5, TO_DATE('27-03-2023', 'DD-MM-YYYY'), TO_DATE('31-03-2023','DD-MM-YYYY'), TO_DATE('04-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(53, 4, TO_DATE('17-02-2023', 'DD-MM-YYYY'), TO_DATE('19-02-2023','DD-MM-YYYY'), TO_DATE('21-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(2, 9, TO_DATE('10-03-2023', 'DD-MM-YYYY'), TO_DATE('11-03-2023','DD-MM-YYYY'), TO_DATE('15-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(49, 4, TO_DATE('03-01-2023', 'DD-MM-YYYY'), TO_DATE('05-01-2023','DD-MM-YYYY'), TO_DATE('06-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(43, 4, TO_DATE('14-02-2023', 'DD-MM-YYYY'), TO_DATE('18-02-2023','DD-MM-YYYY'), TO_DATE('22-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(66, 9, TO_DATE('10-04-2023', 'DD-MM-YYYY'), TO_DATE('13-04-2023','DD-MM-YYYY'), TO_DATE('16-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(92, 9, TO_DATE('26-03-2023', 'DD-MM-YYYY'), TO_DATE('29-03-2023','DD-MM-YYYY'), TO_DATE('30-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(36, 9, TO_DATE('29-03-2023', 'DD-MM-YYYY'), TO_DATE('30-03-2023','DD-MM-YYYY'), TO_DATE('02-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(86, 5, TO_DATE('21-03-2023', 'DD-MM-YYYY'), TO_DATE('25-03-2023','DD-MM-YYYY'), TO_DATE('26-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(89, 4, TO_DATE('05-03-2023', 'DD-MM-YYYY'), TO_DATE('09-03-2023','DD-MM-YYYY'), TO_DATE('12-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(12, 9, TO_DATE('02-02-2023', 'DD-MM-YYYY'), TO_DATE('05-02-2023','DD-MM-YYYY'), TO_DATE('06-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(42, 5, TO_DATE('11-04-2023', 'DD-MM-YYYY'), TO_DATE('15-04-2023','DD-MM-YYYY'), TO_DATE('18-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(62, 5, TO_DATE('28-04-2023', 'DD-MM-YYYY'), TO_DATE('02-05-2023','DD-MM-YYYY'), TO_DATE('05-05-2023','DD-MM-YYYY'), null, 1);

p_add_orders(34, 4, TO_DATE('10-01-2023', 'DD-MM-YYYY'), TO_DATE('12-01-2023','DD-MM-YYYY'), TO_DATE('15-01-2023','DD-MM-YYYY'), null, 5);

p_add_orders(62, 4, TO_DATE('20-03-2023', 'DD-MM-YYYY'), TO_DATE('23-03-2023','DD-MM-YYYY'), TO_DATE('24-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(21, 9, TO_DATE('12-01-2023', 'DD-MM-YYYY'), TO_DATE('15-01-2023','DD-MM-YYYY'), TO_DATE('19-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(28, 4, TO_DATE('04-01-2023', 'DD-MM-YYYY'), TO_DATE('07-01-2023','DD-MM-YYYY'), TO_DATE('10-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(34, 9, TO_DATE('09-03-2023', 'DD-MM-YYYY'), TO_DATE('11-03-2023','DD-MM-YYYY'), TO_DATE('12-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(50, 9, TO_DATE('16-04-2023', 'DD-MM-YYYY'), TO_DATE('18-04-2023','DD-MM-YYYY'), TO_DATE('20-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(24, 4, TO_DATE('06-05-2023', 'DD-MM-YYYY'), TO_DATE('08-05-2023','DD-MM-YYYY'), TO_DATE('09-05-2023','DD-MM-YYYY'), null, 1);

p_add_orders(10, 5, TO_DATE('05-05-2023', 'DD-MM-YYYY'), TO_DATE('07-05-2023','DD-MM-YYYY'), TO_DATE('11-05-2023','DD-MM-YYYY'), null, 1);

p_add_orders(24, 4, TO_DATE('24-04-2023', 'DD-MM-YYYY'), TO_DATE('28-04-2023','DD-MM-YYYY'), TO_DATE('01-05-2023','DD-MM-YYYY'), null, 5);

p_add_orders(100, 4, TO_DATE('24-01-2023', 'DD-MM-YYYY'), TO_DATE('25-01-2023','DD-MM-YYYY'), TO_DATE('28-01-2023','DD-MM-YYYY'), null, 1);

p_add_orders(1, 4, TO_DATE('25-03-2023', 'DD-MM-YYYY'), TO_DATE('28-03-2023','DD-MM-YYYY'), TO_DATE('29-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(40, 5, TO_DATE('03-03-2023', 'DD-MM-YYYY'), TO_DATE('05-03-2023','DD-MM-YYYY'), TO_DATE('08-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(28, 4, TO_DATE('08-05-2023', 'DD-MM-YYYY'), TO_DATE('09-05-2023','DD-MM-YYYY'), TO_DATE('12-05-2023','DD-MM-YYYY'), null, 4);

p_add_orders(41, 4, TO_DATE('13-01-2023', 'DD-MM-YYYY'), TO_DATE('14-01-2023','DD-MM-YYYY'), TO_DATE('18-01-2023','DD-MM-YYYY'), null, 1);

p_add_orders(31, 5, TO_DATE('05-04-2023', 'DD-MM-YYYY'), TO_DATE('06-04-2023','DD-MM-YYYY'), TO_DATE('10-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(21, 4, TO_DATE('23-02-2023', 'DD-MM-YYYY'), TO_DATE('26-02-2023','DD-MM-YYYY'), TO_DATE('27-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(64, 4, TO_DATE('19-04-2023', 'DD-MM-YYYY'), TO_DATE('20-04-2023','DD-MM-YYYY'), TO_DATE('21-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(62, 9, TO_DATE('23-02-2023', 'DD-MM-YYYY'), TO_DATE('27-02-2023','DD-MM-YYYY'), TO_DATE('01-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(89, 4, TO_DATE('16-04-2023', 'DD-MM-YYYY'), TO_DATE('18-04-2023','DD-MM-YYYY'), TO_DATE('20-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(74, 4, TO_DATE('05-02-2023', 'DD-MM-YYYY'), TO_DATE('09-02-2023','DD-MM-YYYY'), TO_DATE('10-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(71, 5, TO_DATE('26-01-2023', 'DD-MM-YYYY'), TO_DATE('28-01-2023','DD-MM-YYYY'), TO_DATE('30-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(72, 4, TO_DATE('10-03-2023', 'DD-MM-YYYY'), TO_DATE('11-03-2023','DD-MM-YYYY'), TO_DATE('12-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(87, 5, TO_DATE('22-01-2023', 'DD-MM-YYYY'), TO_DATE('25-01-2023','DD-MM-YYYY'), TO_DATE('27-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(1, 5, TO_DATE('23-03-2023', 'DD-MM-YYYY'), TO_DATE('27-03-2023','DD-MM-YYYY'), TO_DATE('28-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(70, 4, TO_DATE('25-03-2023', 'DD-MM-YYYY'), TO_DATE('27-03-2023','DD-MM-YYYY'), TO_DATE('28-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(77, 5, TO_DATE('07-04-2023', 'DD-MM-YYYY'), TO_DATE('10-04-2023','DD-MM-YYYY'), TO_DATE('14-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(94, 4, TO_DATE('01-02-2023', 'DD-MM-YYYY'), TO_DATE('04-02-2023','DD-MM-YYYY'), TO_DATE('06-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(86, 5, TO_DATE('27-02-2023', 'DD-MM-YYYY'), TO_DATE('03-03-2023','DD-MM-YYYY'), TO_DATE('05-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(1, 9, TO_DATE('10-01-2023', 'DD-MM-YYYY'), TO_DATE('13-01-2023','DD-MM-YYYY'), TO_DATE('15-01-2023','DD-MM-YYYY'), null, 5);

p_add_orders(19, 5, TO_DATE('10-04-2023', 'DD-MM-YYYY'), TO_DATE('12-04-2023','DD-MM-YYYY'), TO_DATE('14-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(22, 5, TO_DATE('04-04-2023', 'DD-MM-YYYY'), TO_DATE('07-04-2023','DD-MM-YYYY'), TO_DATE('08-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(39, 5, TO_DATE('07-04-2023', 'DD-MM-YYYY'), TO_DATE('09-04-2023','DD-MM-YYYY'), TO_DATE('11-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(82, 5, TO_DATE('25-02-2023', 'DD-MM-YYYY'), TO_DATE('28-02-2023','DD-MM-YYYY'), TO_DATE('01-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(24, 4, TO_DATE('04-02-2023', 'DD-MM-YYYY'), TO_DATE('05-02-2023','DD-MM-YYYY'), TO_DATE('08-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(59, 4, TO_DATE('06-03-2023', 'DD-MM-YYYY'), TO_DATE('08-03-2023','DD-MM-YYYY'), TO_DATE('11-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(64, 5, TO_DATE('01-01-2023', 'DD-MM-YYYY'), TO_DATE('05-01-2023','DD-MM-YYYY'), TO_DATE('07-01-2023','DD-MM-YYYY'), null, 1);

p_add_orders(78, 5, TO_DATE('01-02-2023', 'DD-MM-YYYY'), TO_DATE('02-02-2023','DD-MM-YYYY'), TO_DATE('03-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(48, 5, TO_DATE('05-01-2023', 'DD-MM-YYYY'), TO_DATE('08-01-2023','DD-MM-YYYY'), TO_DATE('11-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(46, 5, TO_DATE('23-04-2023', 'DD-MM-YYYY'), TO_DATE('24-04-2023','DD-MM-YYYY'), TO_DATE('28-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(34, 5, TO_DATE('05-04-2023', 'DD-MM-YYYY'), TO_DATE('06-04-2023','DD-MM-YYYY'), TO_DATE('09-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(31, 9, TO_DATE('03-02-2023', 'DD-MM-YYYY'), TO_DATE('06-02-2023','DD-MM-YYYY'), TO_DATE('08-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(81, 4, TO_DATE('26-04-2023', 'DD-MM-YYYY'), TO_DATE('27-04-2023','DD-MM-YYYY'), TO_DATE('30-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(94, 5, TO_DATE('01-03-2023', 'DD-MM-YYYY'), TO_DATE('05-03-2023','DD-MM-YYYY'), TO_DATE('06-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(74, 4, TO_DATE('21-01-2023', 'DD-MM-YYYY'), TO_DATE('24-01-2023','DD-MM-YYYY'), TO_DATE('25-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(37, 9, TO_DATE('22-03-2023', 'DD-MM-YYYY'), TO_DATE('25-03-2023','DD-MM-YYYY'), TO_DATE('28-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(76, 4, TO_DATE('09-05-2023', 'DD-MM-YYYY'), TO_DATE('13-05-2023','DD-MM-YYYY'), TO_DATE('17-05-2023','DD-MM-YYYY'), null, 2);

p_add_orders(57, 4, TO_DATE('11-03-2023', 'DD-MM-YYYY'), TO_DATE('12-03-2023','DD-MM-YYYY'), TO_DATE('15-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(3, 5, TO_DATE('02-04-2023', 'DD-MM-YYYY'), TO_DATE('04-04-2023','DD-MM-YYYY'), TO_DATE('07-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(11, 5, TO_DATE('30-04-2023', 'DD-MM-YYYY'), TO_DATE('03-05-2023','DD-MM-YYYY'), TO_DATE('06-05-2023','DD-MM-YYYY'), null, 2);

p_add_orders(44, 4, TO_DATE('08-01-2023', 'DD-MM-YYYY'), TO_DATE('10-01-2023','DD-MM-YYYY'), TO_DATE('12-01-2023','DD-MM-YYYY'), null, 5);

p_add_orders(65, 5, TO_DATE('01-01-2023', 'DD-MM-YYYY'), TO_DATE('02-01-2023','DD-MM-YYYY'), TO_DATE('03-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(65, 9, TO_DATE('05-01-2023', 'DD-MM-YYYY'), TO_DATE('07-01-2023','DD-MM-YYYY'), TO_DATE('08-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(52, 5, TO_DATE('04-02-2023', 'DD-MM-YYYY'), TO_DATE('08-02-2023','DD-MM-YYYY'), TO_DATE('10-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(26, 5, TO_DATE('21-03-2023', 'DD-MM-YYYY'), TO_DATE('24-03-2023','DD-MM-YYYY'), TO_DATE('25-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(17, 4, TO_DATE('06-02-2023', 'DD-MM-YYYY'), TO_DATE('07-02-2023','DD-MM-YYYY'), TO_DATE('10-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(77, 9, TO_DATE('28-03-2023', 'DD-MM-YYYY'), TO_DATE('30-03-2023','DD-MM-YYYY'), TO_DATE('02-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(75, 5, TO_DATE('17-02-2023', 'DD-MM-YYYY'), TO_DATE('18-02-2023','DD-MM-YYYY'), TO_DATE('21-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(10, 4, TO_DATE('04-01-2023', 'DD-MM-YYYY'), TO_DATE('05-01-2023','DD-MM-YYYY'), TO_DATE('06-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(12, 9, TO_DATE('18-03-2023', 'DD-MM-YYYY'), TO_DATE('22-03-2023','DD-MM-YYYY'), TO_DATE('26-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(40, 9, TO_DATE('05-04-2023', 'DD-MM-YYYY'), TO_DATE('06-04-2023','DD-MM-YYYY'), TO_DATE('09-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(14, 9, TO_DATE('06-03-2023', 'DD-MM-YYYY'), TO_DATE('09-03-2023','DD-MM-YYYY'), TO_DATE('12-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(27, 5, TO_DATE('23-04-2023', 'DD-MM-YYYY'), TO_DATE('25-04-2023','DD-MM-YYYY'), TO_DATE('29-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(20, 4, TO_DATE('26-02-2023', 'DD-MM-YYYY'), TO_DATE('28-02-2023','DD-MM-YYYY'), TO_DATE('02-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(30, 5, TO_DATE('06-05-2023', 'DD-MM-YYYY'), TO_DATE('07-05-2023','DD-MM-YYYY'), TO_DATE('08-05-2023','DD-MM-YYYY'), null, 5);

p_add_orders(3, 9, TO_DATE('14-02-2023', 'DD-MM-YYYY'), TO_DATE('16-02-2023','DD-MM-YYYY'), TO_DATE('17-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(90, 4, TO_DATE('16-03-2023', 'DD-MM-YYYY'), TO_DATE('18-03-2023','DD-MM-YYYY'), TO_DATE('20-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(66, 5, TO_DATE('13-01-2023', 'DD-MM-YYYY'), TO_DATE('15-01-2023','DD-MM-YYYY'), TO_DATE('17-01-2023','DD-MM-YYYY'), null, 1);

p_add_orders(80, 5, TO_DATE('14-04-2023', 'DD-MM-YYYY'), TO_DATE('18-04-2023','DD-MM-YYYY'), TO_DATE('19-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(53, 9, TO_DATE('19-04-2023', 'DD-MM-YYYY'), TO_DATE('21-04-2023','DD-MM-YYYY'), TO_DATE('24-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(22, 5, TO_DATE('11-02-2023', 'DD-MM-YYYY'), TO_DATE('13-02-2023','DD-MM-YYYY'), TO_DATE('16-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(35, 4, TO_DATE('16-04-2023', 'DD-MM-YYYY'), TO_DATE('18-04-2023','DD-MM-YYYY'), TO_DATE('21-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(94, 4, TO_DATE('19-03-2023', 'DD-MM-YYYY'), TO_DATE('20-03-2023','DD-MM-YYYY'), TO_DATE('21-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(84, 9, TO_DATE('09-01-2023', 'DD-MM-YYYY'), TO_DATE('12-01-2023','DD-MM-YYYY'), TO_DATE('16-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(2, 9, TO_DATE('04-02-2023', 'DD-MM-YYYY'), TO_DATE('05-02-2023','DD-MM-YYYY'), TO_DATE('09-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(37, 5, TO_DATE('31-03-2023', 'DD-MM-YYYY'), TO_DATE('01-04-2023','DD-MM-YYYY'), TO_DATE('03-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(89, 4, TO_DATE('31-03-2023', 'DD-MM-YYYY'), TO_DATE('01-04-2023','DD-MM-YYYY'), TO_DATE('05-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(19, 4, TO_DATE('18-01-2023', 'DD-MM-YYYY'), TO_DATE('21-01-2023','DD-MM-YYYY'), TO_DATE('22-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(60, 5, TO_DATE('28-04-2023', 'DD-MM-YYYY'), TO_DATE('30-04-2023','DD-MM-YYYY'), TO_DATE('04-05-2023','DD-MM-YYYY'), null, 4);

p_add_orders(57, 5, TO_DATE('11-01-2023', 'DD-MM-YYYY'), TO_DATE('14-01-2023','DD-MM-YYYY'), TO_DATE('16-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(68, 5, TO_DATE('12-02-2023', 'DD-MM-YYYY'), TO_DATE('13-02-2023','DD-MM-YYYY'), TO_DATE('17-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(88, 5, TO_DATE('20-02-2023', 'DD-MM-YYYY'), TO_DATE('21-02-2023','DD-MM-YYYY'), TO_DATE('22-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(44, 5, TO_DATE('08-02-2023', 'DD-MM-YYYY'), TO_DATE('10-02-2023','DD-MM-YYYY'), TO_DATE('13-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(46, 4, TO_DATE('09-03-2023', 'DD-MM-YYYY'), TO_DATE('13-03-2023','DD-MM-YYYY'), TO_DATE('16-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(26, 4, TO_DATE('24-02-2023', 'DD-MM-YYYY'), TO_DATE('26-02-2023','DD-MM-YYYY'), TO_DATE('01-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(87, 9, TO_DATE('07-03-2023', 'DD-MM-YYYY'), TO_DATE('11-03-2023','DD-MM-YYYY'), TO_DATE('15-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(81, 9, TO_DATE('16-01-2023', 'DD-MM-YYYY'), TO_DATE('17-01-2023','DD-MM-YYYY'), TO_DATE('20-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(35, 4, TO_DATE('28-02-2023', 'DD-MM-YYYY'), TO_DATE('04-03-2023','DD-MM-YYYY'), TO_DATE('07-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(88, 5, TO_DATE('06-04-2023', 'DD-MM-YYYY'), TO_DATE('07-04-2023','DD-MM-YYYY'), TO_DATE('08-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(100, 9, TO_DATE('08-02-2023', 'DD-MM-YYYY'), TO_DATE('12-02-2023','DD-MM-YYYY'), TO_DATE('15-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(96, 5, TO_DATE('07-04-2023', 'DD-MM-YYYY'), TO_DATE('09-04-2023','DD-MM-YYYY'), TO_DATE('13-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(93, 4, TO_DATE('28-04-2023', 'DD-MM-YYYY'), TO_DATE('02-05-2023','DD-MM-YYYY'), TO_DATE('04-05-2023','DD-MM-YYYY'), null, 5);

p_add_orders(82, 4, TO_DATE('17-02-2023', 'DD-MM-YYYY'), TO_DATE('21-02-2023','DD-MM-YYYY'), TO_DATE('23-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(84, 5, TO_DATE('02-03-2023', 'DD-MM-YYYY'), TO_DATE('05-03-2023','DD-MM-YYYY'), TO_DATE('06-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(96, 5, TO_DATE('25-02-2023', 'DD-MM-YYYY'), TO_DATE('26-02-2023','DD-MM-YYYY'), TO_DATE('02-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(60, 5, TO_DATE('11-02-2023', 'DD-MM-YYYY'), TO_DATE('12-02-2023','DD-MM-YYYY'), TO_DATE('13-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(54, 9, TO_DATE('11-02-2023', 'DD-MM-YYYY'), TO_DATE('12-02-2023','DD-MM-YYYY'), TO_DATE('15-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(35, 4, TO_DATE('01-04-2023', 'DD-MM-YYYY'), TO_DATE('04-04-2023','DD-MM-YYYY'), TO_DATE('06-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(46, 5, TO_DATE('07-05-2023', 'DD-MM-YYYY'), TO_DATE('08-05-2023','DD-MM-YYYY'), TO_DATE('11-05-2023','DD-MM-YYYY'), null, 5);

p_add_orders(81, 4, TO_DATE('29-01-2023', 'DD-MM-YYYY'), TO_DATE('31-01-2023','DD-MM-YYYY'), TO_DATE('03-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(17, 9, TO_DATE('22-04-2023', 'DD-MM-YYYY'), TO_DATE('24-04-2023','DD-MM-YYYY'), TO_DATE('28-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(50, 4, TO_DATE('04-03-2023', 'DD-MM-YYYY'), TO_DATE('07-03-2023','DD-MM-YYYY'), TO_DATE('09-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(74, 5, TO_DATE('12-02-2023', 'DD-MM-YYYY'), TO_DATE('15-02-2023','DD-MM-YYYY'), TO_DATE('17-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(13, 5, TO_DATE('14-03-2023', 'DD-MM-YYYY'), TO_DATE('17-03-2023','DD-MM-YYYY'), TO_DATE('18-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(34, 9, TO_DATE('11-03-2023', 'DD-MM-YYYY'), TO_DATE('12-03-2023','DD-MM-YYYY'), TO_DATE('16-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(91, 9, TO_DATE('01-03-2023', 'DD-MM-YYYY'), TO_DATE('05-03-2023','DD-MM-YYYY'), TO_DATE('07-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(40, 4, TO_DATE('16-03-2023', 'DD-MM-YYYY'), TO_DATE('20-03-2023','DD-MM-YYYY'), TO_DATE('23-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(54, 4, TO_DATE('14-02-2023', 'DD-MM-YYYY'), TO_DATE('15-02-2023','DD-MM-YYYY'), TO_DATE('19-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(100, 9, TO_DATE('18-04-2023', 'DD-MM-YYYY'), TO_DATE('20-04-2023','DD-MM-YYYY'), TO_DATE('23-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(64, 4, TO_DATE('06-01-2023', 'DD-MM-YYYY'), TO_DATE('09-01-2023','DD-MM-YYYY'), TO_DATE('11-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(19, 5, TO_DATE('01-05-2023', 'DD-MM-YYYY'), TO_DATE('04-05-2023','DD-MM-YYYY'), TO_DATE('05-05-2023','DD-MM-YYYY'), null, 1);

p_add_orders(22, 9, TO_DATE('21-03-2023', 'DD-MM-YYYY'), TO_DATE('23-03-2023','DD-MM-YYYY'), TO_DATE('25-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(55, 4, TO_DATE('16-04-2023', 'DD-MM-YYYY'), TO_DATE('20-04-2023','DD-MM-YYYY'), TO_DATE('24-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(3, 9, TO_DATE('19-04-2023', 'DD-MM-YYYY'), TO_DATE('23-04-2023','DD-MM-YYYY'), TO_DATE('24-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(32, 5, TO_DATE('10-05-2023', 'DD-MM-YYYY'), TO_DATE('12-05-2023','DD-MM-YYYY'), TO_DATE('14-05-2023','DD-MM-YYYY'), null, 2);

p_add_orders(29, 5, TO_DATE('09-01-2023', 'DD-MM-YYYY'), TO_DATE('12-01-2023','DD-MM-YYYY'), TO_DATE('15-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(68, 9, TO_DATE('06-02-2023', 'DD-MM-YYYY'), TO_DATE('10-02-2023','DD-MM-YYYY'), TO_DATE('14-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(55, 5, TO_DATE('16-04-2023', 'DD-MM-YYYY'), TO_DATE('19-04-2023','DD-MM-YYYY'), TO_DATE('23-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(85, 4, TO_DATE('07-02-2023', 'DD-MM-YYYY'), TO_DATE('10-02-2023','DD-MM-YYYY'), TO_DATE('11-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(70, 4, TO_DATE('22-03-2023', 'DD-MM-YYYY'), TO_DATE('23-03-2023','DD-MM-YYYY'), TO_DATE('25-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(70, 4, TO_DATE('22-03-2023', 'DD-MM-YYYY'), TO_DATE('24-03-2023','DD-MM-YYYY'), TO_DATE('27-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(1, 4, TO_DATE('07-02-2023', 'DD-MM-YYYY'), TO_DATE('09-02-2023','DD-MM-YYYY'), TO_DATE('13-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(64, 9, TO_DATE('22-01-2023', 'DD-MM-YYYY'), TO_DATE('26-01-2023','DD-MM-YYYY'), TO_DATE('30-01-2023','DD-MM-YYYY'), null, 1);

p_add_orders(68, 5, TO_DATE('30-01-2023', 'DD-MM-YYYY'), TO_DATE('01-02-2023','DD-MM-YYYY'), TO_DATE('04-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(67, 9, TO_DATE('18-03-2023', 'DD-MM-YYYY'), TO_DATE('22-03-2023','DD-MM-YYYY'), TO_DATE('26-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(88, 4, TO_DATE('07-02-2023', 'DD-MM-YYYY'), TO_DATE('09-02-2023','DD-MM-YYYY'), TO_DATE('10-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(98, 9, TO_DATE('06-04-2023', 'DD-MM-YYYY'), TO_DATE('08-04-2023','DD-MM-YYYY'), TO_DATE('11-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(22, 4, TO_DATE('12-02-2023', 'DD-MM-YYYY'), TO_DATE('16-02-2023','DD-MM-YYYY'), TO_DATE('17-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(95, 9, TO_DATE('07-05-2023', 'DD-MM-YYYY'), TO_DATE('11-05-2023','DD-MM-YYYY'), TO_DATE('14-05-2023','DD-MM-YYYY'), null, 4);

p_add_orders(19, 5, TO_DATE('05-05-2023', 'DD-MM-YYYY'), TO_DATE('09-05-2023','DD-MM-YYYY'), TO_DATE('11-05-2023','DD-MM-YYYY'), null, 5);

p_add_orders(92, 4, TO_DATE('17-02-2023', 'DD-MM-YYYY'), TO_DATE('18-02-2023','DD-MM-YYYY'), TO_DATE('22-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(54, 9, TO_DATE('17-02-2023', 'DD-MM-YYYY'), TO_DATE('18-02-2023','DD-MM-YYYY'), TO_DATE('21-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(94, 5, TO_DATE('14-04-2023', 'DD-MM-YYYY'), TO_DATE('18-04-2023','DD-MM-YYYY'), TO_DATE('21-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(8, 9, TO_DATE('01-03-2023', 'DD-MM-YYYY'), TO_DATE('04-03-2023','DD-MM-YYYY'), TO_DATE('07-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(65, 4, TO_DATE('11-01-2023', 'DD-MM-YYYY'), TO_DATE('14-01-2023','DD-MM-YYYY'), TO_DATE('15-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(53, 4, TO_DATE('23-04-2023', 'DD-MM-YYYY'), TO_DATE('24-04-2023','DD-MM-YYYY'), TO_DATE('25-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(17, 9, TO_DATE('07-05-2023', 'DD-MM-YYYY'), TO_DATE('11-05-2023','DD-MM-YYYY'), TO_DATE('14-05-2023','DD-MM-YYYY'), null, 2);

p_add_orders(11, 9, TO_DATE('04-03-2023', 'DD-MM-YYYY'), TO_DATE('07-03-2023','DD-MM-YYYY'), TO_DATE('08-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(92, 9, TO_DATE('09-01-2023', 'DD-MM-YYYY'), TO_DATE('11-01-2023','DD-MM-YYYY'), TO_DATE('15-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(5, 4, TO_DATE('12-03-2023', 'DD-MM-YYYY'), TO_DATE('15-03-2023','DD-MM-YYYY'), TO_DATE('19-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(42, 9, TO_DATE('09-01-2023', 'DD-MM-YYYY'), TO_DATE('11-01-2023','DD-MM-YYYY'), TO_DATE('12-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(68, 5, TO_DATE('29-04-2023', 'DD-MM-YYYY'), TO_DATE('02-05-2023','DD-MM-YYYY'), TO_DATE('05-05-2023','DD-MM-YYYY'), null, 4);

p_add_orders(8, 9, TO_DATE('14-02-2023', 'DD-MM-YYYY'), TO_DATE('17-02-2023','DD-MM-YYYY'), TO_DATE('18-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(17, 9, TO_DATE('10-01-2023', 'DD-MM-YYYY'), TO_DATE('13-01-2023','DD-MM-YYYY'), TO_DATE('16-01-2023','DD-MM-YYYY'), null, 1);

p_add_orders(54, 4, TO_DATE('15-01-2023', 'DD-MM-YYYY'), TO_DATE('16-01-2023','DD-MM-YYYY'), TO_DATE('18-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(46, 9, TO_DATE('30-03-2023', 'DD-MM-YYYY'), TO_DATE('31-03-2023','DD-MM-YYYY'), TO_DATE('01-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(59, 4, TO_DATE('11-04-2023', 'DD-MM-YYYY'), TO_DATE('14-04-2023','DD-MM-YYYY'), TO_DATE('17-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(14, 4, TO_DATE('01-04-2023', 'DD-MM-YYYY'), TO_DATE('05-04-2023','DD-MM-YYYY'), TO_DATE('08-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(57, 4, TO_DATE('04-02-2023', 'DD-MM-YYYY'), TO_DATE('06-02-2023','DD-MM-YYYY'), TO_DATE('09-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(55, 5, TO_DATE('22-02-2023', 'DD-MM-YYYY'), TO_DATE('23-02-2023','DD-MM-YYYY'), TO_DATE('27-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(36, 4, TO_DATE('24-03-2023', 'DD-MM-YYYY'), TO_DATE('26-03-2023','DD-MM-YYYY'), TO_DATE('28-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(78, 4, TO_DATE('01-05-2023', 'DD-MM-YYYY'), TO_DATE('05-05-2023','DD-MM-YYYY'), TO_DATE('09-05-2023','DD-MM-YYYY'), null, 4);

p_add_orders(93, 5, TO_DATE('23-01-2023', 'DD-MM-YYYY'), TO_DATE('25-01-2023','DD-MM-YYYY'), TO_DATE('29-01-2023','DD-MM-YYYY'), null, 5);

p_add_orders(33, 9, TO_DATE('30-01-2023', 'DD-MM-YYYY'), TO_DATE('31-01-2023','DD-MM-YYYY'), TO_DATE('02-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(12, 5, TO_DATE('17-01-2023', 'DD-MM-YYYY'), TO_DATE('21-01-2023','DD-MM-YYYY'), TO_DATE('25-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(37, 9, TO_DATE('06-03-2023', 'DD-MM-YYYY'), TO_DATE('09-03-2023','DD-MM-YYYY'), TO_DATE('13-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(18, 4, TO_DATE('08-05-2023', 'DD-MM-YYYY'), TO_DATE('11-05-2023','DD-MM-YYYY'), TO_DATE('12-05-2023','DD-MM-YYYY'), null, 4);

p_add_orders(57, 4, TO_DATE('12-04-2023', 'DD-MM-YYYY'), TO_DATE('14-04-2023','DD-MM-YYYY'), TO_DATE('15-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(2, 5, TO_DATE('22-01-2023', 'DD-MM-YYYY'), TO_DATE('24-01-2023','DD-MM-YYYY'), TO_DATE('25-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(24, 9, TO_DATE('18-04-2023', 'DD-MM-YYYY'), TO_DATE('22-04-2023','DD-MM-YYYY'), TO_DATE('24-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(5, 4, TO_DATE('19-04-2023', 'DD-MM-YYYY'), TO_DATE('22-04-2023','DD-MM-YYYY'), TO_DATE('26-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(52, 9, TO_DATE('16-01-2023', 'DD-MM-YYYY'), TO_DATE('19-01-2023','DD-MM-YYYY'), TO_DATE('21-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(100, 5, TO_DATE('01-04-2023', 'DD-MM-YYYY'), TO_DATE('03-04-2023','DD-MM-YYYY'), TO_DATE('07-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(37, 4, TO_DATE('21-01-2023', 'DD-MM-YYYY'), TO_DATE('23-01-2023','DD-MM-YYYY'), TO_DATE('25-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(52, 5, TO_DATE('13-01-2023', 'DD-MM-YYYY'), TO_DATE('16-01-2023','DD-MM-YYYY'), TO_DATE('20-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(6, 4, TO_DATE('19-01-2023', 'DD-MM-YYYY'), TO_DATE('20-01-2023','DD-MM-YYYY'), TO_DATE('21-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(46, 9, TO_DATE('18-01-2023', 'DD-MM-YYYY'), TO_DATE('22-01-2023','DD-MM-YYYY'), TO_DATE('24-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(52, 4, TO_DATE('05-03-2023', 'DD-MM-YYYY'), TO_DATE('07-03-2023','DD-MM-YYYY'), TO_DATE('09-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(93, 4, TO_DATE('22-02-2023', 'DD-MM-YYYY'), TO_DATE('26-02-2023','DD-MM-YYYY'), TO_DATE('27-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(81, 5, TO_DATE('06-01-2023', 'DD-MM-YYYY'), TO_DATE('07-01-2023','DD-MM-YYYY'), TO_DATE('11-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(31, 9, TO_DATE('16-01-2023', 'DD-MM-YYYY'), TO_DATE('19-01-2023','DD-MM-YYYY'), TO_DATE('22-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(94, 9, TO_DATE('14-03-2023', 'DD-MM-YYYY'), TO_DATE('18-03-2023','DD-MM-YYYY'), TO_DATE('20-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(34, 9, TO_DATE('23-04-2023', 'DD-MM-YYYY'), TO_DATE('24-04-2023','DD-MM-YYYY'), TO_DATE('28-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(9, 5, TO_DATE('27-03-2023', 'DD-MM-YYYY'), TO_DATE('30-03-2023','DD-MM-YYYY'), TO_DATE('31-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(38, 9, TO_DATE('29-04-2023', 'DD-MM-YYYY'), TO_DATE('02-05-2023','DD-MM-YYYY'), TO_DATE('04-05-2023','DD-MM-YYYY'), null, 1);

p_add_orders(32, 4, TO_DATE('08-04-2023', 'DD-MM-YYYY'), TO_DATE('09-04-2023','DD-MM-YYYY'), TO_DATE('11-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(91, 9, TO_DATE('21-01-2023', 'DD-MM-YYYY'), TO_DATE('23-01-2023','DD-MM-YYYY'), TO_DATE('24-01-2023','DD-MM-YYYY'), null, 1);

p_add_orders(12, 4, TO_DATE('17-04-2023', 'DD-MM-YYYY'), TO_DATE('19-04-2023','DD-MM-YYYY'), TO_DATE('23-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(29, 5, TO_DATE('08-05-2023', 'DD-MM-YYYY'), TO_DATE('12-05-2023','DD-MM-YYYY'), TO_DATE('13-05-2023','DD-MM-YYYY'), null, 1);

p_add_orders(69, 4, TO_DATE('07-01-2023', 'DD-MM-YYYY'), TO_DATE('08-01-2023','DD-MM-YYYY'), TO_DATE('11-01-2023','DD-MM-YYYY'), null, 5);

p_add_orders(100, 4, TO_DATE('24-04-2023', 'DD-MM-YYYY'), TO_DATE('28-04-2023','DD-MM-YYYY'), TO_DATE('01-05-2023','DD-MM-YYYY'), null, 1);

p_add_orders(95, 5, TO_DATE('16-03-2023', 'DD-MM-YYYY'), TO_DATE('17-03-2023','DD-MM-YYYY'), TO_DATE('20-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(65, 5, TO_DATE('29-01-2023', 'DD-MM-YYYY'), TO_DATE('31-01-2023','DD-MM-YYYY'), TO_DATE('03-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(3, 5, TO_DATE('08-02-2023', 'DD-MM-YYYY'), TO_DATE('11-02-2023','DD-MM-YYYY'), TO_DATE('14-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(48, 5, TO_DATE('30-03-2023', 'DD-MM-YYYY'), TO_DATE('03-04-2023','DD-MM-YYYY'), TO_DATE('04-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(46, 4, TO_DATE('04-04-2023', 'DD-MM-YYYY'), TO_DATE('08-04-2023','DD-MM-YYYY'), TO_DATE('12-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(14, 5, TO_DATE('07-01-2023', 'DD-MM-YYYY'), TO_DATE('08-01-2023','DD-MM-YYYY'), TO_DATE('11-01-2023','DD-MM-YYYY'), null, 5);

p_add_orders(10, 9, TO_DATE('03-05-2023', 'DD-MM-YYYY'), TO_DATE('04-05-2023','DD-MM-YYYY'), TO_DATE('06-05-2023','DD-MM-YYYY'), null, 5);

p_add_orders(9, 4, TO_DATE('28-03-2023', 'DD-MM-YYYY'), TO_DATE('30-03-2023','DD-MM-YYYY'), TO_DATE('01-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(31, 5, TO_DATE('09-05-2023', 'DD-MM-YYYY'), TO_DATE('12-05-2023','DD-MM-YYYY'), TO_DATE('14-05-2023','DD-MM-YYYY'), null, 2);

p_add_orders(13, 9, TO_DATE('08-05-2023', 'DD-MM-YYYY'), TO_DATE('09-05-2023','DD-MM-YYYY'), TO_DATE('12-05-2023','DD-MM-YYYY'), null, 5);

p_add_orders(6, 9, TO_DATE('25-02-2023', 'DD-MM-YYYY'), TO_DATE('01-03-2023','DD-MM-YYYY'), TO_DATE('02-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(44, 4, TO_DATE('25-01-2023', 'DD-MM-YYYY'), TO_DATE('26-01-2023','DD-MM-YYYY'), TO_DATE('27-01-2023','DD-MM-YYYY'), null, 5);

p_add_orders(2, 5, TO_DATE('10-03-2023', 'DD-MM-YYYY'), TO_DATE('12-03-2023','DD-MM-YYYY'), TO_DATE('16-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(16, 4, TO_DATE('23-03-2023', 'DD-MM-YYYY'), TO_DATE('25-03-2023','DD-MM-YYYY'), TO_DATE('29-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(34, 9, TO_DATE('05-02-2023', 'DD-MM-YYYY'), TO_DATE('07-02-2023','DD-MM-YYYY'), TO_DATE('09-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(10, 9, TO_DATE('22-01-2023', 'DD-MM-YYYY'), TO_DATE('23-01-2023','DD-MM-YYYY'), TO_DATE('26-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(77, 4, TO_DATE('21-03-2023', 'DD-MM-YYYY'), TO_DATE('25-03-2023','DD-MM-YYYY'), TO_DATE('26-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(52, 5, TO_DATE('04-03-2023', 'DD-MM-YYYY'), TO_DATE('07-03-2023','DD-MM-YYYY'), TO_DATE('11-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(75, 9, TO_DATE('19-02-2023', 'DD-MM-YYYY'), TO_DATE('21-02-2023','DD-MM-YYYY'), TO_DATE('22-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(39, 9, TO_DATE('10-03-2023', 'DD-MM-YYYY'), TO_DATE('12-03-2023','DD-MM-YYYY'), TO_DATE('16-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(14, 4, TO_DATE('06-04-2023', 'DD-MM-YYYY'), TO_DATE('09-04-2023','DD-MM-YYYY'), TO_DATE('12-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(42, 9, TO_DATE('20-02-2023', 'DD-MM-YYYY'), TO_DATE('24-02-2023','DD-MM-YYYY'), TO_DATE('25-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(11, 4, TO_DATE('06-02-2023', 'DD-MM-YYYY'), TO_DATE('10-02-2023','DD-MM-YYYY'), TO_DATE('12-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(89, 9, TO_DATE('10-04-2023', 'DD-MM-YYYY'), TO_DATE('14-04-2023','DD-MM-YYYY'), TO_DATE('17-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(64, 4, TO_DATE('18-01-2023', 'DD-MM-YYYY'), TO_DATE('19-01-2023','DD-MM-YYYY'), TO_DATE('22-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(3, 4, TO_DATE('20-02-2023', 'DD-MM-YYYY'), TO_DATE('24-02-2023','DD-MM-YYYY'), TO_DATE('25-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(72, 5, TO_DATE('24-02-2023', 'DD-MM-YYYY'), TO_DATE('28-02-2023','DD-MM-YYYY'), TO_DATE('03-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(1, 4, TO_DATE('07-05-2023', 'DD-MM-YYYY'), TO_DATE('10-05-2023','DD-MM-YYYY'), TO_DATE('13-05-2023','DD-MM-YYYY'), null, 2);

p_add_orders(88, 5, TO_DATE('29-04-2023', 'DD-MM-YYYY'), TO_DATE('02-05-2023','DD-MM-YYYY'), TO_DATE('06-05-2023','DD-MM-YYYY'), null, 2);

p_add_orders(91, 5, TO_DATE('01-04-2023', 'DD-MM-YYYY'), TO_DATE('05-04-2023','DD-MM-YYYY'), TO_DATE('06-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(75, 9, TO_DATE('15-02-2023', 'DD-MM-YYYY'), TO_DATE('19-02-2023','DD-MM-YYYY'), TO_DATE('20-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(3, 9, TO_DATE('13-01-2023', 'DD-MM-YYYY'), TO_DATE('17-01-2023','DD-MM-YYYY'), TO_DATE('19-01-2023','DD-MM-YYYY'), null, 1);

p_add_orders(83, 5, TO_DATE('21-01-2023', 'DD-MM-YYYY'), TO_DATE('24-01-2023','DD-MM-YYYY'), TO_DATE('25-01-2023','DD-MM-YYYY'), null, 5);

p_add_orders(68, 9, TO_DATE('13-03-2023', 'DD-MM-YYYY'), TO_DATE('14-03-2023','DD-MM-YYYY'), TO_DATE('16-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(93, 4, TO_DATE('17-04-2023', 'DD-MM-YYYY'), TO_DATE('19-04-2023','DD-MM-YYYY'), TO_DATE('20-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(32, 4, TO_DATE('07-05-2023', 'DD-MM-YYYY'), TO_DATE('08-05-2023','DD-MM-YYYY'), TO_DATE('09-05-2023','DD-MM-YYYY'), null, 5);

p_add_orders(88, 9, TO_DATE('08-02-2023', 'DD-MM-YYYY'), TO_DATE('12-02-2023','DD-MM-YYYY'), TO_DATE('16-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(16, 5, TO_DATE('29-03-2023', 'DD-MM-YYYY'), TO_DATE('30-03-2023','DD-MM-YYYY'), TO_DATE('02-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(18, 4, TO_DATE('14-03-2023', 'DD-MM-YYYY'), TO_DATE('15-03-2023','DD-MM-YYYY'), TO_DATE('17-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(74, 9, TO_DATE('20-03-2023', 'DD-MM-YYYY'), TO_DATE('23-03-2023','DD-MM-YYYY'), TO_DATE('24-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(34, 4, TO_DATE('27-03-2023', 'DD-MM-YYYY'), TO_DATE('28-03-2023','DD-MM-YYYY'), TO_DATE('31-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(92, 4, TO_DATE('12-03-2023', 'DD-MM-YYYY'), TO_DATE('16-03-2023','DD-MM-YYYY'), TO_DATE('17-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(3, 4, TO_DATE('16-04-2023', 'DD-MM-YYYY'), TO_DATE('17-04-2023','DD-MM-YYYY'), TO_DATE('20-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(70, 9, TO_DATE('30-04-2023', 'DD-MM-YYYY'), TO_DATE('04-05-2023','DD-MM-YYYY'), TO_DATE('06-05-2023','DD-MM-YYYY'), null, 4);

p_add_orders(40, 4, TO_DATE('14-03-2023', 'DD-MM-YYYY'), TO_DATE('18-03-2023','DD-MM-YYYY'), TO_DATE('19-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(51, 9, TO_DATE('04-03-2023', 'DD-MM-YYYY'), TO_DATE('05-03-2023','DD-MM-YYYY'), TO_DATE('07-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(32, 5, TO_DATE('02-01-2023', 'DD-MM-YYYY'), TO_DATE('06-01-2023','DD-MM-YYYY'), TO_DATE('07-01-2023','DD-MM-YYYY'), null, 5);

p_add_orders(81, 5, TO_DATE('11-01-2023', 'DD-MM-YYYY'), TO_DATE('14-01-2023','DD-MM-YYYY'), TO_DATE('18-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(100, 9, TO_DATE('27-01-2023', 'DD-MM-YYYY'), TO_DATE('31-01-2023','DD-MM-YYYY'), TO_DATE('01-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(32, 4, TO_DATE('10-03-2023', 'DD-MM-YYYY'), TO_DATE('12-03-2023','DD-MM-YYYY'), TO_DATE('16-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(75, 4, TO_DATE('10-04-2023', 'DD-MM-YYYY'), TO_DATE('14-04-2023','DD-MM-YYYY'), TO_DATE('16-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(62, 9, TO_DATE('17-02-2023', 'DD-MM-YYYY'), TO_DATE('19-02-2023','DD-MM-YYYY'), TO_DATE('21-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(28, 4, TO_DATE('09-03-2023', 'DD-MM-YYYY'), TO_DATE('13-03-2023','DD-MM-YYYY'), TO_DATE('15-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(18, 5, TO_DATE('07-02-2023', 'DD-MM-YYYY'), TO_DATE('11-02-2023','DD-MM-YYYY'), TO_DATE('15-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(30, 5, TO_DATE('02-03-2023', 'DD-MM-YYYY'), TO_DATE('06-03-2023','DD-MM-YYYY'), TO_DATE('10-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(23, 5, TO_DATE('01-03-2023', 'DD-MM-YYYY'), TO_DATE('05-03-2023','DD-MM-YYYY'), TO_DATE('07-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(28, 4, TO_DATE('10-04-2023', 'DD-MM-YYYY'), TO_DATE('14-04-2023','DD-MM-YYYY'), TO_DATE('17-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(84, 5, TO_DATE('22-02-2023', 'DD-MM-YYYY'), TO_DATE('23-02-2023','DD-MM-YYYY'), TO_DATE('26-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(25, 5, TO_DATE('13-04-2023', 'DD-MM-YYYY'), TO_DATE('17-04-2023','DD-MM-YYYY'), TO_DATE('18-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(93, 9, TO_DATE('17-02-2023', 'DD-MM-YYYY'), TO_DATE('19-02-2023','DD-MM-YYYY'), TO_DATE('21-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(95, 9, TO_DATE('27-02-2023', 'DD-MM-YYYY'), TO_DATE('01-03-2023','DD-MM-YYYY'), TO_DATE('04-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(99, 5, TO_DATE('17-04-2023', 'DD-MM-YYYY'), TO_DATE('20-04-2023','DD-MM-YYYY'), TO_DATE('24-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(21, 4, TO_DATE('19-03-2023', 'DD-MM-YYYY'), TO_DATE('20-03-2023','DD-MM-YYYY'), TO_DATE('23-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(57, 5, TO_DATE('12-02-2023', 'DD-MM-YYYY'), TO_DATE('16-02-2023','DD-MM-YYYY'), TO_DATE('20-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(74, 5, TO_DATE('06-04-2023', 'DD-MM-YYYY'), TO_DATE('10-04-2023','DD-MM-YYYY'), TO_DATE('14-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(36, 4, TO_DATE('10-04-2023', 'DD-MM-YYYY'), TO_DATE('12-04-2023','DD-MM-YYYY'), TO_DATE('15-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(38, 9, TO_DATE('08-02-2023', 'DD-MM-YYYY'), TO_DATE('10-02-2023','DD-MM-YYYY'), TO_DATE('12-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(9, 4, TO_DATE('21-01-2023', 'DD-MM-YYYY'), TO_DATE('23-01-2023','DD-MM-YYYY'), TO_DATE('24-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(45, 9, TO_DATE('27-02-2023', 'DD-MM-YYYY'), TO_DATE('02-03-2023','DD-MM-YYYY'), TO_DATE('05-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(46, 5, TO_DATE('29-01-2023', 'DD-MM-YYYY'), TO_DATE('02-02-2023','DD-MM-YYYY'), TO_DATE('06-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(3, 9, TO_DATE('27-02-2023', 'DD-MM-YYYY'), TO_DATE('03-03-2023','DD-MM-YYYY'), TO_DATE('04-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(97, 5, TO_DATE('09-03-2023', 'DD-MM-YYYY'), TO_DATE('12-03-2023','DD-MM-YYYY'), TO_DATE('14-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(53, 5, TO_DATE('11-04-2023', 'DD-MM-YYYY'), TO_DATE('12-04-2023','DD-MM-YYYY'), TO_DATE('15-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(64, 5, TO_DATE('05-04-2023', 'DD-MM-YYYY'), TO_DATE('09-04-2023','DD-MM-YYYY'), TO_DATE('11-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(81, 5, TO_DATE('23-04-2023', 'DD-MM-YYYY'), TO_DATE('27-04-2023','DD-MM-YYYY'), TO_DATE('29-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(7, 4, TO_DATE('28-02-2023', 'DD-MM-YYYY'), TO_DATE('02-03-2023','DD-MM-YYYY'), TO_DATE('05-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(45, 9, TO_DATE('31-01-2023', 'DD-MM-YYYY'), TO_DATE('01-02-2023','DD-MM-YYYY'), TO_DATE('03-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(33, 4, TO_DATE('27-04-2023', 'DD-MM-YYYY'), TO_DATE('01-05-2023','DD-MM-YYYY'), TO_DATE('03-05-2023','DD-MM-YYYY'), null, 3);

p_add_orders(64, 4, TO_DATE('01-02-2023', 'DD-MM-YYYY'), TO_DATE('02-02-2023','DD-MM-YYYY'), TO_DATE('03-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(38, 5, TO_DATE('20-04-2023', 'DD-MM-YYYY'), TO_DATE('23-04-2023','DD-MM-YYYY'), TO_DATE('24-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(44, 5, TO_DATE('05-02-2023', 'DD-MM-YYYY'), TO_DATE('07-02-2023','DD-MM-YYYY'), TO_DATE('10-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(37, 5, TO_DATE('10-03-2023', 'DD-MM-YYYY'), TO_DATE('14-03-2023','DD-MM-YYYY'), TO_DATE('18-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(100, 5, TO_DATE('16-04-2023', 'DD-MM-YYYY'), TO_DATE('20-04-2023','DD-MM-YYYY'), TO_DATE('24-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(84, 9, TO_DATE('01-05-2023', 'DD-MM-YYYY'), TO_DATE('03-05-2023','DD-MM-YYYY'), TO_DATE('05-05-2023','DD-MM-YYYY'), null, 3);

p_add_orders(6, 5, TO_DATE('18-04-2023', 'DD-MM-YYYY'), TO_DATE('19-04-2023','DD-MM-YYYY'), TO_DATE('22-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(87, 5, TO_DATE('28-04-2023', 'DD-MM-YYYY'), TO_DATE('02-05-2023','DD-MM-YYYY'), TO_DATE('05-05-2023','DD-MM-YYYY'), null, 3);

p_add_orders(67, 9, TO_DATE('06-03-2023', 'DD-MM-YYYY'), TO_DATE('08-03-2023','DD-MM-YYYY'), TO_DATE('09-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(9, 4, TO_DATE('03-03-2023', 'DD-MM-YYYY'), TO_DATE('06-03-2023','DD-MM-YYYY'), TO_DATE('10-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(84, 5, TO_DATE('14-01-2023', 'DD-MM-YYYY'), TO_DATE('15-01-2023','DD-MM-YYYY'), TO_DATE('16-01-2023','DD-MM-YYYY'), null, 1);

p_add_orders(73, 4, TO_DATE('03-05-2023', 'DD-MM-YYYY'), TO_DATE('07-05-2023','DD-MM-YYYY'), TO_DATE('11-05-2023','DD-MM-YYYY'), null, 4);

p_add_orders(63, 4, TO_DATE('23-04-2023', 'DD-MM-YYYY'), TO_DATE('26-04-2023','DD-MM-YYYY'), TO_DATE('28-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(53, 4, TO_DATE('17-03-2023', 'DD-MM-YYYY'), TO_DATE('20-03-2023','DD-MM-YYYY'), TO_DATE('22-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(48, 9, TO_DATE('03-03-2023', 'DD-MM-YYYY'), TO_DATE('04-03-2023','DD-MM-YYYY'), TO_DATE('06-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(71, 5, TO_DATE('29-03-2023', 'DD-MM-YYYY'), TO_DATE('01-04-2023','DD-MM-YYYY'), TO_DATE('05-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(76, 4, TO_DATE('02-01-2023', 'DD-MM-YYYY'), TO_DATE('06-01-2023','DD-MM-YYYY'), TO_DATE('09-01-2023','DD-MM-YYYY'), null, 1);

p_add_orders(96, 5, TO_DATE('24-03-2023', 'DD-MM-YYYY'), TO_DATE('25-03-2023','DD-MM-YYYY'), TO_DATE('28-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(30, 9, TO_DATE('07-01-2023', 'DD-MM-YYYY'), TO_DATE('08-01-2023','DD-MM-YYYY'), TO_DATE('11-01-2023','DD-MM-YYYY'), null, 5);

p_add_orders(69, 9, TO_DATE('14-02-2023', 'DD-MM-YYYY'), TO_DATE('16-02-2023','DD-MM-YYYY'), TO_DATE('18-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(17, 5, TO_DATE('28-03-2023', 'DD-MM-YYYY'), TO_DATE('29-03-2023','DD-MM-YYYY'), TO_DATE('02-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(45, 5, TO_DATE('05-03-2023', 'DD-MM-YYYY'), TO_DATE('09-03-2023','DD-MM-YYYY'), TO_DATE('11-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(24, 4, TO_DATE('17-03-2023', 'DD-MM-YYYY'), TO_DATE('19-03-2023','DD-MM-YYYY'), TO_DATE('23-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(64, 4, TO_DATE('09-02-2023', 'DD-MM-YYYY'), TO_DATE('11-02-2023','DD-MM-YYYY'), TO_DATE('13-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(75, 4, TO_DATE('28-01-2023', 'DD-MM-YYYY'), TO_DATE('01-02-2023','DD-MM-YYYY'), TO_DATE('03-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(27, 4, TO_DATE('01-01-2023', 'DD-MM-YYYY'), TO_DATE('02-01-2023','DD-MM-YYYY'), TO_DATE('03-01-2023','DD-MM-YYYY'), null, 5);

p_add_orders(74, 9, TO_DATE('13-02-2023', 'DD-MM-YYYY'), TO_DATE('17-02-2023','DD-MM-YYYY'), TO_DATE('19-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(33, 5, TO_DATE('03-05-2023', 'DD-MM-YYYY'), TO_DATE('06-05-2023','DD-MM-YYYY'), TO_DATE('08-05-2023','DD-MM-YYYY'), null, 3);

p_add_orders(85, 5, TO_DATE('06-01-2023', 'DD-MM-YYYY'), TO_DATE('10-01-2023','DD-MM-YYYY'), TO_DATE('13-01-2023','DD-MM-YYYY'), null, 1);

p_add_orders(53, 9, TO_DATE('22-01-2023', 'DD-MM-YYYY'), TO_DATE('24-01-2023','DD-MM-YYYY'), TO_DATE('25-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(92, 9, TO_DATE('09-01-2023', 'DD-MM-YYYY'), TO_DATE('10-01-2023','DD-MM-YYYY'), TO_DATE('14-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(71, 9, TO_DATE('14-01-2023', 'DD-MM-YYYY'), TO_DATE('18-01-2023','DD-MM-YYYY'), TO_DATE('19-01-2023','DD-MM-YYYY'), null, 5);

p_add_orders(87, 4, TO_DATE('14-04-2023', 'DD-MM-YYYY'), TO_DATE('18-04-2023','DD-MM-YYYY'), TO_DATE('21-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(63, 5, TO_DATE('06-03-2023', 'DD-MM-YYYY'), TO_DATE('08-03-2023','DD-MM-YYYY'), TO_DATE('09-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(2, 4, TO_DATE('15-04-2023', 'DD-MM-YYYY'), TO_DATE('18-04-2023','DD-MM-YYYY'), TO_DATE('22-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(7, 4, TO_DATE('15-02-2023', 'DD-MM-YYYY'), TO_DATE('17-02-2023','DD-MM-YYYY'), TO_DATE('18-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(89, 5, TO_DATE('05-01-2023', 'DD-MM-YYYY'), TO_DATE('06-01-2023','DD-MM-YYYY'), TO_DATE('10-01-2023','DD-MM-YYYY'), null, 5);

p_add_orders(22, 5, TO_DATE('04-05-2023', 'DD-MM-YYYY'), TO_DATE('05-05-2023','DD-MM-YYYY'), TO_DATE('06-05-2023','DD-MM-YYYY'), null, 4);

p_add_orders(18, 5, TO_DATE('15-04-2023', 'DD-MM-YYYY'), TO_DATE('19-04-2023','DD-MM-YYYY'), TO_DATE('21-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(100, 4, TO_DATE('19-04-2023', 'DD-MM-YYYY'), TO_DATE('23-04-2023','DD-MM-YYYY'), TO_DATE('25-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(50, 5, TO_DATE('30-04-2023', 'DD-MM-YYYY'), TO_DATE('04-05-2023','DD-MM-YYYY'), TO_DATE('08-05-2023','DD-MM-YYYY'), null, 3);

p_add_orders(79, 9, TO_DATE('05-02-2023', 'DD-MM-YYYY'), TO_DATE('08-02-2023','DD-MM-YYYY'), TO_DATE('12-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(55, 4, TO_DATE('07-04-2023', 'DD-MM-YYYY'), TO_DATE('10-04-2023','DD-MM-YYYY'), TO_DATE('12-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(12, 5, TO_DATE('15-04-2023', 'DD-MM-YYYY'), TO_DATE('19-04-2023','DD-MM-YYYY'), TO_DATE('22-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(48, 9, TO_DATE('06-02-2023', 'DD-MM-YYYY'), TO_DATE('10-02-2023','DD-MM-YYYY'), TO_DATE('13-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(2, 4, TO_DATE('25-03-2023', 'DD-MM-YYYY'), TO_DATE('28-03-2023','DD-MM-YYYY'), TO_DATE('29-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(13, 4, TO_DATE('03-01-2023', 'DD-MM-YYYY'), TO_DATE('05-01-2023','DD-MM-YYYY'), TO_DATE('06-01-2023','DD-MM-YYYY'), null, 1);

p_add_orders(6, 9, TO_DATE('30-04-2023', 'DD-MM-YYYY'), TO_DATE('02-05-2023','DD-MM-YYYY'), TO_DATE('03-05-2023','DD-MM-YYYY'), null, 4);

p_add_orders(69, 5, TO_DATE('07-05-2023', 'DD-MM-YYYY'), TO_DATE('10-05-2023','DD-MM-YYYY'), TO_DATE('12-05-2023','DD-MM-YYYY'), null, 4);

p_add_orders(12, 5, TO_DATE('20-02-2023', 'DD-MM-YYYY'), TO_DATE('24-02-2023','DD-MM-YYYY'), TO_DATE('28-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(87, 4, TO_DATE('12-02-2023', 'DD-MM-YYYY'), TO_DATE('13-02-2023','DD-MM-YYYY'), TO_DATE('14-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(14, 9, TO_DATE('26-01-2023', 'DD-MM-YYYY'), TO_DATE('28-01-2023','DD-MM-YYYY'), TO_DATE('01-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(77, 4, TO_DATE('30-01-2023', 'DD-MM-YYYY'), TO_DATE('03-02-2023','DD-MM-YYYY'), TO_DATE('05-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(19, 5, TO_DATE('13-04-2023', 'DD-MM-YYYY'), TO_DATE('15-04-2023','DD-MM-YYYY'), TO_DATE('17-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(45, 9, TO_DATE('02-01-2023', 'DD-MM-YYYY'), TO_DATE('06-01-2023','DD-MM-YYYY'), TO_DATE('07-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(22, 4, TO_DATE('08-02-2023', 'DD-MM-YYYY'), TO_DATE('11-02-2023','DD-MM-YYYY'), TO_DATE('15-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(52, 5, TO_DATE('08-03-2023', 'DD-MM-YYYY'), TO_DATE('11-03-2023','DD-MM-YYYY'), TO_DATE('13-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(60, 4, TO_DATE('09-03-2023', 'DD-MM-YYYY'), TO_DATE('11-03-2023','DD-MM-YYYY'), TO_DATE('12-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(32, 5, TO_DATE('08-05-2023', 'DD-MM-YYYY'), TO_DATE('09-05-2023','DD-MM-YYYY'), TO_DATE('13-05-2023','DD-MM-YYYY'), null, 1);

p_add_orders(80, 5, TO_DATE('22-03-2023', 'DD-MM-YYYY'), TO_DATE('26-03-2023','DD-MM-YYYY'), TO_DATE('28-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(7, 5, TO_DATE('15-01-2023', 'DD-MM-YYYY'), TO_DATE('16-01-2023','DD-MM-YYYY'), TO_DATE('20-01-2023','DD-MM-YYYY'), null, 1);

p_add_orders(16, 5, TO_DATE('19-04-2023', 'DD-MM-YYYY'), TO_DATE('22-04-2023','DD-MM-YYYY'), TO_DATE('25-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(56, 9, TO_DATE('15-04-2023', 'DD-MM-YYYY'), TO_DATE('19-04-2023','DD-MM-YYYY'), TO_DATE('20-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(46, 4, TO_DATE('08-04-2023', 'DD-MM-YYYY'), TO_DATE('12-04-2023','DD-MM-YYYY'), TO_DATE('15-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(97, 5, TO_DATE('16-04-2023', 'DD-MM-YYYY'), TO_DATE('18-04-2023','DD-MM-YYYY'), TO_DATE('21-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(71, 5, TO_DATE('23-01-2023', 'DD-MM-YYYY'), TO_DATE('24-01-2023','DD-MM-YYYY'), TO_DATE('28-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(91, 5, TO_DATE('20-02-2023', 'DD-MM-YYYY'), TO_DATE('21-02-2023','DD-MM-YYYY'), TO_DATE('24-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(54, 4, TO_DATE('19-04-2023', 'DD-MM-YYYY'), TO_DATE('23-04-2023','DD-MM-YYYY'), TO_DATE('26-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(30, 5, TO_DATE('12-04-2023', 'DD-MM-YYYY'), TO_DATE('14-04-2023','DD-MM-YYYY'), TO_DATE('15-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(63, 9, TO_DATE('17-03-2023', 'DD-MM-YYYY'), TO_DATE('21-03-2023','DD-MM-YYYY'), TO_DATE('23-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(60, 4, TO_DATE('14-03-2023', 'DD-MM-YYYY'), TO_DATE('18-03-2023','DD-MM-YYYY'), TO_DATE('19-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(93, 9, TO_DATE('12-02-2023', 'DD-MM-YYYY'), TO_DATE('15-02-2023','DD-MM-YYYY'), TO_DATE('17-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(88, 4, TO_DATE('10-04-2023', 'DD-MM-YYYY'), TO_DATE('11-04-2023','DD-MM-YYYY'), TO_DATE('14-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(27, 9, TO_DATE('11-03-2023', 'DD-MM-YYYY'), TO_DATE('14-03-2023','DD-MM-YYYY'), TO_DATE('18-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(84, 4, TO_DATE('22-03-2023', 'DD-MM-YYYY'), TO_DATE('23-03-2023','DD-MM-YYYY'), TO_DATE('24-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(47, 4, TO_DATE('12-02-2023', 'DD-MM-YYYY'), TO_DATE('13-02-2023','DD-MM-YYYY'), TO_DATE('16-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(87, 9, TO_DATE('25-04-2023', 'DD-MM-YYYY'), TO_DATE('28-04-2023','DD-MM-YYYY'), TO_DATE('29-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(25, 9, TO_DATE('14-01-2023', 'DD-MM-YYYY'), TO_DATE('18-01-2023','DD-MM-YYYY'), TO_DATE('20-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(90, 4, TO_DATE('16-04-2023', 'DD-MM-YYYY'), TO_DATE('17-04-2023','DD-MM-YYYY'), TO_DATE('20-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(45, 9, TO_DATE('18-04-2023', 'DD-MM-YYYY'), TO_DATE('19-04-2023','DD-MM-YYYY'), TO_DATE('21-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(61, 4, TO_DATE('03-02-2023', 'DD-MM-YYYY'), TO_DATE('06-02-2023','DD-MM-YYYY'), TO_DATE('10-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(18, 5, TO_DATE('15-04-2023', 'DD-MM-YYYY'), TO_DATE('16-04-2023','DD-MM-YYYY'), TO_DATE('19-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(14, 4, TO_DATE('20-04-2023', 'DD-MM-YYYY'), TO_DATE('23-04-2023','DD-MM-YYYY'), TO_DATE('24-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(90, 4, TO_DATE('31-01-2023', 'DD-MM-YYYY'), TO_DATE('03-02-2023','DD-MM-YYYY'), TO_DATE('05-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(68, 9, TO_DATE('05-05-2023', 'DD-MM-YYYY'), TO_DATE('09-05-2023','DD-MM-YYYY'), TO_DATE('12-05-2023','DD-MM-YYYY'), null, 5);

p_add_orders(33, 5, TO_DATE('08-02-2023', 'DD-MM-YYYY'), TO_DATE('12-02-2023','DD-MM-YYYY'), TO_DATE('14-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(76, 5, TO_DATE('02-04-2023', 'DD-MM-YYYY'), TO_DATE('06-04-2023','DD-MM-YYYY'), TO_DATE('08-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(81, 4, TO_DATE('04-01-2023', 'DD-MM-YYYY'), TO_DATE('08-01-2023','DD-MM-YYYY'), TO_DATE('10-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(7, 4, TO_DATE('16-04-2023', 'DD-MM-YYYY'), TO_DATE('18-04-2023','DD-MM-YYYY'), TO_DATE('20-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(69, 5, TO_DATE('08-04-2023', 'DD-MM-YYYY'), TO_DATE('12-04-2023','DD-MM-YYYY'), TO_DATE('15-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(60, 9, TO_DATE('23-02-2023', 'DD-MM-YYYY'), TO_DATE('25-02-2023','DD-MM-YYYY'), TO_DATE('28-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(28, 5, TO_DATE('21-01-2023', 'DD-MM-YYYY'), TO_DATE('24-01-2023','DD-MM-YYYY'), TO_DATE('27-01-2023','DD-MM-YYYY'), null, 5);

p_add_orders(4, 5, TO_DATE('30-04-2023', 'DD-MM-YYYY'), TO_DATE('02-05-2023','DD-MM-YYYY'), TO_DATE('06-05-2023','DD-MM-YYYY'), null, 4);

p_add_orders(20, 9, TO_DATE('12-02-2023', 'DD-MM-YYYY'), TO_DATE('15-02-2023','DD-MM-YYYY'), TO_DATE('18-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(72, 4, TO_DATE('16-03-2023', 'DD-MM-YYYY'), TO_DATE('17-03-2023','DD-MM-YYYY'), TO_DATE('19-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(99, 5, TO_DATE('15-04-2023', 'DD-MM-YYYY'), TO_DATE('16-04-2023','DD-MM-YYYY'), TO_DATE('19-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(35, 4, TO_DATE('02-02-2023', 'DD-MM-YYYY'), TO_DATE('05-02-2023','DD-MM-YYYY'), TO_DATE('07-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(4, 9, TO_DATE('04-02-2023', 'DD-MM-YYYY'), TO_DATE('08-02-2023','DD-MM-YYYY'), TO_DATE('11-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(98, 5, TO_DATE('08-02-2023', 'DD-MM-YYYY'), TO_DATE('09-02-2023','DD-MM-YYYY'), TO_DATE('10-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(60, 4, TO_DATE('20-02-2023', 'DD-MM-YYYY'), TO_DATE('22-02-2023','DD-MM-YYYY'), TO_DATE('23-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(98, 5, TO_DATE('13-01-2023', 'DD-MM-YYYY'), TO_DATE('17-01-2023','DD-MM-YYYY'), TO_DATE('21-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(40, 9, TO_DATE('07-04-2023', 'DD-MM-YYYY'), TO_DATE('10-04-2023','DD-MM-YYYY'), TO_DATE('12-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(40, 5, TO_DATE('21-04-2023', 'DD-MM-YYYY'), TO_DATE('23-04-2023','DD-MM-YYYY'), TO_DATE('24-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(49, 5, TO_DATE('06-03-2023', 'DD-MM-YYYY'), TO_DATE('07-03-2023','DD-MM-YYYY'), TO_DATE('10-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(66, 9, TO_DATE('07-01-2023', 'DD-MM-YYYY'), TO_DATE('08-01-2023','DD-MM-YYYY'), TO_DATE('12-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(45, 9, TO_DATE('02-02-2023', 'DD-MM-YYYY'), TO_DATE('05-02-2023','DD-MM-YYYY'), TO_DATE('08-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(50, 4, TO_DATE('05-04-2023', 'DD-MM-YYYY'), TO_DATE('09-04-2023','DD-MM-YYYY'), TO_DATE('11-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(43, 4, TO_DATE('04-02-2023', 'DD-MM-YYYY'), TO_DATE('07-02-2023','DD-MM-YYYY'), TO_DATE('10-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(40, 4, TO_DATE('08-05-2023', 'DD-MM-YYYY'), TO_DATE('12-05-2023','DD-MM-YYYY'), TO_DATE('14-05-2023','DD-MM-YYYY'), null, 1);

p_add_orders(89, 5, TO_DATE('22-01-2023', 'DD-MM-YYYY'), TO_DATE('25-01-2023','DD-MM-YYYY'), TO_DATE('29-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(96, 5, TO_DATE('02-03-2023', 'DD-MM-YYYY'), TO_DATE('06-03-2023','DD-MM-YYYY'), TO_DATE('08-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(29, 4, TO_DATE('17-01-2023', 'DD-MM-YYYY'), TO_DATE('21-01-2023','DD-MM-YYYY'), TO_DATE('23-01-2023','DD-MM-YYYY'), null, 5);

p_add_orders(78, 9, TO_DATE('11-02-2023', 'DD-MM-YYYY'), TO_DATE('13-02-2023','DD-MM-YYYY'), TO_DATE('16-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(58, 4, TO_DATE('05-02-2023', 'DD-MM-YYYY'), TO_DATE('08-02-2023','DD-MM-YYYY'), TO_DATE('11-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(47, 5, TO_DATE('03-02-2023', 'DD-MM-YYYY'), TO_DATE('06-02-2023','DD-MM-YYYY'), TO_DATE('10-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(68, 4, TO_DATE('16-01-2023', 'DD-MM-YYYY'), TO_DATE('17-01-2023','DD-MM-YYYY'), TO_DATE('19-01-2023','DD-MM-YYYY'), null, 5);

p_add_orders(73, 5, TO_DATE('31-03-2023', 'DD-MM-YYYY'), TO_DATE('04-04-2023','DD-MM-YYYY'), TO_DATE('06-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(23, 4, TO_DATE('16-04-2023', 'DD-MM-YYYY'), TO_DATE('18-04-2023','DD-MM-YYYY'), TO_DATE('19-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(87, 5, TO_DATE('08-04-2023', 'DD-MM-YYYY'), TO_DATE('10-04-2023','DD-MM-YYYY'), TO_DATE('11-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(80, 4, TO_DATE('12-01-2023', 'DD-MM-YYYY'), TO_DATE('15-01-2023','DD-MM-YYYY'), TO_DATE('17-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(94, 5, TO_DATE('02-05-2023', 'DD-MM-YYYY'), TO_DATE('06-05-2023','DD-MM-YYYY'), TO_DATE('07-05-2023','DD-MM-YYYY'), null, 1);

p_add_orders(60, 9, TO_DATE('14-03-2023', 'DD-MM-YYYY'), TO_DATE('17-03-2023','DD-MM-YYYY'), TO_DATE('21-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(62, 4, TO_DATE('04-03-2023', 'DD-MM-YYYY'), TO_DATE('05-03-2023','DD-MM-YYYY'), TO_DATE('09-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(33, 5, TO_DATE('14-03-2023', 'DD-MM-YYYY'), TO_DATE('16-03-2023','DD-MM-YYYY'), TO_DATE('20-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(86, 5, TO_DATE('21-01-2023', 'DD-MM-YYYY'), TO_DATE('25-01-2023','DD-MM-YYYY'), TO_DATE('27-01-2023','DD-MM-YYYY'), null, 5);

p_add_orders(43, 5, TO_DATE('08-02-2023', 'DD-MM-YYYY'), TO_DATE('12-02-2023','DD-MM-YYYY'), TO_DATE('14-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(60, 9, TO_DATE('30-04-2023', 'DD-MM-YYYY'), TO_DATE('02-05-2023','DD-MM-YYYY'), TO_DATE('03-05-2023','DD-MM-YYYY'), null, 1);

p_add_orders(70, 4, TO_DATE('17-02-2023', 'DD-MM-YYYY'), TO_DATE('21-02-2023','DD-MM-YYYY'), TO_DATE('24-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(13, 9, TO_DATE('10-05-2023', 'DD-MM-YYYY'), TO_DATE('13-05-2023','DD-MM-YYYY'), TO_DATE('17-05-2023','DD-MM-YYYY'), null, 3);

p_add_orders(100, 9, TO_DATE('13-02-2023', 'DD-MM-YYYY'), TO_DATE('16-02-2023','DD-MM-YYYY'), TO_DATE('17-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(34, 9, TO_DATE('01-02-2023', 'DD-MM-YYYY'), TO_DATE('02-02-2023','DD-MM-YYYY'), TO_DATE('04-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(31, 9, TO_DATE('12-03-2023', 'DD-MM-YYYY'), TO_DATE('13-03-2023','DD-MM-YYYY'), TO_DATE('14-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(32, 9, TO_DATE('31-03-2023', 'DD-MM-YYYY'), TO_DATE('02-04-2023','DD-MM-YYYY'), TO_DATE('04-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(47, 5, TO_DATE('10-04-2023', 'DD-MM-YYYY'), TO_DATE('12-04-2023','DD-MM-YYYY'), TO_DATE('14-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(68, 9, TO_DATE('29-01-2023', 'DD-MM-YYYY'), TO_DATE('31-01-2023','DD-MM-YYYY'), TO_DATE('01-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(33, 5, TO_DATE('08-03-2023', 'DD-MM-YYYY'), TO_DATE('11-03-2023','DD-MM-YYYY'), TO_DATE('12-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(76, 9, TO_DATE('03-04-2023', 'DD-MM-YYYY'), TO_DATE('05-04-2023','DD-MM-YYYY'), TO_DATE('06-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(34, 9, TO_DATE('08-03-2023', 'DD-MM-YYYY'), TO_DATE('12-03-2023','DD-MM-YYYY'), TO_DATE('14-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(26, 5, TO_DATE('10-04-2023', 'DD-MM-YYYY'), TO_DATE('13-04-2023','DD-MM-YYYY'), TO_DATE('17-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(87, 5, TO_DATE('18-02-2023', 'DD-MM-YYYY'), TO_DATE('19-02-2023','DD-MM-YYYY'), TO_DATE('23-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(65, 5, TO_DATE('10-03-2023', 'DD-MM-YYYY'), TO_DATE('12-03-2023','DD-MM-YYYY'), TO_DATE('16-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(21, 9, TO_DATE('16-01-2023', 'DD-MM-YYYY'), TO_DATE('18-01-2023','DD-MM-YYYY'), TO_DATE('20-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(29, 9, TO_DATE('10-02-2023', 'DD-MM-YYYY'), TO_DATE('12-02-2023','DD-MM-YYYY'), TO_DATE('13-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(72, 9, TO_DATE('31-01-2023', 'DD-MM-YYYY'), TO_DATE('02-02-2023','DD-MM-YYYY'), TO_DATE('04-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(64, 4, TO_DATE('09-05-2023', 'DD-MM-YYYY'), TO_DATE('11-05-2023','DD-MM-YYYY'), TO_DATE('12-05-2023','DD-MM-YYYY'), null, 1);

p_add_orders(8, 4, TO_DATE('03-02-2023', 'DD-MM-YYYY'), TO_DATE('05-02-2023','DD-MM-YYYY'), TO_DATE('07-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(40, 4, TO_DATE('16-01-2023', 'DD-MM-YYYY'), TO_DATE('19-01-2023','DD-MM-YYYY'), TO_DATE('22-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(27, 5, TO_DATE('30-04-2023', 'DD-MM-YYYY'), TO_DATE('03-05-2023','DD-MM-YYYY'), TO_DATE('07-05-2023','DD-MM-YYYY'), null, 5);

p_add_orders(43, 5, TO_DATE('28-03-2023', 'DD-MM-YYYY'), TO_DATE('30-03-2023','DD-MM-YYYY'), TO_DATE('02-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(8, 9, TO_DATE('06-04-2023', 'DD-MM-YYYY'), TO_DATE('08-04-2023','DD-MM-YYYY'), TO_DATE('11-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(66, 9, TO_DATE('04-04-2023', 'DD-MM-YYYY'), TO_DATE('08-04-2023','DD-MM-YYYY'), TO_DATE('09-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(64, 5, TO_DATE('06-04-2023', 'DD-MM-YYYY'), TO_DATE('10-04-2023','DD-MM-YYYY'), TO_DATE('14-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(64, 9, TO_DATE('17-03-2023', 'DD-MM-YYYY'), TO_DATE('21-03-2023','DD-MM-YYYY'), TO_DATE('22-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(68, 5, TO_DATE('28-02-2023', 'DD-MM-YYYY'), TO_DATE('02-03-2023','DD-MM-YYYY'), TO_DATE('03-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(86, 5, TO_DATE('18-02-2023', 'DD-MM-YYYY'), TO_DATE('19-02-2023','DD-MM-YYYY'), TO_DATE('23-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(38, 4, TO_DATE('25-02-2023', 'DD-MM-YYYY'), TO_DATE('26-02-2023','DD-MM-YYYY'), TO_DATE('28-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(37, 5, TO_DATE('03-05-2023', 'DD-MM-YYYY'), TO_DATE('06-05-2023','DD-MM-YYYY'), TO_DATE('07-05-2023','DD-MM-YYYY'), null, 1);

p_add_orders(87, 5, TO_DATE('12-03-2023', 'DD-MM-YYYY'), TO_DATE('13-03-2023','DD-MM-YYYY'), TO_DATE('17-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(51, 9, TO_DATE('23-02-2023', 'DD-MM-YYYY'), TO_DATE('25-02-2023','DD-MM-YYYY'), TO_DATE('27-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(12, 4, TO_DATE('30-01-2023', 'DD-MM-YYYY'), TO_DATE('03-02-2023','DD-MM-YYYY'), TO_DATE('07-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(34, 9, TO_DATE('08-02-2023', 'DD-MM-YYYY'), TO_DATE('09-02-2023','DD-MM-YYYY'), TO_DATE('12-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(12, 5, TO_DATE('14-01-2023', 'DD-MM-YYYY'), TO_DATE('15-01-2023','DD-MM-YYYY'), TO_DATE('18-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(32, 9, TO_DATE('18-03-2023', 'DD-MM-YYYY'), TO_DATE('21-03-2023','DD-MM-YYYY'), TO_DATE('24-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(63, 9, TO_DATE('19-04-2023', 'DD-MM-YYYY'), TO_DATE('20-04-2023','DD-MM-YYYY'), TO_DATE('23-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(83, 5, TO_DATE('19-02-2023', 'DD-MM-YYYY'), TO_DATE('21-02-2023','DD-MM-YYYY'), TO_DATE('25-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(70, 4, TO_DATE('25-02-2023', 'DD-MM-YYYY'), TO_DATE('01-03-2023','DD-MM-YYYY'), TO_DATE('05-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(56, 5, TO_DATE('06-05-2023', 'DD-MM-YYYY'), TO_DATE('07-05-2023','DD-MM-YYYY'), TO_DATE('08-05-2023','DD-MM-YYYY'), null, 4);

p_add_orders(96, 9, TO_DATE('26-01-2023', 'DD-MM-YYYY'), TO_DATE('29-01-2023','DD-MM-YYYY'), TO_DATE('31-01-2023','DD-MM-YYYY'), null, 1);

p_add_orders(95, 4, TO_DATE('08-05-2023', 'DD-MM-YYYY'), TO_DATE('11-05-2023','DD-MM-YYYY'), TO_DATE('12-05-2023','DD-MM-YYYY'), null, 1);

p_add_orders(86, 5, TO_DATE('30-04-2023', 'DD-MM-YYYY'), TO_DATE('03-05-2023','DD-MM-YYYY'), TO_DATE('05-05-2023','DD-MM-YYYY'), null, 4);

p_add_orders(88, 4, TO_DATE('25-02-2023', 'DD-MM-YYYY'), TO_DATE('27-02-2023','DD-MM-YYYY'), TO_DATE('01-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(57, 4, TO_DATE('24-03-2023', 'DD-MM-YYYY'), TO_DATE('25-03-2023','DD-MM-YYYY'), TO_DATE('29-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(10, 5, TO_DATE('29-03-2023', 'DD-MM-YYYY'), TO_DATE('31-03-2023','DD-MM-YYYY'), TO_DATE('04-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(85, 5, TO_DATE('20-04-2023', 'DD-MM-YYYY'), TO_DATE('24-04-2023','DD-MM-YYYY'), TO_DATE('28-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(66, 5, TO_DATE('26-03-2023', 'DD-MM-YYYY'), TO_DATE('29-03-2023','DD-MM-YYYY'), TO_DATE('02-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(38, 4, TO_DATE('29-04-2023', 'DD-MM-YYYY'), TO_DATE('01-05-2023','DD-MM-YYYY'), TO_DATE('04-05-2023','DD-MM-YYYY'), null, 2);

p_add_orders(69, 5, TO_DATE('24-03-2023', 'DD-MM-YYYY'), TO_DATE('27-03-2023','DD-MM-YYYY'), TO_DATE('28-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(74, 5, TO_DATE('01-05-2023', 'DD-MM-YYYY'), TO_DATE('05-05-2023','DD-MM-YYYY'), TO_DATE('08-05-2023','DD-MM-YYYY'), null, 5);

p_add_orders(36, 4, TO_DATE('15-01-2023', 'DD-MM-YYYY'), TO_DATE('16-01-2023','DD-MM-YYYY'), TO_DATE('20-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(64, 5, TO_DATE('09-03-2023', 'DD-MM-YYYY'), TO_DATE('12-03-2023','DD-MM-YYYY'), TO_DATE('16-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(19, 5, TO_DATE('22-01-2023', 'DD-MM-YYYY'), TO_DATE('26-01-2023','DD-MM-YYYY'), TO_DATE('27-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(61, 5, TO_DATE('19-01-2023', 'DD-MM-YYYY'), TO_DATE('20-01-2023','DD-MM-YYYY'), TO_DATE('22-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(79, 5, TO_DATE('28-01-2023', 'DD-MM-YYYY'), TO_DATE('31-01-2023','DD-MM-YYYY'), TO_DATE('04-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(96, 5, TO_DATE('11-03-2023', 'DD-MM-YYYY'), TO_DATE('15-03-2023','DD-MM-YYYY'), TO_DATE('16-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(26, 4, TO_DATE('09-05-2023', 'DD-MM-YYYY'), TO_DATE('10-05-2023','DD-MM-YYYY'), TO_DATE('12-05-2023','DD-MM-YYYY'), null, 5);

p_add_orders(14, 5, TO_DATE('12-04-2023', 'DD-MM-YYYY'), TO_DATE('15-04-2023','DD-MM-YYYY'), TO_DATE('19-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(18, 4, TO_DATE('17-03-2023', 'DD-MM-YYYY'), TO_DATE('21-03-2023','DD-MM-YYYY'), TO_DATE('22-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(29, 5, TO_DATE('07-05-2023', 'DD-MM-YYYY'), TO_DATE('09-05-2023','DD-MM-YYYY'), TO_DATE('12-05-2023','DD-MM-YYYY'), null, 4);

p_add_orders(87, 5, TO_DATE('20-03-2023', 'DD-MM-YYYY'), TO_DATE('21-03-2023','DD-MM-YYYY'), TO_DATE('25-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(6, 9, TO_DATE('11-03-2023', 'DD-MM-YYYY'), TO_DATE('12-03-2023','DD-MM-YYYY'), TO_DATE('15-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(73, 9, TO_DATE('27-01-2023', 'DD-MM-YYYY'), TO_DATE('31-01-2023','DD-MM-YYYY'), TO_DATE('04-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(40, 5, TO_DATE('05-04-2023', 'DD-MM-YYYY'), TO_DATE('08-04-2023','DD-MM-YYYY'), TO_DATE('11-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(85, 5, TO_DATE('04-05-2023', 'DD-MM-YYYY'), TO_DATE('05-05-2023','DD-MM-YYYY'), TO_DATE('08-05-2023','DD-MM-YYYY'), null, 1);

p_add_orders(28, 9, TO_DATE('05-04-2023', 'DD-MM-YYYY'), TO_DATE('09-04-2023','DD-MM-YYYY'), TO_DATE('12-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(46, 9, TO_DATE('29-04-2023', 'DD-MM-YYYY'), TO_DATE('02-05-2023','DD-MM-YYYY'), TO_DATE('05-05-2023','DD-MM-YYYY'), null, 4);

p_add_orders(14, 9, TO_DATE('08-05-2023', 'DD-MM-YYYY'), TO_DATE('10-05-2023','DD-MM-YYYY'), TO_DATE('12-05-2023','DD-MM-YYYY'), null, 5);

p_add_orders(66, 4, TO_DATE('10-04-2023', 'DD-MM-YYYY'), TO_DATE('13-04-2023','DD-MM-YYYY'), TO_DATE('15-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(31, 9, TO_DATE('23-02-2023', 'DD-MM-YYYY'), TO_DATE('25-02-2023','DD-MM-YYYY'), TO_DATE('27-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(91, 9, TO_DATE('24-02-2023', 'DD-MM-YYYY'), TO_DATE('26-02-2023','DD-MM-YYYY'), TO_DATE('01-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(84, 5, TO_DATE('27-02-2023', 'DD-MM-YYYY'), TO_DATE('28-02-2023','DD-MM-YYYY'), TO_DATE('03-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(20, 9, TO_DATE('15-04-2023', 'DD-MM-YYYY'), TO_DATE('16-04-2023','DD-MM-YYYY'), TO_DATE('20-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(28, 4, TO_DATE('10-01-2023', 'DD-MM-YYYY'), TO_DATE('11-01-2023','DD-MM-YYYY'), TO_DATE('12-01-2023','DD-MM-YYYY'), null, 1);

p_add_orders(61, 9, TO_DATE('07-02-2023', 'DD-MM-YYYY'), TO_DATE('08-02-2023','DD-MM-YYYY'), TO_DATE('11-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(93, 5, TO_DATE('16-04-2023', 'DD-MM-YYYY'), TO_DATE('19-04-2023','DD-MM-YYYY'), TO_DATE('23-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(58, 9, TO_DATE('17-04-2023', 'DD-MM-YYYY'), TO_DATE('19-04-2023','DD-MM-YYYY'), TO_DATE('20-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(78, 9, TO_DATE('28-01-2023', 'DD-MM-YYYY'), TO_DATE('31-01-2023','DD-MM-YYYY'), TO_DATE('04-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(96, 9, TO_DATE('22-04-2023', 'DD-MM-YYYY'), TO_DATE('25-04-2023','DD-MM-YYYY'), TO_DATE('29-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(10, 4, TO_DATE('04-02-2023', 'DD-MM-YYYY'), TO_DATE('07-02-2023','DD-MM-YYYY'), TO_DATE('11-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(67, 9, TO_DATE('02-05-2023', 'DD-MM-YYYY'), TO_DATE('04-05-2023','DD-MM-YYYY'), TO_DATE('07-05-2023','DD-MM-YYYY'), null, 2);

p_add_orders(82, 5, TO_DATE('16-01-2023', 'DD-MM-YYYY'), TO_DATE('18-01-2023','DD-MM-YYYY'), TO_DATE('21-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(88, 4, TO_DATE('07-02-2023', 'DD-MM-YYYY'), TO_DATE('11-02-2023','DD-MM-YYYY'), TO_DATE('15-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(52, 4, TO_DATE('19-04-2023', 'DD-MM-YYYY'), TO_DATE('23-04-2023','DD-MM-YYYY'), TO_DATE('26-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(69, 4, TO_DATE('14-02-2023', 'DD-MM-YYYY'), TO_DATE('17-02-2023','DD-MM-YYYY'), TO_DATE('18-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(77, 4, TO_DATE('02-04-2023', 'DD-MM-YYYY'), TO_DATE('04-04-2023','DD-MM-YYYY'), TO_DATE('07-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(59, 4, TO_DATE('10-05-2023', 'DD-MM-YYYY'), TO_DATE('14-05-2023','DD-MM-YYYY'), TO_DATE('15-05-2023','DD-MM-YYYY'), null, 1);

p_add_orders(98, 9, TO_DATE('14-04-2023', 'DD-MM-YYYY'), TO_DATE('18-04-2023','DD-MM-YYYY'), TO_DATE('21-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(34, 4, TO_DATE('04-04-2023', 'DD-MM-YYYY'), TO_DATE('08-04-2023','DD-MM-YYYY'), TO_DATE('11-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(59, 9, TO_DATE('05-05-2023', 'DD-MM-YYYY'), TO_DATE('06-05-2023','DD-MM-YYYY'), TO_DATE('10-05-2023','DD-MM-YYYY'), null, 2);

p_add_orders(81, 5, TO_DATE('26-03-2023', 'DD-MM-YYYY'), TO_DATE('28-03-2023','DD-MM-YYYY'), TO_DATE('30-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(62, 4, TO_DATE('14-03-2023', 'DD-MM-YYYY'), TO_DATE('17-03-2023','DD-MM-YYYY'), TO_DATE('18-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(7, 9, TO_DATE('07-02-2023', 'DD-MM-YYYY'), TO_DATE('09-02-2023','DD-MM-YYYY'), TO_DATE('11-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(30, 4, TO_DATE('24-03-2023', 'DD-MM-YYYY'), TO_DATE('26-03-2023','DD-MM-YYYY'), TO_DATE('28-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(50, 9, TO_DATE('05-04-2023', 'DD-MM-YYYY'), TO_DATE('09-04-2023','DD-MM-YYYY'), TO_DATE('12-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(11, 5, TO_DATE('21-04-2023', 'DD-MM-YYYY'), TO_DATE('22-04-2023','DD-MM-YYYY'), TO_DATE('24-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(39, 9, TO_DATE('02-01-2023', 'DD-MM-YYYY'), TO_DATE('03-01-2023','DD-MM-YYYY'), TO_DATE('04-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(76, 4, TO_DATE('04-05-2023', 'DD-MM-YYYY'), TO_DATE('05-05-2023','DD-MM-YYYY'), TO_DATE('09-05-2023','DD-MM-YYYY'), null, 2);

p_add_orders(68, 4, TO_DATE('17-03-2023', 'DD-MM-YYYY'), TO_DATE('20-03-2023','DD-MM-YYYY'), TO_DATE('24-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(4, 9, TO_DATE('26-02-2023', 'DD-MM-YYYY'), TO_DATE('02-03-2023','DD-MM-YYYY'), TO_DATE('05-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(73, 9, TO_DATE('25-03-2023', 'DD-MM-YYYY'), TO_DATE('29-03-2023','DD-MM-YYYY'), TO_DATE('01-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(13, 5, TO_DATE('18-04-2023', 'DD-MM-YYYY'), TO_DATE('21-04-2023','DD-MM-YYYY'), TO_DATE('22-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(85, 9, TO_DATE('02-04-2023', 'DD-MM-YYYY'), TO_DATE('05-04-2023','DD-MM-YYYY'), TO_DATE('08-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(44, 9, TO_DATE('26-03-2023', 'DD-MM-YYYY'), TO_DATE('30-03-2023','DD-MM-YYYY'), TO_DATE('03-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(92, 5, TO_DATE('22-03-2023', 'DD-MM-YYYY'), TO_DATE('23-03-2023','DD-MM-YYYY'), TO_DATE('25-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(96, 9, TO_DATE('24-02-2023', 'DD-MM-YYYY'), TO_DATE('25-02-2023','DD-MM-YYYY'), TO_DATE('26-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(25, 4, TO_DATE('12-01-2023', 'DD-MM-YYYY'), TO_DATE('16-01-2023','DD-MM-YYYY'), TO_DATE('17-01-2023','DD-MM-YYYY'), null, 1);

p_add_orders(84, 5, TO_DATE('11-01-2023', 'DD-MM-YYYY'), TO_DATE('13-01-2023','DD-MM-YYYY'), TO_DATE('16-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(65, 4, TO_DATE('30-04-2023', 'DD-MM-YYYY'), TO_DATE('02-05-2023','DD-MM-YYYY'), TO_DATE('06-05-2023','DD-MM-YYYY'), null, 2);

p_add_orders(65, 5, TO_DATE('13-02-2023', 'DD-MM-YYYY'), TO_DATE('17-02-2023','DD-MM-YYYY'), TO_DATE('20-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(49, 9, TO_DATE('03-03-2023', 'DD-MM-YYYY'), TO_DATE('06-03-2023','DD-MM-YYYY'), TO_DATE('10-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(62, 4, TO_DATE('06-02-2023', 'DD-MM-YYYY'), TO_DATE('07-02-2023','DD-MM-YYYY'), TO_DATE('09-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(90, 4, TO_DATE('26-01-2023', 'DD-MM-YYYY'), TO_DATE('27-01-2023','DD-MM-YYYY'), TO_DATE('29-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(68, 4, TO_DATE('14-03-2023', 'DD-MM-YYYY'), TO_DATE('16-03-2023','DD-MM-YYYY'), TO_DATE('17-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(4, 5, TO_DATE('04-05-2023', 'DD-MM-YYYY'), TO_DATE('05-05-2023','DD-MM-YYYY'), TO_DATE('07-05-2023','DD-MM-YYYY'), null, 5);

p_add_orders(99, 5, TO_DATE('24-03-2023', 'DD-MM-YYYY'), TO_DATE('28-03-2023','DD-MM-YYYY'), TO_DATE('30-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(22, 4, TO_DATE('17-02-2023', 'DD-MM-YYYY'), TO_DATE('19-02-2023','DD-MM-YYYY'), TO_DATE('22-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(60, 9, TO_DATE('27-02-2023', 'DD-MM-YYYY'), TO_DATE('01-03-2023','DD-MM-YYYY'), TO_DATE('03-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(65, 4, TO_DATE('03-05-2023', 'DD-MM-YYYY'), TO_DATE('06-05-2023','DD-MM-YYYY'), TO_DATE('09-05-2023','DD-MM-YYYY'), null, 5);

p_add_orders(61, 5, TO_DATE('18-04-2023', 'DD-MM-YYYY'), TO_DATE('19-04-2023','DD-MM-YYYY'), TO_DATE('22-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(49, 4, TO_DATE('31-03-2023', 'DD-MM-YYYY'), TO_DATE('01-04-2023','DD-MM-YYYY'), TO_DATE('03-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(8, 5, TO_DATE('19-01-2023', 'DD-MM-YYYY'), TO_DATE('20-01-2023','DD-MM-YYYY'), TO_DATE('21-01-2023','DD-MM-YYYY'), null, 5);

p_add_orders(35, 5, TO_DATE('06-02-2023', 'DD-MM-YYYY'), TO_DATE('09-02-2023','DD-MM-YYYY'), TO_DATE('13-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(39, 5, TO_DATE('01-05-2023', 'DD-MM-YYYY'), TO_DATE('03-05-2023','DD-MM-YYYY'), TO_DATE('05-05-2023','DD-MM-YYYY'), null, 2);

p_add_orders(45, 4, TO_DATE('15-04-2023', 'DD-MM-YYYY'), TO_DATE('17-04-2023','DD-MM-YYYY'), TO_DATE('19-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(31, 5, TO_DATE('27-04-2023', 'DD-MM-YYYY'), TO_DATE('28-04-2023','DD-MM-YYYY'), TO_DATE('29-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(74, 9, TO_DATE('16-02-2023', 'DD-MM-YYYY'), TO_DATE('19-02-2023','DD-MM-YYYY'), TO_DATE('22-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(44, 5, TO_DATE('13-02-2023', 'DD-MM-YYYY'), TO_DATE('17-02-2023','DD-MM-YYYY'), TO_DATE('20-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(71, 4, TO_DATE('02-05-2023', 'DD-MM-YYYY'), TO_DATE('05-05-2023','DD-MM-YYYY'), TO_DATE('06-05-2023','DD-MM-YYYY'), null, 2);

p_add_orders(91, 4, TO_DATE('08-05-2023', 'DD-MM-YYYY'), TO_DATE('09-05-2023','DD-MM-YYYY'), TO_DATE('12-05-2023','DD-MM-YYYY'), null, 4);

p_add_orders(49, 4, TO_DATE('07-03-2023', 'DD-MM-YYYY'), TO_DATE('11-03-2023','DD-MM-YYYY'), TO_DATE('12-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(12, 5, TO_DATE('30-04-2023', 'DD-MM-YYYY'), TO_DATE('03-05-2023','DD-MM-YYYY'), TO_DATE('05-05-2023','DD-MM-YYYY'), null, 4);

p_add_orders(36, 9, TO_DATE('05-01-2023', 'DD-MM-YYYY'), TO_DATE('08-01-2023','DD-MM-YYYY'), TO_DATE('12-01-2023','DD-MM-YYYY'), null, 1);

p_add_orders(5, 5, TO_DATE('23-04-2023', 'DD-MM-YYYY'), TO_DATE('27-04-2023','DD-MM-YYYY'), TO_DATE('01-05-2023','DD-MM-YYYY'), null, 4);

p_add_orders(33, 4, TO_DATE('16-02-2023', 'DD-MM-YYYY'), TO_DATE('20-02-2023','DD-MM-YYYY'), TO_DATE('23-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(36, 5, TO_DATE('24-01-2023', 'DD-MM-YYYY'), TO_DATE('26-01-2023','DD-MM-YYYY'), TO_DATE('27-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(69, 5, TO_DATE('27-04-2023', 'DD-MM-YYYY'), TO_DATE('28-04-2023','DD-MM-YYYY'), TO_DATE('02-05-2023','DD-MM-YYYY'), null, 1);

p_add_orders(9, 4, TO_DATE('08-03-2023', 'DD-MM-YYYY'), TO_DATE('12-03-2023','DD-MM-YYYY'), TO_DATE('14-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(64, 4, TO_DATE('22-02-2023', 'DD-MM-YYYY'), TO_DATE('24-02-2023','DD-MM-YYYY'), TO_DATE('27-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(96, 9, TO_DATE('24-02-2023', 'DD-MM-YYYY'), TO_DATE('26-02-2023','DD-MM-YYYY'), TO_DATE('02-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(88, 5, TO_DATE('09-03-2023', 'DD-MM-YYYY'), TO_DATE('10-03-2023','DD-MM-YYYY'), TO_DATE('11-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(72, 9, TO_DATE('17-02-2023', 'DD-MM-YYYY'), TO_DATE('20-02-2023','DD-MM-YYYY'), TO_DATE('22-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(8, 4, TO_DATE('29-03-2023', 'DD-MM-YYYY'), TO_DATE('02-04-2023','DD-MM-YYYY'), TO_DATE('03-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(47, 4, TO_DATE('06-04-2023', 'DD-MM-YYYY'), TO_DATE('09-04-2023','DD-MM-YYYY'), TO_DATE('10-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(42, 5, TO_DATE('05-04-2023', 'DD-MM-YYYY'), TO_DATE('09-04-2023','DD-MM-YYYY'), TO_DATE('12-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(44, 5, TO_DATE('11-04-2023', 'DD-MM-YYYY'), TO_DATE('15-04-2023','DD-MM-YYYY'), TO_DATE('19-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(57, 4, TO_DATE('12-03-2023', 'DD-MM-YYYY'), TO_DATE('14-03-2023','DD-MM-YYYY'), TO_DATE('15-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(24, 5, TO_DATE('24-03-2023', 'DD-MM-YYYY'), TO_DATE('26-03-2023','DD-MM-YYYY'), TO_DATE('29-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(14, 9, TO_DATE('05-04-2023', 'DD-MM-YYYY'), TO_DATE('06-04-2023','DD-MM-YYYY'), TO_DATE('07-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(53, 5, TO_DATE('31-03-2023', 'DD-MM-YYYY'), TO_DATE('03-04-2023','DD-MM-YYYY'), TO_DATE('06-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(2, 9, TO_DATE('23-01-2023', 'DD-MM-YYYY'), TO_DATE('26-01-2023','DD-MM-YYYY'), TO_DATE('27-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(58, 5, TO_DATE('20-02-2023', 'DD-MM-YYYY'), TO_DATE('24-02-2023','DD-MM-YYYY'), TO_DATE('25-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(58, 9, TO_DATE('10-04-2023', 'DD-MM-YYYY'), TO_DATE('12-04-2023','DD-MM-YYYY'), TO_DATE('16-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(11, 4, TO_DATE('01-01-2023', 'DD-MM-YYYY'), TO_DATE('04-01-2023','DD-MM-YYYY'), TO_DATE('07-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(74, 5, TO_DATE('30-03-2023', 'DD-MM-YYYY'), TO_DATE('03-04-2023','DD-MM-YYYY'), TO_DATE('04-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(49, 5, TO_DATE('14-03-2023', 'DD-MM-YYYY'), TO_DATE('16-03-2023','DD-MM-YYYY'), TO_DATE('19-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(81, 5, TO_DATE('30-04-2023', 'DD-MM-YYYY'), TO_DATE('04-05-2023','DD-MM-YYYY'), TO_DATE('07-05-2023','DD-MM-YYYY'), null, 3);

p_add_orders(15, 4, TO_DATE('03-02-2023', 'DD-MM-YYYY'), TO_DATE('06-02-2023','DD-MM-YYYY'), TO_DATE('10-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(53, 5, TO_DATE('03-04-2023', 'DD-MM-YYYY'), TO_DATE('04-04-2023','DD-MM-YYYY'), TO_DATE('06-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(31, 4, TO_DATE('16-03-2023', 'DD-MM-YYYY'), TO_DATE('19-03-2023','DD-MM-YYYY'), TO_DATE('21-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(2, 5, TO_DATE('23-02-2023', 'DD-MM-YYYY'), TO_DATE('24-02-2023','DD-MM-YYYY'), TO_DATE('25-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(87, 9, TO_DATE('25-02-2023', 'DD-MM-YYYY'), TO_DATE('01-03-2023','DD-MM-YYYY'), TO_DATE('02-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(13, 9, TO_DATE('06-02-2023', 'DD-MM-YYYY'), TO_DATE('08-02-2023','DD-MM-YYYY'), TO_DATE('10-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(89, 5, TO_DATE('26-04-2023', 'DD-MM-YYYY'), TO_DATE('30-04-2023','DD-MM-YYYY'), TO_DATE('04-05-2023','DD-MM-YYYY'), null, 4);

p_add_orders(34, 5, TO_DATE('11-02-2023', 'DD-MM-YYYY'), TO_DATE('13-02-2023','DD-MM-YYYY'), TO_DATE('16-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(97, 5, TO_DATE('27-04-2023', 'DD-MM-YYYY'), TO_DATE('29-04-2023','DD-MM-YYYY'), TO_DATE('03-05-2023','DD-MM-YYYY'), null, 1);

p_add_orders(2, 5, TO_DATE('29-01-2023', 'DD-MM-YYYY'), TO_DATE('31-01-2023','DD-MM-YYYY'), TO_DATE('04-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(61, 5, TO_DATE('25-04-2023', 'DD-MM-YYYY'), TO_DATE('26-04-2023','DD-MM-YYYY'), TO_DATE('27-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(21, 4, TO_DATE('05-05-2023', 'DD-MM-YYYY'), TO_DATE('06-05-2023','DD-MM-YYYY'), TO_DATE('10-05-2023','DD-MM-YYYY'), null, 2);

p_add_orders(35, 9, TO_DATE('28-02-2023', 'DD-MM-YYYY'), TO_DATE('01-03-2023','DD-MM-YYYY'), TO_DATE('04-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(27, 5, TO_DATE('16-01-2023', 'DD-MM-YYYY'), TO_DATE('20-01-2023','DD-MM-YYYY'), TO_DATE('21-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(37, 4, TO_DATE('06-03-2023', 'DD-MM-YYYY'), TO_DATE('10-03-2023','DD-MM-YYYY'), TO_DATE('13-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(8, 9, TO_DATE('06-02-2023', 'DD-MM-YYYY'), TO_DATE('10-02-2023','DD-MM-YYYY'), TO_DATE('12-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(20, 5, TO_DATE('03-03-2023', 'DD-MM-YYYY'), TO_DATE('06-03-2023','DD-MM-YYYY'), TO_DATE('09-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(23, 5, TO_DATE('26-03-2023', 'DD-MM-YYYY'), TO_DATE('27-03-2023','DD-MM-YYYY'), TO_DATE('31-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(1, 5, TO_DATE('29-04-2023', 'DD-MM-YYYY'), TO_DATE('03-05-2023','DD-MM-YYYY'), TO_DATE('05-05-2023','DD-MM-YYYY'), null, 5);

p_add_orders(84, 9, TO_DATE('13-04-2023', 'DD-MM-YYYY'), TO_DATE('15-04-2023','DD-MM-YYYY'), TO_DATE('17-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(79, 5, TO_DATE('01-02-2023', 'DD-MM-YYYY'), TO_DATE('04-02-2023','DD-MM-YYYY'), TO_DATE('08-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(58, 4, TO_DATE('03-04-2023', 'DD-MM-YYYY'), TO_DATE('07-04-2023','DD-MM-YYYY'), TO_DATE('09-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(21, 4, TO_DATE('25-03-2023', 'DD-MM-YYYY'), TO_DATE('26-03-2023','DD-MM-YYYY'), TO_DATE('28-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(76, 5, TO_DATE('13-03-2023', 'DD-MM-YYYY'), TO_DATE('17-03-2023','DD-MM-YYYY'), TO_DATE('21-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(82, 5, TO_DATE('18-02-2023', 'DD-MM-YYYY'), TO_DATE('21-02-2023','DD-MM-YYYY'), TO_DATE('25-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(69, 5, TO_DATE('08-03-2023', 'DD-MM-YYYY'), TO_DATE('11-03-2023','DD-MM-YYYY'), TO_DATE('13-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(58, 9, TO_DATE('08-03-2023', 'DD-MM-YYYY'), TO_DATE('12-03-2023','DD-MM-YYYY'), TO_DATE('14-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(12, 5, TO_DATE('06-04-2023', 'DD-MM-YYYY'), TO_DATE('08-04-2023','DD-MM-YYYY'), TO_DATE('12-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(20, 5, TO_DATE('16-03-2023', 'DD-MM-YYYY'), TO_DATE('17-03-2023','DD-MM-YYYY'), TO_DATE('19-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(76, 9, TO_DATE('01-04-2023', 'DD-MM-YYYY'), TO_DATE('02-04-2023','DD-MM-YYYY'), TO_DATE('04-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(56, 5, TO_DATE('09-04-2023', 'DD-MM-YYYY'), TO_DATE('13-04-2023','DD-MM-YYYY'), TO_DATE('15-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(6, 5, TO_DATE('12-02-2023', 'DD-MM-YYYY'), TO_DATE('16-02-2023','DD-MM-YYYY'), TO_DATE('18-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(91, 5, TO_DATE('06-03-2023', 'DD-MM-YYYY'), TO_DATE('10-03-2023','DD-MM-YYYY'), TO_DATE('14-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(45, 5, TO_DATE('16-04-2023', 'DD-MM-YYYY'), TO_DATE('17-04-2023','DD-MM-YYYY'), TO_DATE('21-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(96, 9, TO_DATE('19-02-2023', 'DD-MM-YYYY'), TO_DATE('21-02-2023','DD-MM-YYYY'), TO_DATE('24-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(63, 5, TO_DATE('15-04-2023', 'DD-MM-YYYY'), TO_DATE('19-04-2023','DD-MM-YYYY'), TO_DATE('23-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(77, 4, TO_DATE('16-03-2023', 'DD-MM-YYYY'), TO_DATE('18-03-2023','DD-MM-YYYY'), TO_DATE('22-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(28, 4, TO_DATE('18-03-2023', 'DD-MM-YYYY'), TO_DATE('21-03-2023','DD-MM-YYYY'), TO_DATE('23-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(69, 5, TO_DATE('05-02-2023', 'DD-MM-YYYY'), TO_DATE('07-02-2023','DD-MM-YYYY'), TO_DATE('10-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(30, 5, TO_DATE('13-03-2023', 'DD-MM-YYYY'), TO_DATE('16-03-2023','DD-MM-YYYY'), TO_DATE('18-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(79, 5, TO_DATE('13-04-2023', 'DD-MM-YYYY'), TO_DATE('17-04-2023','DD-MM-YYYY'), TO_DATE('20-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(4, 9, TO_DATE('11-04-2023', 'DD-MM-YYYY'), TO_DATE('15-04-2023','DD-MM-YYYY'), TO_DATE('17-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(67, 4, TO_DATE('08-03-2023', 'DD-MM-YYYY'), TO_DATE('11-03-2023','DD-MM-YYYY'), TO_DATE('15-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(37, 4, TO_DATE('16-01-2023', 'DD-MM-YYYY'), TO_DATE('17-01-2023','DD-MM-YYYY'), TO_DATE('19-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(94, 9, TO_DATE('16-02-2023', 'DD-MM-YYYY'), TO_DATE('19-02-2023','DD-MM-YYYY'), TO_DATE('23-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(96, 5, TO_DATE('29-01-2023', 'DD-MM-YYYY'), TO_DATE('01-02-2023','DD-MM-YYYY'), TO_DATE('02-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(59, 4, TO_DATE('11-03-2023', 'DD-MM-YYYY'), TO_DATE('14-03-2023','DD-MM-YYYY'), TO_DATE('17-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(24, 4, TO_DATE('24-02-2023', 'DD-MM-YYYY'), TO_DATE('27-02-2023','DD-MM-YYYY'), TO_DATE('03-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(75, 9, TO_DATE('07-04-2023', 'DD-MM-YYYY'), TO_DATE('10-04-2023','DD-MM-YYYY'), TO_DATE('14-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(77, 5, TO_DATE('20-03-2023', 'DD-MM-YYYY'), TO_DATE('23-03-2023','DD-MM-YYYY'), TO_DATE('26-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(53, 4, TO_DATE('05-05-2023', 'DD-MM-YYYY'), TO_DATE('08-05-2023','DD-MM-YYYY'), TO_DATE('12-05-2023','DD-MM-YYYY'), null, 5);

p_add_orders(46, 9, TO_DATE('24-01-2023', 'DD-MM-YYYY'), TO_DATE('27-01-2023','DD-MM-YYYY'), TO_DATE('30-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(27, 4, TO_DATE('28-03-2023', 'DD-MM-YYYY'), TO_DATE('30-03-2023','DD-MM-YYYY'), TO_DATE('01-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(93, 4, TO_DATE('02-01-2023', 'DD-MM-YYYY'), TO_DATE('03-01-2023','DD-MM-YYYY'), TO_DATE('06-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(86, 9, TO_DATE('29-01-2023', 'DD-MM-YYYY'), TO_DATE('30-01-2023','DD-MM-YYYY'), TO_DATE('03-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(66, 9, TO_DATE('05-01-2023', 'DD-MM-YYYY'), TO_DATE('06-01-2023','DD-MM-YYYY'), TO_DATE('08-01-2023','DD-MM-YYYY'), null, 1);

p_add_orders(60, 4, TO_DATE('18-02-2023', 'DD-MM-YYYY'), TO_DATE('19-02-2023','DD-MM-YYYY'), TO_DATE('21-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(54, 4, TO_DATE('29-01-2023', 'DD-MM-YYYY'), TO_DATE('30-01-2023','DD-MM-YYYY'), TO_DATE('02-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(61, 4, TO_DATE('10-02-2023', 'DD-MM-YYYY'), TO_DATE('14-02-2023','DD-MM-YYYY'), TO_DATE('15-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(86, 4, TO_DATE('06-04-2023', 'DD-MM-YYYY'), TO_DATE('07-04-2023','DD-MM-YYYY'), TO_DATE('09-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(66, 9, TO_DATE('01-02-2023', 'DD-MM-YYYY'), TO_DATE('03-02-2023','DD-MM-YYYY'), TO_DATE('06-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(62, 5, TO_DATE('21-04-2023', 'DD-MM-YYYY'), TO_DATE('22-04-2023','DD-MM-YYYY'), TO_DATE('24-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(18, 9, TO_DATE('13-03-2023', 'DD-MM-YYYY'), TO_DATE('16-03-2023','DD-MM-YYYY'), TO_DATE('18-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(67, 4, TO_DATE('29-03-2023', 'DD-MM-YYYY'), TO_DATE('31-03-2023','DD-MM-YYYY'), TO_DATE('03-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(23, 5, TO_DATE('17-04-2023', 'DD-MM-YYYY'), TO_DATE('18-04-2023','DD-MM-YYYY'), TO_DATE('20-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(78, 5, TO_DATE('02-01-2023', 'DD-MM-YYYY'), TO_DATE('06-01-2023','DD-MM-YYYY'), TO_DATE('10-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(89, 9, TO_DATE('28-03-2023', 'DD-MM-YYYY'), TO_DATE('01-04-2023','DD-MM-YYYY'), TO_DATE('05-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(20, 5, TO_DATE('18-04-2023', 'DD-MM-YYYY'), TO_DATE('21-04-2023','DD-MM-YYYY'), TO_DATE('23-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(35, 9, TO_DATE('20-01-2023', 'DD-MM-YYYY'), TO_DATE('23-01-2023','DD-MM-YYYY'), TO_DATE('24-01-2023','DD-MM-YYYY'), null, 1);

p_add_orders(76, 4, TO_DATE('19-03-2023', 'DD-MM-YYYY'), TO_DATE('21-03-2023','DD-MM-YYYY'), TO_DATE('23-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(79, 5, TO_DATE('09-03-2023', 'DD-MM-YYYY'), TO_DATE('10-03-2023','DD-MM-YYYY'), TO_DATE('11-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(79, 9, TO_DATE('04-03-2023', 'DD-MM-YYYY'), TO_DATE('07-03-2023','DD-MM-YYYY'), TO_DATE('08-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(69, 9, TO_DATE('23-01-2023', 'DD-MM-YYYY'), TO_DATE('24-01-2023','DD-MM-YYYY'), TO_DATE('25-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(19, 4, TO_DATE('22-01-2023', 'DD-MM-YYYY'), TO_DATE('26-01-2023','DD-MM-YYYY'), TO_DATE('28-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(39, 5, TO_DATE('13-01-2023', 'DD-MM-YYYY'), TO_DATE('17-01-2023','DD-MM-YYYY'), TO_DATE('21-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(55, 4, TO_DATE('12-01-2023', 'DD-MM-YYYY'), TO_DATE('14-01-2023','DD-MM-YYYY'), TO_DATE('15-01-2023','DD-MM-YYYY'), null, 1);

p_add_orders(51, 9, TO_DATE('26-02-2023', 'DD-MM-YYYY'), TO_DATE('02-03-2023','DD-MM-YYYY'), TO_DATE('06-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(61, 9, TO_DATE('23-01-2023', 'DD-MM-YYYY'), TO_DATE('26-01-2023','DD-MM-YYYY'), TO_DATE('28-01-2023','DD-MM-YYYY'), null, 5);

p_add_orders(70, 4, TO_DATE('08-03-2023', 'DD-MM-YYYY'), TO_DATE('11-03-2023','DD-MM-YYYY'), TO_DATE('12-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(93, 9, TO_DATE('12-04-2023', 'DD-MM-YYYY'), TO_DATE('14-04-2023','DD-MM-YYYY'), TO_DATE('16-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(2, 4, TO_DATE('11-01-2023', 'DD-MM-YYYY'), TO_DATE('14-01-2023','DD-MM-YYYY'), TO_DATE('18-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(40, 4, TO_DATE('28-03-2023', 'DD-MM-YYYY'), TO_DATE('31-03-2023','DD-MM-YYYY'), TO_DATE('01-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(48, 9, TO_DATE('23-03-2023', 'DD-MM-YYYY'), TO_DATE('24-03-2023','DD-MM-YYYY'), TO_DATE('25-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(82, 5, TO_DATE('03-02-2023', 'DD-MM-YYYY'), TO_DATE('04-02-2023','DD-MM-YYYY'), TO_DATE('08-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(58, 4, TO_DATE('27-03-2023', 'DD-MM-YYYY'), TO_DATE('30-03-2023','DD-MM-YYYY'), TO_DATE('03-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(37, 9, TO_DATE('20-01-2023', 'DD-MM-YYYY'), TO_DATE('22-01-2023','DD-MM-YYYY'), TO_DATE('25-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(76, 5, TO_DATE('17-04-2023', 'DD-MM-YYYY'), TO_DATE('19-04-2023','DD-MM-YYYY'), TO_DATE('23-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(82, 9, TO_DATE('08-04-2023', 'DD-MM-YYYY'), TO_DATE('11-04-2023','DD-MM-YYYY'), TO_DATE('14-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(88, 5, TO_DATE('01-04-2023', 'DD-MM-YYYY'), TO_DATE('05-04-2023','DD-MM-YYYY'), TO_DATE('09-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(92, 4, TO_DATE('29-01-2023', 'DD-MM-YYYY'), TO_DATE('31-01-2023','DD-MM-YYYY'), TO_DATE('04-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(72, 5, TO_DATE('22-02-2023', 'DD-MM-YYYY'), TO_DATE('26-02-2023','DD-MM-YYYY'), TO_DATE('28-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(40, 4, TO_DATE('11-02-2023', 'DD-MM-YYYY'), TO_DATE('13-02-2023','DD-MM-YYYY'), TO_DATE('17-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(97, 5, TO_DATE('06-02-2023', 'DD-MM-YYYY'), TO_DATE('10-02-2023','DD-MM-YYYY'), TO_DATE('14-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(96, 4, TO_DATE('07-02-2023', 'DD-MM-YYYY'), TO_DATE('11-02-2023','DD-MM-YYYY'), TO_DATE('15-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(71, 4, TO_DATE('04-05-2023', 'DD-MM-YYYY'), TO_DATE('08-05-2023','DD-MM-YYYY'), TO_DATE('10-05-2023','DD-MM-YYYY'), null, 3);

p_add_orders(8, 9, TO_DATE('26-03-2023', 'DD-MM-YYYY'), TO_DATE('28-03-2023','DD-MM-YYYY'), TO_DATE('01-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(21, 5, TO_DATE('13-02-2023', 'DD-MM-YYYY'), TO_DATE('14-02-2023','DD-MM-YYYY'), TO_DATE('15-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(5, 4, TO_DATE('19-04-2023', 'DD-MM-YYYY'), TO_DATE('22-04-2023','DD-MM-YYYY'), TO_DATE('26-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(66, 5, TO_DATE('23-02-2023', 'DD-MM-YYYY'), TO_DATE('25-02-2023','DD-MM-YYYY'), TO_DATE('28-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(60, 4, TO_DATE('09-04-2023', 'DD-MM-YYYY'), TO_DATE('10-04-2023','DD-MM-YYYY'), TO_DATE('14-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(52, 9, TO_DATE('10-02-2023', 'DD-MM-YYYY'), TO_DATE('11-02-2023','DD-MM-YYYY'), TO_DATE('15-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(21, 4, TO_DATE('24-01-2023', 'DD-MM-YYYY'), TO_DATE('25-01-2023','DD-MM-YYYY'), TO_DATE('28-01-2023','DD-MM-YYYY'), null, 5);

p_add_orders(24, 5, TO_DATE('24-04-2023', 'DD-MM-YYYY'), TO_DATE('25-04-2023','DD-MM-YYYY'), TO_DATE('27-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(17, 9, TO_DATE('07-03-2023', 'DD-MM-YYYY'), TO_DATE('09-03-2023','DD-MM-YYYY'), TO_DATE('10-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(97, 5, TO_DATE('24-04-2023', 'DD-MM-YYYY'), TO_DATE('26-04-2023','DD-MM-YYYY'), TO_DATE('30-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(84, 9, TO_DATE('17-01-2023', 'DD-MM-YYYY'), TO_DATE('19-01-2023','DD-MM-YYYY'), TO_DATE('21-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(74, 4, TO_DATE('19-03-2023', 'DD-MM-YYYY'), TO_DATE('20-03-2023','DD-MM-YYYY'), TO_DATE('22-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(67, 5, TO_DATE('24-02-2023', 'DD-MM-YYYY'), TO_DATE('25-02-2023','DD-MM-YYYY'), TO_DATE('01-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(29, 4, TO_DATE('02-01-2023', 'DD-MM-YYYY'), TO_DATE('03-01-2023','DD-MM-YYYY'), TO_DATE('07-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(3, 4, TO_DATE('02-04-2023', 'DD-MM-YYYY'), TO_DATE('03-04-2023','DD-MM-YYYY'), TO_DATE('05-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(20, 5, TO_DATE('09-02-2023', 'DD-MM-YYYY'), TO_DATE('11-02-2023','DD-MM-YYYY'), TO_DATE('13-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(52, 4, TO_DATE('10-02-2023', 'DD-MM-YYYY'), TO_DATE('13-02-2023','DD-MM-YYYY'), TO_DATE('15-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(1, 5, TO_DATE('31-01-2023', 'DD-MM-YYYY'), TO_DATE('01-02-2023','DD-MM-YYYY'), TO_DATE('02-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(83, 5, TO_DATE('19-02-2023', 'DD-MM-YYYY'), TO_DATE('21-02-2023','DD-MM-YYYY'), TO_DATE('25-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(14, 9, TO_DATE('15-02-2023', 'DD-MM-YYYY'), TO_DATE('19-02-2023','DD-MM-YYYY'), TO_DATE('21-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(95, 4, TO_DATE('21-01-2023', 'DD-MM-YYYY'), TO_DATE('22-01-2023','DD-MM-YYYY'), TO_DATE('25-01-2023','DD-MM-YYYY'), null, 1);

p_add_orders(94, 4, TO_DATE('27-02-2023', 'DD-MM-YYYY'), TO_DATE('01-03-2023','DD-MM-YYYY'), TO_DATE('02-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(7, 5, TO_DATE('22-02-2023', 'DD-MM-YYYY'), TO_DATE('25-02-2023','DD-MM-YYYY'), TO_DATE('26-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(43, 4, TO_DATE('11-01-2023', 'DD-MM-YYYY'), TO_DATE('14-01-2023','DD-MM-YYYY'), TO_DATE('16-01-2023','DD-MM-YYYY'), null, 1);

p_add_orders(77, 5, TO_DATE('07-03-2023', 'DD-MM-YYYY'), TO_DATE('08-03-2023','DD-MM-YYYY'), TO_DATE('11-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(64, 9, TO_DATE('01-01-2023', 'DD-MM-YYYY'), TO_DATE('05-01-2023','DD-MM-YYYY'), TO_DATE('07-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(69, 9, TO_DATE('16-02-2023', 'DD-MM-YYYY'), TO_DATE('17-02-2023','DD-MM-YYYY'), TO_DATE('21-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(52, 9, TO_DATE('19-01-2023', 'DD-MM-YYYY'), TO_DATE('21-01-2023','DD-MM-YYYY'), TO_DATE('24-01-2023','DD-MM-YYYY'), null, 1);

p_add_orders(88, 9, TO_DATE('01-05-2023', 'DD-MM-YYYY'), TO_DATE('04-05-2023','DD-MM-YYYY'), TO_DATE('08-05-2023','DD-MM-YYYY'), null, 4);

p_add_orders(48, 5, TO_DATE('13-01-2023', 'DD-MM-YYYY'), TO_DATE('16-01-2023','DD-MM-YYYY'), TO_DATE('17-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(48, 5, TO_DATE('10-03-2023', 'DD-MM-YYYY'), TO_DATE('12-03-2023','DD-MM-YYYY'), TO_DATE('15-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(21, 4, TO_DATE('03-01-2023', 'DD-MM-YYYY'), TO_DATE('06-01-2023','DD-MM-YYYY'), TO_DATE('09-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(74, 4, TO_DATE('15-03-2023', 'DD-MM-YYYY'), TO_DATE('16-03-2023','DD-MM-YYYY'), TO_DATE('19-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(34, 5, TO_DATE('21-02-2023', 'DD-MM-YYYY'), TO_DATE('23-02-2023','DD-MM-YYYY'), TO_DATE('26-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(36, 4, TO_DATE('12-02-2023', 'DD-MM-YYYY'), TO_DATE('13-02-2023','DD-MM-YYYY'), TO_DATE('15-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(18, 9, TO_DATE('26-04-2023', 'DD-MM-YYYY'), TO_DATE('29-04-2023','DD-MM-YYYY'), TO_DATE('01-05-2023','DD-MM-YYYY'), null, 1);

p_add_orders(38, 5, TO_DATE('15-02-2023', 'DD-MM-YYYY'), TO_DATE('16-02-2023','DD-MM-YYYY'), TO_DATE('18-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(57, 4, TO_DATE('15-03-2023', 'DD-MM-YYYY'), TO_DATE('17-03-2023','DD-MM-YYYY'), TO_DATE('19-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(30, 4, TO_DATE('22-02-2023', 'DD-MM-YYYY'), TO_DATE('26-02-2023','DD-MM-YYYY'), TO_DATE('01-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(10, 5, TO_DATE('18-01-2023', 'DD-MM-YYYY'), TO_DATE('20-01-2023','DD-MM-YYYY'), TO_DATE('22-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(89, 4, TO_DATE('13-02-2023', 'DD-MM-YYYY'), TO_DATE('14-02-2023','DD-MM-YYYY'), TO_DATE('18-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(61, 5, TO_DATE('16-04-2023', 'DD-MM-YYYY'), TO_DATE('20-04-2023','DD-MM-YYYY'), TO_DATE('22-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(72, 5, TO_DATE('17-03-2023', 'DD-MM-YYYY'), TO_DATE('20-03-2023','DD-MM-YYYY'), TO_DATE('23-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(49, 9, TO_DATE('27-04-2023', 'DD-MM-YYYY'), TO_DATE('01-05-2023','DD-MM-YYYY'), TO_DATE('03-05-2023','DD-MM-YYYY'), null, 4);

p_add_orders(14, 4, TO_DATE('29-04-2023', 'DD-MM-YYYY'), TO_DATE('01-05-2023','DD-MM-YYYY'), TO_DATE('03-05-2023','DD-MM-YYYY'), null, 5);

p_add_orders(69, 9, TO_DATE('06-05-2023', 'DD-MM-YYYY'), TO_DATE('10-05-2023','DD-MM-YYYY'), TO_DATE('11-05-2023','DD-MM-YYYY'), null, 1);

p_add_orders(23, 4, TO_DATE('16-02-2023', 'DD-MM-YYYY'), TO_DATE('17-02-2023','DD-MM-YYYY'), TO_DATE('20-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(21, 9, TO_DATE('15-01-2023', 'DD-MM-YYYY'), TO_DATE('17-01-2023','DD-MM-YYYY'), TO_DATE('19-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(11, 9, TO_DATE('07-05-2023', 'DD-MM-YYYY'), TO_DATE('09-05-2023','DD-MM-YYYY'), TO_DATE('11-05-2023','DD-MM-YYYY'), null, 4);

p_add_orders(11, 4, TO_DATE('02-04-2023', 'DD-MM-YYYY'), TO_DATE('06-04-2023','DD-MM-YYYY'), TO_DATE('09-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(69, 4, TO_DATE('10-03-2023', 'DD-MM-YYYY'), TO_DATE('14-03-2023','DD-MM-YYYY'), TO_DATE('18-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(78, 4, TO_DATE('11-01-2023', 'DD-MM-YYYY'), TO_DATE('13-01-2023','DD-MM-YYYY'), TO_DATE('15-01-2023','DD-MM-YYYY'), null, 1);

p_add_orders(7, 9, TO_DATE('20-04-2023', 'DD-MM-YYYY'), TO_DATE('21-04-2023','DD-MM-YYYY'), TO_DATE('22-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(3, 9, TO_DATE('14-02-2023', 'DD-MM-YYYY'), TO_DATE('17-02-2023','DD-MM-YYYY'), TO_DATE('21-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(38, 5, TO_DATE('22-03-2023', 'DD-MM-YYYY'), TO_DATE('25-03-2023','DD-MM-YYYY'), TO_DATE('29-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(60, 4, TO_DATE('30-01-2023', 'DD-MM-YYYY'), TO_DATE('01-02-2023','DD-MM-YYYY'), TO_DATE('02-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(100, 9, TO_DATE('20-03-2023', 'DD-MM-YYYY'), TO_DATE('23-03-2023','DD-MM-YYYY'), TO_DATE('25-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(24, 4, TO_DATE('08-05-2023', 'DD-MM-YYYY'), TO_DATE('12-05-2023','DD-MM-YYYY'), TO_DATE('15-05-2023','DD-MM-YYYY'), null, 5);

p_add_orders(1, 4, TO_DATE('21-01-2023', 'DD-MM-YYYY'), TO_DATE('25-01-2023','DD-MM-YYYY'), TO_DATE('28-01-2023','DD-MM-YYYY'), null, 5);

p_add_orders(69, 5, TO_DATE('03-03-2023', 'DD-MM-YYYY'), TO_DATE('06-03-2023','DD-MM-YYYY'), TO_DATE('07-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(37, 9, TO_DATE('03-05-2023', 'DD-MM-YYYY'), TO_DATE('07-05-2023','DD-MM-YYYY'), TO_DATE('10-05-2023','DD-MM-YYYY'), null, 1);

p_add_orders(86, 9, TO_DATE('29-01-2023', 'DD-MM-YYYY'), TO_DATE('31-01-2023','DD-MM-YYYY'), TO_DATE('02-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(70, 5, TO_DATE('29-01-2023', 'DD-MM-YYYY'), TO_DATE('02-02-2023','DD-MM-YYYY'), TO_DATE('04-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(7, 9, TO_DATE('14-01-2023', 'DD-MM-YYYY'), TO_DATE('15-01-2023','DD-MM-YYYY'), TO_DATE('16-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(97, 5, TO_DATE('18-02-2023', 'DD-MM-YYYY'), TO_DATE('20-02-2023','DD-MM-YYYY'), TO_DATE('22-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(69, 9, TO_DATE('14-02-2023', 'DD-MM-YYYY'), TO_DATE('17-02-2023','DD-MM-YYYY'), TO_DATE('18-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(90, 5, TO_DATE('08-04-2023', 'DD-MM-YYYY'), TO_DATE('12-04-2023','DD-MM-YYYY'), TO_DATE('13-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(7, 5, TO_DATE('06-02-2023', 'DD-MM-YYYY'), TO_DATE('10-02-2023','DD-MM-YYYY'), TO_DATE('14-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(8, 5, TO_DATE('13-01-2023', 'DD-MM-YYYY'), TO_DATE('14-01-2023','DD-MM-YYYY'), TO_DATE('15-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(53, 9, TO_DATE('28-04-2023', 'DD-MM-YYYY'), TO_DATE('30-04-2023','DD-MM-YYYY'), TO_DATE('04-05-2023','DD-MM-YYYY'), null, 1);

p_add_orders(26, 4, TO_DATE('25-02-2023', 'DD-MM-YYYY'), TO_DATE('01-03-2023','DD-MM-YYYY'), TO_DATE('03-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(49, 5, TO_DATE('28-03-2023', 'DD-MM-YYYY'), TO_DATE('31-03-2023','DD-MM-YYYY'), TO_DATE('01-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(96, 5, TO_DATE('13-04-2023', 'DD-MM-YYYY'), TO_DATE('15-04-2023','DD-MM-YYYY'), TO_DATE('18-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(26, 5, TO_DATE('13-03-2023', 'DD-MM-YYYY'), TO_DATE('15-03-2023','DD-MM-YYYY'), TO_DATE('16-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(44, 9, TO_DATE('10-01-2023', 'DD-MM-YYYY'), TO_DATE('13-01-2023','DD-MM-YYYY'), TO_DATE('17-01-2023','DD-MM-YYYY'), null, 1);

p_add_orders(66, 5, TO_DATE('17-03-2023', 'DD-MM-YYYY'), TO_DATE('21-03-2023','DD-MM-YYYY'), TO_DATE('22-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(85, 4, TO_DATE('03-03-2023', 'DD-MM-YYYY'), TO_DATE('06-03-2023','DD-MM-YYYY'), TO_DATE('07-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(55, 5, TO_DATE('20-03-2023', 'DD-MM-YYYY'), TO_DATE('23-03-2023','DD-MM-YYYY'), TO_DATE('24-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(66, 9, TO_DATE('18-02-2023', 'DD-MM-YYYY'), TO_DATE('19-02-2023','DD-MM-YYYY'), TO_DATE('21-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(37, 4, TO_DATE('16-04-2023', 'DD-MM-YYYY'), TO_DATE('19-04-2023','DD-MM-YYYY'), TO_DATE('20-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(48, 4, TO_DATE('16-02-2023', 'DD-MM-YYYY'), TO_DATE('20-02-2023','DD-MM-YYYY'), TO_DATE('22-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(93, 5, TO_DATE('20-04-2023', 'DD-MM-YYYY'), TO_DATE('23-04-2023','DD-MM-YYYY'), TO_DATE('26-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(11, 5, TO_DATE('06-05-2023', 'DD-MM-YYYY'), TO_DATE('09-05-2023','DD-MM-YYYY'), TO_DATE('10-05-2023','DD-MM-YYYY'), null, 3);

p_add_orders(47, 9, TO_DATE('13-01-2023', 'DD-MM-YYYY'), TO_DATE('14-01-2023','DD-MM-YYYY'), TO_DATE('17-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(86, 9, TO_DATE('22-02-2023', 'DD-MM-YYYY'), TO_DATE('25-02-2023','DD-MM-YYYY'), TO_DATE('26-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(39, 4, TO_DATE('23-03-2023', 'DD-MM-YYYY'), TO_DATE('24-03-2023','DD-MM-YYYY'), TO_DATE('26-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(66, 5, TO_DATE('17-01-2023', 'DD-MM-YYYY'), TO_DATE('18-01-2023','DD-MM-YYYY'), TO_DATE('20-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(96, 9, TO_DATE('04-02-2023', 'DD-MM-YYYY'), TO_DATE('05-02-2023','DD-MM-YYYY'), TO_DATE('06-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(96, 9, TO_DATE('17-03-2023', 'DD-MM-YYYY'), TO_DATE('21-03-2023','DD-MM-YYYY'), TO_DATE('24-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(51, 4, TO_DATE('02-04-2023', 'DD-MM-YYYY'), TO_DATE('03-04-2023','DD-MM-YYYY'), TO_DATE('07-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(82, 5, TO_DATE('08-04-2023', 'DD-MM-YYYY'), TO_DATE('11-04-2023','DD-MM-YYYY'), TO_DATE('13-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(67, 9, TO_DATE('26-02-2023', 'DD-MM-YYYY'), TO_DATE('28-02-2023','DD-MM-YYYY'), TO_DATE('03-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(36, 5, TO_DATE('05-01-2023', 'DD-MM-YYYY'), TO_DATE('06-01-2023','DD-MM-YYYY'), TO_DATE('07-01-2023','DD-MM-YYYY'), null, 5);

p_add_orders(42, 9, TO_DATE('25-03-2023', 'DD-MM-YYYY'), TO_DATE('28-03-2023','DD-MM-YYYY'), TO_DATE('29-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(79, 4, TO_DATE('25-02-2023', 'DD-MM-YYYY'), TO_DATE('01-03-2023','DD-MM-YYYY'), TO_DATE('05-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(52, 5, TO_DATE('24-02-2023', 'DD-MM-YYYY'), TO_DATE('27-02-2023','DD-MM-YYYY'), TO_DATE('02-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(76, 4, TO_DATE('15-02-2023', 'DD-MM-YYYY'), TO_DATE('19-02-2023','DD-MM-YYYY'), TO_DATE('21-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(50, 5, TO_DATE('06-01-2023', 'DD-MM-YYYY'), TO_DATE('07-01-2023','DD-MM-YYYY'), TO_DATE('08-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(21, 5, TO_DATE('26-02-2023', 'DD-MM-YYYY'), TO_DATE('01-03-2023','DD-MM-YYYY'), TO_DATE('05-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(72, 4, TO_DATE('05-03-2023', 'DD-MM-YYYY'), TO_DATE('06-03-2023','DD-MM-YYYY'), TO_DATE('07-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(82, 4, TO_DATE('26-01-2023', 'DD-MM-YYYY'), TO_DATE('28-01-2023','DD-MM-YYYY'), TO_DATE('29-01-2023','DD-MM-YYYY'), null, 1);

p_add_orders(77, 5, TO_DATE('18-04-2023', 'DD-MM-YYYY'), TO_DATE('19-04-2023','DD-MM-YYYY'), TO_DATE('23-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(25, 4, TO_DATE('14-02-2023', 'DD-MM-YYYY'), TO_DATE('17-02-2023','DD-MM-YYYY'), TO_DATE('19-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(36, 4, TO_DATE('01-05-2023', 'DD-MM-YYYY'), TO_DATE('04-05-2023','DD-MM-YYYY'), TO_DATE('07-05-2023','DD-MM-YYYY'), null, 1);

p_add_orders(99, 5, TO_DATE('25-01-2023', 'DD-MM-YYYY'), TO_DATE('29-01-2023','DD-MM-YYYY'), TO_DATE('01-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(2, 5, TO_DATE('05-03-2023', 'DD-MM-YYYY'), TO_DATE('06-03-2023','DD-MM-YYYY'), TO_DATE('08-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(61, 4, TO_DATE('09-02-2023', 'DD-MM-YYYY'), TO_DATE('10-02-2023','DD-MM-YYYY'), TO_DATE('12-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(15, 4, TO_DATE('22-03-2023', 'DD-MM-YYYY'), TO_DATE('24-03-2023','DD-MM-YYYY'), TO_DATE('28-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(65, 4, TO_DATE('29-04-2023', 'DD-MM-YYYY'), TO_DATE('02-05-2023','DD-MM-YYYY'), TO_DATE('03-05-2023','DD-MM-YYYY'), null, 4);

p_add_orders(17, 9, TO_DATE('14-03-2023', 'DD-MM-YYYY'), TO_DATE('17-03-2023','DD-MM-YYYY'), TO_DATE('19-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(72, 4, TO_DATE('02-04-2023', 'DD-MM-YYYY'), TO_DATE('05-04-2023','DD-MM-YYYY'), TO_DATE('08-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(53, 5, TO_DATE('02-03-2023', 'DD-MM-YYYY'), TO_DATE('05-03-2023','DD-MM-YYYY'), TO_DATE('09-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(63, 9, TO_DATE('02-05-2023', 'DD-MM-YYYY'), TO_DATE('06-05-2023','DD-MM-YYYY'), TO_DATE('08-05-2023','DD-MM-YYYY'), null, 4);

p_add_orders(100, 4, TO_DATE('04-02-2023', 'DD-MM-YYYY'), TO_DATE('05-02-2023','DD-MM-YYYY'), TO_DATE('06-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(69, 9, TO_DATE('23-03-2023', 'DD-MM-YYYY'), TO_DATE('27-03-2023','DD-MM-YYYY'), TO_DATE('31-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(62, 4, TO_DATE('17-01-2023', 'DD-MM-YYYY'), TO_DATE('20-01-2023','DD-MM-YYYY'), TO_DATE('24-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(2, 4, TO_DATE('18-03-2023', 'DD-MM-YYYY'), TO_DATE('20-03-2023','DD-MM-YYYY'), TO_DATE('23-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(41, 4, TO_DATE('01-05-2023', 'DD-MM-YYYY'), TO_DATE('03-05-2023','DD-MM-YYYY'), TO_DATE('06-05-2023','DD-MM-YYYY'), null, 2);

p_add_orders(35, 5, TO_DATE('29-03-2023', 'DD-MM-YYYY'), TO_DATE('01-04-2023','DD-MM-YYYY'), TO_DATE('04-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(63, 4, TO_DATE('14-02-2023', 'DD-MM-YYYY'), TO_DATE('17-02-2023','DD-MM-YYYY'), TO_DATE('18-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(3, 9, TO_DATE('03-03-2023', 'DD-MM-YYYY'), TO_DATE('07-03-2023','DD-MM-YYYY'), TO_DATE('11-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(79, 9, TO_DATE('25-01-2023', 'DD-MM-YYYY'), TO_DATE('27-01-2023','DD-MM-YYYY'), TO_DATE('29-01-2023','DD-MM-YYYY'), null, 5);

p_add_orders(64, 9, TO_DATE('18-03-2023', 'DD-MM-YYYY'), TO_DATE('19-03-2023','DD-MM-YYYY'), TO_DATE('20-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(18, 5, TO_DATE('14-03-2023', 'DD-MM-YYYY'), TO_DATE('18-03-2023','DD-MM-YYYY'), TO_DATE('19-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(53, 5, TO_DATE('06-05-2023', 'DD-MM-YYYY'), TO_DATE('07-05-2023','DD-MM-YYYY'), TO_DATE('10-05-2023','DD-MM-YYYY'), null, 4);

p_add_orders(84, 9, TO_DATE('14-02-2023', 'DD-MM-YYYY'), TO_DATE('16-02-2023','DD-MM-YYYY'), TO_DATE('20-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(59, 5, TO_DATE('13-03-2023', 'DD-MM-YYYY'), TO_DATE('14-03-2023','DD-MM-YYYY'), TO_DATE('15-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(94, 5, TO_DATE('30-04-2023', 'DD-MM-YYYY'), TO_DATE('03-05-2023','DD-MM-YYYY'), TO_DATE('05-05-2023','DD-MM-YYYY'), null, 5);

p_add_orders(14, 9, TO_DATE('07-01-2023', 'DD-MM-YYYY'), TO_DATE('10-01-2023','DD-MM-YYYY'), TO_DATE('12-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(3, 9, TO_DATE('07-04-2023', 'DD-MM-YYYY'), TO_DATE('09-04-2023','DD-MM-YYYY'), TO_DATE('11-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(37, 9, TO_DATE('08-03-2023', 'DD-MM-YYYY'), TO_DATE('12-03-2023','DD-MM-YYYY'), TO_DATE('13-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(47, 9, TO_DATE('25-03-2023', 'DD-MM-YYYY'), TO_DATE('26-03-2023','DD-MM-YYYY'), TO_DATE('29-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(32, 4, TO_DATE('30-01-2023', 'DD-MM-YYYY'), TO_DATE('03-02-2023','DD-MM-YYYY'), TO_DATE('06-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(51, 4, TO_DATE('09-03-2023', 'DD-MM-YYYY'), TO_DATE('13-03-2023','DD-MM-YYYY'), TO_DATE('17-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(54, 9, TO_DATE('17-03-2023', 'DD-MM-YYYY'), TO_DATE('18-03-2023','DD-MM-YYYY'), TO_DATE('20-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(98, 5, TO_DATE('03-05-2023', 'DD-MM-YYYY'), TO_DATE('06-05-2023','DD-MM-YYYY'), TO_DATE('07-05-2023','DD-MM-YYYY'), null, 4);

p_add_orders(23, 4, TO_DATE('09-02-2023', 'DD-MM-YYYY'), TO_DATE('11-02-2023','DD-MM-YYYY'), TO_DATE('12-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(80, 5, TO_DATE('03-05-2023', 'DD-MM-YYYY'), TO_DATE('05-05-2023','DD-MM-YYYY'), TO_DATE('07-05-2023','DD-MM-YYYY'), null, 1);

p_add_orders(75, 4, TO_DATE('09-02-2023', 'DD-MM-YYYY'), TO_DATE('13-02-2023','DD-MM-YYYY'), TO_DATE('16-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(2, 4, TO_DATE('08-05-2023', 'DD-MM-YYYY'), TO_DATE('11-05-2023','DD-MM-YYYY'), TO_DATE('13-05-2023','DD-MM-YYYY'), null, 2);

p_add_orders(71, 9, TO_DATE('06-04-2023', 'DD-MM-YYYY'), TO_DATE('10-04-2023','DD-MM-YYYY'), TO_DATE('14-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(57, 9, TO_DATE('18-02-2023', 'DD-MM-YYYY'), TO_DATE('19-02-2023','DD-MM-YYYY'), TO_DATE('20-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(51, 5, TO_DATE('04-03-2023', 'DD-MM-YYYY'), TO_DATE('07-03-2023','DD-MM-YYYY'), TO_DATE('08-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(61, 4, TO_DATE('17-03-2023', 'DD-MM-YYYY'), TO_DATE('19-03-2023','DD-MM-YYYY'), TO_DATE('20-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(79, 9, TO_DATE('21-02-2023', 'DD-MM-YYYY'), TO_DATE('24-02-2023','DD-MM-YYYY'), TO_DATE('25-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(20, 9, TO_DATE('09-05-2023', 'DD-MM-YYYY'), TO_DATE('10-05-2023','DD-MM-YYYY'), TO_DATE('11-05-2023','DD-MM-YYYY'), null, 1);

p_add_orders(5, 9, TO_DATE('10-03-2023', 'DD-MM-YYYY'), TO_DATE('13-03-2023','DD-MM-YYYY'), TO_DATE('17-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(86, 9, TO_DATE('06-02-2023', 'DD-MM-YYYY'), TO_DATE('10-02-2023','DD-MM-YYYY'), TO_DATE('11-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(63, 9, TO_DATE('11-01-2023', 'DD-MM-YYYY'), TO_DATE('14-01-2023','DD-MM-YYYY'), TO_DATE('16-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(33, 5, TO_DATE('27-04-2023', 'DD-MM-YYYY'), TO_DATE('01-05-2023','DD-MM-YYYY'), TO_DATE('02-05-2023','DD-MM-YYYY'), null, 5);

p_add_orders(99, 9, TO_DATE('04-03-2023', 'DD-MM-YYYY'), TO_DATE('05-03-2023','DD-MM-YYYY'), TO_DATE('06-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(73, 5, TO_DATE('31-03-2023', 'DD-MM-YYYY'), TO_DATE('03-04-2023','DD-MM-YYYY'), TO_DATE('05-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(98, 4, TO_DATE('18-01-2023', 'DD-MM-YYYY'), TO_DATE('21-01-2023','DD-MM-YYYY'), TO_DATE('23-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(19, 9, TO_DATE('16-01-2023', 'DD-MM-YYYY'), TO_DATE('18-01-2023','DD-MM-YYYY'), TO_DATE('20-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(76, 4, TO_DATE('22-02-2023', 'DD-MM-YYYY'), TO_DATE('26-02-2023','DD-MM-YYYY'), TO_DATE('01-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(47, 4, TO_DATE('04-04-2023', 'DD-MM-YYYY'), TO_DATE('07-04-2023','DD-MM-YYYY'), TO_DATE('09-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(11, 9, TO_DATE('10-05-2023', 'DD-MM-YYYY'), TO_DATE('11-05-2023','DD-MM-YYYY'), TO_DATE('13-05-2023','DD-MM-YYYY'), null, 1);

p_add_orders(40, 4, TO_DATE('24-03-2023', 'DD-MM-YYYY'), TO_DATE('27-03-2023','DD-MM-YYYY'), TO_DATE('29-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(87, 9, TO_DATE('15-01-2023', 'DD-MM-YYYY'), TO_DATE('18-01-2023','DD-MM-YYYY'), TO_DATE('19-01-2023','DD-MM-YYYY'), null, 5);

p_add_orders(36, 5, TO_DATE('09-04-2023', 'DD-MM-YYYY'), TO_DATE('10-04-2023','DD-MM-YYYY'), TO_DATE('12-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(91, 4, TO_DATE('18-04-2023', 'DD-MM-YYYY'), TO_DATE('20-04-2023','DD-MM-YYYY'), TO_DATE('21-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(19, 5, TO_DATE('23-02-2023', 'DD-MM-YYYY'), TO_DATE('26-02-2023','DD-MM-YYYY'), TO_DATE('02-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(90, 4, TO_DATE('26-02-2023', 'DD-MM-YYYY'), TO_DATE('02-03-2023','DD-MM-YYYY'), TO_DATE('05-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(12, 9, TO_DATE('26-01-2023', 'DD-MM-YYYY'), TO_DATE('30-01-2023','DD-MM-YYYY'), TO_DATE('31-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(87, 4, TO_DATE('26-04-2023', 'DD-MM-YYYY'), TO_DATE('29-04-2023','DD-MM-YYYY'), TO_DATE('01-05-2023','DD-MM-YYYY'), null, 1);

p_add_orders(54, 5, TO_DATE('19-04-2023', 'DD-MM-YYYY'), TO_DATE('23-04-2023','DD-MM-YYYY'), TO_DATE('26-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(40, 5, TO_DATE('20-02-2023', 'DD-MM-YYYY'), TO_DATE('21-02-2023','DD-MM-YYYY'), TO_DATE('24-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(9, 9, TO_DATE('10-05-2023', 'DD-MM-YYYY'), TO_DATE('13-05-2023','DD-MM-YYYY'), TO_DATE('16-05-2023','DD-MM-YYYY'), null, 1);

p_add_orders(17, 4, TO_DATE('08-03-2023', 'DD-MM-YYYY'), TO_DATE('11-03-2023','DD-MM-YYYY'), TO_DATE('13-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(64, 4, TO_DATE('17-03-2023', 'DD-MM-YYYY'), TO_DATE('20-03-2023','DD-MM-YYYY'), TO_DATE('21-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(18, 4, TO_DATE('01-04-2023', 'DD-MM-YYYY'), TO_DATE('05-04-2023','DD-MM-YYYY'), TO_DATE('06-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(11, 9, TO_DATE('11-03-2023', 'DD-MM-YYYY'), TO_DATE('15-03-2023','DD-MM-YYYY'), TO_DATE('18-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(7, 5, TO_DATE('10-02-2023', 'DD-MM-YYYY'), TO_DATE('12-02-2023','DD-MM-YYYY'), TO_DATE('14-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(26, 5, TO_DATE('22-04-2023', 'DD-MM-YYYY'), TO_DATE('26-04-2023','DD-MM-YYYY'), TO_DATE('28-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(66, 9, TO_DATE('18-02-2023', 'DD-MM-YYYY'), TO_DATE('21-02-2023','DD-MM-YYYY'), TO_DATE('22-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(55, 4, TO_DATE('19-03-2023', 'DD-MM-YYYY'), TO_DATE('20-03-2023','DD-MM-YYYY'), TO_DATE('24-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(97, 4, TO_DATE('29-03-2023', 'DD-MM-YYYY'), TO_DATE('30-03-2023','DD-MM-YYYY'), TO_DATE('02-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(16, 5, TO_DATE('27-02-2023', 'DD-MM-YYYY'), TO_DATE('28-02-2023','DD-MM-YYYY'), TO_DATE('02-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(45, 9, TO_DATE('07-02-2023', 'DD-MM-YYYY'), TO_DATE('11-02-2023','DD-MM-YYYY'), TO_DATE('14-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(54, 9, TO_DATE('04-04-2023', 'DD-MM-YYYY'), TO_DATE('05-04-2023','DD-MM-YYYY'), TO_DATE('09-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(88, 5, TO_DATE('01-05-2023', 'DD-MM-YYYY'), TO_DATE('03-05-2023','DD-MM-YYYY'), TO_DATE('05-05-2023','DD-MM-YYYY'), null, 2);

p_add_orders(71, 4, TO_DATE('01-01-2023', 'DD-MM-YYYY'), TO_DATE('02-01-2023','DD-MM-YYYY'), TO_DATE('06-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(16, 5, TO_DATE('28-03-2023', 'DD-MM-YYYY'), TO_DATE('31-03-2023','DD-MM-YYYY'), TO_DATE('02-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(42, 5, TO_DATE('06-02-2023', 'DD-MM-YYYY'), TO_DATE('08-02-2023','DD-MM-YYYY'), TO_DATE('11-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(98, 5, TO_DATE('24-02-2023', 'DD-MM-YYYY'), TO_DATE('26-02-2023','DD-MM-YYYY'), TO_DATE('02-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(100, 4, TO_DATE('08-02-2023', 'DD-MM-YYYY'), TO_DATE('12-02-2023','DD-MM-YYYY'), TO_DATE('16-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(43, 4, TO_DATE('12-04-2023', 'DD-MM-YYYY'), TO_DATE('15-04-2023','DD-MM-YYYY'), TO_DATE('19-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(55, 4, TO_DATE('25-02-2023', 'DD-MM-YYYY'), TO_DATE('27-02-2023','DD-MM-YYYY'), TO_DATE('01-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(22, 4, TO_DATE('16-04-2023', 'DD-MM-YYYY'), TO_DATE('20-04-2023','DD-MM-YYYY'), TO_DATE('21-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(48, 5, TO_DATE('06-02-2023', 'DD-MM-YYYY'), TO_DATE('09-02-2023','DD-MM-YYYY'), TO_DATE('12-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(96, 4, TO_DATE('05-05-2023', 'DD-MM-YYYY'), TO_DATE('06-05-2023','DD-MM-YYYY'), TO_DATE('10-05-2023','DD-MM-YYYY'), null, 5);

p_add_orders(26, 5, TO_DATE('20-02-2023', 'DD-MM-YYYY'), TO_DATE('23-02-2023','DD-MM-YYYY'), TO_DATE('26-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(22, 9, TO_DATE('16-03-2023', 'DD-MM-YYYY'), TO_DATE('18-03-2023','DD-MM-YYYY'), TO_DATE('21-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(94, 5, TO_DATE('29-01-2023', 'DD-MM-YYYY'), TO_DATE('02-02-2023','DD-MM-YYYY'), TO_DATE('05-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(2, 5, TO_DATE('06-01-2023', 'DD-MM-YYYY'), TO_DATE('08-01-2023','DD-MM-YYYY'), TO_DATE('10-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(100, 9, TO_DATE('01-04-2023', 'DD-MM-YYYY'), TO_DATE('05-04-2023','DD-MM-YYYY'), TO_DATE('06-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(33, 5, TO_DATE('09-01-2023', 'DD-MM-YYYY'), TO_DATE('13-01-2023','DD-MM-YYYY'), TO_DATE('14-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(17, 4, TO_DATE('21-02-2023', 'DD-MM-YYYY'), TO_DATE('24-02-2023','DD-MM-YYYY'), TO_DATE('26-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(35, 4, TO_DATE('18-01-2023', 'DD-MM-YYYY'), TO_DATE('22-01-2023','DD-MM-YYYY'), TO_DATE('23-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(61, 5, TO_DATE('04-01-2023', 'DD-MM-YYYY'), TO_DATE('06-01-2023','DD-MM-YYYY'), TO_DATE('07-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(10, 9, TO_DATE('19-03-2023', 'DD-MM-YYYY'), TO_DATE('22-03-2023','DD-MM-YYYY'), TO_DATE('25-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(51, 9, TO_DATE('23-03-2023', 'DD-MM-YYYY'), TO_DATE('25-03-2023','DD-MM-YYYY'), TO_DATE('29-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(89, 4, TO_DATE('25-02-2023', 'DD-MM-YYYY'), TO_DATE('27-02-2023','DD-MM-YYYY'), TO_DATE('28-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(13, 5, TO_DATE('22-02-2023', 'DD-MM-YYYY'), TO_DATE('26-02-2023','DD-MM-YYYY'), TO_DATE('02-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(52, 5, TO_DATE('25-04-2023', 'DD-MM-YYYY'), TO_DATE('29-04-2023','DD-MM-YYYY'), TO_DATE('01-05-2023','DD-MM-YYYY'), null, 1);

p_add_orders(83, 5, TO_DATE('09-02-2023', 'DD-MM-YYYY'), TO_DATE('12-02-2023','DD-MM-YYYY'), TO_DATE('16-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(96, 5, TO_DATE('14-04-2023', 'DD-MM-YYYY'), TO_DATE('16-04-2023','DD-MM-YYYY'), TO_DATE('17-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(60, 9, TO_DATE('24-04-2023', 'DD-MM-YYYY'), TO_DATE('25-04-2023','DD-MM-YYYY'), TO_DATE('26-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(86, 9, TO_DATE('26-04-2023', 'DD-MM-YYYY'), TO_DATE('27-04-2023','DD-MM-YYYY'), TO_DATE('28-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(76, 9, TO_DATE('24-04-2023', 'DD-MM-YYYY'), TO_DATE('28-04-2023','DD-MM-YYYY'), TO_DATE('29-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(14, 5, TO_DATE('01-04-2023', 'DD-MM-YYYY'), TO_DATE('04-04-2023','DD-MM-YYYY'), TO_DATE('05-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(46, 9, TO_DATE('18-04-2023', 'DD-MM-YYYY'), TO_DATE('20-04-2023','DD-MM-YYYY'), TO_DATE('23-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(37, 9, TO_DATE('16-01-2023', 'DD-MM-YYYY'), TO_DATE('18-01-2023','DD-MM-YYYY'), TO_DATE('20-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(24, 9, TO_DATE('17-01-2023', 'DD-MM-YYYY'), TO_DATE('19-01-2023','DD-MM-YYYY'), TO_DATE('20-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(11, 5, TO_DATE('07-01-2023', 'DD-MM-YYYY'), TO_DATE('08-01-2023','DD-MM-YYYY'), TO_DATE('12-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(25, 5, TO_DATE('12-02-2023', 'DD-MM-YYYY'), TO_DATE('16-02-2023','DD-MM-YYYY'), TO_DATE('20-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(89, 5, TO_DATE('25-03-2023', 'DD-MM-YYYY'), TO_DATE('29-03-2023','DD-MM-YYYY'), TO_DATE('31-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(43, 4, TO_DATE('31-03-2023', 'DD-MM-YYYY'), TO_DATE('01-04-2023','DD-MM-YYYY'), TO_DATE('02-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(69, 5, TO_DATE('21-01-2023', 'DD-MM-YYYY'), TO_DATE('25-01-2023','DD-MM-YYYY'), TO_DATE('29-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(25, 9, TO_DATE('08-02-2023', 'DD-MM-YYYY'), TO_DATE('09-02-2023','DD-MM-YYYY'), TO_DATE('13-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(86, 9, TO_DATE('10-02-2023', 'DD-MM-YYYY'), TO_DATE('12-02-2023','DD-MM-YYYY'), TO_DATE('13-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(69, 9, TO_DATE('21-04-2023', 'DD-MM-YYYY'), TO_DATE('24-04-2023','DD-MM-YYYY'), TO_DATE('25-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(37, 9, TO_DATE('26-01-2023', 'DD-MM-YYYY'), TO_DATE('27-01-2023','DD-MM-YYYY'), TO_DATE('31-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(91, 5, TO_DATE('16-02-2023', 'DD-MM-YYYY'), TO_DATE('18-02-2023','DD-MM-YYYY'), TO_DATE('21-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(51, 4, TO_DATE('06-04-2023', 'DD-MM-YYYY'), TO_DATE('10-04-2023','DD-MM-YYYY'), TO_DATE('14-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(53, 5, TO_DATE('02-01-2023', 'DD-MM-YYYY'), TO_DATE('04-01-2023','DD-MM-YYYY'), TO_DATE('05-01-2023','DD-MM-YYYY'), null, 5);

p_add_orders(34, 4, TO_DATE('01-01-2023', 'DD-MM-YYYY'), TO_DATE('04-01-2023','DD-MM-YYYY'), TO_DATE('05-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(1, 5, TO_DATE('26-01-2023', 'DD-MM-YYYY'), TO_DATE('28-01-2023','DD-MM-YYYY'), TO_DATE('29-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(62, 5, TO_DATE('05-01-2023', 'DD-MM-YYYY'), TO_DATE('07-01-2023','DD-MM-YYYY'), TO_DATE('11-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(24, 4, TO_DATE('14-01-2023', 'DD-MM-YYYY'), TO_DATE('18-01-2023','DD-MM-YYYY'), TO_DATE('22-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(66, 5, TO_DATE('12-04-2023', 'DD-MM-YYYY'), TO_DATE('16-04-2023','DD-MM-YYYY'), TO_DATE('20-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(88, 9, TO_DATE('01-03-2023', 'DD-MM-YYYY'), TO_DATE('05-03-2023','DD-MM-YYYY'), TO_DATE('08-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(23, 4, TO_DATE('15-02-2023', 'DD-MM-YYYY'), TO_DATE('17-02-2023','DD-MM-YYYY'), TO_DATE('21-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(61, 5, TO_DATE('20-01-2023', 'DD-MM-YYYY'), TO_DATE('21-01-2023','DD-MM-YYYY'), TO_DATE('22-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(59, 5, TO_DATE('12-04-2023', 'DD-MM-YYYY'), TO_DATE('14-04-2023','DD-MM-YYYY'), TO_DATE('18-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(87, 4, TO_DATE('13-02-2023', 'DD-MM-YYYY'), TO_DATE('17-02-2023','DD-MM-YYYY'), TO_DATE('20-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(98, 5, TO_DATE('16-04-2023', 'DD-MM-YYYY'), TO_DATE('19-04-2023','DD-MM-YYYY'), TO_DATE('20-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(19, 9, TO_DATE('23-04-2023', 'DD-MM-YYYY'), TO_DATE('27-04-2023','DD-MM-YYYY'), TO_DATE('29-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(43, 5, TO_DATE('27-02-2023', 'DD-MM-YYYY'), TO_DATE('28-02-2023','DD-MM-YYYY'), TO_DATE('01-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(74, 9, TO_DATE('03-04-2023', 'DD-MM-YYYY'), TO_DATE('06-04-2023','DD-MM-YYYY'), TO_DATE('09-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(69, 5, TO_DATE('30-04-2023', 'DD-MM-YYYY'), TO_DATE('04-05-2023','DD-MM-YYYY'), TO_DATE('05-05-2023','DD-MM-YYYY'), null, 4);

p_add_orders(91, 5, TO_DATE('28-02-2023', 'DD-MM-YYYY'), TO_DATE('01-03-2023','DD-MM-YYYY'), TO_DATE('04-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(52, 9, TO_DATE('25-03-2023', 'DD-MM-YYYY'), TO_DATE('29-03-2023','DD-MM-YYYY'), TO_DATE('30-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(28, 4, TO_DATE('17-01-2023', 'DD-MM-YYYY'), TO_DATE('21-01-2023','DD-MM-YYYY'), TO_DATE('23-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(50, 9, TO_DATE('07-01-2023', 'DD-MM-YYYY'), TO_DATE('08-01-2023','DD-MM-YYYY'), TO_DATE('09-01-2023','DD-MM-YYYY'), null, 1);

p_add_orders(30, 4, TO_DATE('20-01-2023', 'DD-MM-YYYY'), TO_DATE('21-01-2023','DD-MM-YYYY'), TO_DATE('25-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(77, 4, TO_DATE('25-02-2023', 'DD-MM-YYYY'), TO_DATE('27-02-2023','DD-MM-YYYY'), TO_DATE('03-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(47, 4, TO_DATE('20-02-2023', 'DD-MM-YYYY'), TO_DATE('21-02-2023','DD-MM-YYYY'), TO_DATE('24-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(81, 9, TO_DATE('25-01-2023', 'DD-MM-YYYY'), TO_DATE('28-01-2023','DD-MM-YYYY'), TO_DATE('30-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(66, 5, TO_DATE('05-03-2023', 'DD-MM-YYYY'), TO_DATE('06-03-2023','DD-MM-YYYY'), TO_DATE('10-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(15, 4, TO_DATE('18-02-2023', 'DD-MM-YYYY'), TO_DATE('21-02-2023','DD-MM-YYYY'), TO_DATE('25-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(77, 4, TO_DATE('21-02-2023', 'DD-MM-YYYY'), TO_DATE('25-02-2023','DD-MM-YYYY'), TO_DATE('01-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(19, 4, TO_DATE('25-01-2023', 'DD-MM-YYYY'), TO_DATE('27-01-2023','DD-MM-YYYY'), TO_DATE('29-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(11, 4, TO_DATE('31-01-2023', 'DD-MM-YYYY'), TO_DATE('03-02-2023','DD-MM-YYYY'), TO_DATE('04-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(9, 9, TO_DATE('31-03-2023', 'DD-MM-YYYY'), TO_DATE('04-04-2023','DD-MM-YYYY'), TO_DATE('06-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(97, 5, TO_DATE('24-02-2023', 'DD-MM-YYYY'), TO_DATE('27-02-2023','DD-MM-YYYY'), TO_DATE('28-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(66, 5, TO_DATE('05-03-2023', 'DD-MM-YYYY'), TO_DATE('07-03-2023','DD-MM-YYYY'), TO_DATE('11-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(13, 9, TO_DATE('10-04-2023', 'DD-MM-YYYY'), TO_DATE('12-04-2023','DD-MM-YYYY'), TO_DATE('14-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(5, 5, TO_DATE('18-04-2023', 'DD-MM-YYYY'), TO_DATE('21-04-2023','DD-MM-YYYY'), TO_DATE('22-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(59, 5, TO_DATE('23-01-2023', 'DD-MM-YYYY'), TO_DATE('25-01-2023','DD-MM-YYYY'), TO_DATE('26-01-2023','DD-MM-YYYY'), null, 3);

p_add_orders(72, 5, TO_DATE('11-02-2023', 'DD-MM-YYYY'), TO_DATE('14-02-2023','DD-MM-YYYY'), TO_DATE('16-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(47, 5, TO_DATE('24-03-2023', 'DD-MM-YYYY'), TO_DATE('26-03-2023','DD-MM-YYYY'), TO_DATE('29-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(55, 5, TO_DATE('03-01-2023', 'DD-MM-YYYY'), TO_DATE('04-01-2023','DD-MM-YYYY'), TO_DATE('05-01-2023','DD-MM-YYYY'), null, 5);

p_add_orders(90, 4, TO_DATE('10-03-2023', 'DD-MM-YYYY'), TO_DATE('14-03-2023','DD-MM-YYYY'), TO_DATE('18-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(53, 4, TO_DATE('04-01-2023', 'DD-MM-YYYY'), TO_DATE('07-01-2023','DD-MM-YYYY'), TO_DATE('10-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(26, 4, TO_DATE('17-02-2023', 'DD-MM-YYYY'), TO_DATE('21-02-2023','DD-MM-YYYY'), TO_DATE('22-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(59, 5, TO_DATE('13-02-2023', 'DD-MM-YYYY'), TO_DATE('17-02-2023','DD-MM-YYYY'), TO_DATE('20-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(46, 9, TO_DATE('21-03-2023', 'DD-MM-YYYY'), TO_DATE('24-03-2023','DD-MM-YYYY'), TO_DATE('28-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(3, 4, TO_DATE('26-02-2023', 'DD-MM-YYYY'), TO_DATE('28-02-2023','DD-MM-YYYY'), TO_DATE('03-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(58, 9, TO_DATE('22-03-2023', 'DD-MM-YYYY'), TO_DATE('25-03-2023','DD-MM-YYYY'), TO_DATE('28-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(31, 5, TO_DATE('01-05-2023', 'DD-MM-YYYY'), TO_DATE('02-05-2023','DD-MM-YYYY'), TO_DATE('03-05-2023','DD-MM-YYYY'), null, 2);

p_add_orders(86, 4, TO_DATE('11-03-2023', 'DD-MM-YYYY'), TO_DATE('13-03-2023','DD-MM-YYYY'), TO_DATE('14-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(6, 9, TO_DATE('29-01-2023', 'DD-MM-YYYY'), TO_DATE('02-02-2023','DD-MM-YYYY'), TO_DATE('03-02-2023','DD-MM-YYYY'), null, 4);

p_add_orders(71, 9, TO_DATE('27-03-2023', 'DD-MM-YYYY'), TO_DATE('31-03-2023','DD-MM-YYYY'), TO_DATE('02-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(47, 9, TO_DATE('19-02-2023', 'DD-MM-YYYY'), TO_DATE('20-02-2023','DD-MM-YYYY'), TO_DATE('24-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(78, 9, TO_DATE('14-04-2023', 'DD-MM-YYYY'), TO_DATE('18-04-2023','DD-MM-YYYY'), TO_DATE('19-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(18, 5, TO_DATE('16-02-2023', 'DD-MM-YYYY'), TO_DATE('18-02-2023','DD-MM-YYYY'), TO_DATE('19-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(9, 9, TO_DATE('17-04-2023', 'DD-MM-YYYY'), TO_DATE('18-04-2023','DD-MM-YYYY'), TO_DATE('21-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(5, 9, TO_DATE('20-03-2023', 'DD-MM-YYYY'), TO_DATE('21-03-2023','DD-MM-YYYY'), TO_DATE('22-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(72, 9, TO_DATE('04-03-2023', 'DD-MM-YYYY'), TO_DATE('05-03-2023','DD-MM-YYYY'), TO_DATE('07-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(97, 4, TO_DATE('31-01-2023', 'DD-MM-YYYY'), TO_DATE('03-02-2023','DD-MM-YYYY'), TO_DATE('04-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(10, 9, TO_DATE('27-03-2023', 'DD-MM-YYYY'), TO_DATE('28-03-2023','DD-MM-YYYY'), TO_DATE('30-03-2023','DD-MM-YYYY'), null, 4);

p_add_orders(89, 5, TO_DATE('18-02-2023', 'DD-MM-YYYY'), TO_DATE('22-02-2023','DD-MM-YYYY'), TO_DATE('23-02-2023','DD-MM-YYYY'), null, 1);

p_add_orders(47, 5, TO_DATE('23-01-2023', 'DD-MM-YYYY'), TO_DATE('26-01-2023','DD-MM-YYYY'), TO_DATE('28-01-2023','DD-MM-YYYY'), null, 5);

p_add_orders(92, 9, TO_DATE('22-04-2023', 'DD-MM-YYYY'), TO_DATE('24-04-2023','DD-MM-YYYY'), TO_DATE('25-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(28, 9, TO_DATE('27-04-2023', 'DD-MM-YYYY'), TO_DATE('30-04-2023','DD-MM-YYYY'), TO_DATE('04-05-2023','DD-MM-YYYY'), null, 4);

p_add_orders(54, 4, TO_DATE('28-04-2023', 'DD-MM-YYYY'), TO_DATE('01-05-2023','DD-MM-YYYY'), TO_DATE('05-05-2023','DD-MM-YYYY'), null, 5);

p_add_orders(28, 4, TO_DATE('19-03-2023', 'DD-MM-YYYY'), TO_DATE('21-03-2023','DD-MM-YYYY'), TO_DATE('23-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(37, 5, TO_DATE('09-04-2023', 'DD-MM-YYYY'), TO_DATE('10-04-2023','DD-MM-YYYY'), TO_DATE('11-04-2023','DD-MM-YYYY'), null, 3);

p_add_orders(1, 9, TO_DATE('07-03-2023', 'DD-MM-YYYY'), TO_DATE('08-03-2023','DD-MM-YYYY'), TO_DATE('09-03-2023','DD-MM-YYYY'), null, 5);

p_add_orders(60, 4, TO_DATE('09-01-2023', 'DD-MM-YYYY'), TO_DATE('11-01-2023','DD-MM-YYYY'), TO_DATE('13-01-2023','DD-MM-YYYY'), null, 2);

p_add_orders(34, 9, TO_DATE('14-01-2023', 'DD-MM-YYYY'), TO_DATE('15-01-2023','DD-MM-YYYY'), TO_DATE('19-01-2023','DD-MM-YYYY'), null, 5);

p_add_orders(36, 5, TO_DATE('04-04-2023', 'DD-MM-YYYY'), TO_DATE('05-04-2023','DD-MM-YYYY'), TO_DATE('07-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(63, 4, TO_DATE('17-02-2023', 'DD-MM-YYYY'), TO_DATE('19-02-2023','DD-MM-YYYY'), TO_DATE('20-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(36, 9, TO_DATE('10-04-2023', 'DD-MM-YYYY'), TO_DATE('11-04-2023','DD-MM-YYYY'), TO_DATE('13-04-2023','DD-MM-YYYY'), null, 2);

p_add_orders(47, 5, TO_DATE('10-03-2023', 'DD-MM-YYYY'), TO_DATE('14-03-2023','DD-MM-YYYY'), TO_DATE('15-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(8, 5, TO_DATE('30-04-2023', 'DD-MM-YYYY'), TO_DATE('03-05-2023','DD-MM-YYYY'), TO_DATE('06-05-2023','DD-MM-YYYY'), null, 2);

p_add_orders(97, 9, TO_DATE('04-01-2023', 'DD-MM-YYYY'), TO_DATE('07-01-2023','DD-MM-YYYY'), TO_DATE('09-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(85, 9, TO_DATE('04-02-2023', 'DD-MM-YYYY'), TO_DATE('05-02-2023','DD-MM-YYYY'), TO_DATE('09-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(81, 5, TO_DATE('31-01-2023', 'DD-MM-YYYY'), TO_DATE('01-02-2023','DD-MM-YYYY'), TO_DATE('02-02-2023','DD-MM-YYYY'), null, 2);

p_add_orders(67, 9, TO_DATE('05-02-2023', 'DD-MM-YYYY'), TO_DATE('06-02-2023','DD-MM-YYYY'), TO_DATE('07-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(8, 4, TO_DATE('15-04-2023', 'DD-MM-YYYY'), TO_DATE('16-04-2023','DD-MM-YYYY'), TO_DATE('17-04-2023','DD-MM-YYYY'), null, 1);

p_add_orders(40, 5, TO_DATE('15-04-2023', 'DD-MM-YYYY'), TO_DATE('19-04-2023','DD-MM-YYYY'), TO_DATE('21-04-2023','DD-MM-YYYY'), null, 4);

p_add_orders(58, 5, TO_DATE('07-03-2023', 'DD-MM-YYYY'), TO_DATE('08-03-2023','DD-MM-YYYY'), TO_DATE('11-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(74, 9, TO_DATE('30-03-2023', 'DD-MM-YYYY'), TO_DATE('02-04-2023','DD-MM-YYYY'), TO_DATE('05-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(76, 5, TO_DATE('10-03-2023', 'DD-MM-YYYY'), TO_DATE('13-03-2023','DD-MM-YYYY'), TO_DATE('16-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(23, 4, TO_DATE('11-03-2023', 'DD-MM-YYYY'), TO_DATE('15-03-2023','DD-MM-YYYY'), TO_DATE('19-03-2023','DD-MM-YYYY'), null, 3);

p_add_orders(63, 4, TO_DATE('01-02-2023', 'DD-MM-YYYY'), TO_DATE('05-02-2023','DD-MM-YYYY'), TO_DATE('09-02-2023','DD-MM-YYYY'), null, 5);

p_add_orders(82, 9, TO_DATE('30-04-2023', 'DD-MM-YYYY'), TO_DATE('02-05-2023','DD-MM-YYYY'), TO_DATE('05-05-2023','DD-MM-YYYY'), null, 4);

p_add_orders(15, 4, TO_DATE('05-02-2023', 'DD-MM-YYYY'), TO_DATE('09-02-2023','DD-MM-YYYY'), TO_DATE('13-02-2023','DD-MM-YYYY'), null, 3);

p_add_orders(36, 9, TO_DATE('03-03-2023', 'DD-MM-YYYY'), TO_DATE('06-03-2023','DD-MM-YYYY'), TO_DATE('08-03-2023','DD-MM-YYYY'), null, 2);

p_add_orders(96, 4, TO_DATE('13-01-2023', 'DD-MM-YYYY'), TO_DATE('15-01-2023','DD-MM-YYYY'), TO_DATE('18-01-2023','DD-MM-YYYY'), null, 5);

p_add_orders(36, 4, TO_DATE('13-04-2023', 'DD-MM-YYYY'), TO_DATE('16-04-2023','DD-MM-YYYY'), TO_DATE('18-04-2023','DD-MM-YYYY'), null, 5);

p_add_orders(37, 5, TO_DATE('06-05-2023', 'DD-MM-YYYY'), TO_DATE('07-05-2023','DD-MM-YYYY'), TO_DATE('10-05-2023','DD-MM-YYYY'), null, 3);

p_add_orders(70, 9, TO_DATE('23-03-2023', 'DD-MM-YYYY'), TO_DATE('26-03-2023','DD-MM-YYYY'), TO_DATE('29-03-2023','DD-MM-YYYY'), null, 1);

p_add_orders(96, 5, TO_DATE('08-01-2023', 'DD-MM-YYYY'), TO_DATE('09-01-2023','DD-MM-YYYY'), TO_DATE('10-01-2023','DD-MM-YYYY'), null, 4);

p_add_orders(67, 5, TO_DATE('13-04-2023', 'DD-MM-YYYY'), TO_DATE('17-04-2023','DD-MM-YYYY'), TO_DATE('19-04-2023','DD-MM-YYYY'), null, 1);

END;


/

Select * from orders
Order by order_id;


INSERT INTO orders (customer_id, employee_id, order_date, required_date, shipped_date, order_value, supplier_id)
VALUES (34, 4, TO_DATE('03-02-2023', 'DD-MM-YYYY'), TO_DATE('07-02-2023','DD-MM-YYYY'), TO_DATE('10-02-2023','DD-MM-YYYY'), null, 2);

INSERT INTO orders (customer_id, employee_id, order_date, required_date, shipped_date, order_value, supplier_id)
VALUES (72, 9, TO_DATE('06-03-2023', 'DD-MM-YYYY'), TO_DATE('08-03-2023','DD-MM-YYYY'), TO_DATE('12-03-2023','DD-MM-YYYY'), null, 4);

INSERT INTO orders (customer_id, employee_id, order_date, required_date, shipped_date, order_value, supplier_id)
VALUES (77, 9, TO_DATE('15-04-2023', 'DD-MM-YYYY'), TO_DATE('17-04-2023','DD-MM-YYYY'), TO_DATE('18-04-2023','DD-MM-YYYY'), null, 4);

INSERT INTO orders (customer_id, employee_id, order_date, required_date, shipped_date, order_value, supplier_id)
VALUES (25, 5, TO_DATE('07-05-2023', 'DD-MM-YYYY'), TO_DATE('11-05-2023','DD-MM-YYYY'), TO_DATE('12-05-2023','DD-MM-YYYY'), null, 2);

INSERT INTO orders (customer_id, employee_id, order_date, required_date, shipped_date, order_value, supplier_id)
VALUES (7, 5, TO_DATE('29-04-2023', 'DD-MM-YYYY'), TO_DATE('03-05-2023','DD-MM-YYYY'), TO_DATE('05-05-2023','DD-MM-YYYY'), null, 3);

INSERT INTO orders (customer_id, employee_id, order_date, required_date, shipped_date, order_value, supplier_id)
VALUES (52, 9, TO_DATE('17-03-2023', 'DD-MM-YYYY'), TO_DATE('19-03-2023','DD-MM-YYYY'), TO_DATE('22-03-2023','DD-MM-YYYY'), null, 2);

INSERT INTO orders (customer_id, employee_id, order_date, required_date, shipped_date, order_value, supplier_id)
VALUES (78, 5, TO_DATE('25-04-2023', 'DD-MM-YYYY'), TO_DATE('29-04-2023','DD-MM-YYYY'), TO_DATE('01-05-2023','DD-MM-YYYY'), null, 3);

INSERT INTO orders (customer_id, employee_id, order_date, required_date, shipped_date, order_value, supplier_id)
VALUES (75, 5, TO_DATE('20-02-2023', 'DD-MM-YYYY'), TO_DATE('21-02-2023','DD-MM-YYYY'), TO_DATE('24-02-2023','DD-MM-YYYY'), null, 5);

INSERT INTO orders (customer_id, employee_id, order_date, required_date, shipped_date, order_value, supplier_id)
VALUES (90, 5, TO_DATE('22-01-2023', 'DD-MM-YYYY'), TO_DATE('26-01-2023','DD-MM-YYYY'), TO_DATE('29-01-2023','DD-MM-YYYY'), null, 5);

INSERT INTO orders (customer_id, employee_id, order_date, required_date, shipped_date, order_value, supplier_id)
VALUES (55, 4, TO_DATE('22-01-2023', 'DD-MM-YYYY'), TO_DATE('25-01-2023','DD-MM-YYYY'), TO_DATE('26-01-2023','DD-MM-YYYY'), null, 4);


----------------------------------------------------


