from datetime import datetime
from flask import Flask, render_template, request, redirect, url_for
import os
import database as db

template_dir = os.path.dirname(os.path.abspath(os.path.dirname(__file__)))
template_dir = os.path.join(template_dir, 'src', 'templates')

app = Flask(__name__, template_folder = template_dir)

#Rutas de la aplicación
@app.route('/')
def home(): return render_template('index.html')

# #Ruta para guardar usuarios en la bdd
# @app.route('/user', methods=['POST'])
# def addUser():
#     username = request.form['username']
#     name = request.form['name']
#     password = request.form['password']

#     if username and name and password:
#         cursor = db.database.cursor()
#         sql = "INSERT INTO users (username, name, password) VALUES (%s, %s, %s)"
#         data = (username, name, password)
#         cursor.execute(sql, data)
#         db.database.commit()
#     return redirect(url_for('home'))

# @app.route('/delete/<string:id>')
# def delete(id):
#     cursor = db.database.cursor()
#     sql = "DELETE FROM users WHERE id=%s"
#     data = (id,)
#     cursor.execute(sql, data)
#     db.database.commit()
#     return redirect(url_for('home'))

# @app.route('/edit/<string:id>', methods=['POST'])
# def edit(id):
#     username = request.form['username']
#     name = request.form['name']
#     password = request.form['password']

#     if username and name and password:
#         cursor = db.database.cursor()
#         sql = "UPDATE users SET username = %s, name = %s, password = %s WHERE id = %s"
#         data = (username, name, password, id)
#         cursor.execute(sql, data)
#         db.database.commit()
#     return redirect(url_for('home'))

@app.route('/persona')
def persona():
    print('PETICION /persona !!')
    cursor = db.database.cursor()
    cursor.execute("SELECT * FROM personas")
    myresult = cursor.fetchall()
    #Convertir los datos a diccionario
    insertObject = []
    columnNames = [column[0] for column in cursor.description]
    for record in myresult:
        insertObject.append(dict(zip(columnNames,  [x if x!=None else " " for x in record])))
    cursor.close()
    return render_template('persona.html', data=insertObject)




@app.route('/persona_add', methods=['POST'])
def persona_add():
    nombre = request.form['nombre']
    t_doc = request.form['t_doc']
    n_doc = int(request.form['n_doc'])
    nacimiento = datetime.strptime(request.form['nacimiento'], '%Y-%m-%d').date()
    sexo = request.form['sexo']
    tel_cel = request.form.get('tel_cel')
    vivienda_actual =  request.form['vivienda_actual']
    if all(x for x in request.form.values()):
        cursor = db.database.cursor()
        sql = "INSERT INTO personas (id, tipo_doc, nombre, fecha_nac,  sexo, telefono, vivienda_actual) VALUES (%s, %s, %s, %s, %s, %s, %s)"
        data= (n_doc, t_doc, nombre, nacimiento, sexo, tel_cel, vivienda_actual)
        cursor.execute(sql, data)
        db.database.commit()
    return redirect(url_for('persona'))



@app.route('/persona_edit/<string:id>', methods=["POST"])
def persona_edit(id):
    new_id = request.form['id']
    tipo_doc = request.form['tipo_doc']
    nombre = request.form['nombre']
    fecha_nac = request.form['fecha_nac']
    sexo = request.form['sexo']
    telefono = request.form['telefono']
    vivienda_actual = request.form['vivienda_actual']

    if all(x for x in request.form.values() if x not in {'telefono'}): #Telefono puede ser Null
        cursor = db.database.cursor()
        sql = "UPDATE personas SET id = %s, tipo_doc = %s, nombre = %s, fecha_nac = %s, sexo = %s, telefono=%s, vivienda_actual = %s WHERE id = %s"
        data = (new_id, tipo_doc, nombre, fecha_nac, sexo, telefono,vivienda_actual, id)
        cursor.execute(sql, data)
        db.database.commit()
    return redirect(url_for('persona'))


@app.route('/persona_delete/<string:id>', methods=['POST'])
def persona_delete(id):
    cursor = db.database.cursor()
    sql = "DELETE FROM personas WHERE id=%s"
    data = (id,)
    cursor.execute(sql, data)
    db.database.commit()
    return redirect(url_for('persona'))
 

@app.route('/vivienda')
def vivienda():
    cursor = db.database.cursor()
    cursor.execute("SELECT * FROM viviendas")
    myresult = cursor.fetchall()
    #Convertir los datos a diccionario
    insertObject = []
    columnNames = [column[0] for column in cursor.description]
    for record in myresult:
        print(record)
        insertObject.append(dict(zip(columnNames,record)))
    cursor.close()
    
    return render_template('vivienda.html', data=insertObject)


@app.route('/vivienda_edit/<string:id>', methods=['POST'])
def vivienda_edit(id):
    username = request.form['username']
    name = request.form['name']
    password = request.form['password']

    if username and name and password:
        cursor = db.database.cursor()
        sql = "UPDATE viviendas SET username = %s, name = %s, password = %s WHERE id = %s"
        data = (username, name, password, id)
        cursor.execute(sql, data)
        db.database.commit()
    return redirect(url_for('vivienda'))



