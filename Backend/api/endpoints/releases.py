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
        response = requests.get("https://openlibrary.org/isbn/"+isbn+".json")
        response = response.json()

        authors = ""
        # Iteratively fetch authors
        for author in response["authors"]:
            authorResponse = requests.get("https://openlibrary.org"+author["key"]+".json")
            authors = authors + authorResponse.json()["name"] + ", "
        authors=authors[:-2]

        book = Book(title=response['title'], isbn=isbn, cover_url="https://covers.openlibrary.org/b/id/"+str(response["covers"][0])+"-L.jpg", authors=authors)
        book.save()

    return JsonResponse({"isbn": book.isbn, "title": book.title, "cover_url": book.cover_url, "author": book.authors, "book_id": book.id, "rating": 5}, safe=False)