extern "C"
{
#include "sqlite3.h"
}
#include <iostream>
#include <vector>
#include <string>
#include <functional>
#include <sstream> // For to_string alternatives
#include <ctime>
#include <iomanip>
#include <algorithm>
using namespace std;

class Database
{
public:
    sqlite3 *db;
    Database(const string &db_name)
    {
        if (sqlite3_open(db_name.c_str(), &db) != SQLITE_OK)
        {
            cerr << "Error opening database: " << sqlite3_errmsg(db) << endl;
        }
    }
   // Getter function to provide access to sqlite3* instance
    sqlite3 *getDB()
    {
        return db;
    }

    // Show all data
    void showAllData(const string &tableName)
    {
        string sql = "SELECT * FROM " + tableName + ";";
        sqlite3_stmt *stmt;

        if (sqlite3_prepare_v2(db, sql.c_str(), -1, &stmt, nullptr) != SQLITE_OK)
        {
            cerr << "SQL error: " << sqlite3_errmsg(db) << endl;
            return;
        }

        int columnCount = sqlite3_column_count(stmt);
        cout << "Data from table: " << tableName << endl;
        cout << "-----------------------------------" << endl;

        while (sqlite3_step(stmt) == SQLITE_ROW)
        {
            for (int i = 0; i < columnCount; i++)
            {
                const char *columnValue = reinterpret_cast<const char *>(sqlite3_column_text(stmt, i));
                cout << (columnValue ? columnValue : "NULL") << " | ";
            }
            cout << endl;
        }

        sqlite3_finalize(stmt);
    }

    ~Database()
    {
        sqlite3_close(db);
    }
};

// Utility function for error-safe to_string
string safe_to_string(int value)
{
    ostringstream oss;
    oss << value;
    return oss.str();
}

// User Class
class User
{
public:
    int user_id;
    string username;
    string password_hash;
    string email;
    string phone;
    string profile_picture;
    vector<string> order_history;
    vector<string> reservation_history;
    vector<string> current_orders;
    vector<string> current_reservations;
    vector<pair<string, int>> cart;

    User() : user_id(0), username(""), password_hash(""), email(""), phone(""), profile_picture("") {}

    // Hash Password
    static string hashPassword(const string &password)
    {
        hash<string> hasher;
        size_t hashedValue = hasher(password);
        ostringstream oss;
        oss << hashedValue;
        return oss.str();
    }

    // Add a user
    static void addUser(Database &db, const string &username, const string &password, const string &email,
                        const string &phone, const string &profile_picture, const string &role)
    {
        string hashedPassword = hashPassword(password);
        string sql = "INSERT INTO Users (username, password_hash, email, phone, profile_picture, role) VALUES (?, ?, ?, ?, ?, ?);";
        sqlite3_stmt *stmt;

        if (sqlite3_prepare_v2(db.db, sql.c_str(), -1, &stmt, nullptr) != SQLITE_OK)
        {
            cerr << "SQL error: " << sqlite3_errmsg(db.db) << endl;
            return;
        }

        sqlite3_bind_text(stmt, 1, username.c_str(), -1, SQLITE_STATIC);
        sqlite3_bind_text(stmt, 2, hashedPassword.c_str(), -1, SQLITE_STATIC);
        sqlite3_bind_text(stmt, 3, email.c_str(), -1, SQLITE_STATIC);
        sqlite3_bind_text(stmt, 4, phone.c_str(), -1, SQLITE_STATIC);
        sqlite3_bind_text(stmt, 5, profile_picture.c_str(), -1, SQLITE_STATIC);
        sqlite3_bind_text(stmt, 6, role.c_str(), -1, SQLITE_STATIC);

        if (sqlite3_step(stmt) == SQLITE_DONE)
        {
            cout << "User added successfully!" << endl;
        }
        else
        {
            cerr << "Error adding user: " << sqlite3_errmsg(db.db) << endl;
        }

        sqlite3_finalize(stmt);
    }

