const functions = require('firebase-functions');
const admin = require('firebase-admin');

exports.hello = functions.https.onRequest((request, response) => {
 response.send("Hello from Firebase!");
});

exports.newMessage = functions.database.ref('/messages/{discussionId}/{messageId}').onWrite((event, context) => {

    const discussionId = context.params.discussionId;
    const messageId = context.params.messageId;

    const message = event.after.val();

    if(!message){
        return;
    }

    var message_value = message.type == "image" ? "It's an image!!" : message.value;
    message_value = message.displayName + ": " + message_value;

    admin.initializeApp();

    const setLastMessageOnDiscussion = admin.database().ref(`/discussions/${discussionId}/lastMessage`).set(message_value);

    //ENVIAR NOTIFICACION PUSH


    return Promise.all([setLastMessageOnDiscussion])

});
