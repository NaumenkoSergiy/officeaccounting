@App = {}
# @App.cable = Cable.createConsumer('/cable')

# App.cable.subscriptions.create 'ChatChannel',
#   received: (data) ->
#     if chatJs.pmWindows[0].chat_id == parseInt(data.chat_id)
#       generateGuidPart = ->
#         ((1 + Math.random()) * 0x10000 | 0).toString(16).substring 1

#       clientGuid = generateGuidPart() + generateGuidPart() + '-' + generateGuidPart() + '-' + generateGuidPart() + '-' + generateGuidPart() + '-' + generateGuidPart() + generateGuidPart() + generateGuidPart()
#       bounceMessage = new ChatMessageInfo
#       bounceMessage.UserFromId = data.sender_id
#       bounceMessage.UserToId = data.recipients
#       bounceMessage.RoomId = 1
#       bounceMessage.Message = data.message_text
#       bounceMessage.ClientGuid = clientGuid
#       users = []
#       users = data.recipients
#       users.push data.sender_id
#       i = 0
#       while i < chatJs.options.adapter.client.messagesChangedHandlers.length
#         chatJs.options.adapter.client.messagesChangedHandlers[i] bounceMessage
#         i++
#     else if data.recipients.length < 2
#       $('.user-list-item[data-val-id=\'' + data.sender_id + '\']').addClass 'incoming-message'

$(document).ready ->

  $('.select2').select2()

  AjaxGetRecipients =
    url: '/users/recipients/'
    dataType: 'json'
    data: (term) ->
      { q: term }
    results: (data) ->
      { results: data['data'] }

  $('#recipients').select2
    minimumInputLength: 3
    multiple: true
    ajax: AjaxGetRecipients