@app.route('/vivienda_delete/<string:id>', methods=['POST'])
def vivienda_delete(id):
    cursor = db.database.cursor()
    sql = "DELETE FROM viviendas WHERE id=%s"
    data = (id,)
    cursor.execute(sql, data)
    db.database.commit()
    return redirect(url_for('vivienda'))



@app.route('/municipio')
def municipio():
    cursor = db.database.cursor()
    cursor.execute("SELECT * FROM municipios")
    myresult = cursor.fetchall()
    #Convertir los datos a diccionario
    insertObject = []
    columnNames = [column[0] for column in cursor.description]
    for record in myresult:
        insertObject.append(dict(zip(columnNames, record)))
    cursor.close()
    
    return render_template('municipio.html', data=insertObject)

@app.route('/municipio_add', methods=['POST'])
def municipio_add():
    id = int(request.form['id'])
    nombre = request.form['nombre']
    if all(x for x in request.form.values()):
        cursor = db.database.cursor()
        sql = "INSERT INTO municipios (id, nombre) VALUES (%s, %s)"
        data= (id,nombre)
        cursor.execute(sql, data)
        db.database.commit()
    return redirect(url_for('municipio'))
    
    
@app.route('/municipio_edit/<string:id>', methods=['POST'])
def municipio_edit(id):
    id = int(request.form['id'])
    nombre = request.form['nombre']

    if all(x for x in request.form.values()):
        cursor = db.database.cursor()
        sql = "UPDATE municipios SET id = %s, nombre = %s WHERE id = %s"
        data = (id, nombre, id)
        cursor.execute(sql, data)
        db.database.commit()
    return redirect(url_for('municipio'))


@app.route('/municipio_delete/<string:id>')
def municipio_delete(id):
    cursor = db.database.cursor()
    sql = "DELETE FROM municipios WHERE id=%s"
    data = (id,)
    cursor.execute(sql, data)
    db.database.commit()
    return redirect(url_for('municipio'))



@app.route('/posesiones/<string:id>', methods=["GET"])
def posesiones(id):
    try:
        cursor = db.database.cursor()
        q="SELECT * FROM posesiones WHERE id=%s"
        data=(id,)
        cursor.execute(q, data)
        myresult = cursor.fetchall()
    except:
        return render_template('index.html')
    #Convertir los datos a diccionario
    insertObject = []
    columnNames = [column[0] for column in cursor.description]
    for record in myresult:
        insertObject.append(dict(zip(columnNames, record)))
    cursor.close()
    
    return render_template('posesion.html', data=insertObject)

@app.route('/posesiones_add', methods=['POST'])
def posesiones_add():
    id_persona = int(request.form['id_persona'])
    id_vivienda = int(request.form['id_vivienda'])
    fecha_posesion =  datetime.now().strftime('%Y-%m-%d')
    if all(x for x in request.form.values()):
        cursor = db.database.cursor()
        sql = "INSERT INTO posesiones (id_persona, id_vivienda, fecha_posesion) VALUES (%s, %s, %s)"
        data= (id_persona,id_vivienda, fecha_posesion)
        cursor.execute(sql, data)
        db.database.commit()
    return redirect(url_for('posesion'))

fecha_actual = datetime.now().strftime('%Y-%m-%d')

    
@app.route('/posesiones_edit/<string:id>', methods=['POST'])
def posesiones_edit(id):
    id_persona = int(request.form['id_persona'])
    id_vivienda = int(request.form['id_vivienda'])
    fecha_posesion = datetime.strptime(request.form['fecha_posesion'], '%Y-%m-%d').date()
    if all(x for x in request.form.values()):
        cursor = db.database.cursor()
        sql = "UPDATE posesiones SET id_persona = %s, id_vivienda = %s, fecha_posesion = %s WHERE id = %s"
        data = (id_persona, id_vivienda, fecha_posesion)
        cursor.execute(sql, data)
        db.database.commit()
    return redirect(url_for('posesion'))



@app.route('/posesiones_delete/<string:id>')
def posesiones_delete(id):
    cursor = db.database.cursor()
    sql = "DELETE FROM posesiones WHERE id=%s"
    data = (id,)
    cursor.execute(sql, data)
    db.database.commit()
    return redirect(url_for('posesion'))









@app.route('/cdf/<string:id>', methods=["GET"])
def cdf(id):
    try:
        cursor = db.database.cursor()
        q="SELECT * FROM posesiones WHERE id=%s"
        data=(id,)
        cursor.execute(q, data)
        myresult = cursor.fetchall()
        
    except:
        return render_template('index.html')
            
    #Convertir los datos a diccionario
    insertObject = []
    columnNames = [column[0] for column in cursor.description]
    for record in myresult:
        insertObject.append(dict(zip(columnNames, record)))
    cursor.close()
    
    return render_template('cdf.html', data=insertObject)




if __name__ == '__main__':
    app.run(debug=True, port=5000)