    // Login Function
    bool login(Database &db, const string &input_username, const string &input_password)
    {
        string sql = "SELECT user_id, password_hash, email, phone, profile_picture FROM Users WHERE username = ?;";
        sqlite3_stmt *stmt;
        if (sqlite3_prepare_v2(db.db, sql.c_str(), -1, &stmt, nullptr) != SQLITE_OK)
        {
            cerr << "SQL error: " << sqlite3_errmsg(db.db) << endl;
            return false;
        }
        sqlite3_bind_text(stmt, 1, input_username.c_str(), -1, SQLITE_STATIC);

        if (sqlite3_step(stmt) == SQLITE_ROW)
        {
            user_id = sqlite3_column_int(stmt, 0);
            string storedPassword = reinterpret_cast<const char *>(sqlite3_column_text(stmt, 1));
            if (storedPassword == hashPassword(input_password))
            {
                username = input_username;
                email = (sqlite3_column_text(stmt, 2) ? reinterpret_cast<const char *>(sqlite3_column_text(stmt, 2)) : "N/A");
                phone = (sqlite3_column_text(stmt, 3) ? reinterpret_cast<const char *>(sqlite3_column_text(stmt, 3)) : "N/A");
                profile_picture = (sqlite3_column_text(stmt, 4) ? reinterpret_cast<const char *>(sqlite3_column_text(stmt, 4)) : "N/A");

                cout << "Login successful for user: " << username << endl;
                sqlite3_finalize(stmt);
                return true;
            }
            else
            {
                cout << "Incorrect password!" << endl;
            }
        }
        else
        {
            cout << "User not found!" << endl;
        }
        sqlite3_finalize(stmt);
        return false;
    }

    // View Profile
    void viewProfile() const
    {
        cout << "User Profile:\n";
        cout << "Username: " << username << "\nEmail: " << email << "\nPhone: " << phone << "\n";

        cout << "Order History:\n";
        if (order_history.empty())
        {
            cout << "No orders placed yet.\n";
        }
        else
        {
            for (const auto &order : order_history)
                cout << order << "\n";
        }

        cout << "Reservation History:\n";
        if (reservation_history.empty())
        {
            cout << "No reservations made yet.\n";
        }
        else
        {
            for (const auto &reservation : reservation_history)
                cout << reservation << "\n";
        }
    }

    // Function to delete a user by username
    bool deleteUserByUsername(Database &db, const string &username)
    {
        // SQL query to delete a user by username
        string sql = "DELETE FROM Users WHERE username = ?;";
        sqlite3_stmt *stmt;

        // Prepare the statement
        if (sqlite3_prepare_v2(db.db, sql.c_str(), -1, &stmt, nullptr) != SQLITE_OK)
        {
            cerr << "SQL error: " << sqlite3_errmsg(db.db) << endl;
            return false;
        }

        // Bind the username to the query
        sqlite3_bind_text(stmt, 1, username.c_str(), -1, SQLITE_STATIC);

        // Execute the query and check the result
        if (sqlite3_step(stmt) != SQLITE_DONE)
        {
            cerr << "Error deleting user: " << sqlite3_errmsg(db.db) << endl;
            sqlite3_finalize(stmt);
            return false;
        }

        // Notify that the user has been deleted
        cout << "User '" << username << "' deleted successfully!" << endl;

        // Finalize the statement
        sqlite3_finalize(stmt);
        return true;
    }
};
class MenuItem
{
public:
    int item_id;
    string name;
    string description;
    float price;

    MenuItem(int id, const string &n, const string &desc, float p)
        : item_id(id), name(n), description(desc), price(p) {}

