from django.http import JsonResponse
from api.models import *
import datetime

def create_review(request):
    user_id = request.GET.get("user_id", None)
    book_id = request.GET.get("book_id", None)
    content = request.GET.get("content", None)
    star = request.GET.get("stars", None)

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


    today = datetime.date.today()
    newReview = Review(user_id=user_id, book_id=book_id, review=content, stars=star,date=today)
    newReview.save()
    return JsonResponse({'msg': 'Review Create Success', 'review': {'review_id': newReview.id, "review": newReview.review,
                                                          "stars": newReview.stars,"user_id": newReview.user_id,
                                                          "book_id": newReview.book_id},"date":newReview.date,
                         'success': True}, safe=False)

