class Global{
  constructor(){
    this.CDN = `include/`;
    this.session = undefined;
  }
}
const G = new Global();

class PersonInfo{
  constructor(fullname, email, self_intro, status, avatar_url, wallpaper_url){
    this.fullname = fullname ? fullname : "";
    this.email = email ? email : "default";
    this.self_intro = self_intro ? self_intro : "..";
    this.status = status ? status : "default";
    this.avatar_url = avatar_url ? avatar_url:"";
    this.wallpaper_url =  wallpaper_url ? wallpaper_url:"";
  }
  
  toString(){
    return JSON.stringify(this);
  }
}

class Post{
  constructor(pin, text){
    this.pin = pin ? pin : "";
    this.text = text ? text : ""; 
  }
  
  toString(){
    return JSON.stringify(this);
  }
}


// init project
'use strict';
var express = require('express');
var session = require('express-session');
var bodyParser = require('body-parser');
var app = express();
var fs = require('fs');
var Promise = require('promise');
var moment = require('moment');
require('moment-timezone');
moment.tz.setDefault();//set default timezone to local
var nodemailer = require('nodemailer');

const APP_BASE = 'https://ideabook.glitch.me/';
const DB_PATH = './.data/sqlite.db';
var exists = fs.existsSync(DB_PATH);
var sqlite3 = require('sqlite3').verbose();
var db = new sqlite3.Database(DB_PATH);

db.allAsync = function (query, param) {
    var that = this;
    return new Promise(function (resolve, reject) {
        that.all(query, param, function (err, row) {
            if (err){
              printDetailError({}, err);
              reject(err);
            }
            else
                resolve(row);
        });
    });
};


var transporter = nodemailer.createTransport({
 service: 'gmail',
 auth: {
        user: 'ideachainteam@gmail.com',
        pass: 'grpatjjdptldjlkc'
    }
});
  



// var G.session;
app.set('view engine', 'ejs');
app.use(express.static(__dirname + '/public'));
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.urlencoded({ extended: false }));
// app.use(bodyParser.json());
app.use(session({secret: 'RANDOM',saveUninitialized: true,resave: true}));

//detect ip address
app.enable('trust proxy')

//allow consant access
//https://stackoverflow.com/questions/20035101/why-does-my-javascript-code-get-a-no-access-control-allow-origin-header-is-pr
app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
});

app.get('/', function(request, response) {
  G.session = request.session; 
  var message = (G.session.message)?G.session.message:"";
  if(G.session.message != ""){
    G.session.message = "";
  }
  response.render(__dirname + '/views/index.ejs', {G:G, message:message});
});


app.post('/submitUserFeedback', function(request, response) {
  var params = request.body;
  G.session = request.session;
  sanityCheck(request, response, params);
  
  var mail_body = `
  <h1>User feed back</h1>
  <h3>From: ${G.session.username}</h3>
  <p>Feedback type: ${params.feedback_type}</p>
  <p>Star rating: ${params.star_rating}</p>
  <p>Message: ${params.feedback_message}</p>
  `;
  
  const mailOptions = {
    from: 'ideachainteam@gmail.com', // sender address
    to: 'ideachainteam@gmail.com', // list of receivers
    subject: `User feedback from ${G.session.username}`, // Subject line
    html: mail_body// plain text body
  };
  transporter.sendMail(mailOptions, function (err, info) {
     if(err){
       console.log(err)
       return response.status(500).send(JSON.stringify(err));
     }else{
       console.log(info);
       return response.status(200).send(`OK`);
     }
  });
});
/*********************************************************************
******************************signup*********************************
**********************************************************************/
app.get('/signup', function(request, response) {
  response.render(__dirname + '/views/signup.ejs', {G:G});
}).post('/signup', function(request, response) {
  G.session = request.session;
  var params = request.body;
  sanityCheck(request, response, params);
  // console.log('param', param);
  db.run("INSERT INTO users (username, password, email) VALUES (?, ?, ?)", 
         [params.username, params.password, params.email], function(error, results){
    if(error){
      printDetailError(request, error);
      response.status(500).send(error);
    }else{
      G.session.email = params.email; 
      G.session.user = params.username;
      G.session.user_id = this.lastID;
      console.log('signup ', G.session);
      response.redirect(301, "/dashboard");
    }
  })
});
/******************************END************************************/