    static void displayMenu(Database &db, int restaurant_id)
    {
        string sql = "SELECT * FROM Menu_Items WHERE restaurant_id = ?;";
        sqlite3_stmt *stmt;
        if (sqlite3_prepare_v2(db.db, sql.c_str(), -1, &stmt, nullptr) != SQLITE_OK)
        {
            cerr << "SQL error: " << sqlite3_errmsg(db.db) << endl;
            return;
        }
        sqlite3_bind_int(stmt, 1, restaurant_id);
        cout << "Menu:\n";
        while (sqlite3_step(stmt) == SQLITE_ROW)
        {
            string name = reinterpret_cast<const char *>(sqlite3_column_text(stmt, 2));
            float price = static_cast<float>(sqlite3_column_double(stmt, 5));
            cout << "Dish: " << name << ", Price: " << price << endl;
        }
        sqlite3_finalize(stmt);
    }
};

// Restaurant Class
class Restaurant
{
public:
    int restaurant_id;
    string name;
    string location;
    string status;

    Restaurant(int id, const string &n, const string &loc, const string &stat)
        : restaurant_id(id), name(n), location(loc), status(stat) {}

    void displayDetails() const
    {
        cout << "Restaurant: " << name << " | Location: " << location << " | Status: " << status << endl;
    }

    // Fetch 10 restaurants (for catalogue)
    static void fetchRestaurants(sqlite3 *db)
    {
        string sql = "SELECT restaurant_id, name, location, status FROM Restaurants LIMIT 10;";
        sqlite3_stmt *stmt;

        if (sqlite3_prepare_v2(db, sql.c_str(), -1, &stmt, nullptr) != SQLITE_OK)
        {
            cerr << "SQL error: " << sqlite3_errmsg(db) << endl;
            return;
        }

        cout << "\n--- Restaurant Catalogue ---\n";
        while (sqlite3_step(stmt) == SQLITE_ROW)
        {
            int id = sqlite3_column_int(stmt, 0);
            string name = reinterpret_cast<const char *>(sqlite3_column_text(stmt, 1));
            string location = reinterpret_cast<const char *>(sqlite3_column_text(stmt, 2));
            string status = reinterpret_cast<const char *>(sqlite3_column_text(stmt, 3));

            cout << "ID: " << id << " | " << name << " | " << location << " | Status: " << status << endl;
        }

        sqlite3_finalize(stmt);
    }

    // Search restaurants by name (search bar)
    static void searchRestaurant(sqlite3 *db, const string &keyword)
    {
        string sql = "SELECT restaurant_id, name, location, status FROM Restaurants WHERE name LIKE '%' || ? || '%';";
        sqlite3_stmt *stmt;

        if (sqlite3_prepare_v2(db, sql.c_str(), -1, &stmt, nullptr) != SQLITE_OK)
        {
            cerr << "SQL error: " << sqlite3_errmsg(db) << endl;
            return;
        }

        sqlite3_bind_text(stmt, 1, keyword.c_str(), -1, SQLITE_STATIC);
        bool found = false;

        cout << "\n--- Search Results ---\n";
        while (sqlite3_step(stmt) == SQLITE_ROW)
        {
            found = true;
            int id = sqlite3_column_int(stmt, 0);
            string name = reinterpret_cast<const char *>(sqlite3_column_text(stmt, 1));
            string location = reinterpret_cast<const char *>(sqlite3_column_text(stmt, 2));
            string status = reinterpret_cast<const char *>(sqlite3_column_text(stmt, 3));

            cout << "ID: " << id << " | " << name << " | " << location << " | Status: " << status << endl;
        }

        if (!found)
        {
            cout << "No restaurants found matching the search criteria." << endl;
        }

        sqlite3_finalize(stmt);
    }

    // Filter restaurants by cuisine type
    static void filterByCuisine(sqlite3 *db, const string &cuisineTag)
    {
        string sql = R"(
                SELECT R.restaurant_id, R.name, R.location, R.status 
                FROM Restaurants R
                JOIN Restaurant_Cuisine RC ON R.restaurant_id = RC.restaurant_id
                JOIN Cuisine_Tags CT ON RC.cuisine_id = CT.cuisine_id
                WHERE CT.name = ?;
            )";

        sqlite3_stmt *stmt;
        if (sqlite3_prepare_v2(db, sql.c_str(), -1, &stmt, nullptr) != SQLITE_OK)
        {
            cerr << "SQL error: " << sqlite3_errmsg(db) << endl;
            return;
        }

