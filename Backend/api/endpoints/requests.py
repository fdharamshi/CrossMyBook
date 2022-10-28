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

    # Check if listing exists and it's still available to be requested.
    # Check if requestor exists.
    # Create new listing in DB.
    
    return JsonResponse({'msg': 'Not implemented yet.', 'success': False}, safe=False)