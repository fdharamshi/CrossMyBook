from django.http import JsonResponse
import requests
from api.models import *


def getDetailsFromISBN(request):
    isbn = request.GET.get("isbn", None)

    if isbn is None:
        return JsonResponse({'msg': 'ISBN missing in request.', 'success': False}, safe=False)

    # Try to find ISBN in DB
    try:
        book = Book.objects.get(isbn=isbn)
    except Book.DoesNotExist:
        # FETCH from OpenLibrary

        # TODO: Needs error handling, if no book is found on openlibary for an isbn
        response = requests.get("https://openlibrary.org/isbn/"+isbn+".json")
        response = response.json()

        authors = ""
        # Iteratively fetch authors from openlibrary
        for author in response["authors"]:
            authorResponse = requests.get("https://openlibrary.org"+author["key"]+".json")
            authors = authors + authorResponse.json()["name"] + ", "
        authors=authors[:-2]

        book = Book(title=response['title'], isbn=isbn, cover_url="https://covers.openlibrary.org/b/id/"+str(response["covers"][0])+"-L.jpg", authors=authors)
        book.save()

    return JsonResponse({"isbn": book.isbn, "title": book.title, "cover_url": book.cover_url, "author": book.authors, "book_id": book.id, "rating": 5}, safe=False)


def releaseANewCopy(request):

    # THIS IS A POST REQUEST SINCE A NEW RECORD WILL BE CREATED.

    user_id = request.POST.get("user_id", None)
    book_id = request.POST.get("book_id", None)

    lat = request.POST.get("lat", None)
    lon = request.POST.get("lon", None)
    book_condition = request.POST.get("book_condition", None)
    charges = request.POST.get("charges", None)
    max_distance = request.POST.get("max_distance", None)
    note = request.POST.get("note", None)
    status = 0

    # TODO: Validations for the above field
    # TODO: Add error handling

    # CREATE A NEW COPY
    copy = BookCopy(book_id=book_id, status=0)
    copy.save()

    # CREATE A NEW LISTING
    new_listing = Listing(copy=copy, user_id=user_id, lat=lat, long=lon, book_condition=book_condition, charges=charges, max_distance=max_distance, note=note, status=status)
    new_listing.save()

    return JsonResponse({'msg': 'Success!', 'success': True, "listing_id": new_listing.id, "copy_id": copy.id}, safe=False)


def releaseACopyAlreadyCreated(request):

    user_id = request.POST.get("user_id", None)
    copy_id = request.POST.get("book_id", None)

    lat = request.POST.get("lat", None)
    lon = request.POST.get("lon", None)
    book_condition = request.POST.get("book_condition", None)
    charges = request.POST.get("charges", None)
    max_distance = request.POST.get("max_distance", None)
    note = request.POST.get("note", None)
    status = 0

    # TODO: Validations for the above field
    # TODO: Add error handling

    # FETCH THE COPY
    copy = BookCopy.objects.get(id=copy_id)
    # TODO: Change copy status

    # CREATE A NEW LISTING
    new_listing = Listing(copy=copy, user_id=user_id, lat=lat, long=lon, book_condition=book_condition, charges=charges,
                          max_distance=max_distance, note=note, status=status)
    new_listing.save()

    return JsonResponse({'msg': 'Success!', 'success': True, "listing_id": new_listing.id, "copy_id": copy.id},
                        safe=False)