"""Crud operations."""

from model import User, Location, SavedLocations, Matches, TextChannel, Message, Blocked, Ratings, Posts

def create_user(email, password, display_name, birthday, img_url, about_me, hobbies):
    """Create and return a new user."""

    user = User(email=email, password=password, display_name=display_name, birthday=birthday, profile_pic_url=img_url, about_me=about_me, hobbies=hobbies)

    return user

def get_users():
    """Return all users."""

    return User.query.all()

def get_user_by_id(user_id):
    """Return a user by primary key."""

    return User.query.get(user_id)

def get_user_by_email(email):
    """Return a user by email."""

    return User.query.filter(User.email == email).first()

def get_location():
    """Return all locations."""

    return Location.query.all()

def get_location_by_id(location_id):
    """Return a location by primary key."""

    return Location.query.get(location_id)

def get_locations_by_state(state):
    """Return locations by state"""

    return Location.query.filter(Location.state == state).all()

def get_locations_by_city(city):
    """Return locations by city"""

    return Location.query.filter(Location.city == city).all()

def create_location(location_id, name, address, city, state, country, zip_code, url, phone_num, img_url, rating, review_count):
    """Create new location."""

    location = Location(location_id=location_id,
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
    
    return location

def create_saved_locations(user_id, location_id):
    """Create saved location."""
    
    saved_loc = SavedLocations(user_id=user_id,
                               location_id=location_id)
    
    return saved_loc
    
def get_saved_locations(user_id, location_id):
    """Return all saved locations by user_id and location_id"""
    
    return SavedLocations.query.filter(SavedLocations.user_id == user_id, SavedLocations.location_id == location_id).first()

def get_saved_locations_by_user(user_id):
    """Return all saved locations by user_id"""

    return SavedLocations.query.filter(SavedLocations.user_id == user_id).all()


def create_post(user_id, location_id, post_body):
    """Create new post."""

    post = Posts(user_id=user_id,
                 location_id=location_id,
                 post_body=post_body)
    
    return post

def get_post_location_id(location_id):
    """Query all posts by users at given location id."""

    return Posts.query.filter_by(location_id=location_id).all()

def get_textChannel():
    """Return text channel"""

    return TextChannel.query.all

def create_textChannel(user1_id, user2_id):
    """Create new text channel."""

    text_channel = TextChannel(user1_id = user1_id,
                               user2_id = user2_id)
    
    return text_channel

def get_all_messages():
    """Return all messages"""

    return Message.query.all()

def create_message(user_id, content, time_stamps):
    """Create new message."""

    message = Message(user_id=user_id,
                      content=content,
                      time_stamps=time_stamps)
    
    return message





def create_rating(user, location, score):

    rating = Ratings(user=user, location=location, score=score)

    return rating

if __name__ == "__main__":
    from server import app

    connect_to_db(app)