/*********************************************************************
******************************signin*********************************
**********************************************************************/
app.post('/signin', function(request, response) {
  var param = request.body;
  G.session = request.session;

  
  db.all("SELECT id, email, username, password FROM users WHERE email=? AND password=?", 
         [param.email, param.password], (error, results) => {
    if(error){
      console.log("Fail signin", error);
      response.status(500).send(error);
      
    }else{
      if(results.length == 0){
        G.session.message = "Invalid Email or Password";
        response.redirect(301, '/');
      }else{
        G.session.email = param.email; 
        G.session.username = results[0].username;
        G.session.user_id = results[0].id;
        console.log('singin sess', G.session);
        response.redirect(301, "/dashboard");
      }
    }
  })
});
/******************************END************************************/


/*********************************************************************
******************************signout*********************************
**********************************************************************/
app.get('/signout', (request, response) => {
  request.session.destroy((error) => {
    if(error){
      return console.log(error);
    }
    response.redirect('/');
  });
});
/******************************END************************************/


/*********************************************************************
*****************************dashboard********************************
**********************************************************************/
app.get('/dashboard', async function(request, response) {
  
  G.session = request.session;
  if(G.session.email){
    let q = `SELECT latitude, longitude FROM users WHERE id=?`;
    let user_location = await db.allAsync(q, [G.session.user_id]);
    let user_location_exist = true;
    if(user_location[0].latitude == null){
      user_location_exist = false;   
    }
    
    response.render(__dirname + '/views/dashboard.ejs', {G:G, user_location_exist:user_location_exist});
  }else{
    G.session.message = "Please login";
    response.redirect('/');
  }
});



app.get('/updateUserLocation', function(request, response){
  G.session = request.session;
  console.log('request', request.body, request.query)
  var params = request.query;
  let q = `UPDATE users 
           SET longitude=?, latitude=?, city=?, state=?, country=?
           WHERE id=?`;
  let qparams = [params.longitude, params.latitude, params.city, params.state, params.country, G.session.user_id];
  console.log('qparams', qparams);
  db.run(q, qparams,function (error){
    if(error){
      printDetailError(request, error);
      response.status(500).send(error);
    }else{
      response.status(200).send(`OK`);
    }
  });
});

async function getActionOnPosts(action_id){
  let q = `
      SELECT post_id FROM (
        SELECT MAX(upa.id) as id, upa.post__id AS post_id, ua.user__id,
            upa.user_post_action_select__id, ua.timestamp
          FROM user_post_action upa 
          INNER JOIN user_action ua 
              ON ua.id=upa.user_action__id
          GROUP BY upa.post__id 
        ) sm
      WHERE sm.user__id=? AND 
        sm.user_post_action_select__id=?`;
  let qparams = [G.session.user_id+"", action_id+""];
  let stars = await db.allAsync(q,qparams);
  
  // console.log("stars send ", stars, qparams);
  return stars;
}


app.get('/dashboard/getPosts', async (request, response) => {
  G.session = request.session;
  var q = `
    SELECT p.id as post_id, p.user__id AS user_id, u.username as name, p.title as title, 
       p.content as content, p.description as description, p.create_timestamp as create_timestamp,
       p.last_modified_timestamp as last_modified_timestamp, upa.user_post_action_select__id, count(*) as view_count
    FROM posts p
    LEFT OUTER JOIN user_post_action upa ON p.id=upa.post__id
    INNER JOIN users u ON p.user__id=u.id
    WHERE p.user__id != ? AND upa.user_post_action_select__id=1
    GROUP BY post_id
    ORDER BY create_timestamp DESC, view_count DESC`;
  var param = [G.session.user_id]; 
  var posts = await getPost(q, param);
  let stars = await getActionOnPosts(2);
  let data = {
    posts : posts, 
    stars : stars
  };
  // console.log('getpost dashboard', data);
  response.send(JSON.stringify(data));
});

