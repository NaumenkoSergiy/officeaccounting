/// <reference path="../../Scripts/Typings/jquery/jquery.d.ts"/>
/// <reference path="jquery.chatjs.interfaces.ts"/>

var ChatWindowOptions = (function () {
    function ChatWindowOptions() {
    }
    return ChatWindowOptions;
})();

// a generic window that shows in the bottom right corner. It can have any content in it.
var ChatWindow = (function () {
    function ChatWindow(options) {
        var _this = this;
        var chat = { 'in_group': false };
        var defaultOptions = new ChatWindowOptions();
        // defaultOptions.chatId =
        defaultOptions.otherUserId = [];
        defaultOptions.isMaximized = true;
        defaultOptions.canClose = true;
        defaultOptions.onCreated = function () {
        };
        defaultOptions.onClose = function () {
        };
        defaultOptions.onMaximizedStateChanged = function () {
        };

        this.options = $.extend({}, defaultOptions, options);

        // window
        this.$window = $("<div/>").addClass("chat-window");
        this.$window.appendTo($("body"));

        if (this.options.width)
            this.$window.css("width", this.options.width);

        // title
        this.$windowTitle = $("<div/>").addClass("chat-window-title");
        this.$windowTitle.appendTo(this.$window);
        var $windowTitle = this.$windowTitle;
        this.$text = $("<div/>").addClass("text").text(this.options.title);
        this.$text.appendTo(this.$windowTitle);

        this.$participants = $("<div/>").addClass("participants");
        this.$participants.insertAfter(this.$text);
        var $participants = this.$participants;
        this.$participants.click(function (){
            if(_this.options.otherUserId.length >= 1){
                if($(".showing-participants").length < 1){
                    $show_bar = $("<div/>").addClass("showing-participants");
                    $show_bar.insertBefore($windowTitle);
                    $participants.addClass("button-active");
                }else{
                    $(".showing-participants").remove();
                    $participants.removeClass("button-active")
                }
                var users = new Array;
                _this.options.otherUserId.forEach(function(element, index, array){
                    gon.users.forEach(function(el, ind, arr){
                        if(element == el.id)
                            users[index] = el.email;
                    })
                    $participant = $("<div/>").addClass("participant").attr("participant-id", element).appendTo($show_bar);
                    $participant_content = $("<div/>").addClass("participant-content").text(users[index]).appendTo($participant);
                    $participant_remove = $("<div/>").addClass("remove-from-chat").appendTo($participant);
                    (function(userId, chatId) {
                        $participant_remove.click(function(e){
                            $.ajax({
                                url: '/chat/'+chatId,
                                type: 'DELETE',
                                data: {participant_id: userId, id: chatId},
                                success: function(data){
                                    $chat_item = $(".chat-name[chat_id='"+ chatId +"']");
                                    if(_this.options.otherUserId.length > 1) {
                                        if(data && data.destroyed)
                                            $(".chat-name[chat_id='"+ chatId +"']").remove();
                                        _this.options.otherUserId.splice(_this.options.otherUserId.indexOf(element), 1);
                                        users = _this.options.otherUserId.slice();
                                        users.push(gon.current_user.id);
                                        users = sorting(users);
                                        $(".chat-name[chat_id='"+ chatId +"']").attr("participants_id", users);

                                        window.chatJs.pmWindows[0].otherUserId.splice(window.chatJs.pmWindows[0].otherUserId.indexOf(element), 1);
                                        $(".participant[participant-id='" + userId + "']").remove();

                                        window.chatJs.saveState();

                                        $(".chat-name[chat_id='"+ chatId +"'] .chat-content").remove();
                                        $chat_content = $("<div/>").addClass("chat-content").text(data.chat.name).appendTo($chat_item);
                                        (function (userId, chatId) {
                                            $chat_content.click(function () {
                                                window.chatJs.mainWindow.options.chatClicked(userId, chatId);
                                            });
                                        })(users, chatId);
                                    }else{
                                        window.chatJs.pmWindows[0].pmWindow.chatWindow.$window.remove();
                                        window.chatJs.pmWindows[0].pmWindow.chatWindow.options.onClose(window.chatJs.pmWindows[0].pmWindow.chatWindow);
                                        $chat_item.remove();
                                        $show_bar.remove();
                                    }
                                }
                            });
                        })
                    })(element, window.chatJs.pmWindows[0].chat_id);
                })
            }
        });            
        _this.$nameTextBox = $("<input />").addClass("chat-name-text-box");
        if (this.options.canClose) {
            _this.$text.click(function(e){
                chatId = window.chatJs.pmWindows[0].chat_id;
                e.stopPropagation();
                _this.$text.css("display", "none");
                _this.$nameTextBox = $("<input />").addClass("chat-name-text-box");
                _this.$nameTextBox.insertAfter(_this.$text);

                _this.$nameTextBox.keypress(function (e) {
                    if (e.which == 13 && _this.$nameTextBox.val()) {
                        e.preventDefault();
                        $.ajax({
                            url: '/chat/'+chatId+'/change_name',
                                type: 'PUT',
                                data: {name: _this.$nameTextBox.val().slice(0, 15)},
                                success: function(data){
                                    _this.$text.text(data.name);
                                    _this.$nameTextBox.remove();
                                    _this.$text.css("display", "block");
                                    if(data.in_group)
                                        $(".chat-name[chat_id='"+chatId+"'] .chat-content").text(data.name);
                                    window.chatJs.pmWindows[0].chat_name = data.name;
                                    window.chatJs.saveState();
                                }
                        })
                    }
                });
            })
            var $icon = $("<div/>").addClass("open-icon").appendTo(this.$participants);
                $("<div/>").addClass("participants-title").text(this.options.participants_title).appendTo(this.$participants);
            var $closeButton = $("<div/>").addClass("close").appendTo(this.$windowTitle);
            $closeButton.click(function (e) {
                e.stopPropagation();
                // removes the window
                _this.$window.remove();

                // triggers the event
                _this.options.onClose(_this);
            });
        }

        var $hideButton = $("<div/>").addClass("hide-button").appendTo(this.$windowTitle);
        $hideButton.click(function(){
            _this.toggleMaximizedState();
        })

        // content
        this.$windowContent = $("<div/>").addClass("chat-window-content").appendTo(this.$window);
        if (this.options.height)
            this.$windowContent.css("height", this.options.height);
        this.$windowInnerContent = $("<div/>").addClass("chat-window-inner-content").appendTo(this.$windowContent);
        if ( !($( ".chat-list-content" ).length) ) {
            this.$windowInnerContentChat = $("<div/>").addClass("chat-list-content").appendTo(this.$windowContent);
        }
        if(this.options.canClose && _this.$nameTextBox){
            _this.$windowContent.click(function(e){
                e.stopPropagation();
                _this.$text.css("display", "block");
                _this.$nameTextBox.remove();
            })
        }
        // wire everything up
        

        this.setState(this.options.isMaximized, false);

        this.options.onCreated(this);
    }
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

    ChatWindow.prototype.getWidth = function () {
        return this.$window.outerWidth();
    };

    ChatWindow.prototype.setRightOffset = function (offset) {
        this.$window.css("right", offset);
    };

    ChatWindow.prototype.setTitle = function (title) {
        $("div[class=text]", this.$windowTitle).text(title);
    };

    ChatWindow.prototype.setVisible = function (visible) {
        if (visible)
            this.$window.show();
        else
            this.$window.hide();
    };

    // returns whether the window is maximized
    ChatWindow.prototype.getState = function () {
        return !this.$window.hasClass("minimized");
    };

    ChatWindow.prototype.setState = function (state, triggerMaximizedStateEvent) {
        // windows are maximized if the this.$windowContent is visible
        if (typeof triggerMaximizedStateEvent === "undefined") { triggerMaximizedStateEvent = true; }
        if (state) {
            // if it can't expand and is maximized
            this.$window.removeClass("minimized");
            this.$windowContent.show();
        } else {
            // if it can't expand and is minimized
            this.$window.addClass("minimized");
            this.$windowContent.hide();
        }

        if (triggerMaximizedStateEvent)
            this.options.onMaximizedStateChanged(this, state);
    };

    ChatWindow.prototype.toggleMaximizedState = function () {
        this.setState(this.$window.hasClass("minimized"));
    };

    ChatWindow.prototype.focus = function () {
        //todo: Implement
    };
    return ChatWindow;
})();

// The actual plugin
$.chatWindow = function (options) {
    var chatWindow = new ChatWindow(options);
    return chatWindow;
};
//# sourceMappingURL=jquery.chatjs.window.js.map
