import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();

export const onUserCreate = functions.firestore.document('user/{userId}').onCreate((snapshot, context) => {
    snapshot.ref.update({
        "createdAt": admin.firestore.FieldValue.serverTimestamp(),
    });
});

export const onOrderCreate = functions.firestore.document('order/{orderId}').onCreate((snapshot, context) => {
    snapshot.ref.update({
        "createdAt": admin.firestore.FieldValue.serverTimestamp(),
    });
});

export const onItemCreate = functions.firestore.document('item/{itemId}').onCreate((snapshot, context) => {
    snapshot.ref.update({
        "createdAt": admin.firestore.FieldValue.serverTimestamp(),
    });
});