/******************************END************************************/


/*********************************************************************
**************************personalinfo********************************
**********************************************************************/
app.get('/personalinfo', (request, response) => {
  G.session = request.session;
  var params = request.query;
  console.log('param personalinfo', params);
  
  var q = "SELECT username, email,  personal_info, fullname FROM users WHERE id=?";
  db.all(q, [params.user_id], (error, results) => {
    q = "SELECT id, tag FROM post_tag_select";
    db.all(q, [], (_error, tags) => {
      console.log("res", results);
      let _info = JSON.parse(results[0].personal_info);
      var person_info = new PersonInfo(results[0].fullname, 
                                       results[0].email,
                                       _info.self_intro,//self_intro
                                       _info.status,
                                       _info.avatar_url, 
                                       _info.wallpaper_url);
      person_info.username = results[0].username;
      q = `SELECT uis.id, uis.val FROM user_interest ui 
              INNER JOIN user_interest_select uis ON ui.user_interest_select__id=uis.id
              WHERE ui.user__id=?`;
      db.all(q, [params.user_id], async (__error, interests) => {
        
        let friend_view = false;//false indicate the user is viewing his/her own profile
        let isfriend = false;
        if(G.session.user_id != params.user_id){
          friend_view = true;
          let friend_res = await isFriendWith(params.user_id);
          isfriend = friend_res.isfriend;
        }
        
        let friendList = await getFriendList(params.user_id);
        let data = {G:G, person_info:person_info,
                         tags:tags,
                         interests : interests,
                         friend_view : friend_view,
                         friend_view_id: params.user_id,
                         isfriend : isfriend,
                         total_friend: friendList.length,
                        };
        // console.log('data ejs', data);
        response.render(__dirname + '/views/personalinfo.ejs', data);
      });

    });

  });
  
});
async function isFriendWith(other_user_id){
  let isfriend = false;
  let res = {
    isfriend : false,
    relationship_id : undefined,
  };
  let q = `
    SELECT id FROM relationships
      WHERE (link_from=? AND link_to=?) OR
            (link_from=? AND link_to=?) `;
  let friend_res = await db.allAsync(q, [G.session.user_id, other_user_id, other_user_id, G.session.user_id]);
  if(friend_res.length > 0){
    res.isfriend = true;
    res.relationship_id = friend_res[0].id;
  }
  return res;
}

app.get('/personalinfo/getPersonalInfo', (request, response) => {
  G.session = request.session;
  
  let q = `SELECT username, email,  personal_info, fullname FROM users WHERE id=?`;
  db.all(q, [G.session.user_id], (error, results) => {
    if(error){
      printDetailError(request, error);
      response.status(500).send(error);
    }else{
      
      let _info = JSON.parse(results[0].personal_info);
      let person_info = new PersonInfo(results[0].fullname, 
                                       results[0].email,
                                       _info.status,
                                       _info.avatar_url, 
                                       _info.wallpaper_url);
      
      response.send(JSON.stringify(person_info));
    }
  });
});

app.get('/selectPostTags', async (request, response) => {
  let q = "SELECT id, tag FROM post_tag_select"; 
  db.all(q, [], (error, tags) => {
    if(error){
      printDetailError(request, error);
      response.status(500).send(error);
    }else{
      response.send(JSON.stringify(tags));
    }
  });
});

app.get('/selectUserInterest', async (request, response) => {
  let q = "SELECT id, val FROM user_interest_select"; 
  db.all(q, [], (error, vals) => {
    if(error){
      printDetailError(request, error);
      response.status(500).send(error);
    }else{
      response.send(JSON.stringify(vals));
    }
  });
});

