from django.http import JsonResponse
from api.models import *


def getRequests(request):

    # THIS IS A GET REQUEST.

    user_id = request.GET.get("user_id", None)

    # TODO: Check if user exists.
    # TODO: Add error handling

    """
    0 = Request Sent
    1 = Request Accepted
    2 = Request Declined
    """

    # FETCH PENDING REQUESTS FOR THE USER:
    pending = Request.objects.filter(listing_id__in=Listing.objects.filter(user_id=user_id, status=0).values_list('id', flat=True), status=0)
    # My idea of it: Find all the listings this particular user has made. Then find all the requests for those listings
    # Which have status code 0

    # FETCH ACCEPTED REQUESTS:
    accepted = Request.objects.filter(listing_id__in=Listing.objects.filter(user_id=user_id, status=1).values_list('id', flat=True), status=1)

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

            "title": r.copy.book.title
        })

    return JsonResponse({'msg': 'Success!', 'success': True, "pending_requests": pending_requests, "accepted_requests": accepted_requests}, safe=False)

