from tkinter import Tk,Entry,Label,Button
root=Tk()
e=Entry(root,width=50,text="enter val:")
#e2=Insert(0,"Enter your name")
e.pack()
def give():
	lab=Label(root,text=e.get()).pack()
	#lab2=Label(root,text=e2.get()).pack()
mybut=Button(root,text="Show",command=give).pack()
root.mainloop()