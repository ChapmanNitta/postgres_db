
/*==============================================

Creates queries for answering business questions

================================================*/

-- Query 1 - This query returns a list of all customers that have placed an order
-- with 1900 Ice Cream, the number of orders they've placed, the total amount of
-- revenue they've generated, and their average spend per order

SELECT
  a.first_name || ' ' || a.last_name as customer_name,
  COUNT(DISTINCT po.purchase_order_id) as orders,
  '$' || SUM(order_total) as lifetime_spend,
  AVG(order_total)::decimal(12,2) as average_order_price
FROM purchase_order po
LEFT JOIN account a
	ON po.account_id = a.account_id
GROUP BY customer_name
ORDER BY lifetime_spend DESC;


-- Query 2 - This query returns a full transactional list of all orders placed
-- by customers, their individual order details by line item, and their associated
-- pick up locations. This query can be thought of as a precursor for a mroe business friendly
-- order detail view

SELECT
	od.purchase_order_id,
	po.purchase_order_date,
	a.first_name || ' ' || a.last_name as customer_name,
	f.name as flavor,
	od.quantity line_item_quantity,
	od.price as lline_item_price,
	po.pick_up_date,
	d.name as distributor_name,
	po.picked_up_status
FROM order_details od
LEFT JOIN purchase_order po
	ON od.purchase_order_id = po.purchase_order_id
LEFT JOIN account a
	ON po.account_id = a.account_id
LEFT JOIN distributor d
 	ON po.distributor_id = d.distributor_id
LEFT JOIN flavor f
	ON od.flavor_id = f.flavor_id
ORDER BY purchase_order_date ASC;


-- Query 3 - This query utilizes the history table to return a list of distirbutors
-- who received new inventory over the course of the current month and then orders
-- them by who received the most new pints on average by flavor.

-- For the sake of having dummmy data to reference, run this code first:
START TRANSACTION;
DO
  $$
    BEGIN
      EXECUTE update_inventory('Somerset Splits', 'Trap Lord', 30);
	  EXECUTE update_inventory('Kurant Brew & Brew', 'Trap Lord', 40);
	  EXECUTE update_inventory('Reanimator Coffee', 'Trap Lord', 50);
    END;
  $$;
COMMIT TRANSACTION;



WITH change as (
	SELECT
	date_trunc('month', change_date) as restock_month,
	date_trunc('day', change_date) as restock_date,
	d.name as "distributor",
	f.name as flavor,
	ih.new_quantity - ih.old_quantity as new_quantity
	FROM inventory_history ih
	LEFT JOIN distributor d
	ON ih.distributor_id = d.distributor_id
	LEFT JOIN flavor f
	ON ih.flavor_id = f.flavor_id
	WHERE date_trunc('month', change_date) = date_trunc('month', current_date)
)

SELECT
	restock_month,
	distributor,
	flavor,
	FLOOR(AVG(change.new_quantity)) as average_stock_added
FROM change
GROUP BY restock_month, distributor, flavor
ORDER BY average_stock_added DESC;
