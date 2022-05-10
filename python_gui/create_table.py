import mysql.connector as ms
mydb=ms.connect(host="localhost",username="root",password="",database="new_db")
mycur=mydb.cursor()
mycur.execute("create table users_pool(id int primary key auto_increment,name varchar(20))")