async function getTags(post_id){
  var q = `SELECT tag 
            FROM post_tag it 
              INNER JOIN post_tag_select t ON it.tag__id=t.id 
            WHERE post__id=?`;
  var tags = await db.allAsync(q, [post_id]);
  return tags;
}
async function getPost(q, param){
  var posts = await db.allAsync(q, param);
  for(var i=0; i<posts.length; i++){
    var tags = await getTags(posts[i].post_id);
    posts[i].tags = tags;
  }
  return posts;
}
app.get('/personalinfo/getPosts', async (request, response) => {
  G.session = request.session;
  var q = `SELECT id as post_id, user__id as user_id, title, description
              FROM posts 
           WHERE user__id=? 
           ORDER BY create_timestamp`;
  var param = [G.session.user_id];
  var posts = await getPost(q, param);
  response.send(JSON.stringify(posts));
});

app.post('/personalinfo/update', async (request, response) => {
  G.session = request.session;
  var params = request.body; 
  sanityCheck(request, response, params);
  var person = new PersonInfo(params.fullname, params.status, 
                              params.avatar_url, params.wallpaper_url);
  var q = "UPDATE users SET personal_info=?, fullname=? WHERE id=?";
  db.all(q, [JSON.stringify(person), params.fullname, G.session.user_id], async (error, results) => {
    if(error){
      printDetailError(request, error);      
      response.status(500).send(error);
    }else{
      
      //update user interest
      var user_interest = params.user_interest;
      // console.log('user_interest', user_interest);
      q = `DELETE FROM user_interest WHERE user__id=?`;
      await db.allAsync(q, [G.session.user_id]);
      
      //addd all interest in a list
      for(var i=0; i<user_interest.length; i++){
        // var _i = [i];
        // console.log('update interest', user_interest[i]);
        q = `SELECT id, user_interest_select__id 
              FROM user_interest WHERE user__id=? AND 
                                       user_interest_select__id=?`;
        //see if it already added
        let existed_user_interest = await db.allAsync(q, [G.session.user_id, user_interest[i]]);
        // console.log("interest", existed_user_interest);
        //if not added then add it
        let qparams = [G.session.user_id, user_interest[i]];
        q = `INSERT INTO user_interest(user__id, user_interest_select__id)
                  VALUES(?, ?)`;
        if(existed_user_interest.length == 0){//if not exist
          await db.allAsync(q, qparams);
        }
      }
      response.status(200).send(`OK`);
      
    }
  });
});
/******************************END************************************/


/*********************************************************************
*******************************admin**********************************
**********************************************************************/
app.get('/admin', (request, response) => {
  
  db.all("SELECT * FROM users", 
        [], (error, users) => {
    db.all("SELECT id, link_from, link_to FROM relationships",
          [], (error, edges) => {
      db.all("SELECT * FROM posts",
            [], (error, posts) => {
        response.render(__dirname + '/views/admin.ejs', {G:G, users:users, 
                                                         edges:edges,
                                               posts:posts});
      })

    });
  });
  
});


app.get('/admin/editor', (request, response) => {
  G.session = request.session;
  var params = request.body;
  response.render(__dirname + '/views/admin/editor.ejs', {G:G});
});

app.get('/admin/query', (request, response) => {
  G.session = request.session;
  var params = request.query;
  // console.log('params', params);
  db.all(params.query, [], (error, results) => {
    if(error){
      printDetailError(request, error);
      response.send(JSON.stringify(error.message));
    }else{
      response.send(JSON.stringify(results));
    }
  });
});
/**********************************************************************/

/********************************************************
********************************************************/

