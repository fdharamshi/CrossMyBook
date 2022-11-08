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
            "listing_id": copy.id,
            "title": copy.book.title,
            "cover_url": copy.book.cover_url,
            "author": copy.book.authors
        })

    return JsonResponse({'msg': 'Success!', 'success': True, "all_books": all_books, "all_copies": all_copies},
                        safe=False)