        sqlite3_bind_text(stmt, 1, cuisineTag.c_str(), -1, SQLITE_STATIC);
        bool found = false;

        cout << "\n--- Filtered Restaurants (" << cuisineTag << ") ---\n";
        while (sqlite3_step(stmt) == SQLITE_ROW)
        {
            found = true;
            int id = sqlite3_column_int(stmt, 0);
            string name = reinterpret_cast<const char *>(sqlite3_column_text(stmt, 1));
            string location = reinterpret_cast<const char *>(sqlite3_column_text(stmt, 2));
            string status = reinterpret_cast<const char *>(sqlite3_column_text(stmt, 3));

            cout << "ID: " << id << " | " << name << " | " << location << " | Status: " << status << endl;
        }

        if (!found)
        {
            cout << "No restaurants found with the selected cuisine." << endl;
        }

        sqlite3_finalize(stmt);
    }

    // Fetch detailed restaurant info by ID
    static void getRestaurantDetails(Database &db, int restaurantId)
    {
        string sql = R"(
                SELECT R.name, R.location, R.status, GROUP_CONCAT(CT.name, ', ') as cuisines
                FROM Restaurants R
                LEFT JOIN Restaurant_Cuisine RC ON R.restaurant_id = RC.restaurant_id
                LEFT JOIN Cuisine_Tags CT ON RC.cuisine_id = CT.cuisine_id
                WHERE R.restaurant_id = ?
                GROUP BY R.restaurant_id;
            )";

        sqlite3_stmt *stmt;
        if (sqlite3_prepare_v2(db.db, sql.c_str(), -1, &stmt, nullptr) != SQLITE_OK)
        {
            cerr << "SQL error: " << sqlite3_errmsg(db.db) << endl;
            return;
        }

        sqlite3_bind_int(stmt, 1, restaurantId);

        if (sqlite3_step(stmt) == SQLITE_ROW)
        {
            string name = reinterpret_cast<const char *>(sqlite3_column_text(stmt, 0));
            string location = reinterpret_cast<const char *>(sqlite3_column_text(stmt, 1));
            string status = reinterpret_cast<const char *>(sqlite3_column_text(stmt, 2));
            string cuisines = reinterpret_cast<const char *>(sqlite3_column_text(stmt, 3));

            cout << "\n--- Restaurant Details ---\n";
            cout << "Name: " << name << endl;
            cout << "Location: " << location << endl;
            cout << "Status: " << status << endl;
            cout << "Cuisines: " << cuisines << endl;

            // Display menu using MenuItem class
            cout << "\n--- Menu ---\n";
            MenuItem::displayMenu(db, restaurantId);
        }
        else
        {
            cout << "Restaurant not found." << endl;
        }

        sqlite3_finalize(stmt);
    }
};

// -----------------------------------Addition--------------------------------------------------
// Order Class
class Order
{
public:
    int orderID;
    int userID;
    int restaurantID;
    vector<pair<MenuItem, int>> items; // Stores selected menu items and their quantity
    float totalAmount;
    string orderDate;
    string orderCode;

    Order(int oID, int uID, int rID)
        : orderID(oID), userID(uID), restaurantID(rID), totalAmount(0)
    {
        orderDate = getCurrentDate(); // Auto-generate date
        orderCode = generateOrderCode();
    }

    // Generate a unique order code
    string generateOrderCode()
    {
        srand(time(0));
        stringstream ss;
        ss << "ORD" << orderID << userID << restaurantID << rand() % 10000;
        return ss.str();
    }

    // Function to get the current date and time
    string getCurrentDate()
    {
        time_t now = time(0);
        tm *ltm = localtime(&now);
        stringstream ss;
        ss << put_time(ltm, "%Y-%m-%d %H:%M:%S");
        return ss.str();
    }

