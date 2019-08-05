PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE users (
  id integer NOT NULL PRIMARY KEY,
  username text NOT NULL,
  password text NOT NULL,
  email text UNIQUE,
  personal_info text DEFAULT '{}'
);
INSERT INTO "users" VALUES(1,'test','test','test@test.com','{}');
INSERT INTO "users" VALUES(2,'mberg','fb','mberg@fb.com','{}');
INSERT INTO "users" VALUES(3,'john','pass','john@john.com','{}');
INSERT INTO "users" VALUES(4,'danna','pass','danna@danna.com','{}');
INSERT INTO "users" VALUES(5,'sjob','apple','sjob@apple.com','{}');
INSERT INTO "users" VALUES(6,'jock','apple','jock@apple.com','{}');
INSERT INTO "users" VALUES(7,'timcook','apple','timcook@apple.com','{}');
INSERT INTO "users" VALUES(8,'bomb','apple','bomb@apple.com','{}');
INSERT INTO "users" VALUES(9,'a','apple','a@apple.com','{}');
INSERT INTO "users" VALUES(10,'b','apple','b@apple.com','{}');
INSERT INTO "users" VALUES(11,'c','apple','c@apple.com','{}');
INSERT INTO "users" VALUES(12,'d','apple','d@apple.com','{}');
INSERT INTO "users" VALUES(13,'e','apple','e@apple.com','{}');
INSERT INTO "users" VALUES(14,'f','apple','f@apple.com','{}');
INSERT INTO "users" VALUES(15,'g','apple','g@apple.com','{}');
INSERT INTO "users" VALUES(16,'h','apple','h@apple.com','{}');
INSERT INTO "users" VALUES(17,'a','google','a@google.com','{}');
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
INSERT INTO "relationships" VALUES(7,'9','4');
INSERT INTO "relationships" VALUES(8,'9','3');
INSERT INTO "relationships" VALUES(9,'9','5');
INSERT INTO "relationships" VALUES(10,'9','11');
INSERT INTO "relationships" VALUES(11,'9','8');
INSERT INTO "relationships" VALUES(12,'9','7');
INSERT INTO "relationships" VALUES(13,'9','6');
INSERT INTO "relationships" VALUES(14,'9','12');
INSERT INTO "relationships" VALUES(15,'9','2');
INSERT INTO "relationships" VALUES(16,'9','15');
INSERT INTO "relationships" VALUES(17,'9','16');
INSERT INTO "relationships" VALUES(18,'2','13');
INSERT INTO "relationships" VALUES(19,'2','4');
INSERT INTO "relationships" VALUES(20,'2','5');
INSERT INTO "relationships" VALUES(21,'2','6');
INSERT INTO "relationships" VALUES(22,'2','7');
INSERT INTO "relationships" VALUES(23,'2','8');
INSERT INTO "relationships" VALUES(24,'2','10');
INSERT INTO "relationships" VALUES(25,'2','11');
INSERT INTO "relationships" VALUES(26,'2','12');
INSERT INTO "relationships" VALUES(27,'2','3');
INSERT INTO "relationships" VALUES(28,'2','14');
INSERT INTO "relationships" VALUES(29,'2','1');
INSERT INTO "relationships" VALUES(30,'2','15');
INSERT INTO "relationships" VALUES(31,'2','16');
INSERT INTO "relationships" VALUES(32,'1','3');
INSERT INTO "relationships" VALUES(33,'1','4');
INSERT INTO "relationships" VALUES(34,'1','16');
INSERT INTO "relationships" VALUES(35,'1','15');
INSERT INTO "relationships" VALUES(36,'1','14');
INSERT INTO "relationships" VALUES(37,'1','6');
INSERT INTO "relationships" VALUES(38,'1','5');
INSERT INTO "relationships" VALUES(39,'1','7');
INSERT INTO "relationships" VALUES(40,'1','8');
INSERT INTO "relationships" VALUES(41,'1','10');
INSERT INTO "relationships" VALUES(42,'1','11');
INSERT INTO "relationships" VALUES(43,'1','12');
INSERT INTO "relationships" VALUES(44,'1','13');
INSERT INTO "relationships" VALUES(45,'1','17');
INSERT INTO "relationships" VALUES(46,'17','2');
INSERT INTO "relationships" VALUES(47,'17','16');
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
DELETE FROM sqlite_sequence;
INSERT INTO "sqlite_sequence" VALUES('relationships',47);
INSERT INTO "sqlite_sequence" VALUES('tags',7);
INSERT INTO "sqlite_sequence" VALUES('ideas',31);
INSERT INTO "sqlite_sequence" VALUES('idea_tag',70);
COMMIT;