app.get('/i', async (request, response) => {
  console.log(' /i request', request.ip, request.ips);
  moment.tz.guess(true);
  G.session = request.session;
  var params = request.query;
  
  var user_id = null;
  if(G.session.user_id == null){//if session does not exist then query for the post creator
    let q = `SELECT user__id FROM posts WHERE id=?`;
    user_id = (await db.allAsync(q, [params.post_id]))[0].user__id;
    
    console.log('in user_id', user_id);
  }else{
    user_id = G.session.user_id;
  }
  console.log('user_id', user_id);
  
  //check user viewing status
  let q = `SELECT COUNT(*) as count 
            FROM user_post_action upa
            INNER JOIN user_action ua 
              ON ua.id=upa.user_action__id
            WHERE ua.user__id=? AND 
                  upa.post__id=? AND 
                  upa.user_post_action_select__id='1'`;
  db.all(q, [user_id, params.post_id], function (error, count) {
    count = count[0].count;
    console.log('get first count', count);
    if(count == 0){
      console.log('this', this);
      let q = `INSERT INTO user_action (user__id, user_action_select__id) VALUES (?, ?)`;
      db.run(q, [user_id, 2], function(err) {//change this manualy. '2' is a magic number
        let q = `INSERT INTO user_post_action (post__id, user_action__id, user_post_action_select__id) 
                  VALUES (?, ?, ?)`;
        if(err){
          printDetailError(request, err);
          throw new Error();;
        }
        db.run(q, [params.post_id, this.lastID, '1'], (_error) => {
          if(_error){
            printDetailError(request, _error);
            return response.status(500).send(_error.message);
            throw new Error();
          }
        });
      });

    }
  });
  
  //TODO: get count of all userview
  
  //query the post information then send html
  q = `SELECT id, post_type, user__id as user_id, title, 
              content, description, create_timestamp, 
              last_modified_timestamp FROM posts 
        WHERE id=?`;
  db.all(q, [params.post_id], (error, post) => {
    let q = `SELECT t.id, t.tag 
              FROM post_tag it 
                INNER JOIN post_tag_select t ON it.tag__id=t.id 
              WHERE post__id=?`;
    
    post = post[0];
    post.formatted_create_timestamp = moment.unix(post.create_timestamp).format("LLLL");
    
    post.content = JSON.parse(post.content);
    db.all(q, [params.post_id], (_error, tags) => {
      if(_error){
        printDetailError(request, error);
        return response.status(500).send(error.message);
      }else{
        post.tags = tags;
        q = `SELECT COUNT(*) as view_count FROM user_post_action WHERE post__id=? AND user_post_action_select__id='1'`;
        db.all(q, [params.post_id], (__error, view_count) =>{
          view_count = view_count[0].view_count;
          q = `SELECT COUNT(*) as star_count 
                  FROM user_post_action 
               WHERE post__id=? AND 
               user_post_action_select__id='2'`;
          db.all(q, [params.post_id], (___error, star_count) => {
            console.log('star count', star_count);
            star_count = star_count[0].star_count;
            return response.render(__dirname + '/views/i.ejs', {G:G, post:post, tags:tags, view_count: view_count, star_count: star_count});
          });
        });
      }

    });
  });
  
});

/*********************************************************************
*******************************function*******************************
**********************************************************************/
app.get('/getTags', (request, response) => {
  G.session = request.session;
  db.all('SELECT id, tag FROM tags',[], 
        (error, results) => {
      response.send(JSON.stringify(results));
  });
});
app.post('/addFriend', async (request, response) => {
  G.session = request.session;
  var params = request.body;
  
  let isfriend_res = await isFriendWith(params.id);
  let q = ``;
  let qparams = [];
  let rresponse = {
    added : true
  };
  if(isfriend_res.isfriend){//if already friend then unfriend
    q = `DELETE FROM relationships WHERE id=?`;
    qparams = [isfriend_res.relationship_id];
    rresponse.added = false;
  }else{
    q = `INSERT INTO relationships (link_from, link_to) VALUES (?, ?)`;
    qparams = [G.session.user_id, params.id];
    rresponse.added = true;
  }
  db.run(q, qparams, (error) => {
    if(error){
      printDetailError(request, error);
      response.status(500).send(error.message);
    }else{
      response.status(200).send(JSON.stringify(rresponse));
    }
  });
});