    // Save the order to the database
    void saveOrder(Database &db)
    {
        string sql = "INSERT INTO Orders (user_id, restaurant_id, total_amount, created_at, order_code) VALUES (?, ?, ?, ?, ?);";
        sqlite3_stmt *stmt;

        if (sqlite3_prepare_v2(db.db, sql.c_str(), -1, &stmt, nullptr) != SQLITE_OK)
        {
            cerr << "SQL error: " << sqlite3_errmsg(db.db) << endl;
            return;
        }

        sqlite3_bind_int(stmt, 1, userID);
        sqlite3_bind_int(stmt, 2, restaurantID);
        sqlite3_bind_double(stmt, 3, totalAmount);
        sqlite3_bind_text(stmt, 4, orderDate.c_str(), -1, SQLITE_STATIC);
        sqlite3_bind_text(stmt, 5, orderCode.c_str(), -1, SQLITE_STATIC);

        if (sqlite3_step(stmt) == SQLITE_DONE)
        {
            orderID = sqlite3_last_insert_rowid(db.db);
            cout << "Order saved successfully!" << endl;
        }
        else
        {
            cerr << "Failed to save order." << endl;
        }

        sqlite3_finalize(stmt);
    }

    // Add item to order and save it to Order_Items table
    void addItem(Database &db, int itemID, int quantity, int restaurantID)
    {
        if (quantity <= 0)
        {
            cout << "Invalid quantity!" << endl;
            return;
        }
        cout << "Trying to add item ID: " << itemID << " from Restaurant ID: " << restaurantID << endl;
    
        string sql = "SELECT item_id, name, description, price FROM Menu_Items WHERE item_id = ? AND restaurant_id = ?;";
        sqlite3_stmt *stmt;
    
        if (sqlite3_prepare_v2(db.db, sql.c_str(), -1, &stmt, nullptr) != SQLITE_OK)
        {
            cerr << "SQL error: " << sqlite3_errmsg(db.db) << endl;
            return;
        }
    
        sqlite3_bind_int(stmt, 1, itemID);
        sqlite3_bind_int(stmt, 2, restaurantID);
    
        if (sqlite3_step(stmt) == SQLITE_ROW)
        {
            int fetchedID = sqlite3_column_int(stmt, 0);
            string name = reinterpret_cast<const char *>(sqlite3_column_text(stmt, 1));
            string description = reinterpret_cast<const char *>(sqlite3_column_text(stmt, 2));
            float price = sqlite3_column_double(stmt, 3);
    
            cout << "Fetched Item - ID: " << fetchedID << ", Name: " << name << ", Price: $" << price << endl;
    
            MenuItem item(fetchedID, name, description, price);
            items.push_back(make_pair(item, quantity));
            totalAmount += price * quantity;  // Update total in memory
    
            // Insert item into Order_Items table
            string insertSQL = "INSERT INTO Order_Items (order_id, item_id, quantity) VALUES (?, ?, ?);";
            sqlite3_stmt *insertStmt;
            if (sqlite3_prepare_v2(db.db, insertSQL.c_str(), -1, &insertStmt, nullptr) == SQLITE_OK)
            {
                sqlite3_bind_int(insertStmt, 1, orderID);
                sqlite3_bind_int(insertStmt, 2, itemID);
                sqlite3_bind_int(insertStmt, 3, quantity);
                sqlite3_step(insertStmt);
            }
            sqlite3_finalize(insertStmt);
    
            //Update total_amount in Orders table
            string updateSQL = "UPDATE Orders SET total_amount = ? WHERE order_id = ?;";
            sqlite3_stmt *updateStmt;
            if (sqlite3_prepare_v2(db.db, updateSQL.c_str(), -1, &updateStmt, nullptr) == SQLITE_OK)
            {
                sqlite3_bind_double(updateStmt, 1, totalAmount);
                sqlite3_bind_int(updateStmt, 2, orderID);
                sqlite3_step(updateStmt);
            }
            sqlite3_finalize(updateStmt);
    
            cout << quantity << " x " << name << " added to order." << endl;
        }
        else
        {
            cout << "Item not found!" << endl;
        }
    
        sqlite3_finalize(stmt);
    }
    

