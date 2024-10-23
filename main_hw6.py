# HOMEWORK 6
#  CS 457 

import psycopg

# Credentials Information
hostname = 'localhost'
database = 'homework 5'
username = 'postgres'
pwd = 'Pitosa1@'
port_id = 5432

# Function for connection to database, making a connection object
def connect_db():
    try:
        conn = psycopg.connect(
            host = hostname,
            dbname = database,
            user = username,
            password = pwd,
            port = port_id)
        print("Successful connection to database.")
        return conn
    except Exception as e:
        print(f"Error connecting: {e}")
        return None

# Function for new food into the food_intake table
def log_food_intake(conn):
    intake_id = input("Enter random 4 number id: ") #
    fdc_id = input("Enter food fdc_id: ") # testing 319878 hummus, 325734 white bread
    date_of_eating = input("Enter date (YYYY-MM-DD): ") # testing 2024-10-13

    try:
        with conn.cursor() as cur:
            query = "INSERT INTO food_intake (intake_id, fdc_id, date_of_eating) VALUES (%s, %s, %s); "
            cur.execute(query, (intake_id, fdc_id, date_of_eating))
            conn.commit() # Commit changes to database
            print("\nSuccessful logging")
    except Exception as e:
        print(f"Error logging: {e}")

# Function for fetching macronutrient_names from food_intake JOINING food JOINING nutrient table
def get_nutrient_totals(conn):
    date_of_eating = input("Enter date of eating (YYYY-MM-DD): ") #testing dates: 2024-10-13, 2024-10-05
    try:
        with conn.cursor() as cur:
            query = """ 
            SELECT food.description, nutrient.macronutrient_names
            FROM food_intake
            JOIN food on food_intake.fdc_id = food.fdc_id
            JOIN food_nutrient on food.fdc_id = food_nutrient.fdc_id
            JOIN nutrient on food_nutrient.nutrient_id = nutrient.nutrient_id
            WHERE food_intake.date_of_eating = %s
            """
            cur.execute(query, (date_of_eating, ))
            results = cur.fetchall()
            
            if results:
                print("Getting nutrient totals: ")
                for row in results:
                    print(row)
            else:
                print("No nutrient totals.")
    except Exception as e:
        print(f"Error fetching nutrient data: {e}")


# Main Function
def main():
    conn = connect_db()
    try:
        if conn: # after successful connection
            while True:
                print("\n-- M E N U --") # terminal UI
                print("1.Log food")
                print("2. Get nutrient totals")
                print("3. Exit")
                choice = input("Enter number of your choice: ")

                if choice == '1': # log food
                    log_food_intake(conn)
                elif choice == '2': # get nutrients
                    get_nutrient_totals(conn)
                elif choice == '3': # exit, break out of the loop, connection is closed in Finally
                    print("Exiting.")
                    break 
                else:
                    print("invalid number, please try again.")
    finally:
        if conn: # ensure connection is closed
            conn.close() 


if __name__ == '__main__':
    main()




# #testing function for fetching data from food_intake table
# def fetch_food_intake(conn):
#     try:
#         with conn.cursor() as cur: # cursor for fetching
#             cur.execute("SELECT * FROM food_intake")
#             for row in cur.fetchall():
#                 print(row)
#     except Exception as e:
#         print(f"Error executing query: {e}")