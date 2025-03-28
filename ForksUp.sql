-- DROP TABLE IF EXISTS Admin_Actions;
-- DROP TABLE IF EXISTS Order_Items;
-- DROP TABLE IF EXISTS Orders;
-- DROP TABLE IF EXISTS Reservations;
-- DROP TABLE IF EXISTS Discount_Codes;
-- DROP TABLE IF EXISTS Menu_Items;
-- DROP TABLE IF EXISTS Restaurant_Cuisine;
-- DROP TABLE IF EXISTS Cuisine_Tags;
-- DROP TABLE IF EXISTS Restaurants;
-- DROP TABLE IF EXISTS Users;

-- -- Users Table
-- CREATE TABLE Users (
--     user_id INTEGER PRIMARY KEY AUTOINCREMENT,
--     username TEXT UNIQUE NOT NULL,
--     password_hash TEXT NOT NULL,
--     email TEXT UNIQUE NOT NULL,
--     phone TEXT NOT NULL,
--     profile_picture TEXT,  -- Store image path or Base64
--     role TEXT CHECK(role IN ('user', 'admin')) NOT NULL
-- );

-- -- Restaurants Table
-- CREATE TABLE Restaurants (
--     restaurant_id INTEGER PRIMARY KEY AUTOINCREMENT,
--     name TEXT NOT NULL,
--     location TEXT NOT NULL,
--     status TEXT CHECK(status IN ('Open', 'Closed')) NOT NULL DEFAULT 'Open',
--     admin_id INTEGER NOT NULL,
--     FOREIGN KEY (admin_id) REFERENCES Users(user_id) ON DELETE CASCADE
-- );

-- -- Cuisine Tags Table
-- CREATE TABLE Cuisine_Tags (
--     cuisine_id INTEGER PRIMARY KEY AUTOINCREMENT,
--     name TEXT UNIQUE NOT NULL
-- );

-- -- Join Table: Restaurant_Cuisine (Many-to-Many)
-- CREATE TABLE Restaurant_Cuisine (
--     restaurant_id INTEGER NOT NULL,
--     cuisine_id INTEGER NOT NULL,
--     PRIMARY KEY (restaurant_id, cuisine_id),
--     FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id) ON DELETE CASCADE,
--     FOREIGN KEY (cuisine_id) REFERENCES Cuisine_Tags(cuisine_id) ON DELETE CASCADE
-- );

-- -- Menu Items Table
-- CREATE TABLE Menu_Items (
--     item_id INTEGER PRIMARY KEY AUTOINCREMENT,
--     restaurant_id INTEGER NOT NULL,
--     name TEXT NOT NULL,
--     description TEXT,
--     price REAL NOT NULL CHECK(price > 0),
--     availability BOOLEAN DEFAULT 1, -- 1 = Available, 0 = Not Available
--     FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id) ON DELETE CASCADE
-- );

-- -- Orders Table
-- CREATE TABLE Orders (
--     order_id INTEGER PRIMARY KEY AUTOINCREMENT,
--     user_id INTEGER NOT NULL,
--     restaurant_id INTEGER NOT NULL,
--     order_code TEXT UNIQUE NOT NULL,
--     total_amount REAL NOT NULL CHECK(total_amount >= 0),
--     discount_code TEXT,
--     status TEXT CHECK(status IN ('Pending', 'Confirmed', 'Delivered', 'Canceled')) DEFAULT 'Pending',
--     created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
--     FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
--     FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id) ON DELETE CASCADE,
--     FOREIGN KEY (discount_code) REFERENCES Discount_Codes(code) ON DELETE SET NULL
-- );

-- -- Order_Items Table (Many-to-Many between Orders and Menu_Items)
-- CREATE TABLE Order_Items (
--     order_item_id INTEGER PRIMARY KEY AUTOINCREMENT,
--     order_id INTEGER NOT NULL,
--     item_id INTEGER NOT NULL,
--     quantity INTEGER NOT NULL CHECK(quantity > 0),
--     FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
--     FOREIGN KEY (item_id) REFERENCES Menu_Items(item_id) ON DELETE CASCADE
-- );

-- CREATE TABLE Reservations (
--     reservation_id INTEGER PRIMARY KEY AUTOINCREMENT,
--     user_id INTEGER NOT NULL,
--     restaurant_id INTEGER NOT NULL,
--     reservation_code TEXT UNIQUE NOT NULL,
--     reservation_date DATE NOT NULL,
--     reservation_time TIME NOT NULL,
--     guests INTEGER NOT NULL CHECK(guests > 0),
--     status TEXT CHECK(status IN ('Pending', 'Confirmed', 'Canceled')) DEFAULT 'Pending',
--     FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
--     FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id) ON DELETE CASCADE
-- );