    // Remove item from the order
    void removeItem(Database &db, int itemID)
    {
        auto it = find_if(items.begin(), items.end(), [&](const pair<MenuItem, int> &item)
                          { return item.first.item_id == itemID; });
    
        if (it != items.end())
        {
            float itemTotal = it->first.price * it->second; // Get the amount to subtract
            totalAmount -= itemTotal; // Update total in memory
            items.erase(it); // Remove from cart list
    
            // Remove from Order_Items table
            string deleteSQL = "DELETE FROM Order_Items WHERE order_id = ? AND item_id = ?;";
            sqlite3_stmt *stmt;
            if (sqlite3_prepare_v2(db.db, deleteSQL.c_str(), -1, &stmt, nullptr) == SQLITE_OK)
            {
                sqlite3_bind_int(stmt, 1, orderID);
                sqlite3_bind_int(stmt, 2, itemID);
                sqlite3_step(stmt);
            }
            sqlite3_finalize(stmt);
    
            //  Update total_amount in Orders table
            string updateSQL = "UPDATE Orders SET total_amount = ? WHERE order_id = ?;";
            sqlite3_stmt *updateStmt;
            if (sqlite3_prepare_v2(db.db, updateSQL.c_str(), -1, &updateStmt, nullptr) == SQLITE_OK)
            {
                sqlite3_bind_double(updateStmt, 1, totalAmount);
                sqlite3_bind_int(updateStmt, 2, orderID);
                sqlite3_step(updateStmt);
            }
            sqlite3_finalize(updateStmt);
    
            cout << "Item removed from order.\n";
        }
        else
        {
            cout << "Item not found in order!\n";
        }
    }
    
    // Fetch an existing order from the database
    static Order fetchOrder(Database &db, int orderID)
    {
        string sql = "SELECT user_id, restaurant_id, total_amount, order_date, order_code FROM Orders WHERE order_id = ?;";
        sqlite3_stmt *stmt;

        if (sqlite3_prepare_v2(db.db, sql.c_str(), -1, &stmt, nullptr) != SQLITE_OK)
        {
            cerr << "SQL error: " << sqlite3_errmsg(db.db) << endl;
            return Order(-1, -1, -1);
        }

        sqlite3_bind_int(stmt, 1, orderID);
        Order order(-1, -1, -1);
        if (sqlite3_step(stmt) == SQLITE_ROW)
        {
            int userID = sqlite3_column_int(stmt, 0);
            int restaurantID = sqlite3_column_int(stmt, 1);
            float totalAmount = sqlite3_column_double(stmt, 2);
            string orderDate = reinterpret_cast<const char *>(sqlite3_column_text(stmt, 3));
            string orderCode = reinterpret_cast<const char *>(sqlite3_column_text(stmt, 4));
            order = Order(orderID, userID, restaurantID);
            order.totalAmount = totalAmount;
            order.orderCode = orderCode;
        }

        sqlite3_finalize(stmt);
        return order;
    }
    void orderDetails()
    {
        cout << "\n--- Order Details ---\n";
        cout << "Order ID: " << orderID << "\n";
        cout << "User ID: " << userID << "\n";
        cout << "Restaurant ID: " << restaurantID << "\n";
        cout << "Order Date: " << orderDate << "\n";
        cout << "Order Code: " << orderCode << "\n";
    }

    // Display current cart contents
    void viewCart()
    {
        cout << "\n--- Cart Items ---\n";
        if (items.empty())
        {
            cout << "Cart is empty.\n";
            return;
        }

        for (const auto &item : items)
        {
            cout << item.second << "x " << item.first.name << " - $" << (item.first.price * item.second) << endl;
        }
        cout << "Total Amount: $" << totalAmount << endl;
    }

