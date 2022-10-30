from django.http import JsonResponse
from api.models import *

def getRequests(request):

    # THIS IS A GET REQUEST.

    user_id = request.GET.get("user_id", None)

    # TODO: Check if user exists.

    """
    0 = Request Sent
    1 = Request Accepted
    2 = Request Declined
    """

    # FETCH PENDING REQUESTS FOR THE USER:
    pending = Request.objects.filter(listing__in=[Listing.objects.filter(user_id=user_id, status=0)], status=0)
    # TODO: Need to check if this query works.
    # My idea of it: Find all the listings this particular user has made. Then find all the requests for those listings
    # Which have status code 0

    # FETCH ACCEPTED REQUESTS:
    accepted = Request.objects.filter(listing__in=[Listing.objects.filter(user_id=user_id, status=1)], status=1)

    # TODO: Create JSON response and send it back.
    return JsonResponse({'msg': 'Not implemented yet!.', 'success': False}, safe=False)

