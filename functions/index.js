const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.createUser = functions.https.onCall(async (data, context) => {
  //return "sss"
  try {
    const { email, password, phoneNumber, displayName } = data;

    // Create user in Firebase Authentication
    const userRecord = await admin.auth().createUser({
      email: email,
      password: password,
      phoneNumber: phoneNumber,
      displayName: displayName,

    });

    // Save additional user data in Firestore
    await admin.firestore().collection("users").doc(userRecord.uid).set({
      email: email,
      phoneNumber: phoneNumber,
      displayName: displayName,
      // Additional user data...
    });

    return {
      success: true, uid: userRecord.uid, email: userRecord.email,
      phoneNumber: userRecord.phoneNumber, displayName: userRecord.displayName
    };
    // return "sss"
  } catch (error) {
    console.error("Error creating user:", error);
    throw new functions.https.HttpsError('internal', 'Error creating user');
  }
});

exports.delete = functions.https.onCall(async (data, context) => {
  const { uid } = data;

  try {
   
    await admin.auth().deleteUser(uid);

  
    await admin.firestore().collection("users").doc(uid).delete();

    return { success: true, message: 'User deleted successfully.' };
  } catch (error) {
    console.error('Error deleting user:', error);
    return { success: false, message: 'Error deleting user.' };
  }
});


exports.getuser = functions.https.onCall(async (data, context) => {
  const { uid } = data;

  const userRecord = await admin.auth().getUser(
    uid

  );
  return {
    success: true, uid: userRecord.uid, email: userRecord.email,
    phoneNumber: userRecord.phoneNumber, displayName: userRecord.displayName
  };
});

exports.getAllUsers = functions.https.onCall(async (data, context) => {
  const usersSnapshot = await admin.firestore().collection("users").get();
  const allUsers = [];

  usersSnapshot.forEach((doc) => {
    const userData = doc.data();
    allUsers.push({
      uid: doc.id,
      email: userData.email,
      phoneNumber: userData.phoneNumber,
      displayName: userData.displayName,
    });
  });
  if (usersSnapshot.empty) {
    console.log("No users found in Firestore.");
    return { success: true, users: [] };
  }

  console.log("allUsers:", allUsers);
  return { success: true, users: allUsers };
});
exports.update = functions.https.onCall(async (data, context) => {
  //return "sss"
  try {
    const { email, password, phoneNumber, displayName } = data;

    // Create user in Firebase Authentication
    const userRecord = await admin.auth().updateUser({
      email: email,
      password: password,
      phoneNumber: phoneNumber,
      displayName: displayName,

    });

    // Save additional user data in Firestore
    await admin.firestore().collection("users").doc(userRecord.uid).set({
      email: email,
      phoneNumber: phoneNumber,
      displayName: displayName,
      // Additional user data...
    });

    return {
      success: true, uid: userRecord.uid, email: userRecord.email,
      phoneNumber: userRecord.phoneNumber, displayName: userRecord.displayName
    };
    // return "sss"
  } catch (error) {
    console.error("Error creating user:", error);
    throw new functions.https.HttpsError('internal', 'Error creating user');
  }
});
