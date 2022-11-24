from django.contrib import admin
from api.models import *

# Register your models here.
admin.site.register(Users)
admin.site.register(Book)
admin.site.register(BookCopy)
admin.site.register(Listing)
admin.site.register(Request)
admin.site.register(Review)
admin.site.register(TravelHistory)
admin.site.register(Messages)