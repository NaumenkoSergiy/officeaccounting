/// <reference path="jquery.chatjs.adapter.ts" />
var AdapterConstats = (function () {
    function AdapterConstats() {
    }
    AdapterConstats.CURRENT_USER_ID = 1;

    AdapterConstats.ECHOBOT_USER_ID = 2;

    AdapterConstats.DEFAULT_ROOM_ID = 1;

    AdapterConstats.ECHOBOT_TYPING_DELAY = 1000;

    AdapterConstats.ECHOBOT_REPLY_DELAY = 3000;
    return AdapterConstats;
})();

var ClientAdapter = (function () {
    function ClientAdapter() {
        this.messagesChangedHandlers = [];
        this.typingSignalReceivedHandlers = [];
        this.userListChangedHandlers = [];
    }
    // adds a handler to the messagesChanged event
    ClientAdapter.prototype.onMessagesChanged = function (handler) {
      if(this.messagesChangedHandlers.length < 2)
        this.messagesChangedHandlers.push(handler);
    };

    // adds a handler to the typingSignalReceived event
    ClientAdapter.prototype.onTypingSignalReceived = function (handler) {
        this.typingSignalReceivedHandlers.push(handler);
    };

    // adds a handler to the userListChanged event
    ClientAdapter.prototype.onUserListChanged = function (handler) {
        this.userListChangedHandlers.push(handler);
    };

    ClientAdapter.prototype.triggerMessagesChanged = function (message) {
        for (var i = 0; i < this.messagesChangedHandlers.length; i++)
            this.messagesChangedHandlers[i](message);
    };

    ClientAdapter.prototype.triggerTypingSignalReceived = function (typingSignal) {
        for (var i = 0; i < this.typingSignalReceivedHandlers.length; i++)
            this.typingSignalReceivedHandlers[i](typingSignal);
    };

    ClientAdapter.prototype.triggerUserListChanged = function (userListChangedInfo) {
        for (var i = 0; i < this.userListChangedHandlers.length; i++)
            this.userListChangedHandlers[i](userListChangedInfo);
    };
    return ClientAdapter;
})();

var ServerAdapter = (function () {
    function ServerAdapter(clientAdapter) {
        this.clientAdapter = clientAdapter;

        var users = [];
        gon.users.forEach(function (element, index, array) {
          users[index] = new ChatUserInfo();
          users[index].Id = element.id;
          users[index].Name = element.email;
          if(gon.online_users.indexOf(""+element.id)>=0)
            users[index].Status = 1;
        else
            users[index].Status = 0;

            users[index].ProfilePictureUrl = 'http://www.gravatar.com/avatar/' + $.md5(element.email)
        })

        var that = this;
        that.users = new Array();
        users.forEach(function (element, index, array){
          that.users.push(element);
        })
        // adds the users in the global user list

        // configuring rooms
        var room = new ChatRoomInfo();
        room.Id = 1;
        room.Name = "Room";
        room.UsersOnline = this.users.length;

        this.rooms = new Array();
        this.rooms.push(room);

        // configuring client to return every event to me
        this.clientAdapter.onMessagesChanged(function (message) {
            return function () {
            };
        });
    }
    ServerAdapter.prototype.sendMessage = function (chatId, conversationId, otherUserId, messageText, clientGuid, done) {
        var _this = this;

        // we have to send the current message to the current user first
        // in chatjs, when you send a message to someone, the same message bounces back to the user
        // just so that all browser windows are synchronized
        var bounceMessage = new ChatMessageInfo();
        bounceMessage.UserFromId = gon.current_user.id; // It will from our user
        bounceMessage.UserToId = otherUserId; // ... to the Echobot
        bounceMessage.RoomId = 1;
        bounceMessage.Message = messageText;
        bounceMessage.ClientGuid = clientGuid;
        var users = otherUserId.slice();
        users.push(gon.current_user.id);
        setTimeout(function () {
            _this.clientAdapter.triggerMessagesChanged(bounceMessage);
        }, 300);
        $.post('/chat_messages/', {chat_id: chatId, message_text: bounceMessage.Message, sender_id: bounceMessage.UserFromId});
    };

    ServerAdapter.prototype.sendTypingSignal = function (roomId, conversationId, userToId, done) {
    };

    ServerAdapter.prototype.getMessageHistory = function (chatId, conversationId, otherUserId, done) {
        var history = [];
        var users = [];
        var users = otherUserId.slice();
        users.push(gon.current_user.id);
          $.get('/chat_messages/', {chat_id: chatId, page: $(".next-page").attr("page")}, function(returned){
            var i = 0;
            $(".next-page").attr("page", returned.page);
            returned.recipients.forEach(function(element, index, array){
              if(element.recipient_id == gon.current_user.id)
                returned.messages.forEach(function(elem, ind, arr){
                  if(elem.id == element.chat_message_id){
                    history[i] = new ChatMessageInfo();
                    history[i].UserFromId = elem.sender_id;
                    history[i].RoomId = 1;
                    history[i].Message = elem.message_text;
                    history[i].CreatedAtDate = elem.created_at;
                    i++;
                  }
                })
            })
            done(history);
          });
    };

    ServerAdapter.prototype.getUserInfo = function (userId, done) {
        var user = true;
        done(user);
    };

    ServerAdapter.prototype.getUserList = function (roomId, conversationId, done) {
        // if (roomId == AdapterConstats.DEFAULT_ROOM_ID) {
            done(this.users);
            return;
        // }
    };

    ServerAdapter.prototype.enterRoom = function (roomId, done) {

        // if (roomId != AdapterConstats.DEFAULT_ROOM_ID)
        //     throw "Only the default room is supported in the demo adapter";

        var userListChangedInfo = new ChatUserListChangedInfo();
        userListChangedInfo.RoomId = AdapterConstats.DEFAULT_ROOM_ID;
        userListChangedInfo.UserList = this.users;

        this.clientAdapter.triggerUserListChanged(userListChangedInfo);
    };

    ServerAdapter.prototype.leaveRoom = function (roomId, done) {
    };

    // gets the given user from the user list
    ServerAdapter.prototype.getUserById = function (userId) {
        for (var i = 0; i < this.users.length; i++) {
            if (this.users[i].Id == userId)
                return this.users[i];
        }
        throw "Could not find the given user";
    };
    return ServerAdapter;
})();

var Adapter = (function () {
    function Adapter() {
    }
    // called when the adapter is initialized
    Adapter.prototype.init = function (done) {
        this.client = new ClientAdapter();
        this.server = new ServerAdapter(this.client);
        done();
    };
    return Adapter;
})();
//# sourceMappingURL=jquery.chatjs.adapter.demo.js.map
