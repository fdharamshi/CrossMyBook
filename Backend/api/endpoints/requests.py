from django.http import JsonResponse
from api.models import *
from django.db.models import Avg


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

    # get average of all reviews
    rating = {
        "stars__avg": 5
    }
    reviews = Review.objects.filter(book=copy.book)
    if reviews.count() > 0:
        rating = reviews.aggregate(Avg('stars'))

    # Fetch Travel History
    travelHistory = []
    travelPoints = TravelHistory.objects.filter(copy=copy).order_by('date')
    current_tp = travelPoints.last()

    if travelPoints.count() == 0:
        return JsonResponse({'msg': 'There is no travel history of the book', 'success': False}, safe=False)

    # get status
    # 0: available  1: unavailable
    # 2: owner, listed  3: owner, not listed
    cur_status = copy.status
    # get listing information
    try:
        listing = Listing.objects.get(copy_id=copy_id, status=0)
    except Listing.DoesNotExist:
        cur_status = 1;

    if int(current_tp.user_id) == int(user_id):
        cur_status += 2

    for travelPoint in travelPoints:
        travelHistory.append({
            "date": travelPoint.date,
            "user": travelPoint.user.first_name + " " + travelPoint.user.last_name,
            "user_picture": travelPoint.user.profile_url,
            "user_id": travelPoint.user.id,
            "lat": travelPoint.lat,
            "lon": travelPoint.lon
        })

    if cur_status == 0 or cur_status == 2:
        response = {
            "success": True,
            "msg": "Success!",
            "copy_id": copy_id,
            "book_id": copy.book.id,
            "status": cur_status,
            "travel_history": travelHistory,
            "cover_url": copy.book.cover_url,
            "title": copy.book.title,
            "author": copy.book.authors,
            "rating": rating,

            # information related with release
            "Listing": {
                "listing_id": listing.id,
                "shipping_expense": listing.charges,
                "willingness": listing.max_distance,
                "book_condition": listing.book_condition,
                "note": listing.note
            }
        }
    else:
        response = {
            "success": True,
            "msg": "Success!",
            "copy_id": copy_id,
            "book_id": copy.book.id,
            "status": cur_status,
            "travel_history": travelHistory,
            "cover_url": copy.book.cover_url,
            "title": copy.book.title,
            "author": copy.book.authors,
            "rating": rating,
        }

    return JsonResponse(response, safe=False)


def create_request(request):
    # This is a POST endpoint
    # Fetch listing id, and user id from request body

    user_id = request.POST.get("user_id", None)

    copy_id = request.POST.get("copy_id", None)

    listing_id = request.POST.get("listing_id", None)

    lat = request.POST.get("lat", None)
    lon = request.POST.get("lon", None)

    note = request.POST.get("note", None)
    if user_id is None:
        return JsonResponse({'msg': 'User is not logged in.', 'success': False}, safe=False)
    if listing_id is None:
        return JsonResponse({'msg': 'Parameter missing error.', 'success': False}, safe=False)
    if lat is None or lon is None:
        return JsonResponse({'msg': 'Location of user is not given.', 'success': False}, safe=False)

    status = 0
    # Check if listing exists and it's still available to be requested.
    try:
        listing = Listing.objects.get(id=listing_id,status=0)
    except Listing.DoesNotExist:
        return JsonResponse({'msg': 'Available Release Information Not Found.', 'success': False}, safe=False)

    # Check if requestor exists.
    try:
        user = Users.objects.get(id=user_id)
    except Users.DoesNotExist:
        return JsonResponse({'msg': 'Requestor not exists.', 'success': False}, safe=False)

    # Check if this user has already made a request for this listing.
    requests = Request.objects.filter(listing_id=listing_id,requester_id=user_id)
    if requests.exists():
        return JsonResponse({'msg': 'User has made a request for this listing.', 'success': False}, safe=False)


    # Check: Owner of the book cannot make a request to his own listing :P
    if int(user_id) == int(listing.user_id):
        return JsonResponse({'msg': 'Owner of the book cannot make a request to his own listing.', 'success': False}, safe=False)


    # Create new request in DB.
    request = Request(requester_id=user_id, copy_id=copy_id, listing_id=listing_id, lat=lat, lon=lon, note=note, status=status)
    request.save()
    
    return JsonResponse({'msg': 'Success!.', 'success': True, "request_id": request.id}, safe=False)


def takeActionOnRequest(request):
    user_id = request.POST.get("user_id", None)
    accepted = int(request.POST.get("accepted", 0))
    request_id = request.POST.get("request_id", None)
    # Read about status codes: https://docs.google.com/document/d/17V0KUq2AUdlq7JpJU4ABkw4SStUGPyKXFUmi9HRgz30/edit
    request = Request.objects.get(id=request_id)
    owner_id = request.listing.user.id

    # Check is user_id owns the listing
    if user_id != owner_id:
        return JsonResponse({'msg': 'User is not the owner of copy.', 'success': False}, safe=False)

    if accepted == 1:
        """
            If request is accepted, change status of request to 1
            Change status of Listing to 1
            Change status of all other requests for this listing to 2 (Since they're declined)

            Add the new location to Travel History
        """

        open_requests = Request.objects.filter(listing=request.listing)
        open_requests.update(status=2)
        request.status = 1
        request.save()

        travelPoint = TravelHistory(copy_id=request.listing.copy.id, lat=request.lat, lon=request.lon, user=request.requester)
        travelPoint.save()

        listing = request.listing
        listing.status = 1
        listing.save()

        return JsonResponse({'msg': 'Success!', 'success': True}, safe=False)

    else:
        # If request is rejected, change status of request to 2 and do nothing else
        request.status = 2
        request.save()
        return JsonResponse({'msg': 'Success!', 'success': True}, safe=False)
