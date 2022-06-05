import time
import re
from index import phish_call
from TrainingSetsUtil import *
from tkinter import Button, Label,Tk,messagebox
#import tkMessageBox
root=Tk()
root.geometry('700x500')
import mysql.connector as mysql
from fetch_table import getInbox,getText
from test import seperator
box=[]
mydb=mysql.connect(host="localhost",username="root",password="",database="swordmail")
mycur=mydb.cursor()
getInbox(mycur,box)
a=getText(mycur,box)
def classify(message, training_set, prior = 0.5, c = 3.7e-4):
    msg_terms = get_words(message)
    msg_probability = 170
    for term in msg_terms:        
        if term in training_set:
            msg_probability *= training_set[term]
        else:
            msg_probability *= c
            
    return msg_probability * prior

b=seperator(a)
#print(a)
#print("\n\n\n----------------------------------------------------------------------------------")
#print(b[2])
#msges=b[2]
#print(b)
#print(msges)
print("\n\n\n")
data=[]
def calculate(a):
    for x in b:
        #print(x)
        temp=[]
        for i in range(len(x)):
            temp.append(x[i])
        data.append(temp)
        #print(msg)
def activate():
    calculate(a)
    msg_data=data[3]
#print(len(data[0]))
    for i in range(len(msg_data)):
    #print(msg_data[i])
        temp=0
        mail_msg=msg_data[i]
        #print(mail_msg)
        urls_list1=re.findall('http?://(?:[-\w.]|(?:%[\da-fA-F]{2}))+',mail_msg)
        urls_list2=re.findall('https://(?:[-\w.]|(?:%[\da-fA-F]{2}))+',mail_msg)
        urls_list=urls_list1+urls_list2
        #print(urls_list)
        #print(phish_call(mail_msg))
        phish_flag=0
        phish_adder=0
        for url in urls_list:
            result_phish=phish_call(url)
            if(result_phish=='P'):
                phish_flag=1
        if(phish_flag==1):
            phish_adder=1000
        spam_probability = classify(mail_msg, spam_training_set, 0.2)
        ham_probability = classify(mail_msg, ham_training_set, 0.8)
        if spam_probability > ham_probability:
            #print('This mail has been classified as SPAM.')
            temp=1+phish_adder
        else:
            #print('This mail has been classified as HAM.')
            temp=0+phish_adder
        temp_cur=mydb.cursor()
        temp_table_name=data[1][i]+"_inbox"
        temp_table_id=data[0][i]
    #temp_cur.execute("update alansam_inbox set spam=1 where ibox_id=3")
    #mydb.commit()
        temp_cur.execute(f"update {temp_table_name} set spam={temp} where ibox_id={temp_table_id}")
        mydb.commit()
        print(temp_table_id,temp_table_name,temp)
        print("---------------")
    messagebox.showinfo("swordmail","Classifier activated Successfully")
    #temp_cur.execute(f'update {}')

def activate2():
    calculate(a)
    msg_data=data[3]
#print(len(data[0]))
    for i in range(len(msg_data)):
    #print(msg_data[i])
        temp=0
        mail_msg=msg_data[i]
        spam_probability = classify(mail_msg, spam_training_set, 0.2)
        ham_probability = classify(mail_msg, ham_training_set, 0.8)
        if spam_probability > ham_probability:
            #print('This mail has been classified as SPAM.')
            temp=1
        else:
            #print('This mail has been classified as HAM.')
            temp=0
        temp_cur=mydb.cursor()
        temp_table_name=data[1][i]+"_inbox"
        temp_table_id=data[0][i]
    #temp_cur.execute("update alansam_inbox set spam=1 where ibox_id=3")
    #mydb.commit()
        temp_cur.execute(f"update {temp_table_name} set spam={temp} where ibox_id={temp_table_id}")
        mydb.commit()
        print(temp_table_id,temp_table_name,temp)
        print("---------------")
    #messagebox.showinfo("swordmail","Classifier activated Successfully")
def tensec():
    while True:
        activate2()
        time.sleep(15)
def stopp():
    while True:
        quit()
        time.sleep(10)
mylabel=Label(root,text="Admin Panel of Swordmail",pady=20,font=("Arial", 25)).pack()    
my_butt=Button(root,text="Start Classifier",command=activate,pady=5).pack()
auto=Button(root,text="Smart mode",command=tensec,pady=5).pack()
phishing=Button(root,text="Smart mode",command=tensec,pady=5).pack()
my_butt2=Button(root,text="Quit",command=stopp,pady=5).pack()
root.mainloop()
#print(data[3][i][i])


