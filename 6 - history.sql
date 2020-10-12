/*==============================================

Create the history table and associated trigger

================================================*/

CREATE TABLE inventory_history(
  inventory_history_id SERIAL PRIMARY KEY,
  distributor_id INT NOT NULL,
  flavor_id INT NOT NULL,
  old_quantity INT NOT NULL,
  new_quantity INT NOT NULL,
  change_date TIMESTAMP NOT NULL
);

ALTER TABLE inventory_history
ADD CONSTRAINT inventory_fk
FOREIGN KEY(inventory_history_id)
REFERENCES inventory(inventory_id);


CREATE OR REPLACE FUNCTION update_inventory_history()
RETURNS TRIGGER LANGUAGE plpgsql
AS $trigfunc$
BEGIN
  IF OLD.quantity <> NEW.quantity THEN
    INSERT INTO inventory_history(distributor_id, flavor_id, old_quantity, new_quantity, change_date)
    VALUES(
      NEW.distributor_id,
      NEW.flavor_id,
      OLD.quantity,
      NEW.quantity,
      NOW());
  END IF;
  RETURN NEW;
END;
$trigfunc$;

CREATE TRIGGER inventory_history_trg
AFTER UPDATE ON inventory
FOR EACH ROW
EXECUTE PROCEDURE update_inventory_history();

START TRANSACTION;
DO
  $$
    BEGIN
      EXECUTE update_inventory('Somerset Splits', 'Trap Lord', 5);
    END;
  $$;
COMMIT TRANSACTION;

SELECT *
FROM inventory_history;
