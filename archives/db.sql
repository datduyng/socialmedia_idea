-- first, run 
/**
-- intial setup
sqlite3 .data/sqlite.db 
.mode column
.headers on
.timer on
-- 
.read archives/db.sql


-- save the sqlite data base
sqlite3 .data/sqlite.db .dump > output.sql

-- show all table
*/

CREATE TABLE images (
  id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  image_url text NOT NULL,
  image_type text
);

CREATE TABLE users (
  id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  username VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  fullname VARCHAR(255),
  email VARCHAR(255) NOT NULL UNIQUE,
  
  personal_info text DEFAULT '{}',
  
  /*User location*/
  city VARCHAR(255) DEFAULT NULL, 
  state VARCHAR(255) DEFAULT NULL, 
  country VARCHAR(255) DEFAULT NULL,
  latitude DOUBLE DEFAULT NULL,
  longitude DOUBLE DEFAULT NULL
);

INSERT INTO users (id, username, password, email) VALUES (1, 'test', 'test', 'test@test.com');

INSERT INTO users (id, username, password, email) VALUES (2, 'mberg', 'fb', 'mberg@fb.com');

INSERT INTO users (id, username, password, email) VALUES (3, 'john', 'pass', 'john@john.com');

INSERT INTO users (id, username, password, email) VALUES (4, 'danna', 'pass', 'danna@danna.com');

INSERT INTO users (id, username, password, email) VALUES (5, 'sjob', 'apple', 'sjob@apple.com');
INSERT INTO users (id, username, password, email) VALUES (6, 'jock', 'apple', 'jock@apple.com');
INSERT INTO users (id, username, password, email) VALUES (7, 'timcook', 'apple', 'timcook@apple.com');
INSERT INTO users (id, username, password, email) VALUES (8, 'bomb', 'apple', 'bomb@apple.com');
INSERT INTO users (id, username, password, email) VALUES (9, 'a', 'apple', 'a@apple.com');
INSERT INTO users (id, username, password, email) VALUES (10, 'b', 'apple', 'b@apple.com');
INSERT INTO users (id, username, password, email) VALUES (11, 'c', 'apple', 'c@apple.com');
INSERT INTO users (id, username, password, email) VALUES (12, 'd', 'apple', 'd@apple.com');
INSERT INTO users (id, username, password, email) VALUES (13, 'e', 'apple', 'e@apple.com');
INSERT INTO users (id, username, password, email) VALUES (14, 'f', 'apple', 'f@apple.com');
INSERT INTO users (id, username, password, email) VALUES (15, 'g', 'apple', 'g@apple.com');
INSERT INTO users (id, username, password, email) VALUES (16, 'h', 'apple', 'h@apple.com');

CREATE TABLE relationships (
  id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  link_from text NOT NULL,
  link_to text NOT NULL,
  FOREIGN KEY (link_from) 
    REFERENCES users(id)
    ON DELETE CASCADE,

  FOREIGN KEY (link_to)
  	REFERENCES users(id)
    ON DELETE CASCADE
);

INSERT INTO relationships (link_from, link_to) VALUES ('9', '10');
INSERT INTO relationships (link_from, link_to) VALUES ('9', '13');
INSERT INTO relationships (link_from, link_to) VALUES ('9', '14');

INSERT INTO relationships (link_from, link_to) VALUES ('11', '14');
INSERT INTO relationships (link_from, link_to) VALUES ('11', '16');

CREATE TABLE posts (
  id integer PRIMARY KEY AUTOINCREMENT, 
  post_type integer NOT NULL,
  user__id integer NOT NULL, 
  title text NOT NULL,
  content text DEFAULT '{}',
  description text DEFAULT '',
  create_timestamp integer DEFAULT (CAST(strftime('%s','now') as integer)),
  last_modified_timestamp integer DEFAULT (CAST(strftime('%s','now') as integer)),
  
   FOREIGN KEY (user__id)
    REFERENCES users(id)
    ON DELETE CASCADE
);

CREATE TABLE post_types (
  id integer PRIMARY KEY AUTOINCREMENT,
  type text NOT NULL
);

INSERT INTO post_types (type) VALUES ('idea');
INSERT INTO post_types (type) VALUES ('project');


CREATE TABLE post_tag_select (
  id integer PRIMARY KEY AUTOINCREMENT,
  tag text NOT NULL
);

