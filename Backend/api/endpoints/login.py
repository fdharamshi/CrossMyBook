from django.http import JsonResponse

from api.endpoints import requests
from api.models import Users


def login_request(request):
    email = request.POST.get("email", None)
    password = request.POST.get("password", None)

    if email is None or password is None:
        return JsonResponse({'msg': 'Email or password missing', 'success': False}, safe=False)

    try:
        user = Users.objects.get(email=email, password=password)
        return JsonResponse({'msg': 'Login Success', 'success': True, 'user': {'user_id': user.id,
                                                                               "profile_picture": user.profile_url,
                                                                               "first_name": user.first_name,
                                                                               "last_name": user.last_name}},
                            safe=False)
    except Users.DoesNotExist:
        return JsonResponse({'msg': 'Email or password incorrect', 'success': False}, safe=False)


def signup_request(request):
    email = request.POST.get("email", None)
    password = request.POST.get("password", None)
    firstName = request.POST.get("first_name", None)
    lastName = request.POST.get("last_name", None)

    if email is None or password is None or firstName is None or lastName is None:
        return JsonResponse({'msg': 'Some or all details are missing.', 'success': False}, safe=False)

    # TODO: Add validation

    # https://randomuser.me/api/?inc=picture
    try:
        response = requests.get("https://randomuser.me/api/?inc=picture")
        response = response.json()
        pictureURL = response["results"][0]["picture"]["large"]
    except:
        pictureURL = "https://xsgames.co/randomusers/assets/avatars/male/44.jpg"

    newUser = Users(first_name=firstName, last_name=lastName, email=email, password=password,
                    profile_url=pictureURL)

    newUser.save()
    return JsonResponse({'msg': 'Login Success', 'user': {'user_id': newUser.id, "profile_picture": newUser.profile_url,
                                                          "first_name": newUser.first_name,
                                                          "last_name": newUser.last_name},
                         'success': True}, safe=False)
