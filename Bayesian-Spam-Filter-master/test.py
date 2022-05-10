import mysql.connector as mysql
from fetch_table import getInbox,getText
box=[]
mydb=mysql.connect(host="localhost",username="root",password="",database="swordmail")
mycur=mydb.cursor()
getInbox(mycur,box)
a=getText(mycur,box)
#print(len(a))
def seperator(a):
	i_id=[]
	owner_id=[]
	from_id=[]
	msg_id=[]
	result=[]
	for i in range(len(a)):
		selector=i%4
		if(selector==0):
			i_id.append(a[i])

		if(selector==1):
			owner_id.append(a[i])

		if(selector==2):
			from_id.append(a[i])

		if (selector==3):
			msg_id.append(a[i])
	result.append(i_id)
	result.append(owner_id)
	result.append(from_id)
	result.append(msg_id)
	return result
res=seperator(a)
#print(res[0])
