import mysql.connector
mydb=mysql.connector.connect(host="localhost",user="root",password="")
mycur=mydb.cursor()
mycur.execute("show databases")
for x in mycur:
	print(x)