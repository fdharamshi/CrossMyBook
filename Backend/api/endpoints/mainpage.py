from django.http import JsonResponse
from api.models import *


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
