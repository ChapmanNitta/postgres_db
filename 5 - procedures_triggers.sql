/*==============================================

Create stored procedures

================================================*/


-- Create stored procedure to allow users to add new flavors of ice cream

CREATE OR REPLACE FUNCTION add_flavor(
  p_name IN VARCHAR,
  p_description IN VARCHAR,
  p_price IN DECIMAL
) RETURNS VOID LANGUAGE plpgsql
AS
$proc$
BEGIN
  INSERT INTO flavor(name, description, price)
  VALUES(p_name, p_description, p_price);
END;
$proc$;

START TRANSACTION;
DO
  $$
    BEGIN
      EXECUTE add_flavor('Candy Ripper', 'Splitz Dark Pretzel ice cream, peanut butter stracciatella, chocolate covered peanuts, caramel swirl.', 11.99);
    END;
  $$;
COMMIT TRANSACTION;

-- Create stored procedure to allow users to perform an upsert against inventory at a specified locations

CREATE OR REPLACE FUNCTION update_inventory(
  p_distributor_name IN VARCHAR,
  p_flavor_name IN VARCHAR,
  p_quantity IN INT
) RETURNS VOID LANGUAGE plpgsql
AS
$proc$
DECLARE
  v_distributor_id INT;
  v_flavor_id INT;
BEGIN
  SELECT distributor_id
  INTO v_distributor_id
  FROM distributor
  WHERE name = p_distributor_name;

  SELECT flavor_id
  INTO v_flavor_id
  FROM flavor
  WHERE name = p_flavor_name;

  INSERT INTO inventory(distributor_id, flavor_id, quantity)
  VALUES(v_distributor_id, v_flavor_id, p_quantity);
  EXCEPTION WHEN unique_violation THEN
  UPDATE inventory
  SET quantity = p_quantity
  WHERE distributor_id = v_distributor_id AND flavor_id = v_flavor_id;
END;
$proc$;

START TRANSACTION;
DO
  $$
    BEGIN
      EXECUTE update_inventory('Somerset Splits', 'Trap Lord', 2);
    END;
  $$;
COMMIT TRANSACTION;

-- Create stored procedure to allow users to perform an upsert against inventory at a specified locations
CREATE OR REPLACE FUNCTION validate_inventory_quantity()
RETURNS TRIGGER LANGUAGE plpgsql
AS
$trigfunc$
BEGIN

  IF NEW.quantity < 0 THEN
    RAISE EXCEPTION USING MESSAGE = 'Inventory quantity can not be less than 0',
    ERRCODE = 22000;
  END IF;
  RETURN NEW;
END;
$trigfunc$;

CREATE TRIGGER inventory_qty_trg
BEFORE UPDATE OR INSERT ON inventory
FOR EACH ROW
EXECUTE PROCEDURE validate_inventory_quantity();

START TRANSACTION;
DO
  $$
    BEGIN
      EXECUTE update_inventory('Somerset Splits', 'Trap Lord', -2);
    END;
  $$;
COMMIT TRANSACTION;
