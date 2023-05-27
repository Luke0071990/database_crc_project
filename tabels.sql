CREATE TABLE authors (
    author_id   NUMBER DEFAULT author_id_seq.NEXTVAL
    , pesel       NUMBER(11)
    , first_name  VARCHAR2(30) NOT NULL
    , last_name   VARCHAR2(30) NOT NULL
);
/

ALTER TABLE authors ADD CONSTRAINT author_pk PRIMARY KEY ( author_id );
/

CREATE TABLE book_authors (
    author_id   NUMBER NOT NULL
    , product_id  NUMBER NOT NULL
);
/

ALTER TABLE book_authors ADD CONSTRAINT book_authors_pk PRIMARY KEY ( author_id
, product_id );
/

CREATE TABLE suppliers (
    supplier_id    NUMBER DEFAULT supplier_id_seq.NEXTVAL
    , supplier_name  VARCHAR2(30) NOT NULL
);

ALTER TABLE suppliers ADD CONSTRAINT suppliers_pk PRIMARY KEY ( supplier_id );

CREATE TABLE customers (
    customer_id    NUMBER DEFAULT customer_id_seq.NEXTVAL
    , first_name     VARCHAR2(50) NOT NULL
    , last_name      VARCHAR2(50) NOT NULL
    , city           VARCHAR2(30) NOT NULL
    , postal_code    NUMBER(5) NOT NULL
    , adress_street  VARCHAR2(30) NOT NULL
    , adress_number  VARCHAR2(10) NOT NULL
    , phone          NUMBER(9) NOT NULL 
    , e_mail         VARCHAR2(30) NOT NULL
    , nip            NUMBER(10) UNIQUE
    , company_name   VARCHAR2(30) 
	
	CONSTRAINT customer_phone_len CHECK (LENGTH(phone) = 9),
    CONSTRAINT customer_postal_code_len CHECK (LENGTH(postal_code) = 5),
);

ALTER TABLE customers ADD CONSTRAINT customers_pk PRIMARY KEY ( customer_id );

ALTER TABLE customers
    ADD CONSTRAINT customers_un UNIQUE ( nip
    , phone
    , e_mail
    , company_name );
/

CREATE TABLE publishing_house_books (
    product_id     NUMBER NOT NULL
    , publishing_id  NUMBER NOT NULL
);

ALTER TABLE publishing_house_books ADD CONSTRAINT pub_hb_ph PRIMARY KEY ( product_id
, publishing_id );



CREATE TABLE employees (
    employee_id     NUMBER,
    first_name      VARCHAR2(100) NOT NULL,
    last_name       VARCHAR2(100) NOT NULL,
    pesel           NUMBER(11) NOT NULL UNIQUE,
    city            VARCHAR2(100) NOT NULL,
    postal_code     VARCHAR2(5) NOT NULL,
    adress_street   VARCHAR2(100) NOT NULL,
    adress_number   VARCHAR2(10) NOT NULL,
    phone           NUMBER(9) NOT NULL UNIQUE,
    e_mail          VARCHAR2(100),
    department_id   NUMBER,
    
    CONSTRAINT employees_pk PRIMARY KEY (employee_id),
    CONSTRAINT employees_pesel_len CHECK (LENGTH(pesel) = 11),
    CONSTRAINT employees_phone_len CHECK (LENGTH(phone) = 9),
    CONSTRAINT employees_postal_code_len CHECK (LENGTH(postal_code) = 5),
    CONSTRAINT employees_dep_fk FOREIGN KEY (department_id)
        REFERENCES departments (department_id)
);



CREATE TABLE products (
    product_id         NUMBER DEFAULT product_id_seq.NEXTVAL
    , product_name       VARCHAR2(100) NOT NULL
    , number_of_pages    NUMBER NOT NULL
    , price_per_unit     NUMBER NOT NULL
    , quantity_in_stock  NUMBER NOT NULL
);
/

ALTER TABLE products ADD CONSTRAINT products_pk PRIMARY KEY ( product_id );

ALTER TABLE products ADD CONSTRAINT products_un UNIQUE ( product_name );

ALTER TABLE products ADD CONSTRAINT check_quantity_in_stock CHECK (quantity_in_stock >= 0);

ALTER TABLE products ADD CONSTRAINTS check_price CHECK (price_per_unit >= 0);

ALTER TABLE products ADD CONSTRAINT check_pages CHECK (number_of_pages > 0);
/

CREATE TABLE departments (
    department_id    NUMBER DEFAULT department_id_seq.NEXTVAL
    , department_name  VARCHAR2(30) NOT NULL
    , salary           NUMBER
);
/

ALTER TABLE departments ADD Constraint departments_pk Primary KEY (department_id);


/
CREATE TABLE order_details (
    order_id    NUMBER NOT NULL
    , product_id  NUMBER NOT NULL
    , quantity    NUMBER NOT NULL
    , discount    NUMBER
);

ALTER TABLE order_details ADD CONSTRAINT order_details_pk PRIMARY KEY ( order_id
, product_id );
/

