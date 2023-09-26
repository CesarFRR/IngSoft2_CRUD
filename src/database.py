import mysql.connector
local = False
config = {
    'user': 'CesarFRR',
    'password': 'labcrud123',
    'host': 'CesarFRR.mysql.pythonanywhere-services.com',
    'database': 'CesarFRR$lab_crud'  # Puerto predeterminado de MySQL
}

localConfig = {
    'user': 'root',
    'password': 'labcrud123456',
    'host': 'localhost',  # Nombre o dirección IP del servidor MySQL
    'port': 3306,
    'database': 'lab_crud'  # Puerto predeterminado de MySQL
}

if local:
    database = mysql.connector.connect(**localConfig)
else:
    database = mysql.connector.connect(**config)


#print('BBDD conectada!!', "Modo localhost!" if local else "Modo pythonanywhere!")
