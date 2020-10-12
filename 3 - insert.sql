-- Insert data into account table
INSERT INTO account(email_address,first_name,last_name,account_created_date)
VALUES
  ('LuneaBush2734@gmail.com','Lunea','Bush','2019-01-26'),
  ('UlricF@temple.edu','Ulric','Fischer','2019-02-08'),
  ('bcollier@drexel.edu','Brenda','Collier','2019-02-26'),
  ('Ehart@hotmail.com','Eric','Hart','2019-03-18'),
  ('vladwilk@bu.edu','Vladimir','Wilkinson','2019-03-19'),
  ('breanna.french@comcast.net','Brenna','French','2019-04-06'),
  ('wmcmillan247@hotmail.com','Winter','Mcmillan','2019-04-27'),
  ('ffreeman@penn.edu','Forrest','Freeman','2019-08-16'),
  ('Sade.Pierce@gmail.com','Sade','Pierce','2019-10-14'),
  ('MiraSanders1219@gmail.com','Mira','Sanders','2019-12-19');

-- Insert data into Distributor Table
INSERT INTO distributor(name)
VALUES
  ('Herman''s Coffee'),
  ('Kurant Brew & Brew'),
  ('Liberty Kitchen'),
  ('Somerset Splits'),
  ('Reanimator Coffee'),
  ('Omoi Zakka Shop');

-- Insert data into brick and mortar table
INSERT INTO brick_and_mortar(distributor_id, address, address_secondary, city, state, zipcode)
VALUES
  (1, '1313 S 3rd St', NULL, 'Philadelphia', 'Pennsylvania', 19147),
  (2, '436 E Girard Ave', NULL, 'Philadelphia', 'Pennsylvania', 19125),
  (3, '1244 N Front St', NULL, 'Philadelphia', 'Pennsylvania', 19122),
  (4, '2600 E Somerset', NULL, 'Philadelphia', 'Pennsylvania', 19134),
  (5, '1523 E Susquehanna Ave', NULL, 'Philadelphia', 'Pennsylvania', 19122);

-- Insert data into online table
INSERT INTO online(distributor_id, website)
VALUES
  (6, 'www.omoionline.com');

-- Insert data into Flavor Table
INSERT INTO flavor(name, description, price)
VALUES
  ('Trap Lord', 'Dark chocholate ice cream, oreos, dark fudge swirl.', 11.99),
  ('Magical Mila', 'Cotton candy ice cream, bubble gum marshmallow, rainbow sprinkles.', 11.99),
  ('Cherry Pie Slide', 'Cherry ice cream, Italian amarena cherries, cherry pie crust crumb, dark fudge swirl.', 11.99),
  ('Ba-Gnar-Na Valley', 'Salted banana ice cream, dark chocholate covered walnut clusters, caramel swirl.', 11.99),
  ('AAA Vanilla', 'Roasted whole bean AAA Madagascar vanilla.', 14.99),
  ('Supertron', 'Butterscotch ice cream, chocolate chip cookie dough, gooey fudge brownie chunks, peanut butter swirl.', 11.99),
  ('Snickers Face Melt', 'Snickers nougat ice cream, dark chocolate stracciatella, roasted salted peanuts, caramel swirl.', 11.99),
  ('Super Snack Blast', 'Salted peanut butter ice cream, Ruffles potato chip-pretzel crunch clusters coated in white chocolate, dark fudge swirl.', 11.99),
  ('Yeti Lord', 'Extra brute chocolate peppermint ice cream, chocolate cookie pie chunks swirled with peppermint sugar cookie pie chunks, marshmallow cream poofs.', 11.99),
  ('Kevin''s World', 'Candy cane ice cream, white icing swirl with candy cane chips, sugar cookie pie chunks.', 11.99),
  ('Bloob Goblin', 'Cream cheese ice cream, blueberry compote, graham cracker crunch.', 11.99),
  ('Deep Gnar Blast', 'Snickers Bar malt ice cream, liquid cheesecake swirl, chocolate covered graham crackers.', 11.99),
  ('Cookie Gangster', 'Nutter Butter ice cream, chocolate chip cookie pie chunks, dark fudge swirl.', 11.99),
  ('Moon Wolf', 'Oreo cheesecake ice cream, funfetti cream cheese icing, dark chocolate crumb crunch.', 11.99),
  ('Carrot Cake Lord', 'Carrot ice cream, carrot cake chunks, butter toffee pecan crunch, graham cracker frosting swirl.', 11.99);

-- Insert data into Order table
INSERT INTO purchase_order(account_id, distributor_id, purchase_order_date , order_total, pick_up_date, picked_up_status)
VALUES
  (1, 1, '2019-01-26', 23.98, '2020-02-02','True'),
  (2, 1, '2019-02-10', 11.99, '2019-02-15','True'),
  (3, 3, '2019-02-27', 11.99, '2019-03-01','True'),
  (4, 2, '2019-03-18', 11.99, '2020-03-20','False'),
  (5, 4, '2019-03-21', 26.98, '2019-03-28','True'),
  (6, 3, '2019-04-06', 35.97, '2019-04-10','True'),
  (7, 4, '2019-04-27', 11.99, '2019-05-03','True'),
  (3, 2, '2019-08-19', 11.99, '2019-08-27','True'),
  (5, 3, '2019-10-14', 11.99, '2019-10-21','True'),
  (10, 1, '2019-12-19', 11.99, '2019-12-23','False');

-- Insert data into Order Details table
INSERT INTO order_details(purchase_order_id, flavor_id, quantity, price)
VALUES
  (1, 1, 1, 11.99),
  (1, 2, 1, 11.99),
  (2, 3, 1, 11.99),
  (3, 4, 1, 11.99),
  (4, 4, 1, 11.99),
  (5, 5, 1, 14.99),
  (5, 6, 1, 11.99),
  (6, 7, 1, 11.99),
  (6, 8, 1, 11.99),
  (6, 9, 1, 11.99),
  (7, 10, 1, 11.99),
  (8, 11, 1, 11.99),
  (9, 12, 1, 11.99),
  (10, 13, 1, 11.99);

-- Insert data into Sale table
INSERT INTO sale(distributor_id, sale_total, sale_date)
VALUES
  (1, 11.99, '2019-01-15'),
  (3, 23.98, '2019-02-21'),
  (1, 11.99, '2019-03-11'),
  (4, 35.97, '2019-05-11'),
  (2, 11.99, '2020-01-11');


-- Insert data into Sale detail table
INSERT INTO sale_details(sale_id, flavor_id, quantity, price)
VALUES
  (1, 1, 1, 11.99),
  (2, 3, 1, 11.99),
  (2, 4, 1, 11.99),
  (3, 5, 1, 11.99),
  (4, 8, 1, 11.99),
  (4, 9, 1, 11.99),
  (4, 10, 1, 11.99),
  (5, 14, 1, 11.99);

-- Insert data into Inventory table
INSERT INTO inventory (distributor_id, flavor_id, quantity)
SELECT distributor_id, flavor_id, floor(random()*(30-15+1))+15 FROM distributor CROSS JOIN flavor;

-- For the sake of this project, distributor #1 will only have inventory on hand this week. In order to speed up data population, I've just pretended that every distributor has either stocked
-- every flavor in the past and only
UPDATE inventory
SET quantity = 0
WHERE distributor_id != 1 OR flavor_id NOT IN (13,14,15);
