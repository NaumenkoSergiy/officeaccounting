/// <reference path="../../Scripts/Typings/jquery/jquery.d.ts"/>
/// <reference path="jquery.chatjs.interfaces.ts"/>
/// <reference path="jquery.chatjs.utils.ts"/>
/// <reference path="jquery.chatjs.adapter.ts"/>
/// <reference path="jquery.chatjs.window.ts"/>
/// <reference path="jquery.chatjs.messageboard.ts"/>

var UserListOptions = (function () {
    function UserListOptions() {
    }
    return UserListOptions;
})();

var UserList = (function () {
    function UserList(jQuery, options) {
        var _this = this;
        this.$el = jQuery;
        var defaultOptions = new UserListOptions();
        defaultOptions.emptyRoomText = "No users available for chatting.";
        defaultOptions.height = 125;
        defaultOptions.excludeCurrentUser = false;
        defaultOptions.userClicked = function () {
        };
        defaultOptions.add_to_chat = function () {
        };
        defaultOptions.chatClicked = function () {
        };
        defaultOptions.leaveChatClicked = function () {
        };
        this.options = $.extend({}, defaultOptions, options);

        this.$el.addClass("user-list");
        $(".chat-list-content").addClass("chat-list");
        this.$list = $(".chat-list-content.chat-list");
        ChatJsUtils.setOuterHeight(this.$el, this.options.height);

        // when the user list changed, this list must be updated
        this.options.adapter.client.onUserListChanged(function (userListData) {
            if ((_this.options.roomId && userListData.RoomId == _this.options.roomId) || (_this.options.conversationId && _this.options.conversationId == userListData.ConversationId)) {
                var userList = userListData.UserList;
                _this.populateList(userList);
            }
        });

        // loads the list now
        this.options.adapter.server.getUserList(this.options.roomId, this.options.conversationId, function (userList) {
            _this.populateList(userList);
            _this.chatList();
        });
    }
    UserList.prototype.populateList = function (rawUserList) {
        var _this = this;
        // this will copy the list to a new array
        var userList = rawUserList.slice(0);

        if (this.options.excludeCurrentUser) {
            var j = 0;
            while (j < userList.length) {
                if (userList[j].Id == this.options.userId)
                    userList.splice(j, 1);
                else
                    j++;
            }
        }
        this.$el.html('');
        if (userList.length == 0) {
            $("<div/>").addClass("user-list-empty").text(this.options.emptyRoomText).appendTo(this.$el);
        } else {
            for (var i = 0; i < userList.length; i++) {
                var $userListItem = $("<div/>").addClass(userList[i].Status == 0 ? "offline" : "online").addClass("user-list-item").attr("data-val-id", userList[i].Id).appendTo(this.$el);

                $("<img/>").addClass("profile-picture").attr("src", userList[i].ProfilePictureUrl).appendTo($userListItem);
                // if($(".user-list-item[data-val-id='"+  +"']"))
                var $chat = $("<div/>").addClass("profile-add-to-chat").addClass("add-to-chat").appendTo($userListItem);

                var $content = $("<div/>").addClass("content").text(userList[i].Name).appendTo($userListItem);

                // makes a click in the user to either create a new chat window or open an existing
                // I must clusure the 'i'
                (function (userId) {
                    // handles clicking in a user. Starts up a new chat session
                    $chat.click(function () {
                        if(window.chatJs.pmWindows[0].otherUserId.indexOf(userId) < 0)
                            _this.options.add_to_chat(userId);
                    });
                })(userList[i].Id);

                (function (userId) {
                    // handles clicking in a user. Starts up a new chat session
                    $content.click(function () {
                        _this.options.userClicked(userId);
                    });
                })(userList[i].Id);
            }
        }
    };

    UserList.prototype.chatList = function () {
        var _this = this;
        var $chat_list = this.$list;
        var $chat_item;
        var user_id = new Array();
        var chat_length;
        $.get('/ua/chat/list', { user_id: gon.current_user.id },function(data){
            chat_length = data.chat_id.length;
            for (var i = 0; i < data.chat_id.length; i++) {
                user_id[i] = new Array()
                for (var j = 0; j < data.chat_id[i].length; j++) {
                    if(data.chat_id[i][j].existing)
                        user_id[i].push(data.chat_id[i][j].participant_id);
                };
            };
            var participate = false;
            for(var i = 0; i < user_id.length; i++){
                participate = false;
                for (var j = 0; j < user_id[i].length; j++) {
                    if(gon.current_user.id == user_id[i][j]){
                        participate = true;
                    }
                };
                if(participate){
                    if(user_id[i].length > 1){
                        $chat_item = $("<div/>").addClass("chat-name").attr({participants_id: user_id[i], chat_id: data.id[i]}).appendTo($chat_list);
                        $chat_content = $("<div/>").addClass("chat-content").text(data.chat_name[i]).appendTo($chat_item);
                        $leave_chat = $("<div/>").addClass("leave-chat-icon").appendTo($chat_item);
                        (function (userId, chatId) {
                            $chat_content.click(function () {
                                _this.options.chatClicked(userId, chatId);
                            });
                        })(user_id[i], data.id[i]);

                        (function (chatId) {
                            $leave_chat.click(function () {
                                _this.options.leaveChatClicked(chatId);
                            })
                        })(data.id[i]);
                    }
                }
            }
        });
    }
    return UserList;
})();

$.fn.userList = function (options) {
    if (this.length) {
        this.each(function () {
            var data = new UserList($(this), options);
            $(this).data('userList', data);
        });
    }
    return this;
};
//# sourceMappingURL=jquery.chatjs.userlist.js.map
