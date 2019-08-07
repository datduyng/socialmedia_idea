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

INSERT INTO user_interest_select (val) VALUES ('Art');
INSERT INTO user_interest_select (val) VALUES ('Music');
INSERT INTO user_interest_select (val) VALUES ('General');
INSERT INTO user_interest_select (val) VALUES ('web application');
INSERT INTO user_interest_select (val) VALUES ('start up');
INSERT INTO user_interest_select (val) VALUES ('technology');
INSERT INTO user_interest_select (val) VALUES ('sport');


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
