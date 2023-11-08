--
-- PostgreSQL database dump
--

-- Dumped from database version 13.12 (Ubuntu 13.12-1.pgdg22.04+1)
-- Dumped by pg_dump version 13.12 (Ubuntu 13.12-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: blocked; Type: TABLE; Schema: public; Owner: jkay
--

CREATE TABLE public.blocked (
    blocked_id integer NOT NULL,
    user_id integer,
    person_blocked character varying
);


ALTER TABLE public.blocked OWNER TO jkay;

--
-- Name: blocked_blocked_id_seq; Type: SEQUENCE; Schema: public; Owner: jkay
--

CREATE SEQUENCE public.blocked_blocked_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blocked_blocked_id_seq OWNER TO jkay;

--
-- Name: blocked_blocked_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jkay
--

ALTER SEQUENCE public.blocked_blocked_id_seq OWNED BY public.blocked.blocked_id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: jkay
--

CREATE TABLE public.locations (
    location_id character varying NOT NULL,
    name character varying,
    state character varying,
    city character varying,
    address character varying,
    zip_code integer,
    country character varying,
    url character varying,
    phone_num character varying,
    img_url character varying,
    rating character varying,
    review_count integer
);


ALTER TABLE public.locations OWNER TO jkay;

--
-- Name: matches; Type: TABLE; Schema: public; Owner: jkay
--

CREATE TABLE public.matches (
    matches_id integer NOT NULL,
    user_id integer,
    match_id integer
);


ALTER TABLE public.matches OWNER TO jkay;

--
-- Name: matches_matches_id_seq; Type: SEQUENCE; Schema: public; Owner: jkay
--

CREATE SEQUENCE public.matches_matches_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.matches_matches_id_seq OWNER TO jkay;

--
-- Name: matches_matches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jkay
--

ALTER SEQUENCE public.matches_matches_id_seq OWNED BY public.matches.matches_id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: jkay
--

CREATE TABLE public.messages (
    message_id integer NOT NULL,
    textch_id integer,
    user_id integer,
    content text,
    time_stamps timestamp without time zone
);


ALTER TABLE public.messages OWNER TO jkay;

--
-- Name: messages_message_id_seq; Type: SEQUENCE; Schema: public; Owner: jkay
--

CREATE SEQUENCE public.messages_message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messages_message_id_seq OWNER TO jkay;

--
-- Name: messages_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jkay
--

ALTER SEQUENCE public.messages_message_id_seq OWNED BY public.messages.message_id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: jkay
--

CREATE TABLE public.posts (
    post_id integer NOT NULL,
    user_id integer,
    location_id character varying,
    post_body text
);


ALTER TABLE public.posts OWNER TO jkay;

--
-- Name: posts_post_id_seq; Type: SEQUENCE; Schema: public; Owner: jkay
--

CREATE SEQUENCE public.posts_post_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.posts_post_id_seq OWNER TO jkay;

--
-- Name: posts_post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jkay
--

ALTER SEQUENCE public.posts_post_id_seq OWNED BY public.posts.post_id;


--
-- Name: ratings; Type: TABLE; Schema: public; Owner: jkay
--

CREATE TABLE public.ratings (
    rating_id integer NOT NULL,
    user_id integer,
    score integer,
    location_id character varying
);


ALTER TABLE public.ratings OWNER TO jkay;

--
-- Name: ratings_rating_id_seq; Type: SEQUENCE; Schema: public; Owner: jkay
--

CREATE SEQUENCE public.ratings_rating_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ratings_rating_id_seq OWNER TO jkay;

--
-- Name: ratings_rating_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jkay
--

ALTER SEQUENCE public.ratings_rating_id_seq OWNED BY public.ratings.rating_id;


--
-- Name: savedloc; Type: TABLE; Schema: public; Owner: jkay
--

CREATE TABLE public.savedloc (
    saved_id integer NOT NULL,
    user_id integer,
    location_id character varying
);


ALTER TABLE public.savedloc OWNER TO jkay;

--
-- Name: savedloc_saved_id_seq; Type: SEQUENCE; Schema: public; Owner: jkay
--

CREATE SEQUENCE public.savedloc_saved_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.savedloc_saved_id_seq OWNER TO jkay;

--
-- Name: savedloc_saved_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jkay
--

ALTER SEQUENCE public.savedloc_saved_id_seq OWNED BY public.savedloc.saved_id;


--
-- Name: textchs; Type: TABLE; Schema: public; Owner: jkay
--

CREATE TABLE public.textchs (
    textch_id integer NOT NULL,
    blocked_matched boolean,
    user1_id integer,
    user2_id integer
);


ALTER TABLE public.textchs OWNER TO jkay;

--
-- Name: textchs_textch_id_seq; Type: SEQUENCE; Schema: public; Owner: jkay
--

CREATE SEQUENCE public.textchs_textch_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.textchs_textch_id_seq OWNER TO jkay;

--
-- Name: textchs_textch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jkay
--

ALTER SEQUENCE public.textchs_textch_id_seq OWNED BY public.textchs.textch_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: jkay
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    display_name character varying,
    about_me text,
    hobbies text,
    profile_pic_url character varying,
    email character varying,
    password character varying,
    birthday date
);