CREATE TABLE publishings (
    publishing_id          NUMBER DEFAULT publishing_id_seq.NEXTVAL
    , name_of_the_publisher  VARCHAR2(50)
);
/

ALTER TABLE publishings ADD CONSTRAINT publishings_pk PRIMARY KEY ( publishing_id );

/

CREATE TABLE orders (
    order_id       NUMBER DEFAULT order_id_seq.NEXTVAL
    , customer_id    NUMBER NOT NULL
    , employee_id    NUMBER NOT NULL
    , order_date     DATE
    , required_date  DATE
    , shipped_date   DATE
    , order_value    NUMBER
    , supplier_id    NUMBER NOT NULL
	, status 		VARCHAR2(20) DEFAULT 'NEW'
);

ALTER TABLE orders ADD CONSTRAINT orders_pk PRIMARY KEY ( order_id );

ALTER TABLE orders
ADD CONSTRAINT orders_status_check CHECK (status IN ('NEW', 'APPROVED', 'SHIPPED', 'DELIVERED', 'CANCELED'));


CREATE TABLE bonuses (
    bonus_id NUMBER DEFAULT BONUS_ID_SEQ.nextval,
    employee_id NUMBER,
    bonus_amount NUMBER,
    b_year NUMBER,
    b_quarter NUMBER );

ALTER TABLE bonuses
    ADD CONSTRAINT bonuses_pk Primary KEY (bonus_id);


CREATE TABLE order_payments(
  payment_id 	NUMBER DEFAULT PAYMENTS_SEQ.nextval
, payment_date 	DATE DEFAULT SYSDATE
, order_id 		INTEGER
, status 		VARCHAR2(20) DEFAULT 'PENDING'
, CONSTRAINT order_id_fk FOREIGN KEY (order_id) REFERENCES orders(order_id)
)
;

ALTER TABLE order_payments
ADD CONSTRAINT payments_status_check CHECK (status IN ('PENDING', 'APPROVED', 'FAILED', 'REFUNDED'));
/


CREATE TABLE invoices (
  invoice_id    NUMBER DEFAULT invoice_id_seq.NEXTVAL,
  customer_id   NUMBER,
  first_name    VARCHAR2(50),
  last_name     VARCHAR2(50),
  nip           NUMBER(10),
  company_name  VARCHAR2(50),
  order_value   NUMBER,
  vat_value     NUMBER,
  CONSTRAINT invoices_pk PRIMARY KEY (invoice_id),
  CONSTRAINT invoices_fk FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
  
);
/*
CREATE TABLE book_covers (
  cover_id      NUMBER DEFAULT book_cover_id_seq.NEXTVAL,
  product_id       NUMBER,
  cover_image   BLOB,
  CONSTRAINT book_covers_pk PRIMARY KEY (cover_id),
  CONSTRAINT book_covers_fk FOREIGN KEY (product_id) REFERENCES products (product_id)
);
*/
------------------------------------------------------------
ALTER TABLE book_authors
    ADD CONSTRAINT book_authors_authors_fk FOREIGN KEY ( author_id )
        REFERENCES authors ( author_id );

ALTER TABLE book_authors
    ADD CONSTRAINT book_authors_prod_fk FOREIGN KEY ( product_id )
        REFERENCES products ( product_id );

ALTER TABLE publishing_house_books
    ADD CONSTRAINT pub_hb_prod_fk FOREIGN KEY ( product_id )
        REFERENCES products ( product_id );

ALTER TABLE publishing_house_books
    ADD CONSTRAINT pub_hb_pub_fk FOREIGN KEY ( publishing_id )
        REFERENCES publishings ( publishing_id );
/

ALTER TABLE employees
    ADD CONSTRAINT employees_dep_fk FOREIGN KEY ( department_id )
        REFERENCES departments ( department_id );

ALTER TABLE order_details
    ADD CONSTRAINT od_prod_fk FOREIGN KEY ( product_id )
        REFERENCES products ( product_id );

ALTER TABLE order_details
    ADD CONSTRAINT od_orders_fk FOREIGN KEY ( order_id )
        REFERENCES orders ( order_id );

ALTER TABLE orders
    ADD CONSTRAINT orders_supp_fk FOREIGN KEY ( supplier_id )
        REFERENCES suppliers ( supplier_id );

ALTER TABLE orders
    ADD CONSTRAINT orders_emp_fk FOREIGN KEY ( employee_id )
        REFERENCES employees ( employee_id );

ALTER TABLE orders
    ADD CONSTRAINT orders_cust_fk FOREIGN KEY ( customer_id )
        REFERENCES customers ( customer_id );

ALTER TABLE bonuses
    ADD CONSTRAINT bonuses_employees_fk FOREIGN KEY (employee_id)
    REFERENCES employees (employee_id);
	
	
	


-------------------------------------------
/*
DROP TABLE publishings;

DROP TABLE publishing_house_books;

DROP TABLE authors;

DROP TABLE products;

DROP TABLE book_authors;

DROP TABLE suppliers;

DROP TABLE orders;

DROP TABLE order_details;

DROP TABLE employees;

DROP TABLE departments;

DROP TABLE customers;

*/


---------------------------------------------------

