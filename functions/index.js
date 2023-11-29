const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

// Create User Cloud Function
exports.createUser = functions.https.onCall(async (data, context) => {
//return "sss"
 try {
   const { email, password, phoneNumber,displayName } = data;
//Check if the user is authenticated
    if (!context.auth) {
      throw new functions.https.HttpsError(
        'unauthenticated',
        'Authentication required.'
      );
    }
// Create user in Firebase Authentication
    const userRecord = await admin.auth().createUser({
      email: email,
      password: password,
      phoneNumber:phoneNumber,
      displayName:displayName,
    
    });
  
    // Save additional user data in Firestore
    await admin.firestore().collection("users").doc(userRecord.uid).set({
      email: email,
      phoneNumber:phoneNumber,
      displayName:displayName,
      // Additional user data...
    });

    return { success: true, uid: userRecord.uid };
   // return "sss"
  } catch (error) {
    console.error("Error creating user:", error);
    throw new functions.https.HttpsError('internal', 'Error creating user');
 }
});

exports.delete=functions.https.onCall(async(data,context)=>{
  const {uid} = data;
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'Authentication required.'
    );
  }
  const userRecord = await admin.auth().deleteUser(
   uid
  
  );
});
exports.delete=functions.https.onCall(async(data,context)=>{
  const {uid} = data;
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'Authentication required.'
    );
  }
  const userRecord = await admin.auth().siginwithemailAndPassword(
   uid
  
  );
});
