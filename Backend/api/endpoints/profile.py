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


def delete_review(request):
    user_id = request.POST.get("user_id", None)
    review_id = request.POST.get("review_id", None)

    if user_id is None:
        return JsonResponse({'msg': 'User not logged in.', 'success': False}, safe=False)
    if review_id is None:
        return JsonResponse({'msg': 'Review not selected', 'success': False}, safe=False)

    try:
        user = Users.objects.get(id=user_id)
        review = Review.objects.get(id=review_id)
    except Users.DoesNotExist:
        return JsonResponse({'msg': 'User not exists.', 'success': False}, safe=False)
    except Review.DoesNotExist:
        return JsonResponse({'msg': 'Review not exists.', 'success': False}, safe=False)

    # delete all the likes related to the review
    checkLike = Likes.objects.filter(review_id=review_id)
    if checkLike.exists():
        checkLike.delete()
    review.delete()

    return JsonResponse(
        {'msg': 'Delete Review Success', 'success': True}, safe=False)


def get_my_reviews(request):
    user_id = request.GET.get("user_id", None)
    if user_id is None:
        return JsonResponse({'msg': 'User is not logged in.', 'success': False}, safe=False)

    reviewsResp = Review.objects.filter(user_id=user_id).order_by('-date')

    reviews = []
    for review in reviewsResp:
        # book info
        book = Book.objects.get(id=review.book.id)
        reviews.append({
            "id": review.id,
            "book_id": book.id,
            "book_title": book.title,
            "book_author": book.authors,
            "book_cover": book.cover_url,
            "content": review.review,
            "date": review.date,
        })

    response = {
        "success": True,
        "msg": "Success!",
        "reviews": reviews
    }
    return JsonResponse(response, safe=False)

def get_favor_reviews(request):
    user_id = request.GET.get("user_id", None)
    if user_id is None:
        return JsonResponse({'msg': 'User is not logged in.', 'success': False}, safe=False)

    likesResp = Likes.objects.filter(user_id=user_id).order_by('-date')

    reviews = []
    for like in likesResp:
        review = Review.objects.get(id=like.review_id)
        # book info
        book = Book.objects.get(id=review.book.id)
        reviews.append({
            "id": review.id,
            "book_id": book.id,
            "book_title": book.title,
            "book_author": book.authors,
            "book_cover": book.cover_url,
            "content": review.review,
            "date": review.date,
        })

    response = {
        "success": True,
        "msg": "Success!",
        "reviews": reviews
    }
    return JsonResponse(response, safe=False)