INSERT INTO post_tag_select (tag) VALUES ('Arduino');
INSERT INTO post_tag_select (tag) VALUES ('Start Up');
INSERT INTO post_tag_select (tag) VALUES ('Web App');
INSERT INTO post_tag_select (tag) VALUES ('Hobbiest');
INSERT INTO post_tag_select (tag) VALUES ('Fun');
INSERT INTO post_tag_select (tag) VALUES ('Science');
INSERT INTO post_tag_select (tag) VALUES ('Class Project');

CREATE TABLE post_tag (
  id integer PRIMARY KEY AUTOINCREMENT, 
  post__id integer NOT NULL, 
  tag__id integer NOT NULL,

   FOREIGN KEY (post__id)
    REFERENCES posts(id)
    ON DELETE CASCADE,

   FOREIGN KEY (tag__id)
    REFERENCES post_tag_select(id)
    ON DELETE CASCADE
);

CREATE TABLE user_post_action (
  id integer PRIMARY KEY AUTOINCREMENT, 
  post__id integer NOT NULL,
  user_post_action_select__id integer NOT NULL,
  user_action__id integer NOT NULL,
  
   FOREIGN KEY (post__id)
    REFERENCES posts(id)
    ON DELETE CASCADE,

   FOREIGN KEY (user_action__id)
    REFERENCES user_action(id)
    ON DELETE CASCADE
);

CREATE TABLE user_post_action_select (
  id integer PRIMARY KEY AUTOINCREMENT, 
  type text NOT NULL
  
);

INSERT INTO user_post_action_select (type) VALUES ('view');
INSERT INTO user_post_action_select (type) VALUES ('star');
INSERT INTO user_post_action_select (type) VALUES ('unstar');

CREATE TABLE user_interest_select (
  id integer PRIMARY KEY AUTOINCREMENT,
  val text NOT NULL
);

INSERT INTO user_interest_select (val) VALUES ('Art');
INSERT INTO user_interest_select (val) VALUES ('Music');
INSERT INTO user_interest_select (val) VALUES ('General');
INSERT INTO user_interest_select (val) VALUES ('web application');
INSERT INTO user_interest_select (val) VALUES ('start up');
INSERT INTO user_interest_select (val) VALUES ('technology');
INSERT INTO user_interest_select (val) VALUES ('sport');


CREATE TABLE user_interest (
  id integer PRIMARY KEY AUTOINCREMENT,
  user__id integer NOT NULL, 
  user_interest_select__id integer NOT NULL,

   FOREIGN KEY (user__id)
    REFERENCES users(id)
    ON DELETE CASCADE,

   FOREIGN KEY (user_interest_select__id)
    REFERENCES user_interest_select(id)
    ON DELETE CASCADE
);

CREATE TABLE user_action_select (
  id integer PRIMARY KEY AUTOINCREMENT,
  val text NOT NULL
);
INSERT INTO user_action_select (val) VALUES ('user_to_user');
INSERT INTO user_action_select (val) VALUES ('user_to_post');
INSERT INTO user_action_select (val) VALUES ('user_to_self');

CREATE TABLE user_action (
  id integer PRIMARY KEY AUTOINCREMENT,
  user__id integer NOT NULL,
  user_action_select__id integer NOT NULL,
  timestamp integer DEFAULT (CAST(strftime('%s','now') as integer)),
  
  FOREIGN KEY (user_action_select__id)
    REFERENCES user_action_select(id)
    ON DELETE CASCADE,

  FOREIGN KEY (user__id)
    REFERENCES users(id)
    ON DELETE CASCADE
);

CREATE TABLE user_user_action (
  id integer PRIMARY KEY AUTOINCREMENT,
  to_user__id integer NOT NULL,
  user_action__id integer NOT NULL,
  user_user_action_select__id integer NOT NULL,
  
  FOREIGN KEY (user_user_action_select__id)
    REFERENCES user_user_action_select(id)
    ON DELETE CASCADE,
  
  FOREIGN KEY (user_action__id)
    REFERENCES user_action(id)
    ON DELETE CASCADE,

  FOREIGN KEY (to_user__id)
  	REFERENCES users(id)
    ON DELETE CASCADE
);

CREATE TABLE user_user_action_select(
  id integer PRIMARY KEY AUTOINCREMENT,
  val text NOT NULL
);
INSERT INTO user_user_action_select (val) VALUES ('add friend');
INSERT INTO user_user_action_select (val) VALUES ('became member');