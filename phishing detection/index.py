
import joblib
import inputScript

#load the pickle file
classifier = joblib.load('final_models/rf_final.pkl')


url = input("Enter url:")

#checking and predicting
checkprediction = inputScript.main(url)
prediction = classifier.predict(checkprediction)
#print(prediction)
if (prediction==1):
    print("Phishing")
elif(prediction==-1):
    print("Legitimate")