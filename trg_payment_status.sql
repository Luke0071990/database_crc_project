create or replace TRIGGER trg_payment_status
	AFTER UPDATE ON order_payments
	FOR EACH ROW
	WHEN (NEW.status = 'APPROVED')
	DECLARE
		v_order_status orders.status%TYPE;
	BEGIN
		SELECT status
		INTO v_order_status
		FROM orders
		WHERE order_id = :NEW.order_id;

		IF v_order_status = 'SHIPPED' THEN
			RAISE_APPLICATION_ERROR(-20001, 'Nie można zmienić statusu zamówienia, które zostało już wysłane.');
		END IF;

		IF v_order_status = 'DELIVERED' THEN
			RAISE_APPLICATION_ERROR(-20002, 'Nie można zmienić statusu zamówienia, które zostało już dostarczone.');
		END IF;

		IF v_order_status = 'CANCELLED' THEN
			RAISE_APPLICATION_ERROR(-20003, 'Nie można zmienić statusu zamówienia, które zostało anulowane.');
		END IF;


        UPDATE orders
		SET shipped_date = :NEW.payment_date,
		    status = 'SHIPPED'
		WHERE order_id = :NEW.order_id;
	END trg_payment_status;