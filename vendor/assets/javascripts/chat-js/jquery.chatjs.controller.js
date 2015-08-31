/// <reference path="../../Scripts/Typings/jquery/jquery.d.ts"/>
/// <reference path="../../Scripts/Typings/autosize/autosize.d.ts"/>
/// <reference path="jquery.chatjs.adapter.ts"/>
/// <reference path="jquery.chatjs.pmwindow.ts"/>
/// <reference path="jquery.chatjs.friendswindow.ts"/>


var ChatControllerOptions = (function () {
    function ChatControllerOptions() {
    }
    return ChatControllerOptions;
})();

var ChatJsState = (function () {
    function ChatJsState() {
        this.pmWindows = [];
        this.mainWindowState = new ChatFriendsWindowState();
    }
    return ChatJsState;
})();

var ChatController = (function () {
    function ChatController(options) {
        var _this = this;
        var defaultOptions = new ChatControllerOptions();
        defaultOptions.roomId = null;
        defaultOptions.friendsTitleText = I18n.t('conversations.chat_title');
        defaultOptions.availableRoomsText = "Available rooms";
        defaultOptions.typingText = " is typing...";
        defaultOptions.offsetRight = 10;
        defaultOptions.windowsSpacing = 5;
        defaultOptions.enableSound = true;
        defaultOptions.persistenceMode = "cookie";
        defaultOptions.persistenceCookieName = "chatjs";
        defaultOptions.chatJsContentPath = "/chatjs/";

        this.options = $.extend({}, defaultOptions, options);

        // check required properties
        if (!this.options.roomId)
            throw "Room id option is required";

        this.pmWindows = [];

        // getting the adapter started. You cannot call the adapter BEFORE this is done.
        this.options.adapter.init(function () {
            var state = _this.getState();

            // the controller must have a listener to the "messages-changed" event because it has to create
            // new PM windows when the user receives it

            // if the user is able to select rooms
            var friendsWindowOptions = new ChatFriendsWindowOptions();
            friendsWindowOptions.roomId = _this.options.roomId;
            friendsWindowOptions.adapter = _this.options.adapter;
            friendsWindowOptions.userId = _this.options.userId;
            friendsWindowOptions.offsetRight = _this.options.offsetRight;
            friendsWindowOptions.titleText = _this.options.friendsTitleText;
            friendsWindowOptions.isMaximized = state ? state.mainWindowState.isMaximized : true;

            // when the friends window changes state, we must save the state of the controller
            friendsWindowOptions.onStateChanged = function () {
                _this.saveState();
            };

            // when the user clicks another user, we must create a pm window
            friendsWindowOptions.userClicked = function (userId) {
                if(userId.constructor === Array)
                    var users = userId.slice();
                else{
                    var users = new Array;
                    users.push(userId);
                }

                $(".user-list-item[data-val-id='" + userId + "']").removeClass("incoming-message");
                users.push(_this.options.userId);
                if (userId != _this.options.userId) {
                    $.get('/chat/', {participants: users}, function(data){
                        if (data)
                            arg = data.chat.id;
                        else
                            arg = null;
                        $.post('/chat/', {participants: users, id: arg},
                            function(returnedData){
                                var existingWindow = _this.pmWindows[0];
                                if(existingWindow){
                                    // removes the window
                                    existingWindow.pmWindow.chatWindow.$window.remove();

                                    // triggers the event
                                    existingWindow.pmWindow.chatWindow.options.onClose(existingWindow.pmWindow.chatWindow);
                                }
                            // verify whether there's already a PM window for this user
                            _this.createPmWindow(userId, true, true, returnedData.id, returnedData.name);
                            }
                        );
                    })
                }
            };

            friendsWindowOptions.add_to_chat = function(userId) {
                var that = this;
                var users = new Array;
                users = _this.pmWindows[0].otherUserId.slice();
                users.push(_this.pmWindows[0].userId);
                users.push(userId);
                users = sorting(users);
                users = $.unique(users);

                var prev_users = new Array;
                prev_users = _this.pmWindows[0].otherUserId.slice();
                prev_users.push(_this.pmWindows[0].userId);
                prev_users = sorting(prev_users);
                prev_users = $.unique(prev_users);

                var chat_users = new Array;
                chat_users = _this.pmWindows[0].otherUserId.slice();
                chat_users.push(userId);
                chat_users = sorting(chat_users);
                chat_users = $.unique(chat_users);

                var $chat_list = $(".chat-list-content");
                var $chat_item;

                if(_this.pmWindows[0].otherUserId.length < 2)
                    $.post("/chat/", {participants: users, id: _this.pmWindows[0].chat_id, participant_id: userId}, function(returned){
                        var existingWindow = _this.pmWindows[0];
                        if(existingWindow){
                            // removes the window
                            existingWindow.pmWindow.chatWindow.$window.remove();

                            // triggers the event
                            existingWindow.pmWindow.chatWindow.options.onClose(existingWindow.pmWindow.chatWindow);
                        }
                        _this.createPmWindow(chat_users, true, true, returned.id, returned.name);

                        if($(".chat-name[chat_id='"+ returned.id +"']").length < 1){
                            if($(".chat-name[chat_id='"+ returned.id +"'] .chat-content").length < 1)
                                $(".chat-name[chat_id='"+ returned.id +"'] .chat-content").remove();
                            $chat_item = $("<div/>").addClass("chat-name").attr({participants_id: users, chat_id: returned.id}).appendTo($chat_list);
                            $chat_content = $("<div/>").addClass("chat-content").text(returned.name).appendTo($chat_item);
                            $leave_chat = $("<div/>").addClass("leave-chat-icon").appendTo($chat_item);
                            (function (userId, chatId) {
                                $chat_content.click(function () {
                                    that.chatClicked(userId, chatId);
                                });
                            })(users, returned.id);

                            (function (chatId) {
                                $leave_chat.click(function () {
                                    _this.options.leaveChatClicked(chatId);
                                })
                            })(returned.id);
                        }
                    });
                else{
                    $.ajax({
                    url: '/chat/'+_this.pmWindows[0].chat_id,
                    type: 'PUT',
                    data: {participant_id: userId, participants: users},
                    success: function(returned){
                        var chatId = _this.pmWindows[0].chat_id
                        var existingWindow = _this.pmWindows[0];
                        if(existingWindow){
                            // removes the window
                            existingWindow.pmWindow.chatWindow.$window.remove();

                            // triggers the event
                            existingWindow.pmWindow.chatWindow.options.onClose(existingWindow.pmWindow.chatWindow);
                        }
                        _this.createPmWindow(chat_users, true, true, chatId, returned.name);
                        $(".chat-name[chat_id='"+ _this.pmWindows[0].chat_id +"'] .chat-content").remove();
                        $chat_item = $(".chat-name[chat_id='"+ _this.pmWindows[0].chat_id +"']");
                        $chat_content = $("<div/>").addClass("chat-content").text(returned.name).appendTo($chat_item);
                        // $leave_chat = $("<div/>").addClass("leave-chat-icon").appendTo($chat_item);
                        (function (userId, chatId) {
                            $chat_content.click(function () {
                                that.chatClicked(userId, chatId);
                            });
                        })(users, _this.pmWindows[0].chat_id);
                        $chat_item.attr("participants_id", users);

                        }
                    });
                }
            };

            sorting = function(users){
                var res, buf;
                for (var i = 0; i < users.length; i++) {
                    res = users[i];
                    for (var  j = i; j < users.length; j++) {
                        if(users[j] < res){
                            users[i] = users[j];
                            users[j] = res;
                            res = users[i];
                        }
                    };
                };
                return users;
            }

            friendsWindowOptions.chatClicked = function(userId, chatId) {
                var users = new Array;

                $.get('/chat/', {id: chatId, goal: "participants"}, function(data){
                    for (var i = 0; i < data.participants.length; i++) {
                        if (data.participants[i].existing && data.participants[i].participant_id != gon.current_user.id)
                            users.push(data.participants[i].participant_id)
                    };
                    var existingWindow = _this.pmWindows[0];
                    if(existingWindow){
                        // removes the window
                        existingWindow.pmWindow.chatWindow.$window.remove();

                        // triggers the event
                        existingWindow.pmWindow.chatWindow.options.onClose(existingWindow.pmWindow.chatWindow);
                    }
                    _this.createPmWindow(users, true, true, chatId, data.chat.name);
                })
            }

            friendsWindowOptions.leaveChatClicked = function(chatId) {
                $.ajax({
                    url: '/chat/'+chatId,
                    type: 'DELETE',
                    data: { participant_id: gon.current_user.id },
                    success: function(){
                        var existingWindow = _this.pmWindows[0];
                        if(existingWindow){
                            existingWindow.pmWindow.chatWindow.$window.remove();
                            existingWindow.pmWindow.chatWindow.options.onClose(existingWindow.pmWindow.chatWindow);
                        }
                        $(".chat-name[chat_id='"+ chatId +"']").remove();
                    }
                });
            }
            _this.mainWindow = $.chatFriendsWindow(friendsWindowOptions);
            _this.setState(state);
        });

        // for debugging only
        window.chatJs = this;
    }
    // creates a new PM window for the given user
    ChatController.prototype.createPmWindow = function (otherUserId, isMaximized, saveState, chat_id, chat_name) {
        var _this = this;
        var curr_chat_id = null;
        if(chat_id)
            curr_chat_id = chat_id;
        var chatPmOptions = new ChatPmWindowOptions();
        chatPmOptions.userId = this.options.userId;
        if (otherUserId.constructor === Array)
            chatPmOptions.otherUserId = otherUserId;
        else{
            chatPmOptions.otherUserId = new Array();
            chatPmOptions.otherUserId.push(otherUserId);
        }
        chatPmOptions.chatId = chat_id;
        chatPmOptions.chatName = chat_name;
        chatPmOptions.adapter = this.options.adapter;
        chatPmOptions.typingText = this.options.typingText;
        chatPmOptions.isMaximized = isMaximized;
        chatPmOptions.chatJsContentPath = this.options.chatJsContentPath;
        chatPmOptions.onCreated = function (pmWindow) {
            _this.pmWindows.push({
                chat_name: chatPmOptions.chatName,
                chat_id: curr_chat_id,
                userId: chatPmOptions.userId,
                otherUserId: chatPmOptions.otherUserId,
                conversationId: null,
                pmWindow: pmWindow
            });

            _this.organizePmWindows();
            _this.saveState();
            $(".profile-add-to-chat.add-to-chat").css("display", "block");
            $("<div/>").addClass("participants").appendTo(_this.pmWindows[0].pmWindow.chatWindow.$window.children.first);

        };
        chatPmOptions.onClose = function () {
            $(".profile-add-to-chat.add-to-chat").css("display", "none");
            for (var i = 0; i < _this.pmWindows.length; i++)
                if (_this.pmWindows[0].otherUserId == otherUserId) {
                    _this.pmWindows.splice(i, 1);
                    _this.saveState();
                    _this.organizePmWindows();
                    break;
                };
        };
        chatPmOptions.onMaximizedStateChanged = function () {
            _this.saveState();
        };
        return $.chatPmWindow(chatPmOptions);
        
    };

    // saves the windows states
    ChatController.prototype.saveState = function () {
        var state = new ChatJsState();
        for (var i = 0; i < this.pmWindows.length; i++) {
            state.pmWindows.push({
                chat_name: this.pmWindows[i].chat_name,
                chat_id: this.pmWindows[i].chat_id,
                otherUserId: this.pmWindows[i].otherUserId,
                conversationId: null,
                isMaximized: this.pmWindows[i].pmWindow.getState().isMaximized
            });
        };

        // persist rooms state
        state.mainWindowState = this.mainWindow.getState();

        switch (this.options.persistenceMode) {
            case "cookie":
                this.createCookie(this.options.persistenceCookieName, state);
                break;
            case "server":
                throw "Server persistence is not supported yet";
            default:
                throw "Invalid persistence mode. Available modes are: cookie and server";
        }
        return state;
    };

    ChatController.prototype.getState = function () {
        var state;
        switch (this.options.persistenceMode) {
            case "cookie":
                state = this.readCookie(this.options.persistenceCookieName);
                break;
            case "server":
                throw "Server persistence is not supported yet";
            default:
                throw "Invalid persistence mode. Available modes are: cookie and server";
        }
        return state;
    };

    // loads the windows states
    ChatController.prototype.setState = function (state) {
        if (typeof state === "undefined") { state = null; }
        // if a state hasn't been passed in, gets the state. If it continues to be null/undefined, then there's nothing to be done.
        if (!state)
            state = this.getState();
        if (!state)
            return;

        for (var i = 0; i < state.pmWindows.length; i++) {
            var shouldCreatePmWindow = true;

            // if there's already a PM window for the given user, we'll not create it

            if (shouldCreatePmWindow)
                this.createPmWindow(state.pmWindows[i].otherUserId, state.pmWindows[i].isMaximized, false, state.pmWindows[i].chat_id, state.pmWindows[i].chat_name);
        }

        this.mainWindow.setState(state.mainWindowState, false);
    };

    ChatController.prototype.eraseCookie = function (name) {
        this.createCookie(name, "", -1);
    };

    // reads a cookie. The cookie value will be converted to a JSON object if possible, otherwise the value will be returned as is
    ChatController.prototype.readCookie = function (name) {
        var nameEq = name + "=";
        var ca = document.cookie.split(';');
        var cookieValue;
        for (var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ')
                c = c.substring(1, c.length);
            if (c.indexOf(nameEq) == 0) {
                cookieValue = c.substring(nameEq.length, c.length);
            }
        }
        if (cookieValue) {
            try  {
                return JSON.parse(cookieValue);
            } catch (e) {
                return cookieValue;
            }
        } else
            return null;
    };

    // creates a cookie. The passed in value will be converted to JSON, if not a string
    ChatController.prototype.createCookie = function (name, value, days) {
        var stringedValue;
        if (typeof value == "string")
            stringedValue = value;
        else
            stringedValue = JSON.stringify(value);
        if (value)
            var expires;
        if (days) {
            var date = new Date();
            date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
            expires = "; expires=" + date.toUTCString();
        } else {
            expires = "";
        }
        document.cookie = name + "=" + stringedValue + expires + "; path=/";
    };

    ChatController.prototype.findPmWindowByOtherUserId = function (otherUserId) {
        for (var i = 0; i < this.pmWindows.length; i++)
            if (this.pmWindows[i].otherUserId == otherUserId)
                return this.pmWindows[i].pmWindow;
        return null;
    };

    ChatController.prototype.findPmWindowByUserId = function (chat_Id) {
        for (var i = 0; i < this.pmWindows.length; i++)
            if (this.pmWindows[i].userId == this.options.userId)
                return this.pmWindows[i].pmWindow;
        return null;
    };

    // organizes the pm windows
    ChatController.prototype.organizePmWindows = function () {
        // this is the initial right offset
        var rightOffset = +this.options.offsetRight + this.mainWindow.getWidth() + this.options.windowsSpacing;
        for (var i = 0; i < this.pmWindows.length; i++) {
            this.pmWindows[i].pmWindow.setRightOffset(rightOffset);
            rightOffset += this.pmWindows[i].pmWindow.getWidth() + this.options.windowsSpacing;
        }
    };
    return ChatController;
})();

$.chat = function (options) {
    var chat = new ChatController(options);
    return chat;
};
//# sourceMappingURL=jquery.chatjs.controller.js.map
