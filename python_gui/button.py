from tkinter import Button, Label,Tk
root = Tk()
def click():
	mylab=Label(root,text="you have clicked").pack_forget()
	mylab=Label(root,text="you have clicked").pack()
my_butt=Button(root,text="click-me",command=click).pack()
root.mainloop()