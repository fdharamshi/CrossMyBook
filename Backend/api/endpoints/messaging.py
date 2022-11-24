from django.db.models import Q
from django.http import JsonResponse
from api.models import *


# Get all conversations for a user
def get_convo(request):
    user_id = int(request.GET.get("user_id", "-1"))

    # TODO: Check if user_id is present and not -1
    # TODO: -1 means the user id was not integer

    all_messages = Messages.objects.filter(Q(user1_id=user_id) | Q(user2_id=user_id))

    results = []
    temp_list = []

    for message in all_messages:
        if message.user1.id == user_id:
            other_user = message.user2
        else:
            other_user = message.user1

        if other_user.id in temp_list:
            continue
        else:
            temp_list.append(other_user.id)
            latest_message = Messages.objects.filter(user1=min(user_id, other_user.id),
                                                     user2=max(user_id, other_user.id)).latest("timestamp")
            results.append({
                "user": {
                    "name": other_user.first_name + " " + other_user.last_name,
                    "profile_url": other_user.profile_url,
                    "user_id": other_user.id,
                    "last_message": latest_message.timestamp
                },
            })

    return JsonResponse({'conversations': results, 'msg': "Success!", 'success': True}, safe=False)


# Get all messages in a particular conversation for a user
def get_messages(request):
    user1 = int(request.GET.get("user1", "-1"))
    user2 = int(request.GET.get("user2", "-1"))

    # TODO: Check if user1 and user2 are present and not -1
    # TODO: -1 means the user id was not integer

    results = []

    messages = Messages.objects.filter(user1=min(user1, user2), user2=max(user1, user2))
    first_user = Users.objects.get(id=user1)
    second_user = Users.objects.get(id=user2)

    response_user1 = {
        "name": first_user.first_name + " " + first_user.last_name,
        "id": first_user.id,
        "profile_url": first_user.profile_url
    }

    response_user2 = {
        "name": second_user.first_name + " " + second_user.last_name,
        "id": second_user.id,
        "profile_url": second_user.profile_url
    }

    for message in messages:
        results.append({
            "sender": message.sender.id,
            "message": message.message,
            "timestamp": message.timestamp
        })

    return JsonResponse(
        {'messages': results, "user1": response_user1, "user2": response_user2, 'msg': "Success!", 'success': True},
        safe=False)


def sendMessage(request):
    sender = int(request.GET.get("sender", "-1"))
    receiver = int(request.GET.get("receiver", "-1"))
    message = request.POST.get("message", "")

    # TODO: Check if sender and receiver are present and not -1
    # TODO: Check if message is not empty
    # TODO: -1 means the user id was not integer

    try:
        newMessage = Messages(
            user1_id=min(sender, receiver),
            user2_id=max(sender, receiver),
            sender_id=sender,
            message=message
        )
        newMessage.save()

        return JsonResponse({'msg': 'Success', 'success': False}, safe=False)
    except:
        return JsonResponse({'msg': 'Something went wrong.', 'success': False}, safe=False)
