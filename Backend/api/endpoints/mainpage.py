from django.http import JsonResponse
from api.models import *
from django.db.models import Avg


def temporary_main(request):
    all_copies = []
    all_books = []

    books = Book.objects.all()
    copies = BookCopy.objects.all()

    for book in books:
        all_books.append({
            "book_id": book.id,
            "title": book.title,
            "cover_url": book.cover_url,
            "author": book.authors
        })

    for copy in copies:
        all_copies.append({
            "copy_id": copy.id,
            "title": copy.book.title,
            "cover_url": copy.book.cover_url,
            "author": copy.book.authors
        })

    return JsonResponse({'msg': 'Success!', 'success': True, "all_books": all_books, "all_copies": all_copies},
                        safe=False)

def get_available_copies(request):
    available_copies = []

    copies = BookCopy.objects.all()
    for copy in copies:
        # get status
        # 0: available  -1: unavailable
        cur_status = copy.status
        # get listing information
        try:
            listing = Listing.objects.get(copy_id=copy.id, status=0)
        except Listing.DoesNotExist:
            cur_status = -1

        if cur_status == 0:
            available_copies.append({
                "copy_id": copy.id,
                "title": copy.book.title,
                "cover_url": copy.book.cover_url,
                "author": copy.book.authors
            })

    return JsonResponse({'msg': 'Success!', 'success': True, "available_copies": available_copies}, safe=False)


def search(request):
    # TODO: Input validation

    searchString = request.GET.get("query", None)

    BookCopies = BookCopy.objects.filter(book__title__icontains=searchString)
    Books = Book.objects.filter(title__icontains=searchString)

    ResponseBooks = []
    ResponseCopies = []

    for book in Books:
        # get average of all reviews
        rating = {
            "stars__avg": 5
        }
        reviews = Review.objects.filter(book=book)
        if reviews.count() > 0:
            rating = reviews.aggregate(Avg('stars'))
        ResponseBooks.append({
            "title": book.title,
            "id": book.id,
            "cover_url": book.cover_url,
            "author": book.authors,
            "isbn": book.isbn,
            "rating": rating
        })

    for copy in BookCopies:
        # get average of all reviews
        rating = {
            "stars__avg": 5
        }
        reviews = Review.objects.filter(book=copy.book)
        if reviews.count() > 0:
            rating = reviews.aggregate(Avg('stars'))
        ResponseCopies.append({
            "title": copy.book.title,
            "copy_owner": copy.owner.first_name + " " + copy.owner.last_name,
            "copy_id": copy.id,
            "cover_url": copy.book.cover_url,
            "author": copy.book.authors,
            "isbn": copy.book.isbn,
            "book_id": copy.book.id,
            "status": copy.status,
            "rating": rating
        })

    return JsonResponse({'msg': 'Success!', 'success': True, "available_copies": ResponseCopies, "Books": ResponseBooks}, safe=False)