-- -- Discount Codes Table
-- CREATE TABLE Discount_Codes (
--     code TEXT PRIMARY KEY,
--     discount_percent INTEGER NOT NULL CHECK(discount_percent BETWEEN 1 AND 100),
--     expiry_date DATETIME NOT NULL,
--     conditions TEXT
-- );

-- -- Admin Actions Table (Optional for tracking admin activity)
-- CREATE TABLE Admin_Actions (
--     action_id INTEGER PRIMARY KEY AUTOINCREMENT,
--     admin_id INTEGER NOT NULL,
--     action TEXT NOT NULL,
--     timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
--     FOREIGN KEY (admin_id) REFERENCES Users(user_id) ON DELETE CASCADE
-- );

-- ALTER TABLE Reservations ADD COLUMN details TEXT;
-- ALTER TABLE Reservations ADD COLUMN transaction_code TEXT;
-- ALTER TABLE Menu_Items ADD COLUMN price_int INTEGER;
-- UPDATE Menu_Items SET price_int = CAST(price AS INTEGER);
-- ALTER TABLE Menu_Items DROP COLUMN price;
-- ALTER TABLE Menu_Items RENAME COLUMN price_int TO price;


-- -- Insert Restaurants
-- INSERT INTO Restaurants (name, location, status, admin_id) VALUES
-- ('Kolachi', 'Karachi', 'Open', 1),
-- ('Okara', 'Karachi', 'Open', 1),
-- ('Sakura', 'Karachi', 'Open', 1),
-- ('BBQ Tonight', 'Karachi', 'Open', 1),
-- ('Xanders', 'Karachi', 'Open', 1),
-- ('Del Frio', 'Karachi', 'Open', 1),
-- ('Dynasty', 'Karachi', 'Open', 1),
-- ('Butt Karahi', 'Karachi', 'Open', 1),
-- ('Buttlers Chocolate Chip', 'Karachi', 'Open', 1),
-- ('The Patio', 'Karachi', 'Open', 1);

-- -- Insert Cuisine Tags
-- INSERT INTO Cuisine_Tags (name) VALUES
-- ('Desi'),
-- ('Seafood'),
-- ('Japanese'),
-- ('Western'),
-- ('Chinese'),
-- ('Cafe');

-- -- Link Restaurants with Their Cuisine Types
-- INSERT INTO Restaurant_Cuisine (restaurant_id, cuisine_id) VALUES
-- (1, 1),  -- Kolachi (Desi)
-- (2, 2),  -- Okara (Seafood)
-- (3, 3),  -- Sakura (Japanese)
-- (4, 1),  -- BBQ Tonight (Desi)
-- (5, 4),  -- Xanders (Western)
-- (6, 4),  -- Del Frio (Western)
-- (7, 5),  -- Dynasty (Chinese)
-- (8, 1),  -- Butt Karahi (Desi)
-- (9, 6),  -- Buttler’s Chocolate Chip (Cafe)
-- (10, 4); -- The Patio (Western)

-- -- Insert Menu Items
-- INSERT INTO Menu_Items (restaurant_id, name, description, price, availability) VALUES
-- -- Kolachi (Desi)
-- (1, 'Butter Chicken', 'Creamy butter chicken curry', 1200, 1),
-- (1, 'Mutton Karahi', 'Traditional mutton karahi', 1600, 1),
-- (1, 'Chicken Biryani', 'Spiced rice with chicken', 800, 1),
-- (1, 'Chicken White Karahi', 'White sauce-based karahi', 1400, 1),
-- (1, 'Beef Nihari', 'Slow-cooked beef stew', 1000, 1),

-- -- Okara (Seafood)
-- (2, 'Mediterranean Mezza Platter', 'Assorted seafood platter', 2200, 1),
-- (2, 'Spicy Crab Linguine', 'Crab pasta with lemon and chervil', 2500, 1),
-- (2, 'Pan-Fried Salmon', 'Salmon with caperberry butter', 2800, 1),
-- (2, 'Grilled Tiger Prawns', 'Prawns with herb lemon butter sauce', 3200, 1),
-- (2, 'Charcoal Grilled Chicken', 'Grilled chicken with smoky flavor', 1500, 1),

