const functions = require("firebase-functions");
const admin = require('firebase-admin');
admin.initializeApp();

exports.checkIfPhoneExists = functions.https.onCall((data, context) => {
    const phone = data.phone
    return admin.auth().getUserByPhoneNumber(phone)
     .then(function(userRecord){
         return true;
     })
     .catch(function(error) {
         return false;
     });
 });