from django.http import JsonResponse
from api.models import *


def temporary_main(request):
    all_listings = []
    all_books = []

    books = Book.objects.all()
    listings = Listing.objects.all()

    for book in books:
        all_books.append({
            "book_id": book.id,
            "title": book.title,
            "cover_url": book.cover_url,
            "author": book.authors
        })

    for listing in listings:
        all_listings.append({
            "listing_id": listing.id,
            "status": listing.status,
            "title": listing.copy.book.title,
            "cover_url": listing.copy.book.cover_url,
            "author": listing.copy.book.authors
        })

    return JsonResponse({'msg': 'Success!', 'success': True, "all_books": all_books, "all_listings": all_listings},
                        safe=False)