ALTER TABLE public.users OWNER TO jkay;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: jkay
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO jkay;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jkay
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: blocked blocked_id; Type: DEFAULT; Schema: public; Owner: jkay
--

ALTER TABLE ONLY public.blocked ALTER COLUMN blocked_id SET DEFAULT nextval('public.blocked_blocked_id_seq'::regclass);


--
-- Name: matches matches_id; Type: DEFAULT; Schema: public; Owner: jkay
--

ALTER TABLE ONLY public.matches ALTER COLUMN matches_id SET DEFAULT nextval('public.matches_matches_id_seq'::regclass);


--
-- Name: messages message_id; Type: DEFAULT; Schema: public; Owner: jkay
--

ALTER TABLE ONLY public.messages ALTER COLUMN message_id SET DEFAULT nextval('public.messages_message_id_seq'::regclass);


--
-- Name: posts post_id; Type: DEFAULT; Schema: public; Owner: jkay
--

ALTER TABLE ONLY public.posts ALTER COLUMN post_id SET DEFAULT nextval('public.posts_post_id_seq'::regclass);


--
-- Name: ratings rating_id; Type: DEFAULT; Schema: public; Owner: jkay
--

ALTER TABLE ONLY public.ratings ALTER COLUMN rating_id SET DEFAULT nextval('public.ratings_rating_id_seq'::regclass);


--
-- Name: savedloc saved_id; Type: DEFAULT; Schema: public; Owner: jkay
--

ALTER TABLE ONLY public.savedloc ALTER COLUMN saved_id SET DEFAULT nextval('public.savedloc_saved_id_seq'::regclass);


--
-- Name: textchs textch_id; Type: DEFAULT; Schema: public; Owner: jkay
--

