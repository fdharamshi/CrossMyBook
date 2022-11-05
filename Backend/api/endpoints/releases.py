from symbol import except_clause
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
        return JsonResponse({"isbn": book.isbn, "title": book.title, "cover_url": book.cover_url, "author": book.authors, "book_id": book.id, "rating": 5}, safe=False)
    
    except Book.DoesNotExist:
        # FETCH from OpenLibrary

        try:
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
        
        except:
            return JsonResponse({'msg': 'Book not found.', 'success': False}, safe=False)


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

    if user_id is None or book_id is None or lat is None or lon is None or book_condition is None or charges is None or max_distance is None:
        return JsonResponse({'msg': 'Some or all details are missing.', 'success': False}, safe=False)

    # CREATE A NEW COPY
    try:
        copy = BookCopy(book_id=book_id, status=0)
        copy.save()
    except:
        return JsonResponse({'msg': 'Fail to create a new copy.', 'success': False}, safe=False)

    # CREATE A NEW LISTING
    try:
        new_listing = Listing(copy=copy, user_id=user_id, lat=lat, lon=lon, book_condition=book_condition, charges=charges, max_distance=max_distance, note=note, status=status)
        new_listing.save()
    except:
        return JsonResponse({'msg': 'Fail to create a new listing.', 'success': False}, safe=False)

    try:
        newTravelPoint = TravelHistory(copy=copy, user_id=user_id, lat=lat, lon=lon)
        newTravelPoint.save()
    except:
        return JsonResponse({'msg': 'Fail to create a new travel point.', 'success': False}, safe=False)

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

    if user_id is None or copy_id is None or lat is None or lon is None or book_condition is None or charges is None or max_distance is None:
        return JsonResponse({'msg': 'Some or all details are missing.', 'success': False}, safe=False)

    # FETCH THE COPY
    try:
        copy = BookCopy.objects.filter(id=copy_id).update(status=status)
    except BookCopy.DoesNotExist:
        return JsonResponse({'msg': 'Book copy not found.', 'success': False}, safe=False)

    # CREATE A NEW LISTING
    try:
        new_listing = Listing(copy=copy, user_id=user_id, lat=lat, long=lon, book_condition=book_condition, charges=charges,
                            max_distance=max_distance, note=note, status=status)
        new_listing.save()
    except:
        return JsonResponse({'msg': 'Fail to create a new listing.', 'success': False}, safe=False)

    return JsonResponse({'msg': 'Success!', 'success': True, "listing_id": new_listing.id, "copy_id": copy.id},
                        safe=False)