    // Display final bill with breakdown
    void calculateBill()
    {
        cout << "\n--- Final Bill ---\n";
        float calculatedTotal = 0;
        for (const auto &item : items)
        {
            float itemTotal = item.first.price * item.second;
            cout << item.second << "x " << item.first.name << " - $" << itemTotal << endl;
            calculatedTotal += itemTotal;
        }
        cout << "Total Amount: $" << calculatedTotal << endl;
    }
};
// Class Reservation
class Reservation
{
public:
    int reservationID;
    int userID;
    int restaurantID;
    string reservationDate;
    string reservationTime;
    string details;
    string transactionCode;

    // Constructor
    Reservation(int uid, int rid, const string &date, const string &time, const string &det)
        : userID(uid), restaurantID(rid), reservationDate(date), reservationTime(time), details(det)
    {
        transactionCode = generateTransactionCode();
    }

    // Generate unique transaction code
    static string generateTransactionCode()
    {
        stringstream ss;
        time_t now = time(0);
        tm *ltm = localtime(&now);
    
        ss << "RSV" 
           << (1900 + ltm->tm_year) % 100  // Last two digits of the year
           << setw(2) << setfill('0') << ltm->tm_mon + 1  // Month
           << setw(2) << setfill('0') << ltm->tm_mday  // Day
           << ltm->tm_sec; // Only seconds to keep it minimal
    
        return ss.str();
    }

    // Store reservation in database
    void saveReservation(Database &db)
    {
        string sql = "INSERT INTO Reservations (user_id, restaurant_id, reservation_date, reservation_time, guests, reservation_code) VALUES (?, ?, ?, ?, ?, ?);";
        sqlite3_stmt *stmt;

        if (sqlite3_prepare_v2(db.db, sql.c_str(), -1, &stmt, nullptr) != SQLITE_OK)
        {
            cerr << "SQL error: " << sqlite3_errmsg(db.db) << endl;
            return;
        }

        sqlite3_bind_int(stmt, 1, userID);
        sqlite3_bind_int(stmt, 2, restaurantID);
        sqlite3_bind_text(stmt, 3, reservationDate.c_str(), -1, SQLITE_STATIC);
        sqlite3_bind_text(stmt, 4, reservationTime.c_str(), -1, SQLITE_STATIC);
        sqlite3_bind_text(stmt, 5, details.c_str(), -1, SQLITE_STATIC);
        sqlite3_bind_text(stmt, 6, transactionCode.c_str(), -1, SQLITE_STATIC);

        if (sqlite3_step(stmt) == SQLITE_DONE)
        {
            cout << "Reservation saved successfully!\n";
        }
        else
        {
            cerr << "Error saving reservation: " << sqlite3_errmsg(db.db) << endl;
        }

        sqlite3_finalize(stmt);
    }

    // Cancel reservation
    bool cancelReservation(Database &db)
    {
        string sql = "DELETE FROM Reservations WHERE reservation_id = ?;";
        sqlite3_stmt *stmt;

        if (sqlite3_prepare_v2(db.db, sql.c_str(), -1, &stmt, nullptr) != SQLITE_OK)
        {
            cerr << "SQL error: " << sqlite3_errmsg(db.db) << endl;
            return false;
        }

        sqlite3_bind_int(stmt, 1, reservationID);
        if (sqlite3_step(stmt) == SQLITE_DONE)
        {
            cout << "Reservation cancelled successfully.\n";
            sqlite3_finalize(stmt);
            return true;
        }
        else
        {
            cerr << "Error cancelling reservation: " << sqlite3_errmsg(db.db) << endl;
            sqlite3_finalize(stmt);
            return false;
        }
    }

    // Get reservation details
    void getReservationDetails() const
    {
        cout << "\n--- Reservation Details ---\n";
        cout << "Reservation ID: " << reservationID << "\n";
        cout << "User ID: " << userID << "\n";
        cout << "Restaurant ID: " << restaurantID << "\n";
        cout << "Date: " << reservationDate << "\n";
        cout << "Time: " << reservationTime << "\n";
        cout << "Details: " << details << "\n";
        cout << "Transaction Code: " << transactionCode << "\n";
    }
};