app.post('/createIdea', (request, response) => {
  G.session = request.session;
  
  var params = request.body; 
  
  
  var _post = new Post(params.content.pin, params.content.text);
  var q = `INSERT INTO posts (user__id, post_type, title, content) 
           VALUES (?, ?, ?, ?)`;
  db.run(q, [G.session.user_id, 1, params.title, _post.toString()], 
        function(error) {
    if(error){
      printDetailError(request, error);
      
      return response.status(500).send(error.message);
    }else{
      //get last inserted post
        var post_id = this.lastID;
        //insert tags
        if(params.tags){
          for(var i=0; i<params.tags.length; i++){
            let q = `INSERT INTO post_tag (post__id, tag__id) VALUES (?, ?)`;
            db.run(q, [post_id, params.tags[i]],
                  (__error) => {
              if(__error){
                return response.status(500).send(__error.message) ; 
              }
            });
          }
        }
        //return last inserted post. to live update html page. 
        let q = `SELECT p.id as post_id, p.user__id AS user_id, 
                    u.username as name, p.title as title, p.content as content, p.description as description, 
                    p.create_timestamp as create_timestamp, p.last_modified_timestamp as last_modified_timestamp 
                  FROM posts p 
                    INNER JOIN users u ON u.id=p.user__id 
                  WHERE post_id=?`; 
        db.all(q,[post_id], 
              (___error, ___results) => {
          if(___error){
            return response.status(500).send(___error.message) ; 
          }
          // console.log(`/i?post_id=${post_id}`);
          // response.redirect(200, '/');
          // response.redirect(301, `/i?post_id=${post_id}`);
          return response.status(200).send(JSON.stringify(___results));
        });

    }
  });
});


async function getFriendList(user_id = null){
  var q = `
      SELECT u.id, u.username FROM users u
      INNER JOIN (
          SELECT link_to as id 
            FROM relationships WHERE link_from=?
          UNION
          SELECT link_from as id
            FROM relationships WHERE link_to=?
      ) f ON f.id=u.id`;
  let qparams = [G.session.user_id, G.session.user_id];
  if(user_id!= null){
    qparams = [user_id, user_id];
  }
  let friendList = await db.allAsync(q, qparams);
  return friendList;
}

app.get('/getFriendList', async (request, response) => {
  G.session = request.session; 

  let friendList = await getFriendList(); 
  response.send(JSON.stringify(friendList));
});


app.get('/search/username', (request, response) => {
  G.session = request.session; 
  var param = request.query;
  let q = `SELECT * FROM users WHERE username LIKE '%${param.username}%' AND username <> 'admin'`;
  db.all(q, [], (error, results) => {
    if(error){
      printDetailError(request, error);
      response.status(500).send(error);
    }else{
      response.send(JSON.stringify(results));
    }
    
  });
});

app.get('/getOtherPeopleList', (request, response) => {
    G.session = request.session;
    var q = `
        SELECT id, username, email
        FROM users
        WHERE id NOT IN (
          SELECT link_to 
            FROM relationships WHERE link_from=?
          UNION
          SELECT link_from
            FROM relationships WHERE link_to=?
        ) AND id <> ?`
    db.all(q,[G.session.user_id,G.session.user_id,G.session.user_id], (error, results) => {
      response.send(JSON.stringify(results));
    });
});

app.get('/getRecommendedPostBaseOnTag', (request, response) => {
  G.session = request.session;
  let params = request.query;
  sanityCheck(request, response, params);
  let q = `
    SELECT DISTINCT pt.post__id AS post_id, p.user__id AS user_id, title 
    FROM posts p
        INNER JOIN post_tag pt ON p.id=pt.post__id 
        INNER JOIN post_tag_select t ON pt.tag__id=t.id
    WHERE t.id IN (
        SELECT _t.id FROM posts _p 
            INNER JOIN post_tag _pt ON _p.id=_pt.post__id 
            INNER JOIN post_tag_select _t ON _pt.tag__id=_t.id 
        WHERE _p.id=?
    ) AND user__id != ?`;
  
  db.all(q, [params.post_id, G.session.user_id], (error, results) => {
    response.send(JSON.stringify(results));
  });
});

