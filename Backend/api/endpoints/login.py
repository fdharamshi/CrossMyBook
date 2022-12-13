from django.http import JsonResponse

from api.endpoints import requests
from api.models import Users
import random


default_profile_options = [
    "https://images.pexels.com/photos/1490908/pexels-photo-1490908.jpeg?auto=compress&cs=tinysrgb&w=1600",
    "https://images.pexels.com/photos/46505/swiss-shepherd-dog-dog-pet-portrait-46505.jpeg?auto=compress&cs=tinysrgb&w=1600",
    "https://images.pexels.com/photos/825947/pexels-photo-825947.jpeg?auto=compress&cs=tinysrgb&w=1600",
    "https://images.pexels.com/photos/2253275/pexels-photo-2253275.jpeg?auto=compress&cs=tinysrgb&w=1600",
    "https://images.pexels.com/photos/1619690/pexels-photo-1619690.jpeg?auto=compress&cs=tinysrgb&w=1600",
    "https://images.pexels.com/photos/1938126/pexels-photo-1938126.jpeg?auto=compress&cs=tinysrgb&w=1600",
    "https://images.pexels.com/photos/7752793/pexels-photo-7752793.jpeg?auto=compress&cs=tinysrgb&w=1600",
    "https://images.pexels.com/photos/13085125/pexels-photo-13085125.jpeg?auto=compress&cs=tinysrgb&w=1600",
    "https://images.pexels.com/photos/5617166/pexels-photo-5617166.jpeg?auto=compress&cs=tinysrgb&w=1600",
    "https://images.pexels.com/photos/4695939/pexels-photo-4695939.jpeg?auto=compress&cs=tinysrgb&w=1600",
    "https://images.pexels.com/photos/12877342/pexels-photo-12877342.jpeg?auto=compress&cs=tinysrgb&w=1600"
]


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
    # try:
    #     response = requests.get("https://randomuser.me/api/?inc=picture")
    #     response = response.json()
    #     pictureURL = response["results"][0]["picture"]["large"]
    # except:
    #     pictureURL = "https://xsgames.co/randomusers/assets/avatars/male/44.jpg"

    # Temporarily choose a random Dog Image
    pictureURL = random.choice(default_profile_options)

    newUser = Users(first_name=firstName, last_name=lastName, email=email, password=password,
                    profile_url=pictureURL)

    newUser.save()
    return JsonResponse({'msg': 'Login Success', 'user': {'user_id': newUser.id, "profile_picture": newUser.profile_url,
                                                          "first_name": newUser.first_name,
                                                          "last_name": newUser.last_name},
                         'success': True}, safe=False)
