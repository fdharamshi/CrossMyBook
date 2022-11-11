from django.http import JsonResponse
from api.models import *


def getRequests(request):

    # THIS IS A GET REQUEST.

    user_id = request.GET.get("user_id", None)

    if user_id is None:
        return JsonResponse({'msg': 'User not found.', 'success': False}, safe=False)

    """
    0 = Request Sent
    1 = Request Accepted
    2 = Request Declined
    """

    # FETCH PENDING REQUESTS FOR THE USER:
    try:
        pending = Request.objects.filter(listing_id__in=Listing.objects.filter(user_id=user_id, status=0).values_list('id', flat=True), status=0)
        # My idea of it: Find all the listings this particular user has made. Then find all the requests for those listings
        # Which have status code 0
    except:
        return JsonResponse({'msg': 'Fail to fetch pending requests.', 'success': False}, safe=False)

    # FETCH ACCEPTED REQUESTS:
    try:
        accepted = Request.objects.filter(listing_id__in=Listing.objects.filter(user_id=user_id, status=1).values_list('id', flat=True), status=1)
    except:
        return JsonResponse({'msg': 'Fail to fetch acccepted requests.', 'success': False}, safe=False)

    pending_requests = []
    accepted_requests = []

    for r in pending:
        pending_requests.append({
            "user_id": r.requester.id,
            "user_name": r.requester.first_name + r.requester.last_name,
            "copy_id": r.copy.id,
            "listing_id": r.listing.id,
            "date": r.date,
            "lat": r.lat,
            "lon": r.lon,
            "note": r.note,
            "request_id": r.id,

            "cover_url": r.copy.book.cover_url,
            "title": r.copy.book.title
        })

    for r in accepted:
        accepted_requests.append({
            "user_id": r.requester.id,
            "user_name": r.requester.first_name + r.requester.last_name,
            "copy_id": r.copy.id,
            "listing_id": r.listing.id,
            "date": r.date,
            "lat": r.lat,
            "lon": r.lon,
            "note": r.note,
            "request_id": r.id,

            "cover_url": r.copy.book.cover_url,
            "title": r.copy.book.title
        })

    return JsonResponse({'msg': 'Success!', 'success': True, "pending_requests": pending_requests, "accepted_requests": accepted_requests}, safe=False)

