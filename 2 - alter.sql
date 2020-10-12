-- Add constraints and foreign keys to brick and mortar table
ALTER TABLE brick_and_mortar
ADD CONSTRAINT distributor_fk
FOREIGN KEY(distributor_id)
REFERENCES distributor(distributor_id);

-- Add constraints and foreign keys to online table;
ALTER TABLE online
ADD CONSTRAINT distributor_fk
FOREIGN KEY(distributor_id)
REFERENCES distributor(distributor_id);

-- Add constrains and foreign keys to purchase order table
ALTER TABLE purchase_order
ADD
	CONSTRAINT account_fk
	FOREIGN KEY(account_id)
	REFERENCES account(account_id),

ADD
	CONSTRAINT distributor_fk
	FOREIGN KEY(distributor_id)
	REFERENCES distributor(distributor_id);

-- Add constraints and foreign keys to order details table
ALTER TABLE order_details
ADD
  CONSTRAINT purchase_order_fk
  FOREIGN KEY(purchase_order_id)
  REFERENCES purchase_order(purchase_order_id),

ADD
  CONSTRAINT flavor_fk
  FOREIGN KEY(flavor_id)
  REFERENCES flavor(flavor_id);

-- Add constraints and foreign keys to sale table
ALTER TABLE sale
	ADD CONSTRAINT distributor_fk
	FOREIGN KEY(distributor_id)
	REFERENCES distributor(distributor_id);

-- Add constraints and foreign keys to sale details
ALTER TABLE sale_details
ADD
  CONSTRAINT sale_fk
  FOREIGN KEY(sale_id)
  REFERENCES sale(sale_id),

ADD
  CONSTRAINT flavor_fk
  FOREIGN KEY(flavor_id)
  REFERENCES flavor(flavor_id);

-- Add constraints and foreign keys to inventory table
ALTER TABLE inventory
ADD
  CONSTRAINT distributor_fk
  FOREIGN KEY(distributor_id)
  REFERENCES distributor(distributor_id),

ADD
  CONSTRAINT flavor_fk
  FOREIGN KEY(flavor_id)
  REFERENCES flavor(flavor_id);
