CREATE OR REPLACE PROCEDURE p_add_product (
    pin_product_name products.product_name%TYPE,
    pin_number_of_pages products.number_of_pages%TYPE,
    pin_price_per_unit products.price_per_unit%TYPE,
    pin_quantity_in_stock products.quantity_in_stock%TYPE
)
IS
v_product_count NUMBER;
BEGIN
    SELECT count(*)
    INTO v_product_count
    FROM products
    WHERE product_name = pin_product_name;
    
    IF v_product_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'A product with that name already exists in the database');
    END IF;

    IF pin_number_of_pages < 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Number of pages cannot be less than 0.');
    END IF;
    
    IF pin_quantity_in_stock < 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Quantity in stock cannot be less than 0.');
    END IF;
    
    INSERT INTO products(
        product_name,
        number_of_pages,
        price_per_unit,
        quantity_in_stock
    )
    VALUES(
        pin_product_name,
        pin_number_of_pages,
        pin_price_per_unit,
        pin_quantity_in_stock
    );   
		
EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Invalid value error: ' || SQLERRM);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred while adding product: ' || SQLERRM);
        
END p_add_product;
/

BEGIN
    p_add_product('Inflacja wróg publiczny nr 1', 244, 28.78, 7);
    p_add_product('Nowy wspaniały świat', 265, 30.01, 4);
    p_add_product('Antykruchość', 569, 52.31, 11);
    p_add_product('Zrozumieć BPMN', 189, 29.55, 30);
    p_add_product('Storytelling danych', 272, 46.66, 15);
    p_add_product('Analiza danych', 304, 42.99, 20);
    p_add_product('Hurtownie danych', 338, 55.41, 44);
    p_add_product('Python i praca z danymi', 384, 52.69, 16);
    p_add_product('Antywzorce języka SQL', 333, 39.99, 30);
    p_add_product('Myślenie systemowe', 216, 29.49, 10);
    p_add_product('Clean Code', 464, 150, 10);
    p_add_product('The Phoenix Project', 432, 90, 25);
    p_add_product('Code Complete', 960, 180, 5);
    p_add_product('Design Patterns: Elements of Reusable Object-Oriented Software', 416, 130, 5);
    p_add_product('The Pragmatic Programmer: From Journeyman to Master', 352, 120, 7);
    p_add_product('Programming Pearls', 256, 100, 8);
    p_add_product('Cracking the Coding Interview: 189 Programming Questions and Solutions', 687, 170, 4);
    p_add_product('Refactoring: Improving the Design of Existing Code', 455, 140, 4);
    p_add_product('Introduction to Algorithms', 1312, 220, 2);
    p_add_product('Head First Design Patterns', 694, 160, 11);
    p_add_product('Bazy danych. Teoria i praktyka z wykorzystaniem MySQL', 712, 99, 10);
    p_add_product('Wprowadzenie do systemów baz danych', 680, 110, 12);
    p_add_product('Big Data: Podstawy, techniki i narzędzia', 460, 80, 6);
    p_add_product('Przetwarzanie dużych zbiorów danych', 310, 70, 14);
    p_add_product('Bazy danych w praktyce', 420, 90, 21);
    p_add_product('Hadoop: Przetwarzanie ogromnych zbiorów danych', 440, 80, 10);
    p_add_product('NoSQL: Nowoczesne techniki przetwarzania danych', 350, 75, 20);
    p_add_product('Data Science: Analiza danych', 440, 90, 30);
    p_add_product('Podstawy big data. Analiza i wizualizacja', 280, 60, 40);
    p_add_product('HBase: NoSQL na przykładach', 250, 55, 50);
	p_add_product('Wielka wojna o chipy', 550, 69, 60); 
END;
/
