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

--delete a table and restart primarykey counter
delete from your_table;    
delete from sqlite_sequence where name='your_table';

-- show all table
*/

CREATE TABLE images (
  id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  image_url text NOT NULL,
  detail_data text NOT NULL,
  image_host VARCHAR(255),
  timestamp integer DEFAULT (CAST(strftime('%s','now') as integer)),
  image_type text /* posts, users, */
);

INSERT INTO images (image_url, detail_data, image_host, image_type) VALUES ('https://i.ibb.co/Yh4sC3B/a53965d19339.png', '{}', 'default', 'default');

CREATE TABLE users (
  id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  username VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  fullname VARCHAR(255),
  email VARCHAR(255) NOT NULL UNIQUE,
  
  personal_info text DEFAULT '{}',
  user_avatar_img__id INTEGER DEFAULT NULL,
  
  /*User location*/
  city VARCHAR(255) DEFAULT NULL, 
  state VARCHAR(255) DEFAULT NULL, 
  country VARCHAR(255) DEFAULT NULL,
  latitude DOUBLE DEFAULT NULL,
  longitude DOUBLE DEFAULT NULL,
  last_login_timestamp integer DEFAULT (CAST(strftime('%s','now') as integer)),

  FOREIGN KEY (user_avatar_img__id)
  	REFERENCES images(id)
    ON DELETE CASCADE
);

INSERT INTO users (id, username, password, email,user_avatar_img__id) VALUES (1, 'test', 'test', 'test@test.com',1);

INSERT INTO users (id, username, password, email,user_avatar_img__id) VALUES (2, 'mberg', 'fb', 'mberg@fb.com',1);

INSERT INTO users (id, username, password, email,user_avatar_img__id) VALUES (3, 'john', 'pass', 'john@john.com',1);

INSERT INTO users (id, username, password, email,user_avatar_img__id) VALUES (4, 'danna', 'pass', 'danna@danna.com',1);

INSERT INTO users (id, username, password, email,user_avatar_img__id) VALUES (5, 'sjob', 'apple', 'sjob@apple.com',1);
INSERT INTO users (id, username, password, email,user_avatar_img__id) VALUES (6, 'jock', 'apple', 'jock@apple.com',1);
INSERT INTO users (id, username, password, email,user_avatar_img__id) VALUES (7, 'timcook', 'apple', 'timcook@apple.com',1);
INSERT INTO users (id, username, password, email,user_avatar_img__id) VALUES (8, 'bomb', 'apple', 'bomb@apple.com',1);
INSERT INTO users (id, username, password, email,user_avatar_img__id) VALUES (9, 'a', 'apple', 'a@apple.com',1);
INSERT INTO users (id, username, password, email,user_avatar_img__id) VALUES (10, 'b', 'apple', 'b@apple.com',1);
INSERT INTO users (id, username, password, email,user_avatar_img__id) VALUES (11, 'c', 'apple', 'c@apple.com',1);
INSERT INTO users (id, username, password, email,user_avatar_img__id) VALUES (12, 'd', 'apple', 'd@apple.com',1);
INSERT INTO users (id, username, password, email,user_avatar_img__id) VALUES (13, 'e', 'apple', 'e@apple.com',1);
INSERT INTO users (id, username, password, email,user_avatar_img__id) VALUES (14, 'f', 'apple', 'f@apple.com',1);
INSERT INTO users (id, username, password, email,user_avatar_img__id) VALUES (15, 'g', 'apple', 'g@apple.com',1);
INSERT INTO users (id, username, password, email,user_avatar_img__id) VALUES (16, 'h', 'apple', 'h@apple.com',1);

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
  thumbnail__id INTEGER DEFAULT NULL,
  create_timestamp integer DEFAULT (CAST(strftime('%s','now') as integer)),
  last_modified_timestamp integer DEFAULT (CAST(strftime('%s','now') as integer)),

  FOREIGN KEY (user__id)
    REFERENCES users(id)
    ON DELETE CASCADE

  FOREIGN KEY (thumbnail__id)
    REFERENCES images(id)
    ON DELETE CASCADE
);

CREATE TABLE post_types (
  id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
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

CREATE TABLE user_interest_select (
  id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  val text NOT NULL
);

INSERT INTO user_interest_select (val) VALUES ('Arduino');
INSERT INTO user_interest_select (val) VALUES ('Start Up');
INSERT INTO user_interest_select (val) VALUES ('Web App');
INSERT INTO user_interest_select (val) VALUES ('Hobbiest');
INSERT INTO user_interest_select (val) VALUES ('Fun');
INSERT INTO user_interest_select (val) VALUES ('Science');
INSERT INTO user_interest_select (val) VALUES ('Class Project');


CREATE TABLE user_interest (
  id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  user__id integer NOT NULL, 
  user_interest_select__id integer NOT NULL,

   FOREIGN KEY (user__id)
    REFERENCES users(id)
    ON DELETE CASCADE,

   FOREIGN KEY (user_interest_select__id)
    REFERENCES user_interest_select(id)
    ON DELETE CASCADE
);


/* Only keep the most recent user_action */
CREATE TABLE user_action (
	id integer NOT NULL PRIMARY KEY AUTOINCREMENT,	
  full_log_user_action__id integer NOT NULL,

  FOREIGN KEY (full_log_user_action__id)
    REFERENCES full_log_user_action(id)
    ON DELETE CASCADE
);

/* Keep all user activities history*/
CREATE TABLE full_log_user_action(
	id integer NOT NULL PRIMARY KEY AUTOINCREMENT,	
  user__id integer NOT NULL,
  action_target_type VARCHAR(255) NOT NULL, /*u2u, u2p, u2s*/
  action_target__id integer NOT NULL,
  user_action_type__id integer NOT NULL,
  timestamp integer DEFAULT (CAST(strftime('%s','now') as integer)),

  FOREIGN KEY (user__id)
    REFERENCES users(id)
    ON DELETE CASCADE
);

CREATE TABLE user_action_type(
 id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
 status TINYINT DEFAULT 1,
 val VARCHAR(255) NOT NULL
);
/*u2p*/
INSERT INTO user_action_type (status, val) VALUES (1,'view');

INSERT INTO user_action_type (status, val) VALUES (1,'star');
INSERT INTO user_action_type (status, val) VALUES (-1,'star');

/*u2u*/
INSERT INTO user_action_type (status, val) VALUES (1,'friend');
INSERT INTO user_action_type (status, val) VALUES (-1,'friend');

INSERT INTO user_action_type (status, val) VALUES (1,'collaborate');
INSERT INTO user_action_type (status, val) VALUES (-1,'collaborate');

/*u2s*/
INSERT INTO user_action_type (status, val) VALUES (1,'join IdeaChain');
