
import joblib
import inputScript
def phish_call(url):
#load the pickle file
    classifier = joblib.load('final_models/rf_final.pkl')


    #url = input("Enter url:")

#checking and predicting
    checkprediction = inputScript.main(url)
    prediction = classifier.predict(checkprediction)
#print(prediction)
    if (prediction==1):
        return "P"
    elif(prediction==-1):
        return "L"
#url=input("Enter url")
#phish_call(url)