// Admin Class
class Admin
{
public:
    int admin_id;

    // Toggle restaurant open/close status
    void toggleRestaurantStatus(Database &db, int restaurantID)
    {
        string sql = "UPDATE Restaurants SET status = CASE WHEN status = 'Open' THEN 'Closed' ELSE 'Open' END WHERE restaurant_id = ?;";
        sqlite3_stmt *stmt;
        if (sqlite3_prepare_v2(db.db, sql.c_str(), -1, &stmt, nullptr) != SQLITE_OK)
        {
            cerr << "SQL error: " << sqlite3_errmsg(db.db) << endl;
            return;
        }

        sqlite3_bind_int(stmt, 1, restaurantID);
        if (sqlite3_step(stmt) == SQLITE_DONE)
        {
            cout << "Restaurant status toggled.\n";
        }
        else
        {
            cerr << "Error toggling status.\n";
        }
        sqlite3_finalize(stmt);
    }

    void updateMenu(Database &db, int item_id, const string &new_name, float new_price)
    {
        string sql = "UPDATE Menu_Items SET name = ?, price = ? WHERE item_id = ?;";
        sqlite3_stmt *stmt;
        if (sqlite3_prepare_v2(db.db, sql.c_str(), -1, &stmt, nullptr) != SQLITE_OK)
        {
            cerr << "SQL error: " << sqlite3_errmsg(db.db) << endl;
            return;
        }
        sqlite3_bind_text(stmt, 1, new_name.c_str(), -1, SQLITE_STATIC);
        sqlite3_bind_double(stmt, 2, new_price);
        sqlite3_bind_int(stmt, 3, item_id);
        if (sqlite3_step(stmt) == SQLITE_DONE)
        {
            cout << "Menu item updated successfully!" << endl;
        }
        else
        {
            cerr << "Error updating menu item: " << sqlite3_errmsg(db.db) << endl;
        }
        sqlite3_finalize(stmt);
    }
};

// Main Function
int main()
{
    Database db("forksup.db");
    User user;
    User::addUser(db, "new_user12", "password123", "user123@example.com", "1234567890", "pfp.jpeg", "user");
    user.login(db, "new_user12", "password123");
    // user.viewProfile();

    // // searh restaurant by cuisine tag
    // Restaurant::searchRestaurant(db.getDB(), "Pizza");
    // // search restaurant by restaurant name
    // Restaurant::searchRestaurant(db.getDB(), "Xanders");

    // Restaurant::getRestaurantDetails(db, 1);

    // MenuItem::displayMenu(db, 1);

    //-------------------------------Addition--------------------------------------------------------
    user.user_id = 1;
    int restaurantID = 2;
    Order order(1, user.user_id, restaurantID);
    order.saveOrder(db); // Save order in the database

    // Add items to the order
    order.addItem(db, 3, 2, 1); // Add 2 quantities of item ID 3
    order.addItem(db, 5, 1, 1); // Add 1 quantity of item ID 5

    // View order details
    order.orderDetails();

    Reservation res(user.user_id, 2, "2025-03-20", "19:00", "Table for 4 near window");
    res.saveReservation(db);
    res.getReservationDetails();

    // Admin admin;
    // // admin.updateMenu(db, 1, "Updated Dish", 12.99); // This line will edit the menu

    // User views their cart
    order.viewCart();

    // User removes an item from their order
    order.removeItem(db, 3);

    // User views their cart
    order.viewCart();


    // Calculate total billing amount
    order.calculateBill();

    // // Cancel a reservation
    // res.cancelReservation(db);

    // // Admin toggles restaurant status
    // admin.toggleRestaurantStatus(db, 1);

    // db.showAllData("Users");
    // db.showAllData("Restaurants");
    // db.showAllData("Menu_Items");
    db.showAllData("Orders");
    user.deleteUserByUsername(db, "new_user");
    user.deleteUserByUsername(db, "new_user12");

    return 0;
}