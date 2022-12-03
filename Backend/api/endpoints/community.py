from django.http import JsonResponse
from django.core import serializers
from api.endpoints import book as bookEndpoint
from api.models import *

def create_review(request):
    user_id = request.POST.get("user_id", None)
    book_id = request.POST.get("book_id", None)
    content = request.POST.get("content", None)
    star = request.POST.get("stars", None)

    if user_id is None:
        return JsonResponse({'msg': 'User not logged in.', 'success': False}, safe=False)
    if book_id is None:
        return JsonResponse({'msg': 'Book not selected', 'success': False}, safe=False)

    try:
        user = Users.objects.get(id=user_id)
        book = Book.objects.get(id=book_id)
    except Users.DoesNotExist:
        return JsonResponse({'msg': 'User not exists.', 'success': False}, safe=False)
    except Book.DoesNotExist:
        return JsonResponse({'msg': 'Book not exists.', 'success': False}, safe=False)


    # today = datetime.date.today()
    # print("today", today)
    newReview = Review(user_id=user_id, book_id=book_id, review=content, stars=star)
    newReview.save()
    return JsonResponse({'msg': 'Review Create Success', 'review': {'review_id': newReview.id, "review": newReview.review,
                                                          "stars": newReview.stars,"user_id": newReview.user_id,
                                                          "book_id": newReview.book_id},"date":newReview.date,
                         'success': True}, safe=False)


def get_reviews(request):
    user_id = request.GET.get("user_id", None)
    review_type = request.GET.get("review_type", 1)
    # type = 1 get all reviews, sorted by post datetime
    # type = 2 get user-related reviews, sorted by post datetime
    if user_id is None:
        return JsonResponse({'msg': 'User is not logged in.', 'success': False}, safe=False)
    
    reviewsResp = []
    if review_type == '1':
        reviewsResp = Review.objects.all().order_by('-date')
        
    elif review_type == '2':
        related_book_ids = bookEndpoint.get_user_related_books(user_id)
        reviewsResp = Review.objects.filter(id__in=related_book_ids).order_by('-date')
    else:
        return JsonResponse({'msg': 'Invalid review type', 'success': False}, safe=False)
    
    reviews = []
    for review in reviewsResp:
        # user info
        user = Users.objects.get(id=review.user.id)

        # book info
        book = Book.objects.get(id=review.book.id)
        is_liked = True
        try:
            like = Likes.objects.get(user_id=user.id, review_id=review.id)
        except Likes.DoesNotExist:
            is_liked = False
        reviews.append({
            "id": review.id,
            "user_id": user.id,
            "user_name": user.first_name + " " + user.last_name,
            "user_avatar": user.profile_url,
            "book_id": book.id,
            "book_title": book.title,
            "book_author": book.authors,
            "book_cover": book.cover_url,
            "content": review.review,
            "date": review.date,
            "is_liked":is_liked,
        })
    
    response = {
        "success": True,
        "msg": "Success!",
        "reviews": reviews
    }
    return JsonResponse(response, safe=False)

def like_review(request):
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

    checkLike = Likes.objects.filter(user_id=user_id, review_id=review_id)
    if checkLike.exists():
        return JsonResponse({'msg': 'User already liked this review.', 'success': False}, safe=False)

    newLike = Likes(user_id=user_id, review_id=review_id)
    newLike.save()

    return JsonResponse(
        {'msg': 'Like Success', 'like': {'like_id': newLike.id, "review_id": newLike.review_id,
                                         "user_id": newLike.user_id},'success': True}, safe=False)



def unlike_review(request):
    user_id = request.POST.get("user_id", None)
    review_id = request.POST.get("review_id", None)

    if user_id is None:
        return JsonResponse({'msg': 'User not logged in.', 'success': False}, safe=False)
    if review_id is None:
        return JsonResponse({'msg': 'Review not selected', 'success': False}, safe=False)

    try:
        user = Users.objects.get(id=user_id)
        review = Review.objects.get(id=review_id)
        like = Likes.objects.get(user_id=user_id, review_id=review_id)
    except Users.DoesNotExist:
        return JsonResponse({'msg': 'User not exists.', 'success': False}, safe=False)
    except Review.DoesNotExist:
        return JsonResponse({'msg': 'Review not exists.', 'success': False}, safe=False)
    except Likes.DoesNotExist:
        return JsonResponse({'msg': 'Like not exists.', 'success': False}, safe=False)

    like.delete()
    return JsonResponse(
        {'msg': 'Unlike Success', 'success': True}, safe=False)

def delete_review(request):
    user_id = request.POST.get("user_id", None)
    review_id = request.POST.get("review_id", None)

    if user_id is None:
        return JsonResponse({'msg': 'User not logged in.', 'success': False}, safe=False)
    if review_id is None:
        return JsonResponse({'msg': 'Review not selected', 'success': False}, safe=False)

    try:
        review = Review.objects.get(user_id=user_id, id=review_id)
    except Review.DoesNotExist:
        return JsonResponse({'msg': 'Review not found or user is not the owner.', 'success': False}, safe=False)

    review.delete()
    return JsonResponse(
        {'msg': 'Delete Success', 'success': True}, safe=False)


