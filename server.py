"""Server for movie ratings app."""

from flask import Flask, render_template, request, flash, session, redirect, url_for
from model import connect_to_db, db
import datetime
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

@app.route("/users/<user_id>")
def generate_user_profile(user_id):
    """Generate user_profile.html"""

    user = crud.get_user_by_id(user_id)

    return render_template("user_profile.html", user=user)

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

@app.route('/logout')
def logout():
    """Log the current session out"""

    session.pop('user_email', None)
    flash('You were logged out')

    return redirect ('/')

@app.route("/profile")
def profile():
    """Generate Profile.html and check if there is a session user."""

    logged_in_email = session.get("user_email")
    if logged_in_email is None:
        flash("You must log in to see a profile page.")
        return redirect("/")
    
    user = crud.get_user_by_email(logged_in_email)

    return render_template("profile.html",user=user)

@app.route("/edit_profile_page")
def generate_edit_profile_page():
    """Generate edit_profile.html"""

    logged_email = session.get("user_email")
    user = crud.get_user_by_email(logged_email)

    return render_template("edit_profile.html", user=user)

@app.route("/edit_profile", methods=["POST"])
def edit_profile():
    """Edit profile data"""

    logged_email = session.get("user_email")
    user = crud.get_user_by_email(logged_email)

    password = request.form.get("password")
    display_name = request.form.get("display_name")
    birthday = request.form.get("birthday")
    about_me = request.form.get("about_me")
    hobbies = request.form.get("hobbies")

    user.password = password
    user.display_name = display_name
    user.birthday = birthday
    user.about_me = about_me
    user.hobbies = hobbies

    db.session.commit()

    return redirect('/profile')
    
@app.route("/locations")
def locations_form():
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

@app.route("/locations/<location_id>")
def location_details(location_id):
    """Renders location_details.html"""

    logged_email = session.get("user_email")
    
    if logged_email is None:
        flash("You have to be logged in to see this page.")
        return redirect("/")

    location = crud.get_location_by_id(location_id)
    posts = crud.get_post_location_id(location_id=location.location_id)

    #Yelp Reviews API Pull request
    url = f"https://api.yelp.com/v3/businesses/{location.location_id}/reviews?limit=20&sort_by=yelp_sort"
    url1= f"https://api.yelp.com/v3/businesses/{location.location_id}"

    headers = {
    "accept": "application/json",
    "Authorization": f"Bearer {YELP_APIKEY}"
    }

   
    response = requests.get(url, headers=headers)
    response1= requests.get(url1, headers=headers)
    response = response.json()
    response1 = response1.json()

    for hours in response1['hours'][0]['open']:
        for item in hours:
            if item =='start' or item =='end':
                military_hour = hours[item]
                hour = datetime.datetime.strptime(military_hour, '%H%M').strftime('%I:%M %p')
                hours[item] = hour

    hours_dict = {'Monday' : {'when_open': "", 'is_closed_today': True},
                  'Tuesday' : {'when_open': "", 'is_closed_today': True},
                  'Wednesday' : {'when_open': "", 'is_closed_today': True},
                  'Thursday' : {'when_open': "", 'is_closed_today': True},
                  'Friday' : {'when_open': "", 'is_closed_today': True},
                  'Saturday' : {'when_open': "", 'is_closed_today': True},
                  'Sunday' : {'when_open': "", 'is_closed_today': True}
    }
    def set_hours(day):
        if hours_dict[day]['when_open'] == "":
            hours_dict[day]['when_open'] += f"{hours_info['start']} - {hours_info['end']}"
        else:
            hours_dict[day]['when_open'] += f", {hours_info['start']} - {hours_info['end']}"
        hours_dict[day]['is_closed_today'] = False
    
    for hours_info in response1['hours'][0]['open']:
        if hours_info['day'] == 0:
            set_hours('Monday')
        elif hours_info['day'] == 1:
            set_hours('Tuesday')
        elif hours_info['day'] == 2:
            set_hours('Wednesday')
        elif hours_info['day'] == 3:
            set_hours('Thursday')
        elif hours_info['day'] == 4:
            set_hours('Friday')
        elif hours_info['day'] == 5:
            set_hours('Saturday')
        elif hours_info['day'] == 6:
            set_hours('Sunday')

    
    return render_template("locations_details.html",location=location, posts=posts, reviews=response, hours=hours_dict )

@app.route('/save_post', methods=['POST'])
def get_post_body():
    """Grab json data via fetch in JS for the post body"""

    location_id = request.form.get('location_id')
    post_body = request.form.get('post_body')

    logged_email = session.get("user_email")
    user = crud.get_user_by_email(logged_email)

    make_post = crud.create_post(user_id=user.user_id, 
                                 location_id=location_id, 
                                 post_body=post_body)
    
    db.session.add(make_post)
    db.session.commit()
    print(location_id)
    print(post_body)

    return redirect(f'/locations/{location_id}')

@app.route('/savelocation', methods=["POST"])
def save_location_id():
    """Grab json data via fetch in JS for yelp api data on location."""

    location_id = request.json.get("locationid")
    name = request.json.get('name')
    address = request.json.get('address')
    city = request.json.get('city')
    zip_code = request.json.get('zip_code')
    country = request.json.get('country')
    state = request.json.get('state')
    url = request.json.get('url')
    phone_num = request.json.get('display_phone')
    img_url = request.json.get('img_url')
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
                                        img_url=img_url,
                                        rating=rating,
                                        review_count=review_count)
        db.session.add(location)
        db.session.commit()
    
    logged_email = session.get("user_email")
    user = crud.get_user_by_email(logged_email)
    saved_loc = crud.get_saved_locations(user_id=user.user_id, location_id=location_id)
    if not saved_loc:
        saved_loc = crud.create_saved_locations(user_id=user.user_id,
                                          location_id=location_id)
        db.session.add(saved_loc)
        db.session.commit()

    return location_id

@app.route('/locations/<location_id>/delete_saved_location')
def delete_saved_location(location_id):
    """Delete saved location from table"""

    logged_email = session.get("user_email")
    user = crud.get_user_by_email(logged_email)
    location = crud.get_location_by_id(location_id)

    saved_location = crud.get_saved_locations(user_id=user.user_id, location_id=location.location_id)
    db.session.delete(saved_location)
    db.session.commit()

    return redirect('/profile')

if __name__ == "__main__":
    connect_to_db(app)
    app.run(host="0.0.0.0", debug=True)