-- -- Sakura (Japanese)
-- (3, 'Sushi and Sashimi', 'Fresh sushi and sashimi', 2000, 1),
-- (3, 'Teppanyaki', 'Grilled Japanese-style food', 2200, 1),
-- (3, 'Robatayaki', 'Japanese slow-grilled skewers', 1800, 1),
-- (3, 'Noodles and Rice', 'Traditional Japanese noodles and rice', 1300, 1),
-- (3, 'Matcha Ice-Cream', 'Green tea flavored ice-cream', 900, 1),

-- -- BBQ Tonight (Desi)
-- (4, 'Chicken Malai Boti', 'Creamy grilled chicken skewers', 900, 1),
-- (4, 'Lamb Chops', 'Juicy grilled lamb chops', 2500, 1),
-- (4, 'Chicken Dum Biryani', 'Fragrant biryani cooked with dum', 950, 1),
-- (4, 'Highway Chicken Karahi', 'Spicy highway-style karahi', 1600, 1),
-- (4, 'Paneer Tikka Masala', 'Spiced paneer curry', 1200, 1),

-- -- Xanders (Western)
-- (5, 'Rosemary Butter Noisette', 'Butter-seared steak with rosemary', 3200, 1),
-- (5, 'Grilled Chicken Alfredo Pesto Pasta', 'Pesto pasta with grilled chicken', 1400, 1),
-- (5, 'Crumbled Red Snapper', 'Red snapper with green herb sauce', 2800, 1),
-- (5, 'Pizza Toscana', 'Wood-fired pizza with Italian toppings', 1600, 1),
-- (5, 'Cajun Chicken Caesar Sandwich', 'Spicy chicken sandwich', 1200, 1),

-- -- Del Frio (Western)
-- (6, 'Club Sandwich', 'Classic multi-layered sandwich', 950, 1),
-- (6, 'Fettucine Alfredo', 'Creamy Alfredo pasta', 1200, 1),
-- (6, 'Grilled Chicken Steak', 'Grilled chicken breast with sauce', 1500, 1),
-- (6, 'BBQ Chicken Pizza', 'Pizza topped with BBQ chicken', 1400, 1),
-- (6, 'Tex-Mex Burger', 'Spicy Tex-Mex style burger', 1300, 1),

-- -- Dynasty (Chinese)
-- (7, 'Kung Pao Chicken', 'Spicy stir-fried chicken with peanuts', 1100, 1),
-- (7, 'Dragon Noodles', 'Spicy and savory Chinese noodles', 1200, 1),
-- (7, 'Thai Red Curry', 'Rich Thai curry with coconut milk', 1400, 1),
-- (7, 'Beef Broccoli Stir-Fry', 'Beef stir-fried with fresh broccoli', 1300, 1),
-- (7, 'Teppanyaki', 'Japanese-style grilled dish', 1500, 1),

-- -- Butt Karahi (Desi)
-- (8, 'Mutton Karahi', 'Rich and flavorful mutton karahi', 1800, 1),
-- (8, 'Desi Chicken Karahi', 'Traditional Pakistani chicken karahi', 1400, 1),
-- (8, 'Mutton Ribs', 'Slow-cooked mutton ribs', 2200, 1),
-- (8, 'Karaage Chicken', 'Japanese-style crispy chicken', 1200, 1),
-- (8, 'BBQ Platter', 'Assorted BBQ meats and kebabs', 2500, 1),

-- -- Buttler’s Chocolate Chip (Cafe)
-- (9, 'Hot Chocolate Lava Cake', 'Warm chocolate cake with molten center', 900, 1),
-- (9, 'Triple Chocolate Mousse Cake', 'Rich and creamy chocolate mousse', 1200, 1),
-- (9, 'Butlers Signature Sundae', 'Chocolate ice-cream sundae', 1100, 1),
-- (9, 'Chocolate Cheesecakes', 'Creamy chocolate-flavored cheesecake', 1300, 1),
-- (9, 'Lotus Biscoff Sundae', 'Sundae with Lotus Biscoff toppings', 1400, 1),

-- -- The Patio (Western)
-- (10, 'Cilbir Turkish Eggs', 'Turkish poached eggs with yogurt', 1000, 1),
-- (10, 'Chicken Mushroom Gratin', 'Baked chicken with mushroom sauce', 1400, 1),
-- (10, 'Steak Au Gratin', 'Baked beef steak with cheese', 2600, 1),
-- (10, 'Baked 3 Cheese Ravioli', 'Ravioli filled with three cheeses', 1800, 1),
-- (10, 'Chicken Waffle Sandwich', 'Crispy chicken between waffles', 1200, 1);

SELECT * FROM Restaurants;
SELECT * FROM Menu_Items;
SELECT * FROM Restaurant_Cuisine;