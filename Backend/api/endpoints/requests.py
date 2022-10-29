from django.http import JsonResponse
from api.models import *


def get_copy_details(request):
    # THIS IS A GET METHOD. PARAMS WILL BE IN QUERY.

    user_id = request.GET.get("user_id", None)
    copy_id = request.GET.get("copy_id", None)

    if user_id is None:
        return JsonResponse({'msg': 'User is not logged in.', 'success': False}, safe=False)

    if copy_id is None:
        return JsonResponse({'msg': 'Copy ID not received.', 'success': False}, safe=False)

    # Check if copy exists:
    try:
        copy = BookCopy.objects.get(id=copy_id)
    except BookCopy.DoesNotExist:
        return JsonResponse({'msg': 'Book Copy Not Found.', 'success': False}, safe=False)

    # TODO: Fetch Copy Rating -> Need to get average of all reviews
    rating = 5

    # Fetch Travel History
    travelHistory = []
    travelPoints = TravelHistory.objects.filter(copy=copy)
    for travelPoint in travelPoints:
        travelHistory.append({
            "date": travelPoint.date,
            "user": travelPoint.user.first_name + " " + travelPoint.user.last_name,
            "lat": travelPoint.lat,
            "lon": travelPoint.lon
        })

    response = {
        "success": True,
        "msg": "Success!",
        "copy_id": copy_id,
        "book_id": copy.book.id,
        "status": copy.status,
        "travel_history": travelHistory,
        "cover_url": copy.book.cover_url,
        "title": copy.book.title,
        "author": copy.book.authors,
        "rating": rating,

        # TODO: Fetch these from DB:
        "shipping_expense": "requester",
        "willingness": "Same City",
        "book_condition": "Excellent",
        "note": "Fetch note from DB"
    }

    return JsonResponse(response, safe=False)


def create_request(request):
    # This is a POST endpoint
    # Fetch listing id, and user id from request body

    user_id = request.POST.get("user_id", None)
    copy_id = request.POST.get("book_id", None)
    listing_id = request.POST.get("listing_id", None)

    lat = request.POST.get("lat", None)
    lon = request.POST.get("lon", None)

    note = request.POST.get("note", None)
    status = 0

    # TODO: Check if listing exists and it's still available to be requested.
    # TODO: Check if requestor exists.
    # TODO: Check if this user has already made a request for this listing.
    # TODO: Check: Owner of the book cannot make a request to his own listing :P
    # TODO: Add error handling

    # Create new request in DB.
    request = Request(requester_id=user_id, copy_id=copy_id, listing_id=listing_id, lat=lat, lon=lon, note=note, status=status)
    request.save()
    
    return JsonResponse({'msg': 'Success!.', 'success': True, "request_id": request.id}, safe=False)


def takeActionOnRequest(request):

    user_id = request.POST.get("user_id", None)
    copy_id = request.POST.get("book_id", None)
    listing_id = request.POST.get("listing_id", None)

    # TODO: Read about status codes: https://docs.google.com/document/d/17V0KUq2AUdlq7JpJU4ABkw4SStUGPyKXFUmi9HRgz30/edit

    """
    TODO: If request is rejected, change status of request to 2 and do nothing else
    
    TODO: If request is accepted, change status of request to 1
          Change status of Listing to 1
          Change status of all other requests for this listing to 2 (Since they're declined)
          
          Add the new location to Travel History
    """

    return JsonResponse({'msg': 'Not implemented yet!.', 'success': False}, safe=False)