ALTER TABLE ONLY public.textchs ALTER COLUMN textch_id SET DEFAULT nextval('public.textchs_textch_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: jkay
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: blocked; Type: TABLE DATA; Schema: public; Owner: jkay
--

COPY public.blocked (blocked_id, user_id, person_blocked) FROM stdin;
\.


--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: jkay
--

COPY public.locations (location_id, name, state, city, address, zip_code, country, url, phone_num, img_url, rating, review_count) FROM stdin;
Qq3BZfms0C9hiu0DbZMRJQ	SF Basketball Academy	CA	San Francisco	['473 Eucalyptus Dr.', 'San Francisco, CA 94132']	94132	US	https://www.yelp.com/biz/sf-basketball-academy-san-francisco?adjust_creative=zcBUyLlSreuu-R71KXsilw&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=zcBUyLlSreuu-R71KXsilw	(415) 912-8878	https://s3-media1.fl.yelpcdn.com/bphoto/tnbKD7Q2KUXhmIFNVCSUUA/o.jpg	5.0	20
90KlSNNzeO_r95ZrxNQKGA	Bay City Basketball	CA	San Francisco	['4550 Geary Blvd', 'San Francisco, CA 94118']	94118	US	https://www.yelp.com/biz/bay-city-basketball-san-francisco-2?adjust_creative=zcBUyLlSreuu-R71KXsilw&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=zcBUyLlSreuu-R71KXsilw	(510) 910-3649	https://s3-media2.fl.yelpcdn.com/bphoto/HD15myeN5AX6hKMV2n6RzA/o.jpg	4.5	15
OfChrC1Iid_Ct36XekhHUQ	Sunset Recreation Center	CA	San Francisco	['2201 Lawton St', 'San Francisco, CA 94122']	94122	US	https://www.yelp.com/biz/sunset-recreation-center-san-francisco?adjust_creative=zcBUyLlSreuu-R71KXsilw&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=zcBUyLlSreuu-R71KXsilw	(415) 242-1070	https://s3-media2.fl.yelpcdn.com/bphoto/-azartPMvFjByaV41eryZg/o.jpg	4.0	47
QpdaZEaXOLTem_eQzC-fzw	Noe Court Playground	CA	San Francisco	['24TH And Douglas St', 'San Francisco, CA 94110']	94110	US	https://www.yelp.com/biz/noe-court-playground-san-francisco?adjust_creative=zcBUyLlSreuu-R71KXsilw&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=zcBUyLlSreuu-R71KXsilw		https://s3-media3.fl.yelpcdn.com/bphoto/fBm9App5I_TJ6inuHh4Mgw/o.jpg	3.5	20
Ncdi3ruiudpD06_a6s3xqg	Kogi Gogi BBQ	CA	San Francisco	['1358 9th Ave', 'San Francisco, CA 94122']	94122	US	https://www.yelp.com/biz/kogi-gogi-bbq-san-francisco-2?adjust_creative=zcBUyLlSreuu-R71KXsilw&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=zcBUyLlSreuu-R71KXsilw	(415) 702-6792	https://s3-media4.fl.yelpcdn.com/bphoto/WTAvIdZnjpyRQYYtNNzc3A/o.jpg	4.0	819
eBxkmr-hJ2KgpZQzEO3ArQ	Han Il Kwan	CA	San Francisco	['1802 Balboa St', 'San Francisco, CA 94121']	94121	US	https://www.yelp.com/biz/han-il-kwan-san-francisco?adjust_creative=zcBUyLlSreuu-R71KXsilw&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=zcBUyLlSreuu-R71KXsilw	(415) 752-4447	https://s3-media4.fl.yelpcdn.com/bphoto/rWMhKj9EU_TcmhJMUz602Q/o.jpg	4.0	1929
flGIuLUDPjd_CLP5XDIVtA	Rossi Pool	CA	San Francisco	['600 Arguello Blvd', 'San Francisco, CA 94118']	94118	US	https://www.yelp.com/biz/rossi-pool-san-francisco?adjust_creative=zcBUyLlSreuu-R71KXsilw&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=zcBUyLlSreuu-R71KXsilw	(628) 652-7230	https://s3-media1.fl.yelpcdn.com/bphoto/6ZacbojSLNmIoQsaZ574dw/o.jpg	4.0	48
2-gH951C8_2hr8IXApFw9g	SK Korean BBQ	CA	San Bruno	['1610 El Camino Real', 'San Bruno, CA 94066']	94066	US	https://www.yelp.com/biz/sk-korean-bbq-san-bruno?adjust_creative=zcBUyLlSreuu-R71KXsilw&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=zcBUyLlSreuu-R71KXsilw	(650) 583-0702	https://s3-media3.fl.yelpcdn.com/bphoto/2-huVoN-7EUoMHfx_cZYzg/o.jpg	3.5	1012
\.


--
-- Data for Name: matches; Type: TABLE DATA; Schema: public; Owner: jkay
--

COPY public.matches (matches_id, user_id, match_id) FROM stdin;
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: jkay
--

COPY public.messages (message_id, textch_id, user_id, content, time_stamps) FROM stdin;
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: jkay
--

COPY public.posts (post_id, user_id, location_id, post_body) FROM stdin;
1	23	Qq3BZfms0C9hiu0DbZMRJQ	This place looks like it would be a good learning opportunity!
2	23	OfChrC1Iid_Ct36XekhHUQ	Fun place to practice a little bit or run some 5's.
3	1	Ncdi3ruiudpD06_a6s3xqg	This place looks great y'all!
4	1	eBxkmr-hJ2KgpZQzEO3ArQ	This place looks great y'all!
5	1	flGIuLUDPjd_CLP5XDIVtA	Pool is nice and clean!
6	13	eBxkmr-hJ2KgpZQzEO3ArQ	This place does look great! Love the galbi jjim!
7	13	Ncdi3ruiudpD06_a6s3xqg	Love the pork belly!
8	13	flGIuLUDPjd_CLP5XDIVtA	I love getting some laps done here!
9	23	Ncdi3ruiudpD06_a6s3xqg	Bulgogi is my jam
10	23	eBxkmr-hJ2KgpZQzEO3ArQ	Steamed egg with kimchi and some galbi jjim omg.
11	18	eBxkmr-hJ2KgpZQzEO3ArQ	Ya'll definitely need to come here for the pork belly and soft tofu soup.
12	7	flGIuLUDPjd_CLP5XDIVtA	Does this place have a sauna?
13	7	eBxkmr-hJ2KgpZQzEO3ArQ	+1 on the tofu soup and steamed egg
14	23	Ncdi3ruiudpD06_a6s3xqg	I love kbbq!
15	23	Ncdi3ruiudpD06_a6s3xqg	I love pork belly!
\.


--
-- Data for Name: ratings; Type: TABLE DATA; Schema: public; Owner: jkay
--

COPY public.ratings (rating_id, user_id, score, location_id) FROM stdin;
\.


--
-- Data for Name: savedloc; Type: TABLE DATA; Schema: public; Owner: jkay
--

COPY public.savedloc (saved_id, user_id, location_id) FROM stdin;
5	1	Ncdi3ruiudpD06_a6s3xqg
6	1	eBxkmr-hJ2KgpZQzEO3ArQ
7	1	flGIuLUDPjd_CLP5XDIVtA
8	13	eBxkmr-hJ2KgpZQzEO3ArQ
9	13	Ncdi3ruiudpD06_a6s3xqg
10	13	flGIuLUDPjd_CLP5XDIVtA
11	23	Ncdi3ruiudpD06_a6s3xqg
12	23	eBxkmr-hJ2KgpZQzEO3ArQ
13	18	eBxkmr-hJ2KgpZQzEO3ArQ
14	18	Ncdi3ruiudpD06_a6s3xqg
15	7	flGIuLUDPjd_CLP5XDIVtA
16	7	eBxkmr-hJ2KgpZQzEO3ArQ
17	7	Ncdi3ruiudpD06_a6s3xqg
18	23	flGIuLUDPjd_CLP5XDIVtA
22	23	90KlSNNzeO_r95ZrxNQKGA
\.


--
-- Data for Name: textchs; Type: TABLE DATA; Schema: public; Owner: jkay
--

COPY public.textchs (textch_id, blocked_matched, user1_id, user2_id) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: jkay
--

COPY public.users (user_id, display_name, about_me, hobbies, profile_pic_url, email, password, birthday) FROM stdin;
2	user2	Hi, this is a test msg	Hi, this is a test msg	/static/images/2.jpg	user2@test.com	test	1998-10-02
3	user3	Hi, this is a test msg	Hi, this is a test msg	/static/images/3.jpg	user3@test.com	test	1998-10-03
4	user4	Hi, this is a test msg	Hi, this is a test msg	/static/images/4.jpg	user4@test.com	test	1998-10-04
5	user5	Hi, this is a test msg	Hi, this is a test msg	/static/images/5.jpg	user5@test.com	test	1998-10-05
6	user6	Hi, this is a test msg	Hi, this is a test msg	/static/images/6.jpg	user6@test.com	test	1998-10-06
8	user8	Hi, this is a test msg	Hi, this is a test msg	/static/images/8.jpg	user8@test.com	test	1998-10-08
9	user9	Hi, this is a test msg	Hi, this is a test msg	/static/images/9.jpg	user9@test.com	test	1998-10-09
10	user10	Hi, this is a test msg	Hi, this is a test msg	/static/images/10.jpg	user10@test.com	test	1998-10-10
11	user11	Hi, this is a test msg	Hi, this is a test msg	/static/images/11.jpg	user11@test.com	test	1998-10-11
12	user12	Hi, this is a test msg	Hi, this is a test msg	/static/images/12.jpg	user12@test.com	test	1998-10-12
14	user14	Hi, this is a test msg	Hi, this is a test msg	/static/images/14.jpg	user14@test.com	test	1998-10-14
15	user15	Hi, this is a test msg	Hi, this is a test msg	/static/images/15.jpg	user15@test.com	test	1998-10-15
16	user16	Hi, this is a test msg	Hi, this is a test msg	/static/images/16.jpg	user16@test.com	test	1998-10-16
17	user17	Hi, this is a test msg	Hi, this is a test msg	/static/images/17.jpg	user17@test.com	test	1998-10-17
19	user19	Hi, this is a test msg	Hi, this is a test msg	/static/images/19.jpg	user19@test.com	test	1998-10-19
20	user20	Hi, this is a test msg	Hi, this is a test msg	/static/images/20.jpg	user20@test.com	test	1998-10-20
21	user21	Hi, this is a test msg	Hi, this is a test msg	/static/images/21.jpg	user21@test.com	test	1998-10-21
22	user22	Hi, this is a test msg	Hi, this is a test msg	/static/images/22.jpg	user22@test.com	test	1998-10-22
1	Thomas	Born and raised in the bay, hope to meet other engineers in the area!	Baseball, golfing, and ping pong!	/static/images/1.jpg	user1@test.com	test	2023-11-03
13	Wendy	I love knitting and cats! 	Snuggling with my cat and gardening!	/static/images/13.jpg	user13@test.com	test	2023-11-01
18	Jen	Texas transplant to the bay area! 	Snuggling with my dog and cooking!	/static/images/18.jpg	user18@test.com	test	2023-11-02
7	Jon	East coast transplant looking for friends in the area!	Love basketball, running, and football!	/static/images/7.jpg	user7@test.com	asd	2023-10-07
23	JK	Born and raised in the Bay Area, love the Golden State Warriors!	Basketball!	https://res.cloudinary.com/dtan0lsvk/image/upload/v1699315860/lnkh2gb8yrdyrdxpxngn.jpg	kyi.justin@gmail.com	asd	1995-01-16
\.


--
-- Name: blocked_blocked_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jkay
--

SELECT pg_catalog.setval('public.blocked_blocked_id_seq', 1, false);


--
-- Name: matches_matches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jkay
--

SELECT pg_catalog.setval('public.matches_matches_id_seq', 1, false);


--
-- Name: messages_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jkay
--

SELECT pg_catalog.setval('public.messages_message_id_seq', 1, false);


--
-- Name: posts_post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jkay
--

SELECT pg_catalog.setval('public.posts_post_id_seq', 15, true);


--
-- Name: ratings_rating_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jkay
--

SELECT pg_catalog.setval('public.ratings_rating_id_seq', 1, false);


--
-- Name: savedloc_saved_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jkay
--

SELECT pg_catalog.setval('public.savedloc_saved_id_seq', 23, true);


--
-- Name: textchs_textch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jkay
--

SELECT pg_catalog.setval('public.textchs_textch_id_seq', 1, false);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jkay
--

SELECT pg_catalog.setval('public.users_user_id_seq', 23, true);


--
-- Name: blocked blocked_pkey; Type: CONSTRAINT; Schema: public; Owner: jkay
--

ALTER TABLE ONLY public.blocked
    ADD CONSTRAINT blocked_pkey PRIMARY KEY (blocked_id);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: jkay
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (location_id);


--
-- Name: matches matches_pkey; Type: CONSTRAINT; Schema: public; Owner: jkay
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_pkey PRIMARY KEY (matches_id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: jkay
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (message_id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: jkay
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (post_id);


--
-- Name: ratings ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: jkay
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT ratings_pkey PRIMARY KEY (rating_id);


--
-- Name: savedloc savedloc_pkey; Type: CONSTRAINT; Schema: public; Owner: jkay
--

ALTER TABLE ONLY public.savedloc
    ADD CONSTRAINT savedloc_pkey PRIMARY KEY (saved_id);


--
-- Name: textchs textchs_pkey; Type: CONSTRAINT; Schema: public; Owner: jkay
--

ALTER TABLE ONLY public.textchs
    ADD CONSTRAINT textchs_pkey PRIMARY KEY (textch_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: jkay
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: jkay
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: blocked blocked_person_blocked_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jkay
--

ALTER TABLE ONLY public.blocked
    ADD CONSTRAINT blocked_person_blocked_fkey FOREIGN KEY (person_blocked) REFERENCES public.users(email);


--
-- Name: blocked blocked_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jkay
--

ALTER TABLE ONLY public.blocked
    ADD CONSTRAINT blocked_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: matches matches_match_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jkay
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_match_id_fkey FOREIGN KEY (match_id) REFERENCES public.users(user_id);


--
-- Name: matches matches_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jkay
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: messages messages_textch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jkay
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_textch_id_fkey FOREIGN KEY (textch_id) REFERENCES public.textchs(textch_id);


--
-- Name: posts posts_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jkay
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(location_id);


--
-- Name: posts posts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jkay
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: ratings ratings_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jkay
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT ratings_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(location_id);


--
-- Name: ratings ratings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jkay
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT ratings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: savedloc savedloc_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jkay
--

ALTER TABLE ONLY public.savedloc
    ADD CONSTRAINT savedloc_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(location_id);


--
-- Name: savedloc savedloc_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jkay
--

ALTER TABLE ONLY public.savedloc
    ADD CONSTRAINT savedloc_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: textchs textchs_user1_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jkay
--

ALTER TABLE ONLY public.textchs
    ADD CONSTRAINT textchs_user1_id_fkey FOREIGN KEY (user1_id) REFERENCES public.users(user_id);


--
-- Name: textchs textchs_user2_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jkay
--

ALTER TABLE ONLY public.textchs
    ADD CONSTRAINT textchs_user2_id_fkey FOREIGN KEY (user2_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--

