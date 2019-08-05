PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE ideas (
  id integer PRIMARY KEY AUTOINCREMENT, 
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
INSERT INTO "ideas" VALUES(1,2,'teste','{"pin":"ts","text":"test"}','',1562073214,1562073214);
INSERT INTO "ideas" VALUES(2,2,'tesat','{"pin":"sadfasdf","text":"asfasdfsda"}','',1562073335,1562073335);
INSERT INTO "ideas" VALUES(3,2,'te','{"pin":"test","text":"tst"}','',1562073397,1562073397);
INSERT INTO "ideas" VALUES(4,2,'tst','{"pin":"test","text":"test"}','',1562073438,1562073438);
INSERT INTO "ideas" VALUES(5,2,'tst','{"pin":"test","text":"test"}','',1562073463,1562073463);
INSERT INTO "ideas" VALUES(6,2,'eteas','{"pin":"ts","text":"tes"}','',1562073511,1562073511);
INSERT INTO "ideas" VALUES(7,2,'test','{"pin":"test","text":"test"}','',1562080590,1562080590);
INSERT INTO "ideas" VALUES(8,2,'test','{"pin":"test","text":"test"}','',1562087093,1562087093);
INSERT INTO "ideas" VALUES(9,2,'Regex failed to parse Tues Group','{"pin":"https://vuejs.org/images/logo.png","text":"Vuejs is the best"}','',1562095552,1562095552);
INSERT INTO "ideas" VALUES(10,2,'Flower','{"pin":"https://res.cloudinary.com/demo/image/upload/w_500/sample.jpg","text":"Flowers are the most beautiful things"}','',1562618576,1562618576);
INSERT INTO "ideas" VALUES(11,2,'Poison flower','{"pin":"https://images.pexels.com/photos/67636/rose-blue-flower-rose-blooms-67636.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500","text":"Whether you’re trying to convey gratitude, love or congratulations— there’s no better way to do so than with a fresh bouquet of flowers. That being said, delicate flowers offer beauty that may look harmless, but appearances can be deceiving. There are a variety of poisonous flowers that can be harmful, or even deadly, to humans and animals if ingested or touched.\r\n\r\nIt’s important to educate yourself on the harmful effects poisonous flowers can have. Common blooms including yarrow, foxgloves and some options on our site can have toxic properties, but that doesn’t mean you should avoid them completely. At ProFlowers you won’t have to wonder whether a flower is poisonous or not. Our packaging includes clear information on plants and flowers that may be potentially unsafe if ingested. It’s all about taking proper precautions.\r\n\r\nTo help you get a clearer idea of which flowers are the ones to watch out for, we’ve compiled a list of 20 poisonous flowers. Most of these flowers are safe to display or grow in your home, you’ll just need to keep them out of the path of curious children and pets. Browse through the options below to be sure you’re taking proper precautions and not putting anyone in harm’s way."}','',1562620856,1562620856);
INSERT INTO "ideas" VALUES(12,1,'Welcome','{"pin":"","text":"Not thing"}','',1562852593,1562852593);
INSERT INTO "ideas" VALUES(13,1,'asdasdasd','{"pin":"","text":"sdsdasd"}','',1562852649,1562852649);
INSERT INTO "ideas" VALUES(14,1,'test','{"pin":"","text":"test"}','',1562852725,1562852725);
INSERT INTO "ideas" VALUES(15,1,'test','{"pin":"","text":"test"}','',1562852946,1562852946);
INSERT INTO "ideas" VALUES(16,1,'te','{"pin":"","text":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo recusandae nulla rem eos ipsa praesentium esse magnam nemo dolor sequi fuga quia quaerat cum, obcaecati hic, molestias minima iste voluptates."}','',1562853181,1562853181);
INSERT INTO "ideas" VALUES(17,1,'test','{"pin":"","text":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo recusandae nulla re"}','',1562853373,1562853373);
INSERT INTO "ideas" VALUES(18,1,'','{"pin":"","text":""}','',1562853421,1562853421);
INSERT INTO "ideas" VALUES(19,1,'test','{"pin":"","text":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo recusandae nulla rem eos ipsa praesentium esse magnam nemo dolor sequi fuga quia q"}','',1562853469,1562853469);
INSERT INTO "ideas" VALUES(20,1,'test','{"pin":"","text":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo recusandae nulla rem eos ipsa praesentium esse magnam nemo dolor sequi fuga quia quaerat cum, obcaecati hic, molestias minima iste voluptates."}','',1562853581,1562853581);
INSERT INTO "ideas" VALUES(21,1,'test','{"pin":"","text":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo recusandae nulla rem eos ipsa praesentium esse magnam nemo dolor sequi fuga quia quaerat cum, obcaecati hic, molestias minima iste voluptates.\r\n\r\nLorem ipsum dolor sit amet consectetur adipisicing elit. Quo recusandae nulla rem eos ipsa praesentium esse magnam nemo dolor sequi fuga quia quaerat cum, obcaecati hic, molestias minima iste voluptates.Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo recusandae nulla rem eos ipsa praesentium esse magnam nemo dolor sequi fuga quia quaerat cum, obcaecati hic, molestias minima iste voluptates.Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo recusandae nulla rem eos ipsa praesentium esse magnam nemo dolor sequi fuga quia quaerat cum, obcaecati hic, molestias minima iste voluptates.Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo recusandae nulla rem eos ipsa praesentium esse magnam nemo dolor sequi fuga quia quaerat cum, obcaecati hic, molestias minima iste voluptates.Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo recusandae nulla rem eos ipsa praesentium esse magnam nemo dolor sequi fuga quia quaerat cum, obcaecati hic, molestias minima iste voluptates.Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo recusandae nulla rem eos ipsa praesentium esse magnam nemo dolor sequi fuga quia quaerat cum, obcaecati hic, molestias minima iste voluptates.Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo recusandae nulla rem eos ipsa praesentium esse magnam nemo dolor sequi fuga quia quaerat cum, obcaecati hic, molestias minima iste voluptates.Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo recusandae nulla rem eos ipsa praesentium esse magnam nemo dolor sequi fuga quia quaerat cum, obcaecati hic, molestias minima iste voluptates.Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo recusandae nulla rem eos ipsa praesentium esse magnam nemo dolor sequi fuga quia quaerat cum, obcaecati hic, molestias minima iste voluptates.Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo recusandae nulla rem eos ipsa praesentium esse magnam nemo dolor sequi fuga quia quaerat cum, obcaecati hic, molestias minima iste voluptates.Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo recusandae nulla rem eos ipsa praesentium esse magnam nemo dolor sequi fuga quia quaerat cum, obcaecati hic, molestias minima iste voluptates.Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo recusandae nulla rem eos ipsa praesentium esse magnam nemo dolor sequi fuga quia quaerat cum, obcaecati hic, molestias minima iste voluptates.Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo recusandae nulla rem eos ipsa praesentium esse magnam nemo dolor sequi fuga quia quaerat cum, obcaecati hic, molestias minima iste voluptates.Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo recusandae nulla rem eos ipsa praesentium esse magnam nemo dolor sequi fuga quia quaerat cum, obcaecati hic, molestias minima iste voluptates.Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo recusandae nulla rem eos ipsa praesentium esse magnam nemo dolor sequi fuga quia quaerat cum, obcaecati hic, molestias minima iste voluptates.Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo recusandae nulla rem eos ipsa praesentium esse magnam nemo dolor sequi fuga quia quaerat cum, obcaecati hic, molestias minima iste voluptates.Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo recusandae nulla rem eos ipsa praesentium esse magnam nemo dolor sequi fuga quia quaerat cum, obcaecati hic, molestias minima iste voluptates.Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo recusandae nulla rem eos ipsa praesentium esse magnam nemo dolor sequi fuga quia quaerat cum, obcaecati hic, molestias minima iste voluptates.Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo recusandae nulla rem eos ipsa praesentium esse magnam nemo dolor sequi fuga quia quaerat cum, obcaecati hic, molestias minima iste voluptates.Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo recusandae nulla rem eos ipsa praesentium esse magnam nemo dolor sequi fuga quia quaerat cum, obcaecati hic, molestias minima iste voluptates."}','',1562853603,1562853603);
INSERT INTO "ideas" VALUES(22,1,'test','{"pin":"","text":"I am the best"}','',1562853634,1562853634);
INSERT INTO "ideas" VALUES(23,1,'Welcome','{"pin":"https://picsum.photos/50/50","text":"I am new here"}','',1562853789,1562853789);
INSERT INTO "ideas" VALUES(24,1,'test','{"pin":"test","text":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo recusandae nulla rem eos ipsa praesentium esse magnam nemo dolor sequi fuga quia quaerat cum, obcaecati hic, molestias minima iste voluptates."}','',1562855823,1562855823);
INSERT INTO "ideas" VALUES(25,1,'Welcome','{"pin":"https://picsum.photos/50/50","text":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo recusandae nulla rem eos ipsa praesentium esse magnam nemo dolor sequi fuga quia quaerat cum, obcaecati hic, molestias minima iste voluptates."}','',1562855941,1562855941);
INSERT INTO "ideas" VALUES(26,1,'Welcome','{"pin":"","text":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo recusandae nulla rem eos ipsa praesentium esse magnam nemo dolor sequi fuga quia quaerat cum, obcaecati hic, molestias minima iste voluptates."}','',1562856065,1562856065);
INSERT INTO "ideas" VALUES(27,17,'Welcome','{"pin":"68502","text":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo recusandae nulla rem eos ipsa praesentium esse magnam nemo dolor sequi fuga quia quaerat cum, obcaecati hic, molestias minima iste voluptates."}','',1562856965,1562856965);
INSERT INTO "ideas" VALUES(28,17,'Welcome','{"pin":"68502","text":"asdasd"}','',1562857154,1562857154);
INSERT INTO "ideas" VALUES(29,1,'test','{"pin":"te","text":"tesddf"}','',1562878374,1562878374);
INSERT INTO "ideas" VALUES(30,1,'2d buoy','{"pin":"https://picsum.photos/50/50?random=2","text":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo recusandae nulla "}','',1562894852,1562894852);
INSERT INTO "ideas" VALUES(31,1,'Science Rock','{"pin":"https://upload.wikimedia.org/wikipedia/en/thumb/c/cd/March_for_Science.png/220px-March_for_Science.png","text":"I am thinking of science"}','',1563120837,1563120837);
CREATE TABLE idea_tag (
  id integer PRIMARY KEY AUTOINCREMENT, 
  idea__id integer NOT NULL, 
  tag__id integer NOT NULL,

   FOREIGN KEY (idea__id)
    REFERENCES ideas(id)
    ON DELETE CASCADE,

   FOREIGN KEY (tag__id)
    REFERENCES tags(id)
    ON DELETE CASCADE
);
INSERT INTO "idea_tag" VALUES(1,14,1);
INSERT INTO "idea_tag" VALUES(2,6,2);
INSERT INTO "idea_tag" VALUES(3,6,5);
INSERT INTO "idea_tag" VALUES(4,6,6);
INSERT INTO "idea_tag" VALUES(5,6,7);
INSERT INTO "idea_tag" VALUES(6,6,1);
INSERT INTO "idea_tag" VALUES(7,6,3);
INSERT INTO "idea_tag" VALUES(8,6,4);
INSERT INTO "idea_tag" VALUES(9,7,1);
INSERT INTO "idea_tag" VALUES(10,7,5);
INSERT INTO "idea_tag" VALUES(11,7,6);
INSERT INTO "idea_tag" VALUES(12,7,7);
INSERT INTO "idea_tag" VALUES(13,7,2);
INSERT INTO "idea_tag" VALUES(14,7,3);
INSERT INTO "idea_tag" VALUES(15,7,4);
INSERT INTO "idea_tag" VALUES(16,8,1);
INSERT INTO "idea_tag" VALUES(17,8,2);
INSERT INTO "idea_tag" VALUES(18,8,3);
INSERT INTO "idea_tag" VALUES(19,9,2);
INSERT INTO "idea_tag" VALUES(20,9,3);
INSERT INTO "idea_tag" VALUES(21,9,4);
INSERT INTO "idea_tag" VALUES(22,10,4);
INSERT INTO "idea_tag" VALUES(23,10,2);
INSERT INTO "idea_tag" VALUES(24,11,1);
INSERT INTO "idea_tag" VALUES(25,11,5);
INSERT INTO "idea_tag" VALUES(26,11,6);
INSERT INTO "idea_tag" VALUES(27,11,7);
INSERT INTO "idea_tag" VALUES(28,11,2);
INSERT INTO "idea_tag" VALUES(29,11,3);
INSERT INTO "idea_tag" VALUES(30,11,4);
INSERT INTO "idea_tag" VALUES(31,25,1);
INSERT INTO "idea_tag" VALUES(32,25,3);
INSERT INTO "idea_tag" VALUES(33,25,',');
INSERT INTO "idea_tag" VALUES(34,25,4);
INSERT INTO "idea_tag" VALUES(35,25,',');
INSERT INTO "idea_tag" VALUES(36,25,5);
INSERT INTO "idea_tag" VALUES(37,25,2);
INSERT INTO "idea_tag" VALUES(38,25,',');
INSERT INTO "idea_tag" VALUES(39,25,',');
INSERT INTO "idea_tag" VALUES(40,26,2);
INSERT INTO "idea_tag" VALUES(41,26,5);
INSERT INTO "idea_tag" VALUES(42,26,1);
INSERT INTO "idea_tag" VALUES(43,26,7);
INSERT INTO "idea_tag" VALUES(44,26,3);
INSERT INTO "idea_tag" VALUES(45,26,4);
INSERT INTO "idea_tag" VALUES(46,26,6);
INSERT INTO "idea_tag" VALUES(47,27,1);
INSERT INTO "idea_tag" VALUES(48,27,5);
INSERT INTO "idea_tag" VALUES(49,27,6);
INSERT INTO "idea_tag" VALUES(50,27,4);
INSERT INTO "idea_tag" VALUES(51,27,2);
INSERT INTO "idea_tag" VALUES(52,27,3);
INSERT INTO "idea_tag" VALUES(53,28,2);
INSERT INTO "idea_tag" VALUES(54,28,5);
INSERT INTO "idea_tag" VALUES(55,28,6);
INSERT INTO "idea_tag" VALUES(56,28,7);
INSERT INTO "idea_tag" VALUES(57,28,3);
INSERT INTO "idea_tag" VALUES(58,28,1);
INSERT INTO "idea_tag" VALUES(59,28,4);
INSERT INTO "idea_tag" VALUES(60,29,1);
INSERT INTO "idea_tag" VALUES(61,29,5);
INSERT INTO "idea_tag" VALUES(62,29,3);
INSERT INTO "idea_tag" VALUES(63,29,4);
INSERT INTO "idea_tag" VALUES(64,29,2);
INSERT INTO "idea_tag" VALUES(65,30,4);
INSERT INTO "idea_tag" VALUES(66,30,6);
INSERT INTO "idea_tag" VALUES(67,30,2);
INSERT INTO "idea_tag" VALUES(68,31,6);
INSERT INTO "idea_tag" VALUES(69,31,5);
INSERT INTO "idea_tag" VALUES(70,31,4);
CREATE TABLE users (
  id integer NOT NULL PRIMARY KEY,
  username text NOT NULL,
  password text NOT NULL,
  email text UNIQUE,
  personal_info text DEFAULT '{}'
);
INSERT INTO "users" VALUES(1,'test','test','test@test.com','{"username":"undefined","email":"test@test.com","status":"default","avatar_url":"https://picsum.photos/id/54/200/200","wallpaper_url":"https://picsum.photos/id/100/200/200"}');
INSERT INTO "users" VALUES(2,'mberg','fb','mberg@fb.com','{}');
INSERT INTO "users" VALUES(3,'john','pass','john@john.com','{}');
INSERT INTO "users" VALUES(4,'danna','pass','danna@danna.com','{}');
INSERT INTO "users" VALUES(5,'sjob','apple','sjob@apple.com','{}');
INSERT INTO "users" VALUES(6,'jock','apple','jock@apple.com','{}');
INSERT INTO "users" VALUES(7,'timcook','apple','timcook@apple.com','{}');
INSERT INTO "users" VALUES(8,'bomb','apple','bomb@apple.com','{}');
INSERT INTO "users" VALUES(9,'a','apple','a@apple.com','{"username":"New name","email":"a@apple.com","status":"default","avatar_url":"https://gravatar.com/avatar/2adff2097c830c7798c120f365f5766d?s=80&d=https://static.codepen.io/assets/avatars/user-avatar-80x80-bdcd44a3bfb9a5fd01eb8b86f9e033fa1a9897c3a15b33adfc2649a002dab1b6.png","wallpaper_url":"https://gravatar.com/avatar/2adff2097c830c7798c120f365f5766d?s=80&d=https://static.codepen.io/assets/avatars/user-avatar-80x80-bdcd44a3bfb9a5fd01eb8b86f9e033fa1a9897c3a15b33adfc2649a002dab1b6.png"}');
INSERT INTO "users" VALUES(10,'b','apple','b@apple.com','{}');
INSERT INTO "users" VALUES(11,'c','apple','c@apple.com','{}');
INSERT INTO "users" VALUES(12,'d','apple','d@apple.com','{}');
INSERT INTO "users" VALUES(13,'e','apple','e@apple.com','{}');
INSERT INTO "users" VALUES(14,'f','apple','f@apple.com','{}');
INSERT INTO "users" VALUES(15,'g','apple','g@apple.com','{}');
INSERT INTO "users" VALUES(16,'h','apple','h@apple.com','{}');
CREATE TABLE relationships (
  id integer PRIMARY KEY AUTOINCREMENT,
  link_from text NOT NULL,
  link_to text NOT NULL,
  FOREIGN KEY (link_from) 
    REFERENCES users(id)
    ON DELETE CASCADE,

  FOREIGN KEY (link_to)
  	REFERENCES users(id)
    ON DELETE CASCADE
);
INSERT INTO "relationships" VALUES(1,'9','10');
INSERT INTO "relationships" VALUES(2,'9','13');
INSERT INTO "relationships" VALUES(3,'9','14');
INSERT INTO "relationships" VALUES(4,'11','14');
INSERT INTO "relationships" VALUES(5,'11','16');
INSERT INTO "relationships" VALUES(6,'9','1');
INSERT INTO "relationships" VALUES(7,'2','1');
INSERT INTO "relationships" VALUES(8,'10','1');
INSERT INTO "relationships" VALUES(9,'11','2');
INSERT INTO "relationships" VALUES(10,'11','1');
INSERT INTO "relationships" VALUES(11,'11','10');
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
INSERT INTO "posts" VALUES(1,1,1,'Welcome','{"pin":"https://picsum.photos/id/579/50/50","text":"nothings"}','',1563204103,1563204103);
INSERT INTO "posts" VALUES(2,1,1,'Welcome again','{"pin":"https://picsum.photos/id/1000/500/500","text":"Nothing again"}','',1563204203,1563204203);
INSERT INTO "posts" VALUES(3,1,1,'Flower','{"pin":"https://picsum.photos/id/1200/500/500","text":"Most beautiful things"}','',1563204644,1563204644);
INSERT INTO "posts" VALUES(4,1,1,'Flower','{"pin":"https://picsum.photos/id/777/500/500","text":"KJust flower. Beautiful creature"}','',1563204876,1563204876);
INSERT INTO "posts" VALUES(5,1,1,'test','{"pin":"https://picsum.photos/id/123/500/500","text":"tesadasd"}','',1563205287,1563205287);
INSERT INTO "posts" VALUES(6,1,1,'Welcome 4 time','{"pin":"https://picsum.photos/id/452/500/500","text":"ssadfasdfas"}','',1563205485,1563205485);
INSERT INTO "posts" VALUES(7,1,1,'New days','{"pin":"https://picsum.photos/id/562/500/500","text":"new life"}','',1563206285,1563206285);
INSERT INTO "posts" VALUES(8,1,1,'New days','{"pin":"https://picsum.photos/id/234/500/500","text":"new lifes"}','',1563206333,1563206333);
INSERT INTO "posts" VALUES(9,1,1,'Poison flower','{"pin":"https://picsum.photos/id/642/500/500","text":"new flower type"}','',1563206470,1563206470);
INSERT INTO "posts" VALUES(10,1,1,'Flower','{"pin":"https://picsum.photos/id/3434/500/500","text":"new flower type "}','',1563206622,1563206622);
INSERT INTO "posts" VALUES(11,1,1,'Flower','{"pin":"https://picsum.photos/id/334/500/500","text":"new flower type "}','',1563206644,1563206644);
INSERT INTO "posts" VALUES(12,1,1,'Flower','{"pin":"https://picsum.photos/id/354/500/500","text":"new flower type "}','',1563206687,1563206687);
INSERT INTO "posts" VALUES(13,1,1,'Flower','{"pin":"https://picsum.photos/id/384/500/500","text":"new flower type "}','',1563206712,1563206712);
INSERT INTO "posts" VALUES(14,1,1,'new','{"pin":"https://picsum.photos/id/744/500/500","text":"nothing"}','',1563208533,1563208533);
INSERT INTO "posts" VALUES(15,1,1,'more new','{"pin":"https://picsum.photos/id/967/500/500","text":"nothing"}','',1563208548,1563208548);
INSERT INTO "posts" VALUES(16,1,1,'moremore new','{"pin":"https://picsum.photos/id/777/500/500","text":"sfasdfasdfasdf"}','',1563208584,1563208584);
INSERT INTO "posts" VALUES(17,1,1,'Welcome','{"pin":"https://picsum.photos/id/888/500/500","text":"nothing"}','',1563208629,1563208629);
INSERT INTO "posts" VALUES(18,1,1,'moreWelcome','{"pin":"https://picsum.photos/id/888/500/500","text":"nothing"}','',1563208655,1563208655);
INSERT INTO "posts" VALUES(19,1,1,'moremoreWelcome','{"pin":"https://picsum.photos/id/111/500/500","text":"nothing"}','',1563208664,1563208664);
INSERT INTO "posts" VALUES(20,1,1,'tedt','{"pin":"https://picsum.photos/id/111/500/500","text":"safasdfasd"}','',1563208798,1563208798);
INSERT INTO "posts" VALUES(21,1,1,'more tedt','{"pin":"https://picsum.photos/id/111/500/500","text":"safasdfasd"}','',1563208806,1563208806);
INSERT INTO "posts" VALUES(22,1,1,'test','{"pin":"test","text":"test"}','',1563208907,1563208907);
INSERT INTO "posts" VALUES(23,1,1,'test','{"pin":"test","text":"test"}','',1563208941,1563208941);
INSERT INTO "posts" VALUES(24,1,1,'again test','{"pin":"test","text":"test"}','',1563208951,1563208951);
INSERT INTO "posts" VALUES(25,1,1,'again again test','{"pin":"test","text":"test"}','',1563208964,1563208964);
INSERT INTO "posts" VALUES(26,1,1,'again again again test','{"pin":"test","text":"test"}','',1563208966,1563208966);
INSERT INTO "posts" VALUES(27,1,1,' again again again again test','{"pin":"test","text":"test"}','',1563208969,1563208969);
INSERT INTO "posts" VALUES(28,1,1,'Welcome back','{"pin":"https://picsum.photos/id/777/500/500","text":"viesua"}','',1563209759,1563209759);
INSERT INTO "posts" VALUES(29,1,1,'','{"pin":"","text":""}','',1563372710,1563372710);
INSERT INTO "posts" VALUES(30,1,9,'2d buoy','{"pin":"https://gravatar.com/avatar/2adff2097c830c7798c120f365f5766d?s=80&d=https://static.codepen.io/assets/avatars/user-avatar-80x80-bdcd44a3bfb9a5fd01eb8b86f9e033fa1a9897c3a15b33adfc2649a002dab1b6.png","text":"Nothing much"}','',1563447388,1563447388);
INSERT INTO "posts" VALUES(31,1,10,'Arduino project post by b','{"pin":"","text":"Arduino"}','',1563549065,1563549065);
INSERT INTO "posts" VALUES(32,1,11,'Arduino 2','{"pin":"","text":"Arduino 2"}','',1563549119,1563549119);
CREATE TABLE post_types (
  id integer PRIMARY KEY AUTOINCREMENT,
  type text NOT NULL
);
INSERT INTO "post_types" VALUES(1,'idea');
INSERT INTO "post_types" VALUES(2,'project');
CREATE TABLE tags (
  id integer PRIMARY KEY AUTOINCREMENT,
  tag text NOT NULL
);
INSERT INTO "tags" VALUES(1,'Arduino');
INSERT INTO "tags" VALUES(2,'Start Up');
INSERT INTO "tags" VALUES(3,'Web App');
INSERT INTO "tags" VALUES(4,'Hobbiest');
INSERT INTO "tags" VALUES(5,'Fun');
INSERT INTO "tags" VALUES(6,'Science');
INSERT INTO "tags" VALUES(7,'Class Project');
CREATE TABLE post_tag (
  id integer PRIMARY KEY AUTOINCREMENT, 
  post__id integer NOT NULL, 
  tag__id integer NOT NULL,

   FOREIGN KEY (post__id)
    REFERENCES posts(id)
    ON DELETE CASCADE,

   FOREIGN KEY (tag__id)
    REFERENCES tags(id)
    ON DELETE CASCADE
);
INSERT INTO "post_tag" VALUES(1,1,4);
INSERT INTO "post_tag" VALUES(2,1,5);
INSERT INTO "post_tag" VALUES(3,2,4);
INSERT INTO "post_tag" VALUES(4,2,5);
INSERT INTO "post_tag" VALUES(5,2,6);
INSERT INTO "post_tag" VALUES(6,2,7);
INSERT INTO "post_tag" VALUES(7,3,2);
INSERT INTO "post_tag" VALUES(8,3,3);
INSERT INTO "post_tag" VALUES(9,3,4);
INSERT INTO "post_tag" VALUES(10,4,3);
INSERT INTO "post_tag" VALUES(11,4,4);
INSERT INTO "post_tag" VALUES(12,4,6);
INSERT INTO "post_tag" VALUES(13,4,5);
INSERT INTO "post_tag" VALUES(14,5,2);
INSERT INTO "post_tag" VALUES(15,5,3);
INSERT INTO "post_tag" VALUES(16,5,4);
INSERT INTO "post_tag" VALUES(17,6,3);
INSERT INTO "post_tag" VALUES(18,6,7);
INSERT INTO "post_tag" VALUES(19,6,5);
INSERT INTO "post_tag" VALUES(20,6,6);
INSERT INTO "post_tag" VALUES(21,6,4);
INSERT INTO "post_tag" VALUES(22,7,3);
INSERT INTO "post_tag" VALUES(23,7,4);
INSERT INTO "post_tag" VALUES(24,7,5);
INSERT INTO "post_tag" VALUES(25,8,1);
INSERT INTO "post_tag" VALUES(26,8,2);
INSERT INTO "post_tag" VALUES(27,8,3);
INSERT INTO "post_tag" VALUES(28,9,1);
INSERT INTO "post_tag" VALUES(29,9,5);
INSERT INTO "post_tag" VALUES(30,9,6);
INSERT INTO "post_tag" VALUES(31,9,7);
INSERT INTO "post_tag" VALUES(32,9,2);
INSERT INTO "post_tag" VALUES(33,9,3);
INSERT INTO "post_tag" VALUES(34,9,4);
INSERT INTO "post_tag" VALUES(35,10,2);
INSERT INTO "post_tag" VALUES(36,10,3);
INSERT INTO "post_tag" VALUES(37,10,4);
INSERT INTO "post_tag" VALUES(38,10,5);
INSERT INTO "post_tag" VALUES(39,11,2);
INSERT INTO "post_tag" VALUES(40,11,3);
INSERT INTO "post_tag" VALUES(41,11,4);
INSERT INTO "post_tag" VALUES(42,11,5);
INSERT INTO "post_tag" VALUES(43,12,2);
INSERT INTO "post_tag" VALUES(44,12,3);
INSERT INTO "post_tag" VALUES(45,12,4);
INSERT INTO "post_tag" VALUES(46,13,2);
INSERT INTO "post_tag" VALUES(47,13,3);
INSERT INTO "post_tag" VALUES(48,13,4);
INSERT INTO "post_tag" VALUES(49,14,1);
INSERT INTO "post_tag" VALUES(50,14,5);
INSERT INTO "post_tag" VALUES(51,14,3);
INSERT INTO "post_tag" VALUES(52,14,4);
INSERT INTO "post_tag" VALUES(53,14,2);
INSERT INTO "post_tag" VALUES(54,15,1);
INSERT INTO "post_tag" VALUES(55,15,5);
INSERT INTO "post_tag" VALUES(56,15,3);
INSERT INTO "post_tag" VALUES(57,15,4);
INSERT INTO "post_tag" VALUES(58,15,2);
INSERT INTO "post_tag" VALUES(59,16,4);
INSERT INTO "post_tag" VALUES(60,17,2);
INSERT INTO "post_tag" VALUES(61,17,3);
INSERT INTO "post_tag" VALUES(62,18,2);
INSERT INTO "post_tag" VALUES(63,18,3);
INSERT INTO "post_tag" VALUES(64,19,2);
INSERT INTO "post_tag" VALUES(65,19,3);
INSERT INTO "post_tag" VALUES(66,20,6);
INSERT INTO "post_tag" VALUES(67,20,3);
INSERT INTO "post_tag" VALUES(68,21,6);
INSERT INTO "post_tag" VALUES(69,21,3);
INSERT INTO "post_tag" VALUES(70,22,'');
INSERT INTO "post_tag" VALUES(71,23,'');
INSERT INTO "post_tag" VALUES(72,24,'');
INSERT INTO "post_tag" VALUES(73,25,'');
INSERT INTO "post_tag" VALUES(74,26,'');
INSERT INTO "post_tag" VALUES(75,27,'');
INSERT INTO "post_tag" VALUES(76,28,2);
INSERT INTO "post_tag" VALUES(77,28,4);
INSERT INTO "post_tag" VALUES(78,29,'');
INSERT INTO "post_tag" VALUES(79,30,4);
INSERT INTO "post_tag" VALUES(80,30,7);
INSERT INTO "post_tag" VALUES(81,30,6);
INSERT INTO "post_tag" VALUES(82,30,1);
INSERT INTO "post_tag" VALUES(83,30,5);
INSERT INTO "post_tag" VALUES(84,31,1);
INSERT INTO "post_tag" VALUES(85,32,1);
CREATE TABLE post_user_view (
  id integer PRIMARY KEY AUTOINCREMENT, 
  post__id integer NOT NULL,
  user__id integer NOT NULL, 
  
   FOREIGN KEY (post__id)
    REFERENCES posts(id)
    ON DELETE CASCADE,

   FOREIGN KEY (user__id)
    REFERENCES users(id)
    ON DELETE CASCADE
);
INSERT INTO "post_user_view" VALUES(1,16,1);
INSERT INTO "post_user_view" VALUES(2,20,9);
INSERT INTO "post_user_view" VALUES(3,28,1);
INSERT INTO "post_user_view" VALUES(4,27,1);
INSERT INTO "post_user_view" VALUES(5,26,1);
INSERT INTO "post_user_view" VALUES(6,25,1);
INSERT INTO "post_user_view" VALUES(7,28,2);
INSERT INTO "post_user_view" VALUES(8,16,2);
INSERT INTO "post_user_view" VALUES(9,28,10);
INSERT INTO "post_user_view" VALUES(10,27,1);
INSERT INTO "post_user_view" VALUES(11,27,1);
INSERT INTO "post_user_view" VALUES(12,16,1);
INSERT INTO "post_user_view" VALUES(13,28,1);
INSERT INTO "post_user_view" VALUES(14,27,1);
INSERT INTO "post_user_view" VALUES(15,27,1);
INSERT INTO "post_user_view" VALUES(16,3,1);
INSERT INTO "post_user_view" VALUES(17,3,1);
INSERT INTO "post_user_view" VALUES(18,3,1);
INSERT INTO "post_user_view" VALUES(19,3,1);
INSERT INTO "post_user_view" VALUES(20,28,10);
CREATE TABLE post_user_action_select (
  id integer PRIMARY KEY AUTOINCREMENT, 
  type text NOT NULL
);
INSERT INTO "post_user_action_select" VALUES(1,'view');
INSERT INTO "post_user_action_select" VALUES(2,'star');
CREATE TABLE post_user_action (
  id integer PRIMARY KEY AUTOINCREMENT, 
  post__id integer NOT NULL,
  user__id integer NOT NULL, 
  post_user_action_select__id NOT NULL,
  timestamp integer DEFAULT (CAST(strftime('%s','now') as integer)),
  
   FOREIGN KEY (post__id)
    REFERENCES posts(id)
    ON DELETE CASCADE,

   FOREIGN KEY (user__id)
    REFERENCES users(id)
    ON DELETE CASCADE
);
INSERT INTO "post_user_action" VALUES(4,21,1,'2',1563292646);
INSERT INTO "post_user_action" VALUES(7,27,10,'1',1563293586);
INSERT INTO "post_user_action" VALUES(8,28,10,'1',1563293596);
INSERT INTO "post_user_action" VALUES(9,28,1,'1',1563293609);
INSERT INTO "post_user_action" VALUES(12,28,9,'1',1563293650);
INSERT INTO "post_user_action" VALUES(13,22,10,'1',1563297538);
INSERT INTO "post_user_action" VALUES(17,23,1,'2',1563368119);
INSERT INTO "post_user_action" VALUES(18,9,1,'2',1563368208);
INSERT INTO "post_user_action" VALUES(20,26,1,'2',1563368366);
INSERT INTO "post_user_action" VALUES(22,24,1,'2',1563368610);
INSERT INTO "post_user_action" VALUES(23,1,1,'2',1563368817);
INSERT INTO "post_user_action" VALUES(28,27,1,'2',1563369230);
INSERT INTO "post_user_action" VALUES(29,27,1,'1',1563369441);
INSERT INTO "post_user_action" VALUES(30,1,1,'1',1563372714);
INSERT INTO "post_user_action" VALUES(31,28,11,'1',1563415206);
INSERT INTO "post_user_action" VALUES(32,24,1,'1',1563415296);
INSERT INTO "post_user_action" VALUES(33,25,1,'2',1563415307);
INSERT INTO "post_user_action" VALUES(35,29,1,'2',1563415311);
INSERT INTO "post_user_action" VALUES(36,28,9,'2',1563415326);
INSERT INTO "post_user_action" VALUES(37,27,9,'2',1563415333);
INSERT INTO "post_user_action" VALUES(38,24,9,'2',1563415335);
INSERT INTO "post_user_action" VALUES(39,24,9,'1',1563415841);
INSERT INTO "post_user_action" VALUES(40,1,9,'1',1563447392);
INSERT INTO "post_user_action" VALUES(41,30,1,'1',1563478849);
INSERT INTO "post_user_action" VALUES(42,30,10,'1',1563500763);
INSERT INTO "post_user_action" VALUES(43,2,9,'2',1563533623);
INSERT INTO "post_user_action" VALUES(44,30,9,'2',1563533626);
INSERT INTO "post_user_action" VALUES(45,29,9,'2',1563533634);
INSERT INTO "post_user_action" VALUES(46,30,9,'1',1563533639);
INSERT INTO "post_user_action" VALUES(47,4,10,'1',1563549020);
INSERT INTO "post_user_action" VALUES(48,5,10,'1',1563549026);
INSERT INTO "post_user_action" VALUES(49,1,10,'1',1563549067);
INSERT INTO "post_user_action" VALUES(50,1,11,'1',1563549121);
INSERT INTO "post_user_action" VALUES(51,32,11,'1',1563549127);
INSERT INTO "post_user_action" VALUES(52,4,11,'1',1563549538);
INSERT INTO "post_user_action" VALUES(53,5,11,'1',1563549542);
INSERT INTO "post_user_action" VALUES(54,8,11,'1',1563550770);
INSERT INTO "post_user_action" VALUES(55,30,11,'1',1563550775);
INSERT INTO "post_user_action" VALUES(56,18,11,'1',1563550779);
INSERT INTO "post_user_action" VALUES(57,12,11,'1',1563550781);
INSERT INTO "post_user_action" VALUES(58,13,11,'1',1563550784);
INSERT INTO "post_user_action" VALUES(59,10,11,'1',1563550789);
INSERT INTO "post_user_action" VALUES(60,2,11,'1',1563550798);
INSERT INTO "post_user_action" VALUES(61,3,11,'1',1563550801);
INSERT INTO "post_user_action" VALUES(62,9,11,'1',1563550997);
INSERT INTO "post_user_action" VALUES(63,15,11,'1',1563551010);
INSERT INTO "post_user_action" VALUES(64,17,11,'1',1563551015);
INSERT INTO "post_user_action" VALUES(65,32,2,'1',1563557615);
INSERT INTO "post_user_action" VALUES(66,15,2,'1',1563557617);
INSERT INTO "post_user_action" VALUES(67,32,1,'1',1563558072);
INSERT INTO "post_user_action" VALUES(68,31,1,'1',1563559481);
CREATE TABLE user_interest_select (
  id integer PRIMARY KEY AUTOINCREMENT,
  val text NOT NULL
);
INSERT INTO "user_interest_select" VALUES(1,'Art');
INSERT INTO "user_interest_select" VALUES(2,'Music');
INSERT INTO "user_interest_select" VALUES(3,'General');
INSERT INTO "user_interest_select" VALUES(4,'web application');
INSERT INTO "user_interest_select" VALUES(5,'start up');
INSERT INTO "user_interest_select" VALUES(6,'technology');
INSERT INTO "user_interest_select" VALUES(7,'sport');
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
INSERT INTO "user_interest" VALUES(27,9,4);
INSERT INTO "user_interest" VALUES(28,9,7);
INSERT INTO "user_interest" VALUES(29,9,1);
INSERT INTO "user_interest" VALUES(30,9,'');
INSERT INTO "user_interest" VALUES(31,9,2);
INSERT INTO "user_interest" VALUES(32,9,3);
INSERT INTO "user_interest" VALUES(33,9,5);
INSERT INTO "user_interest" VALUES(34,9,6);
DELETE FROM sqlite_sequence;
INSERT INTO "sqlite_sequence" VALUES('ideas',31);
INSERT INTO "sqlite_sequence" VALUES('idea_tag',70);
INSERT INTO "sqlite_sequence" VALUES('relationships',11);
INSERT INTO "sqlite_sequence" VALUES('post_types',2);
INSERT INTO "sqlite_sequence" VALUES('tags',7);
INSERT INTO "sqlite_sequence" VALUES('posts',32);
INSERT INTO "sqlite_sequence" VALUES('post_tag',85);
INSERT INTO "sqlite_sequence" VALUES('post_user_view',20);
INSERT INTO "sqlite_sequence" VALUES('post_user_action_select',2);
INSERT INTO "sqlite_sequence" VALUES('post_user_action',68);
INSERT INTO "sqlite_sequence" VALUES('user_interest_select',7);
INSERT INTO "sqlite_sequence" VALUES('user_interest',34);
COMMIT;
