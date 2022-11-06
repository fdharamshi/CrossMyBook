from django.http import JsonResponse
from api.models import *


def getProfile(request):
    # This is a GET request
    user_id = request.GET.get("user_id", None)

    # check if user exists
    if user_id is None:
        return JsonResponse({'msg': 'User not logged in.', 'success': False}, safe=False)

    try:
        user = Users.objects.get(id=user_id)
    except Users.DoesNotExist:
        return JsonResponse({'msg': 'User not logged in.', 'success': False}, safe=False)

    review_num = Review.objects.filter(user=user).count()
    response = {
        "success": True,
        "msg": "Success!",
        "first_name": user.first_name,
        "last_name": user.last_name,
        "email": user.email,
        "user_id": user.id,
        "profile_url": user.profile_url,
        "review_number": review_num
    }
    return JsonResponse(response, safe=False)
