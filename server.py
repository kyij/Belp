"""Server for movie ratings app."""

from flask import Flask, render_template, request, flash, session, redirect, url_for
from model import connect_to_db, db
import crud
import cloudinary.uploader
import math
import os
import requests

from jinja2 import StrictUndefined

app = Flask(__name__)
app.secret_key = "dev"
app.jinja_env.undefined = StrictUndefined

CLOUDINARY_KEY = os.environ['CLOUDINARY_KEY']
CLOUDINARY_SECRET = os.environ['CLOUDINARY_SECRET']
CLOUD_NAME = "dtan0lsvk"
YELP_APIKEY =os.environ['YELP_APIKEY']

@app.route("/")
def homepage():
    """View homepage."""

    return render_template("homepage.html")

@app.route("/account")
def create_account_button():
    """Press this to create an account"""
    
    return render_template("create_account.html")


@app.route("/users")
def all_users():
    """View all users."""

    users = crud.get_users()

    return render_template("all_users.html", users=users)

@app.route("/users", methods=["POST"])
def register_user():
    """Create a new user."""

    email = request.form.get("email")
    password = request.form.get("password")
    display_name = request.form.get("display_name")
    birthday = request.form.get("birthday")
    about_me = request.form.get("about_me")
    hobbies = request.form.get("hobbies")

    profile_pic_url = request.files["profile_pic_url"]
    result = cloudinary.uploader.upload(profile_pic_url,
                                        api_key=CLOUDINARY_KEY,
                                        api_secret=CLOUDINARY_SECRET,
                                        cloud_name=CLOUD_NAME)
    img_url = result['secure_url']


    user = crud.get_user_by_email(email)
    if user:
        flash("Cannot create an account with that email. Try again.")
    else:
        user = crud.create_user(email, password, display_name, birthday, img_url, about_me, hobbies)
        db.session.add(user)
        db.session.commit()
        flash("Account created! Please log in.")

    return redirect("/")    

@app.route("/login")
def login_page():
    """Displays login page"""

    return render_template("log_in.html")

@app.route("/login", methods=["POST"])
def login_user():
    """Log in user."""

    email = request.form.get("email")
    password = request.form.get("password")

    user = crud.get_user_by_email(email)
    if not user or user.password != password:
        flash("The email or password you entered was incorrect.")
    else:
        # Log in user by storing the user's email in session
        session["user_email"] = user.email
        flash(f"Welcome back, {user.email}!")

    return redirect("/")

@app.route("/profile")
def profile():
    """Display Profile Data"""

    logged_in_email = session.get("user_email")
    if logged_in_email is None:
        flash("You must log in to see a profile page.")
        return redirect("/")
    
    user = crud.get_user_by_email(logged_in_email)


    return render_template("profile.html",user=user)

@app.route("/locations")
def locationsform():
    """Display locations page."""

    return render_template("locations.html")

@app.route("/displaylocations")
def get_search_results():
    """Search for locations on Yelp"""

    url = "https://api.yelp.com/v3/businesses/search"

    headers = {
    "accept": "application/json",
    "Authorization": f"Bearer {YELP_APIKEY}"
    }
    keywords = request.args.get('keywords')
    location = request.args.get('location')
    radius = request.args.get('radius')
    unit = request.args.get('unit')

    #Convert default meters to selected unit.
    if radius != "" or radius is not None:
        radius=float(radius)
        if unit == "Miles":
            radius = radius * 1609.34
        elif unit == "Kilometers":
            radius = radius * 1000
        radius = math.ceil(radius)

    payload ={
    'term': keywords,
    'location': location,
    'radius': radius,
    'limit':50,
    }

    response = requests.get(url, headers=headers, params=payload)
    response = response.json()
    
    return render_template("display_locations.html", locations=response)

@app.route('/savelocation', methods=["POST"])
def save_locationid():

    location_id = request.json.get("locationid")
    name = request.json.get('name')
    address = request.json.get('address')
    city = request.json.get('city')
    zip_code = request.json.get('zip_code')
    country = request.json.get('country')
    state = request.json.get('state')
    url = request.json.get('url')
    phone_num = request.json.get('display_phone')
    rating = request.json.get('rating')
    review_count = request.json.get('review_count')

    location = crud.get_location_by_id(location_id)
    if not location:
        location = crud.create_location(location_id=location_id,
                                        name=name,
                                        address=address,
                                        city=city,
                                        state=state,
                                        country=country,
                                        zip_code=zip_code,
                                        url=url,
                                        phone_num=phone_num,
                                        rating=rating,
                                        review_count=review_count)
        db.session.add(location)
        db.session.commit()
    
    logged_email = session.get("user_email")
    user = crud.get_user_by_email(logged_email)
    saved_loc = crud.create_saved_locations(user_id=user.user_id,
                                          location_id=location_id)
    db.session.add(saved_loc)
    db.session.commit()


    print(location_id)
    print(address)
    print(name)
    print(city)
    print(zip_code)
    print(country)
    print(state)
    print(url)
    print(phone_num)
    print(rating)
    print(review_count)

    return location_id


 

if __name__ == "__main__":
    connect_to_db(app)
    app.run(host="0.0.0.0", debug=True)