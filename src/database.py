import mysql.connector

config = {
    'user': 'CesarFRR',
    'password': 'labcrud123',
    'host': 'CesarFRR.mysql.pythonanywhere-services.com',
    'database': 'CesarFRR$lab_crud'  # Puerto predeterminado de MySQL
}
database = mysql.connector.connect(**config)




print('BBDD conectada!!')