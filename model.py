"""Models for capstone proj"""

from datetime import datetime
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class User(db.Model):
    """A user."""

    __tablename__ = "users"

    user_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    display_name = db.Column(db.String)
    about_me = db.Column(db.Text, nullable = True)
    hobbies = db.Column(db.Text, nullable= True)
    profile_pic_url = db.Column(db.String, nullable=True)
    email = db.Column(db.String, unique=True)
    password = db.Column(db.String)
    birthday = db.Column(db.Date, nullable=True)
    

    saved_locs = db.relationship("SavedLocations", back_populates="user")
    ratings = db.relationship("Ratings", back_populates="user")

    def __repr__(self):
        return f"<User name={self.display_name} email= {self.email}>"

class Location(db.Model):
    """A location"""

    __tablename__ = "locations"

    location_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    name = db.Column(db.String)
    state = db.Column(db.String)
    city = db.Column(db.String)
    address = db.Column(db.String)

    saved_loc = db.relationship("SavedLocations", back_populates="location")
    ratings = db.relationship("Ratings", back_populates="location")
    
    def __repr__(self):
        return f"<Location name={self.name} address = {self.address} state={self.state} city ={self.city}>"

class SavedLocations(db.Model):
    """Saved locations/Associative Table"""

    __tablename__ = "savedloc"

    saved_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey("users.user_id"))
    location_id = db.Column(db.Integer, db.ForeignKey("locations.location_id"))

    user = db.relationship("User", back_populates="saved_locs")
    location = db.relationship("Location", back_populates="saved_loc")

    def __repr__(self):
        return f"<Saved Locations saved_id={self.saved_id} location_id={self.location_id}>"

class Matches(db.Model):
    """Matches, used to store id of user that is making the match and the user that got matched"""

    __tablename__ = "matches"

    matches_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey("users.user_id"))
    match_id = db.Column(db.Integer, db.ForeignKey("users.user_id"))

    
    def __repr__(self):
        return f"<Matches matches_id={self.matches_id} match_id={self.match_id}>"

class TextChannel(db.Model):
    """Discussion between 2 users"""

    __tablename__ = "textchs"

    textch_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    blocked_matched = db.Column(db.Boolean, default = False)
    user1_id = db.Column(db.Integer, db.ForeignKey("users.user_id"))
    user2_id = db.Column(db.Integer, db.ForeignKey("users.user_id"))

    messages = db.relationship("Message", back_populates="textch")

    def __repr__(self):
        return f"<Text Channel textch_id={self.textch_id} user1_id={self.user1_id} user2_id ={self.user2_id}>"
    
class Message(db.Model):
    """What is displayed inside the message tab"""

    __tablename__ = "messages"

    message_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    textch_id = db.Column(db.Integer, db.ForeignKey("textchs.textch_id"))
    user_id = db.Column(db.Integer)
    content = db.Column(db.Text)
    time_stamps = db.Column(db.DateTime)

    textch = db.relationship("TextChannel", back_populates="messages")

    def __repr__(self):
        return f"<Messages message_id={self.message_id} user_id ={self.user_id}>"

class Blocked(db.Model):
    """Users that are blocked"""

    __tablename__ = "blocked"

    blocked_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey("users.user_id"))
    person_blocked = db.Column(db.String, db.ForeignKey("users.email"))

    def __repr__(self):
        return f"<Blocked blocked_id={self.blocked_id} user_id ={self.user_id}>"
    

class Ratings(db.Model):
    """Ratings for locations"""

    __tablename__ = "ratings"

    rating_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey("users.user_id"))
    score = db.Column(db.Integer)
    location_id = db.Column(db.Integer, db.ForeignKey("locations.location_id"))

    user = db.relationship("User", back_populates="ratings")
    location = db.relationship("Location", back_populates="ratings")

    def __repr__(self):
        return f"<Ratings rating_id={self.rating_id} user_id ={self.user_id} location_id={self.location_id} score ={self.score}>"
    
def connect_to_db(flask_app, db_uri="postgresql:///capstone", echo=True):
    flask_app.config["SQLALCHEMY_DATABASE_URI"] = db_uri
    flask_app.config["SQLALCHEMY_ECHO"] = echo
    flask_app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

    db.app = flask_app
    db.init_app(flask_app)

    print("Connected to the db!")


if __name__ == "__main__":
    from flask import Flask

    app = Flask(__name__)
    connect_to_db(app)
