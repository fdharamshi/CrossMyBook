# Team-23
Repo for final project for Team 23  (67-643)

# CrossMyBook Backend - Django

Server hosted at: http://ec2-3-87-92-147.compute-1.amazonaws.com:8000

## Brief Information About the Project:

**About the App:**<br>
BookCrossing is defined as "the practice of leaving a book in a public place to be picked up and read by others, who then do likewise." Aiming to "make the whole world a library."

CrossMyBook app makes it simpler to participate in book crossing along with adding many features to the whole event.

Now, you can release a book into the wild, just by scanning the ISBN Barcode on the book. Any other user can request the book, and you can choose to accept/decline this request.

You can track how far your book has travelled, where it currently is and much more from the Map in the app.

You can read reviews and add reviews for the books that you've read, and be part of the community.

**How to run the code:**<br>
We've build this app for **iOS 16** and for **light mode**, and it works fine on the simulator as well as a physical iOS device.

**Packages required:**<br>
- SDWebImageSwiftUI: https://github.com/SDWebImage/SDWebImageSwiftUI.git
- CodeScanner: https://github.com/twostraws/CodeScanner
- WrappingHStack: https://github.com/dkk/WrappingHStack

## Features Swapped
We implemented a lot of huge C level features that we thought were more important than a few smaller B level features.
Implemented Features:
- [C] Messaging System was implemented
- [C] Onboarding Screens were implemented
- [C] Drawing lines on the map to denote the travel
- [C] A search bar on the Home Page to search a book
- [-] Unlike or delete reviews in User Dashboard Page

Skipped Features:
- [B] Replying to a review on the Community Page
- [B] Options in settings page that allow users to change basic information
- [C] Apple / Firebase push notifications

We have treated level C majorly as "Future Scope" but a few features from [C] made more sense to have in the app before a few of [B]

## Feature list A from sprint 5
- [Login & Signup] Users will create an account with email and password when they first use the app. After that, they will need to log in using the same email and password.
    - A login form for users to enter their email and password
    - A signup form for users to enter the username, email, and password
- [App Main Page] An overview of the app’s highlights. Users will jump to book detail or copy of the book page from the main page.
    - Static pictures for future campaigns or events
    - A book travel route picked by the App
- [Community] This is the platform where users exchange their thoughts about the books. They can view and write reviews, mark reviews as favorites and share them externally.
    - Reviews feed with username, DateTime, review contents, and a book card
    - A form for users to create book reviews. Fields include book name, rating, and contents.
- [User Dashboard] Users can view their personal information and related book copies from the dashboard.
    - Basic user information, including avatar username, id, and reviews data
    - A list view of books with their cover images. By clicking the cover, users can view the details of that book copy.
    - Users can use a tab to change between current and history book copies. Current copies are those the users own (they received them or released them but haven’t received requests from other users). History copies are those the users have “crossed” in the past (they successfully released them to others).
- [Book detail view] Users will be able to view the basic information of a book. If they find it interesting, they can click to view one of the copies or request the book.
    - Present information about the title, author, description, and available copies of a book.
    - Provide descriptions of available copies of the book and a button for requesting
- [Copy of the book detail view] Users will be able to view the details of each copy of the book and take actions based on conditions.
    - Present copy details, including travel history (without a map), shipping expense, willingness to ship, book condition, and notes from the current owner
    - A button to 
        - request the book if the user does not own the book
        - release the book if the user currently owns the book
        - edit release information if the user has released the copy, but no one has requested it yet
- [Request a book] When users find a book interesting, they can request the book from the book page or the book copy page.
    - A form for users to request a copy. Fields include username, address, zip code, and note.
- [Release a book] Users can release a new book by scanning or release an existing book by clicking the plus button on the bottom nav.
    - Barcode Scan to identify ISBN
    - A form for users to edit release information, including book details, notes, location, shipping option, travel distance, and condition.
- [Settings] A set of settings related to user accounts
    - A button for sign-out
    

## Feature list B from sprint 5
- [Community]
    - Buttons to like/ share/ reply to a book review
- [Request a book]
    - When users send a request, they will receive an alert
- [Release a book]
    - When users complete a release, they will receive an alert 
- [Notification & Action] When users receive a request from others, they will be able to check the detailed requirement and notes of the request and decide whether to accept or decline it.
    - A notification page displaying all the requests that a user have received
    - An action page where users can view the request information and accept or decline it by pressing the button on the bottom


## Testing the App:
- You can run the app, the server runs on an AWS EC2 instance, so no need to worry about that. 
- You can create a new user from the Signup Page and test out the app using this new user.
- If you need to check the Database, check the "Django Admin" section of the README file.


**ASSUMPTION:** We generally assume that the data on the backend (Django + MySQL) is consistent. HTTP requests may fail, but if it goes through, the incoming data will not be stale or incosistent.
Since this was a Mobile App Dev class, we did not focus or spend a lot of time to follow "best practices" on the backend design.


## Django Admin:
- Username: femindharamshi
- Password: test
- URL: `/admin`
- On the server: http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/admin


## Some basic information for the Developers:

### Endpoints
-  Endpoints go in files in api/endpoints
-  Do not forget to add these endpoints in crossmybookbackend/urls.py

### Requests
- To get POST parameters, use `request.POST.get("paramName", "DefaultValue")`
- To get GET/Query parameters, use `request.GET.get("paramName", "DefaultValue")`

### Models
- Models are location in api/models.py
- Everytime you make changes to models run:
    - `python3 manage.py makemigrations api`
    - `python3 manage.py migrate`

### Shell
Sometimes, you may need to check the DB using the terminal. To do so,
Run: `python3 manage.py shell`

Then import the model like: `from api.models import Users`
and then you can run python codes on it.

For example, to add a user:
```
newUser = Users(first_name="Femin", last_name="Dharamshi" ...)
newUser.save()
```


