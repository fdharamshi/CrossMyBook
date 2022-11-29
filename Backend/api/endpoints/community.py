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
        })
    
    response = {
        "success": True,
        "msg": "Success!",
        "reviews": reviews
    }
    return JsonResponse(response, safe=False)


    