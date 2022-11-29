"""crossmybookbackend URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path

from api.endpoints import login, releases, requests, alertpage, community, book, mainpage, profile, messaging

urlpatterns = [
    # User authentication
    path('admin/', admin.site.urls),
    path('login', login.login_request),
    path('signup', login.signup_request),
    
    # release
    path('editRelease', releases.editExistingRelease),
    path('releaseNew', releases.releaseANewCopy),
    path('release', releases.releaseACopyAlreadyCreated),

    # request
    path('createRequest', requests.create_request),
    path('getRequests', alertpage.getRequests),
    path('takeActionOnRequest', requests.takeActionOnRequest),

    # book and copy
    path('getLatestListingByCopyId', releases.getLatestListingByCopyId),
    path('getBookDetails', book.get_book_details),
    path('getCopyDetails', requests.get_copy_details),
    path('getBookByCopyId', book.get_book_by_copy_id),
    path('getBookFromISBN', releases.getDetailsFromISBN),

    # reviews
    path('createReview', community.create_review),
    path('getReviews', community.get_reviews),
    path('likeReview', community.like_review),
    path('unlikeReview', community.unlike_review),

    # user dashboard
    path('getBookByUserId', book.get_books_by_user_id),
    path('deleteReview', profile.delete_review),
    path('getMyReview', profile.get_my_reviews),
    path('getFavorReview', profile.get_favor_reviews),

    # other
    path('main', mainpage.temporary_main),
    path('getProfile', profile.getProfile),

    # Messaging
    path('getConversations', messaging.get_convo),
    path('getMessages', messaging.get_messages),
    path('sendMessage', messaging.sendMessage),
    
]
