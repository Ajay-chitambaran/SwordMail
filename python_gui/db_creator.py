from tkinter import Label,Button
import mysql.connector
mydb=mysql.connector.connect(host="localhost",user="root",password="")
mycursor=mydb.cursor()
mycursor.execute("create database new_db2")