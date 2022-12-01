# Team-23
Repo for final project for Team 23  (67-643)

# CrossMyBook Backend - Django

Server hosted at: http://ec2-3-87-92-147.compute-1.amazonaws.com:8000

## Django Admin:
- Username: femindharamshi
- Password: test
- URL: `/admin`
- On the server: http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/admin

## Some basic information:

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


