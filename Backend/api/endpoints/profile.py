from django.http import JsonResponse
from api.models import *

def getProfile(request):

    # This is a GET request
    user_id = request.GET.get("user_id", None)

    # TODO: check if user exists
    if user_id is None:
        return JsonResponse({'msg': 'User not logged in.', 'success': False}, safe=False)

    try:
        user = Users.objects.get(id=user_id)
    except Users.DoesNotExist:
        return JsonResponse({'msg': 'User not logged in.', 'success': False}, safe=False)

    response = {
        "success": True,
        "msg": "Success!",
        # TODO: What other fields do we need? History?
        "first_name": user.first_name,
        "last_name": user.last_name,
        "email": user.email,
        "user_id": user.id,
        "profile_url": user.profile_url
    }
    return JsonResponse(response, safe=False)
