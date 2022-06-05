#from index import phish_call
#url=input("Enter string:")
#print(phish_call(url))
import re
a=input("enter data")
urls=re.findall('http?://(?:[-\w.]|(?:%[\da-fA-F]{2}))+',a)
print("output----------------")
print(urls)
print("\n\n\n\n\n\n\n")