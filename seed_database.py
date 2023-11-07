import os
import json
from random import choice, randint
from datetime import datetime
from os import listdir

import crud
import model
import server

os.system("dropdb capstone")
os.system("createdb capstone")


model.connect_to_db(server.app)
model.db.create_all()


# user1 = model.User(display_name="justin", email="asd", password="asd")
# user2 = model.User(display_name="justi", email="as", password="as")
# user3 = model.User(display_name="just", email="a", password="as^?")
# model.db.session.add(user1)
# model.db.session.add(user2)
# model.db.session.add(user3)
# model.db.session.commit()


#Create 30 users with a random profile pic
for n in range(1,23):
    email = f"user{n}@test.com" 
    password = "test"
    display_name = f"user{n}"
    birthday =  f'10/{n}/1998'
    profile_pic_url = f'/static/images/{n}.jpg'
    about_me = "Hi, this is a test msg"
    hobbies = "Hi, this is a test msg"

    user= crud.create_user(email, password, display_name, birthday, profile_pic_url, about_me, hobbies)
    model.db.session.add(user)

model.db.session.commit()

# location1 = model.Location(location_id="1", name="SF", state="CA", city="SF", address="s", zip_code = 91123, country="USA", url="asd",phone_num="4152341234", img_url="asd")
# location2 = model.Location(location_id="2", name="SJ", state="CA", city="SJ", address="as",zip_code = 91123, country="USA", url="asd",phone_num="4152341234", img_url="asd")
# location3 = model.Location(location_id="3", name="DC", state="CA", city="DC", address="asd",zip_code = 91123, country="USA", url="asd",phone_num="4152341234", img_url="asd") 

# model.db.session.add(location1)
# model.db.session.add(location2)
# model.db.session.add(location3)
# model.db.session.commit()

# savedloc1 = model.SavedLocations(user_id=user1.user_id, location_id=location1.location_id)
# savedloc2 = model.SavedLocations(user_id=user2.user_id, location_id=location2.location_id)
# savedloc3 = model.SavedLocations(user_id=user1.user_id, location_id=location3.location_id)
# model.db.session.add(savedloc1)
# model.db.session.add(savedloc2)
# model.db.session.add(savedloc3)
# model.db.session.commit()

# post1 = model.Posts(user_id=user1.user_id, location_id=location1.location_id, post_body="asd")
# post2 = model.Posts(user_id=user2.user_id, location_id=location1.location_id, post_body="asd2")
# post3 = model.Posts(user_id=user1.user_id, location_id=location1.location_id, post_body="asd3")
# post4 = model.Posts(user_id=user2.user_id, location_id=location1.location_id, post_body="asd4")
# model.db.session.add(post1)
# model.db.session.add(post2)
# model.db.session.add(post3)
# model.db.session.add(post4)
# model.db.session.commit()

# matches1 = model.Matches(user_id=user1.user_id, match_id=user2.user_id)
# matches2 = model.Matches(user_id=user1.user_id, match_id=user3.user_id)
# matches3 = model.Matches(user_id=user2.user_id, match_id=user1.user_id)
# matches4 = model.Matches(user_id=user3.user_id, match_id=user2.user_id)

# model.db.session.add(matches1)
# model.db.session.add(matches2)
# model.db.session.add(matches3)
# model.db.session.add(matches4)
# model.db.session.commit()

# textch1 =model.TextChannel(user1_id=user1.user_id, user2_id=user2.user_id)
# model.db.session.add(textch1)
# model.db.session.commit()



# message1= model.Message(textch_id=textch1.textch_id, user_id=user1.user_id, content="asd", time_stamps=datetime.now())
# message2= model.Message(textch_id=textch1.textch_id, user_id=user2.user_id, content="asdd", time_stamps=datetime.now())
# message3= model.Message(textch_id=textch1.textch_id, user_id=user1.user_id, content="hello", time_stamps=datetime.now())
# message4= model.Message(textch_id=textch1.textch_id, user_id=user2.user_id, content="bye", time_stamps=datetime.now())


# model.db.session.add(message1)
# model.db.session.add(message2)
# model.db.session.add(message3)
# model.db.session.add(message4)
# model.db.session.commit()


# blocked1= model.Blocked(user_id=user1.user_id, person_blocked=user3.email)
# blocked2= model.Blocked(user_id=user2.user_id, person_blocked=user3.email)
# model.db.session.add(blocked1)
# model.db.session.add(blocked2)


# ratings1 = model.Ratings(user_id=user1.user_id, score=5, location_id=location1.location_id)
# ratings2 = model.Ratings(user_id=user1.user_id, score=5, location_id=location2.location_id)
# ratings3 = model.Ratings(user_id=user2.user_id, score=4, location_id=location3.location_id)
# ratings4 = model.Ratings(user_id=user1.user_id, score=4, location_id=location3.location_id)
# ratings5 = model.Ratings(user_id=user2.user_id, score=4, location_id=location1.location_id)

# model.db.session.add(ratings1)
# model.db.session.add(ratings2)
# model.db.session.add(ratings3)
# model.db.session.add(ratings4)
# model.db.session.add(ratings5)
# model.db.session.commit()