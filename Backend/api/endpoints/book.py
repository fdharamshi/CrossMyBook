from django.http import JsonResponse
from api.models import *
from django.db.models import Avg

def get_book_details(request):
    # THIS IS A GET METHOD. PARAMS WILL BE IN QUERY.
    book_id = request.GET.get("book_id", None)
    if book_id is None:
        return JsonResponse({'msg': 'Invalid book id!', 'success': False}, safe=False)  

    # Check if the book exists:
    try:
        book = Book.objects.get(id=book_id)
    except Book.DoesNotExist:
        return JsonResponse({'msg': 'Book Not Found.', 'success': False}, safe=False)

    # rating
    rating = 5
    reviews = Review.objects.filter(book=book)
    if reviews.count() > 0:
        rating = reviews.aggregate(rating=Avg('stars'))["rating"]
    
    # get copies of the book
    copiesResp = BookCopy.objects.filter(book=book_id)
    copies = []
    for copy in copiesResp:
        copy_detail = BookCopy.objects.get(id=copy.id)
        copies.append({
            "owner_name": copy_detail.owner.first_name,
            "owner_profile_url": copy_detail.owner.profile_url,
            "copy_id": copy_detail.id,
            "status": copy_detail.status,
        })
    reviewsResp = Review.objects.filter(book=book_id).order_by('-date')
    reviews = []
    for review in reviewsResp:
        user_detail = Users.objects.get(id=review.user_id)
        reviews.append({
            "user_name": user_detail.first_name + " " + user_detail.last_name,
            "date": review.date,
            "content": review.review,
            "review_id": review.id,
        })


    response = {
        "success": True,
        "msg": "Success!",
        "book_id": book.id,
        "title": book.title,
        "cover_url": book.cover_url,
        "isbn": book.isbn,
        "authors": book.authors,
        "rating": rating,
        "description": book.description,
        # information related with copies
        "copies" : copies,
        "reviews": reviews,
    }

    return JsonResponse(response, safe=False)

