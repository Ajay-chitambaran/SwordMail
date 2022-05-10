import mysql.connector as mysql
boxes=[]
mydb=mysql.connect(host="localhost",username="root",password="",database="swordmail")
mycursor=mydb.cursor()
#SELECT table_name FROM information_schema.tables;
def getInbox(mycursor,boxes):
	mycursor.execute("SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME LIKE '%_inbox'")
#print(mycur)
def getText(mycursor,boxes):
	for x in mycursor:
		if(x[1]=="swordmail"):
			boxes.append(x[2])
#print(boxes)
	texts=[]
	results=[]
	for y in boxes:
		tempcur=mydb.cursor()
		#sql_select_query = """select message from %s"""
	#tuple1=(y)
		tempcur.execute(f"SELECT ibox_id,user_id,fromm,message from ({y})")
		storage=tempcur.fetchall()
		texts.append(storage)
	for x in texts:
		for y in x:
			for z in y:
				#print(z)
				results.append(z)
	return results
getInbox(mycursor,boxes)
getText(mycursor,boxes)

