from enum import unique
from django.db import models

###########################################################################
# Django Auto Creates ID field, so we do not need to explicitly create it #
###########################################################################

class Users(models.Model):
    first_name = models.CharField(max_length=50, blank=False)
    last_name = models.CharField(max_length=50, blank=False)
    email = models.CharField(max_length=1000, blank=False, unique=True)
    password = models.CharField(max_length=1000, blank=False)
    profile_url = models.TextField()

    class Meta:
        db_table = 'Users'

    def __str__(self):
        return f'#{self.id} - {self.first_name}'

class Book(models.Model):
    isbn = models.CharField(max_length=50)
    title = models.CharField(max_length=50)
    cover_url = models.TextField()
    authors = models.TextField(default="Author Not Found")
    description = models.TextField()

    class Meta:
        db_table = 'Book'

    def __str__(self):
        return f'#{self.id} - {self.title}'

class BookCopy(models.Model):
    book = models.ForeignKey(Book, on_delete=models.CASCADE)
    status = models.IntegerField()
    owner = models.ForeignKey(Users, on_delete=models.SET_NULL, null=True)

    class Meta:
        db_table = 'BookCopy'

    def __str__(self):
        return f'#{self.id} - {self.book.title} (Book ID: {self.book.id})'

class Listing(models.Model):
    copy = models.ForeignKey(BookCopy, on_delete=models.CASCADE)
    user = models.ForeignKey(Users, on_delete=models.CASCADE)
    lat = models.FloatField()
    lon = models.FloatField()
    book_condition = models.CharField(max_length=50)
    charges = models.CharField(max_length=50)
    max_distance = models.CharField(max_length=50)
    note = models.TextField(blank=True)
    status = models.IntegerField(default=0)
    post_date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f'#{self.id} - {self.copy.book.title} (Book ID: {self.copy.book.id}, Copy ID: {self.copy.id}) | Status: {self.status} | Listing By: {self.user.first_name}'

    class Meta:
        db_table = 'Listing'

class Request(models.Model):
    requester = models.ForeignKey(Users, on_delete=models.CASCADE)
    copy = models.ForeignKey(BookCopy, on_delete=models.CASCADE)
    listing = models.ForeignKey(Listing, on_delete=models.CASCADE)
    status = models.IntegerField()
    date = models.DateTimeField(auto_now_add=True)
    lat = models.FloatField()
    lon = models.FloatField()
    note = models.TextField(blank=True)

    def __str__(self):
        return f'#{self.id} - {self.copy.book.title} (Book ID: {self.copy.book.id}, Copy ID: {self.copy.id}) | Status: {self.status} | Request By: {self.requester.first_name}'

    class Meta:
        db_table = 'Request'

class TravelHistory(models.Model):
    copy = models.ForeignKey(BookCopy, on_delete=models.CASCADE)
    date = models.DateTimeField(auto_now_add=True)
    user = models.ForeignKey(Users, on_delete=models.CASCADE)
    lat = models.FloatField()
    lon = models.FloatField()

    class Meta:
        db_table = 'TravelHistory'

    def __str__(self):
        return f'#{self.id} - ({self.lat}, {self.lon}) {self.copy.book.title} (Copy ID: {self.copy.id}) - {self.user.first_name}'

class Review(models.Model):
    user = models.ForeignKey(Users, on_delete=models.CASCADE)
    book = models.ForeignKey(Book, on_delete=models.CASCADE)
    stars = models.IntegerField()
    review = models.TextField()
    date = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'Review'

class Messages(models.Model):
    message = models.TextField()
    user1 = models.ForeignKey(Users, on_delete=models.CASCADE, related_name="user1")
    user2 = models.ForeignKey(Users, on_delete=models.CASCADE, related_name="user2")
    timestamp = models.DateTimeField(auto_now_add=True)
    sender = models.ForeignKey(Users, on_delete=models.CASCADE, related_name="sender")

    class Meta:
        db_table = 'Messages'

    def __str__(self):
        return f'#{self.id} - {self.user1.first_name}({self.user1.id}) & {self.user2.first_name}({self.user2.id}) | FROM: {self.sender.first_name}'


class Likes(models.Model):
    user = models.ForeignKey(Users, on_delete=models.CASCADE)
    review = models.ForeignKey(Review, on_delete=models.CASCADE)
    date = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'Likes'

    def __str__(self):
        return f'#{self.id} {self.user.first_name} - {self.review.review}'