app.post('/actionOnPost', async (request, response) => {
  G.session = request.session;
  let params = request.body;
  sanityCheck(request, response, params);

  let action_id = params.action_id;// 2: star/unstar
  let post_id = params.post_id;

  let q =   `
SELECT MAX(upa.id) as id, user_post_action_select__id as user_post_action_select_id
        FROM user_post_action upa
        INNER JOIN user_action ua ON ua.id=upa.user_action__id
        WHERE ua.user__id=? AND
              upa.post__id=? AND (upa.user_post_action_select__id='2' OR
                                 upa.user_post_action_select__id='3')`;//select if exist already 
  let exist = await db.allAsync(q, [G.session.user_id, post_id]);
  if(action_id == '2'){
    
    if(exist.length == 0 || exist[0].user_post_action_select_id == '3' || exist[0].id === null){
      action_id = '2';
    }else{
      action_id = '3';//unstar
    }
  }
  
  q = `INSERT INTO user_action (user__id, user_action_select__id) VALUES (?, ?)`;
  db.run(q, [G.session.user_id, '2'], function (err) {//change this manualy. '2' is a magic number
    q = `INSERT INTO user_post_action (post__id, user_action__id, user_post_action_select__id) 
         VALUES (?, ?,?)`;
    db.run(q, [post_id, this.lastID, action_id], function (_error) {
      if(_error){
        printDetailError(request, _error);
        return response.status(500).send(_error.message);
       }else{
        return response.status(200).send();
       }
    });
  });
  return response.status(200);
});


app.get('/getUserActivityList', async function (request, response) {
  G.session = request.session;
  let params = request.body;
  sanityCheck(request, response, params);
  
  let q = `
    SELECT ua.id, uas.val AS user_action_type, 
            ua.timestamp
        FROM user_action ua 
        INNER JOIN user_action_select uas ON uas.id=ua.user_action_select__id
        WHERE ua.user__id=?
        ORDER BY timestamp DESC
        LIMIT 10`;
  
  let action_list = await db.allAsync(q, [G.session.user_id+""]);
  let activity_list = [];
  for(var i=0; i<action_list.length; i++){
    let detail = {
      name: 'You',
      user_action_type : action_list[i].user_action_type,
      timestamp : action_list[i].timestamp,
    };
    if(action_list[i].user_action_type == 'user_to_post'){//user_to_post action
      q = `
        SELECT p.id as post_id, p.title, upas.type AS user_action_post_type
            FROM user_post_action upa
            INNER JOIN posts p ON p.id=upa.post__id
            INNER JOIN user_post_action_select upas 
                ON upas.id=upa.user_post_action_select__id 
            WHERE user_action__id=?`;
      let __detail = await db.allAsync(q, [action_list[i].id]);
      detail = Object.assign({}, detail, __detail[0]);
      // console.log('detail', detail);
    } else if(action_list[i].user_action_type == 'user_to_user'){//user_to_user action
      q = ``;
      let detail = await db.allAsync(q, []);
    }
    activity_list.push(detail);
  }
  response.send(JSON.stringify(activity_list));
});
/********************************************************************/

/*******************************Ultilities**************************/
function printDetailError(request, error){
  let message = {
    'user' : G.session.email, 
    'url' : request.originalUrl,
    'error' : error,
    'error message' : error.message
  };
  console.log(message);
}
function sanityCheck(request, response, params){

  let message = {
    'user email' : G.session.email,
    'url' : request.originalUrl,
    'params' : params
  };
  console.log(message);
}
/*****************************************************************/
// listen for requests :)
var listener = app.listen(process.env.PORT, function() {
  console.log('Your app is listening on port ' + listener.address().port);
});