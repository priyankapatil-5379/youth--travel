import mysql.connector

try:
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="askl",
        database="youth-travel"
    )
    cursor = conn.cursor()

    # Find foreign key for receiver_id
    cursor.execute("""
        SELECT CONSTRAINT_NAME 
        FROM information_schema.KEY_COLUMN_USAGE 
        WHERE TABLE_SCHEMA = 'youth-travel' 
          AND TABLE_NAME = 'messages' 
          AND COLUMN_NAME = 'receiver_id'
          AND REFERENCED_TABLE_NAME IS NOT NULL
    """)
    res = cursor.fetchone()
    if res:
        fk_name = res[0]
        print(f"Dropping FK for receiver_id: {fk_name}")
        cursor.execute(f"ALTER TABLE messages DROP FOREIGN KEY {fk_name}")

    # Find foreign key for sender_id
    cursor.execute("""
        SELECT CONSTRAINT_NAME 
        FROM information_schema.KEY_COLUMN_USAGE 
        WHERE TABLE_SCHEMA = 'youth-travel' 
          AND TABLE_NAME = 'messages' 
          AND COLUMN_NAME = 'sender_id'
          AND REFERENCED_TABLE_NAME IS NOT NULL
    """)
    res = cursor.fetchone()
    if res:
        fk_name = res[0]
        print(f"Dropping FK for sender_id: {fk_name}")
        cursor.execute(f"ALTER TABLE messages DROP FOREIGN KEY {fk_name}")

    # Now drop the columns
    try:
        cursor.execute("ALTER TABLE messages DROP COLUMN receiver_id")
        print("Dropped receiver_id column")
    except Exception as e:
        print("Could not drop receiver_id:", e)

    try:
        cursor.execute("ALTER TABLE messages DROP COLUMN sender_id")
        print("Dropped sender_id column")
    except Exception as e:
        print("Could not drop sender_id:", e)

    conn.commit()
    cursor.close()
    conn.close()
    print("Database patched successfully!")

except Exception as e:
    print(f"Error: {e}")
