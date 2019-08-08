class ClientExpress{
  constructor() {
    this.routes = {};
  }
  route(path, callback=function(){}){
    this.routes[path] = callback;
  }
  listen(callback=function(){}){
    callback();//print some debugiing

    if (!this.routes[location.pathname]){
      throw new Error("Route '"+location.pathname + "' does not exist")
    }
    this.routes[location.pathname]();
  } 
}

var social_mixin = {
  methods: {
    twitterLink: function(shareurl, title=""){
      let host = "https://twitter.com/share?";//url=[post-url]&text=[post-title]
      let data = {
          url: shareurl,
          text: title
      };
      return host+$.param(data);
    },
    facebookLink: function(shareurl){
      let host = "https://www.facebook.com/sharer.php?";//u=[post-url]
        let data = {
          u: shareurl
        }
      return host+$.param(data);
    },
    redditLink: function(shareurl, title=""){
      let host = "https://reddit.com/submit?";//url=[post-url]&title=[post-title]
      let data = {
          url: shareurl,
          title: title,
      };
      return host+$.param(data);
    },
    //DO NOT REMOVE: window.open(host, "_blank", "toolbar=1, scrollbars=1, resizable=1, width=" + 1015 + ", height=" + 800);// open a new window to share
  }
};

var post_list_mixin = {
  data() {
    return {
      posts: [],
      $grid: undefined
    }
  },
  methods: {
    getUserPostList: async function(limit=null){
      console.log('call', 'getUserPostList')
      await $.get('/dashboard/getPosts', {limit: limit}, (response) => {
        
        let data = JSON.parse(response);
        console.log('data post ', data);
        var objs = data.posts
        var starred_posts = data.stars.map(row => row.post_id);
        console.log('stared_posts', starred_posts);
        starred_posts = new Set(starred_posts);
        console.log('stared_posts became set', starred_posts);
        for(var i=0; i<objs.length; i++){
          if(starred_posts.has(parseInt(objs[i].post_id)) ){
            objs[i].star_status = true;
          }else{
            objs[i].star_status = false;
          }
          objs[i].content = JSON.parse(objs[i].content);
          console.log('tags', objs[i].tags);
        }
        console.log('objs', objs);
        this.posts = objs;
      });
    }
  }
};

const mixin_recent_activity = {
  data() {
    return {
      recent_activity_list: [],
    }
  },
  methods: {
    fetchRecentActivity(limit=1000){
      let data = {
        limit: limit
      };
      $.get('/activity/fetchRecentActivity', data, (response) => {
        var recent_activity = JSON.parse(response);
        this.recent_activity_list = recent_activity;
      });
    }
  }
};


Vue.component('recent-activity-item',{
  props: {
    activity_detail: Object
  }, 
  template: `
    <div class="media text-muted pt-3 list-item">
      <img src="https://cdn.glitch.com/81be7dd8-00c3-4077-b658-479b65c93098%2Ffeac67ed-a868-46f6-a867-7c69d772d51b_200x200%20(4).png?v=1565189956579" alt="" class="bd-placeholder-img mr-2 rounded" width="32" height="32">
      <p class="media-body pb-3 mb-0 small lh-125 border-bottom border-gray">
        <a :href="'http://ideachain.glitch.me/personalinfo?user_id='+this.activity_detail.actioner"><strong class="d-block text-gray-dark">@{{ activity_detail.actioner_username }}</strong></a>
        <span v-html="getActivityMessage()"></span>
      </p>
    </div>
  `,
  methods:{
    getActivityMessage(){
      if(this.activity_detail.action_target_type == 'u2p') {
        this.activity_detail.message = `
          <span> has ${this.activity_detail.action_type_val}ed <a href="http://ideachain.glitch.me/i?post_id=${this.activity_detail.action_target_id}">${this.activity_detail.title}</a></span>
        `;
      }else if(this.activity_detail.action_target_type == 'u2u') {
        this.activity_detail.message = `
          <span> has ${this.activity_detail.action_type_val}ed with ${this.activity_detail.passiver}</span>
        `;
      }else if(this.activity_detail.action_target_type == 'u2s'){
        this.activity_detail.message = `
          <span> ${this.activity_detail.action_type_val}`;
      }
      return this.activity_detail.message;
    }
  }
});

Vue.component('activity-item', {
  props: {
    activity: Object,
    user_avatar: String,
  }, 
  template: `
      <div class="list-group-item list-group-item-action active">
        <div class="notification-info">
        
          <div class="notification-list-user-block ml-2">
            <span class="notification-list-user-name"></span><span v-html="this.activity.message"> {{ this.activity.message}} </span>
          </div>
        </div>
      </div>
  `,
  data: function() {
    return {
      
    }
  },
  methods: {
       getNotificationMessage: function() {
        return this.activity.message;  
       },
      get_redirect_link: function() {
        return "#";
      }
  }
});

Vue.component('friendlist-item', {
  props: ['id', 'name'],
  template: `
          <div class="list-group-item list-group-item-action active">
            <div class="notification-info">
              <div class="notification-list-user-img"><img src="https://picsum.photos/id/354/100/100" alt="" class="user-avatar-md rounded-circle"></div>
              <div class="notification-list-user-block ml-2">
                <span class="notification-list-user-name"><a :href="get_redirect_link()">{{ this.name }}</a></span>
                <div class="notification-date">2 min ago</div>
              </div>
            </div>
          </div>
  `,
  methods: {
    get_redirect_link: function(){
      return `http://ideachain.glitch.me/personalinfo?user_id=${this.id}`;
    }
  }
});

`
          <a href="#" class="list-group-item list-group-item-action d-flex align-items-center disabled">
            <div class="col-md-3 float-left">
                <img class="rounded-circle" width="45" src="https://picsum.photos/id/100/200/200" alt="">
            </div>
            <div class="col-md-6">
              <p class="text-break">
                {{ this.name }}<br>
                {{this.email}}<br>
                <small>65 mutual friends</small>
              </p>
            </div>

            <div class="col-md-3 float-right">
              <button type="button" 
                class="btn btn-primary btn-sm btn-light text-wrap"
                v-on:click="$emit('delete-row')">
                <i class="fa fa-user-plus text-break"> Add friend</i>
              </button>
            </div>
          </a>
`


Vue.component('user-item', {
  props: ['id', 'name', 'email', 'password'],
  template: `


          <div class="list-group-item list-group-item-action active">
            <div class="notification-info">
              <div class="notification-list-user-img"><img src="https://picsum.photos/id/354/100/100" alt="" class="user-avatar-md rounded-circle"></div>
              <div class="notification-list-user-block ml-2">
                <span class="notification-list-user-name"><a :href="get_redirect_link()">{{ this.name }}</a></span>
                <button type="button" 
                  class="btn btn-primary btn-sm btn-dark text-wrap"
                  v-on:click="$emit('delete-row')">
                  <i class="fa fa-user-plus text-break"> Add friend</i>
                </button>
                <div class="notification-date">2 min ago</div>
              </div>
            </div>
          </div>
  `,
  methods: {
    get_redirect_link: function(){
      return `http://ideachain.glitch.me/personalinfo?user_id=${this.id}`;
    }
  }
});


Vue.component('related-post-item', {
  props: {
    post_id: Number,
    title: String
  },
  data: function() {
    return {}
  },
  template: `
    <li><a :href="get_redirect_link()">{{ this.title }}</a></li>
  `,
  methods: {
    get_redirect_link: function(){
      return `http://ideachain.glitch.me/i?post_id=${this.post_id}`;
    }
  }
});


Vue.component('post-item', {
  props: {
    post_id: Number, 
    username: String,
    title: String, 
    content: Object,
    status: String, 
    create_timestamp: Number, 
    tags: Array,
    star_status: Boolean
  },
  mixins: [social_mixin],
  data: function () {
    return {
      user_action: {
        star_toggle: this.star_status
      }
    }
  },
  template: `
<div class="card gedf-card white-panel col-lg-4 mb-1">
  <div class="card-header">
    <div class="d-flex justify-content-between align-items-center">
      <div class="d-flex justify-content-between align-items-center">
        <div class="mr-2">
          <img class="rounded-circle" width="45" src="https://picsum.photos/50/50" alt="">
        </div>
        <div class="ml-2">
          <div class="h5 m-0">@{{ this.username }}</div>
          <!-- <div class="h7 text-muted">{{ this.username }}</div> -->
        </div>
      </div>
      <div>
        <div class="dropdown">
          <button class="btn btn-link dropdown-toggle" type="button" id="gedf-drop1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <i class="fa fa-ellipsis-h"></i>
          </button>
          <div class="dropdown-menu dropdown-menu-right" aria-labelledby="gedf-drop1">
            <div class="h6 dropdown-header">Configuration</div>
            <a class="dropdown-item" href="#">Save</a>
            <a class="dropdown-item" href="#">Hide</a>
            <a class="dropdown-item" href="#">Report</a>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="card-body">
    <div class="text-muted h7 mb-2">
      <i class="fa fa-clock-o"></i> {{ get_datetime_string() }}
    </div>
    <a class="card-link" :href="get_redirect_link()">
      <h5 class="card-title">{{ this.title }}</h5>
    </a>
    <p class="card-text">
      <img :src="this.content.pin" alt="..." class="rounded img-thumbnail">
      {{ get_text_content() }}
    </p>
    <div>
      <a href="#"><span v-for="tag in this.tags" class="badge badge-info" style='margin-left: 2px;'>{{ tag.tag }}</span></a>
    </div>

  </div>
  <div class="card-footer">
    <div class='d-inline-block align-middle'>
      <button type="button" class="btn btn-link" v-on:click="toggle_star()"><i class="fa fa-gittip" :style="user_action.star_toggle?'font-size:14px;color:#ddd' : 'font-size:17px;'"> Star</i></button>                   
      <div class="dropdown d-inline-block">
        <button class="btn btn-link dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-mail-forward" style="font-size:17px;">Share</i></button>
        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="gedf-drop1" data-social>
          <div class="h6 dropdown-header">Share on</div>
          <a :href="buildFacebookLink()" class="dropdown-item ion-social-facebook" target="_blank"><span>Facebook</span></a>
          <a :href="buildTwitterLink()" class="dropdown-item ion-social-twitter" target="_blank"><span>Twitter</span></a>
          <a :href="buildRedditLink()" class="dropdown-item ion-social-reddit" target="_blank"><span>Reddit</span></a>
        </div>
      </div>
    </div>
  </div>
</div>
  `,

  methods: {
    buildFacebookLink: function(){
      return `javascript:window.open('${this.facebookLink(this.get_redirect_link())}', '_blank', 'width=400,height=500');void(0);`
    },
    buildTwitterLink: function(){
          return `javascript:window.open('${this.twitterLink(this.get_redirect_link())}', '_blank', 'width=400,height=500');void(0);`
    },
    buildRedditLink: function(){
          return `javascript:window.open('${this.redditLink(this.get_redirect_link())}', '_blank', 'width=400,height=500');void(0);`

    },
    redirect_post: function(post){
      console.log('post', post);
      alert('redirected ' + this.post_id + ' end');
      window.location.href = this.get_redirect_link();
    },
    get_redirect_link: function(){
      return `http://ideachain.glitch.me/i?post_id=${this.post_id}`;
    },
    get_text_content: function() {
      console.log('post conten ln', this.content.text.length );
      let suff = ""; 
      if(this.content.text.length > 200) suff = "...";
      return this.content.text.substring(0, 200)+suff ; 
    },
    get_datetime_string: function() {
      var dateTimeString = moment.unix(Date.now()/1000).from(moment.unix(this.create_timestamp), true) + " ago";
      return dateTimeString;
    },
    
    toggle_star: function() {
      this.user_action.star_toggle = !this.user_action.star_toggle;
      //type 1: view, type 2: star
      let data = {
        action_id: 2,
        post_id: this.post_id
      };
      $.post('/actionOnPost', data, (response) => {
        console.log('response', response);
      }); 
    }
  }        
});
/******************************************************************************
 ******************************************************************************
 ***********************************Vue App ***********************************
 ******************************************************************************
 *****************************************************************************/
var user_activity_list = new Vue({
  // el: '#user-activity-list',
  data: {
    all_activity: []
  },
  methods: {
    get_datetime_string: function(timestamp) {
      var dateTimeString = moment.unix(Date.now()/1000).from(moment.unix(timestamp), true);
      return dateTimeString;
    },
    getUserActivityList: function() {
      $.get('/getUserActivityList', {limit:10}, (response) => {
        console.log('activity list', response); 
        var all_activity = JSON.parse(response);
        //action_id, actioner, passiver, action_target_type, action_target__id, user_action_type__id, timestamp, username, title
        for(var i=0; i<all_activity.length; i++){
          if(all_activity[i].action_target_type == 'u2p') {
            all_activity[i].message = `
              <span><a href="http://ideachain.glitch.me/personalinfo?user_id=${all_activity[i].actioner}">${all_activity[i].actioner_username}</a> has ${all_activity[i].action_type_val}ed <a href="http://ideachain.glitch.me/i?post_id=${all_activity[i].action_target_id}">${all_activity[i].title}</a></span>
            `;
          }else if(all_activity[i].action_target_type == 'u2u') {
            all_activity[i].message = `
              <span><a href="http://ideachain.glitch.me/personalinfo?user_id=${all_activity[i].actioner}">${all_activity[i].actioner_username}</a> has ${all_activity[i].action_type_val}ed with you</span>
            `;
          }else{
            all_activity[i].message = `
              <span> </span>`;
          }
          all_activity[i].message += `<div class="notification-date">${this.get_datetime_string(all_activity[i].timestamp)} ago</div>`;
        }
        
        this.all_activity = all_activity;
        console.log('all_activity', this.all_activity);
      });
    }
  },
  created: function(){
    this.getUserActivityList();
  }
});

var friendList = new Vue({
  // el: '#friend-list',
  data:{
    users: []
  },
  methods: {
    addFriend: function(newfriend) {
      this.users.push(newfriend);
    },
    getFriendList: function(){
      $.get('/getFriendList', {}, (response) => {
        this.users = JSON.parse(response);
        console.log('get Friend list', this.users);
      });
    }
  },
  created: function() {
    this.getFriendList();
  }
});

var userList = new Vue({
  data: {
    users: [], 
    message : "hello world", 
    text: ""
  }, 
  methods: {
    addFriend: function(index){
      let params = this.users[index];
      $.post('/addFriend', params, (response) => {});
      friendList.addFriend(params);
      console.log(this.users[index]);
      notificationToast(`You are now friend with <a href="http://ideachain.glitch.me/personalinfo?user_id=${this.users[index].id}"> ${this.users[index].username}</a>`);
      this.users.splice(index, 1);
    },
    getOtherPeopleList: function(){
      $.get('/getOtherPeopleList', {}, (response) => {
        this.users = JSON.parse(response);
        self.message = "done!";
      });
    }
  },
  created: function(){
    console.log('created userlist');
    this.getOtherPeopleList();
  }
});

var postListDashBoard = new Vue({
  mixins: [post_list_mixin],
  methods: {
  },
  created: async function() {
    await this.getUserPostList();
    var $this = this;

    setTimeout(function(){ 
      $this.$grid = $('.white-deck').masonry({
        itemSelector: '.white-panel',
        columnWidth: '.grid-sizer',
        percentPosition: true
      }); 
    }, 1000 );
  },
  updated: function(){
  }
});

/******************************************************************************
 ******************************************************************************
 *****************************App Routing *****************************
 *****************************************************************************/
var app = new ClientExpress();

app.route('/activity', () => {
  var recent_activity_page = new Vue({
    el: '#recent-activity-page',
    mixins: [mixin_recent_activity],
    data (){
      return {
        
      }
    },
    methods: {
      
    },
    created: function(){
      this.fetchRecentActivity();
    },
    updated: function () {
      this.$nextTick(function () {
          // jQuery Plugin: http://flaviusmatis.github.io/simplePagination.js/
          var items = $(".list-wrapper .list-item");
          var numItems = items.length;
          var perPage = 10;
          console.log('runing mounted', numItems);
          items.slice(perPage).hide();

          $("#pagination-container").pagination({
            items: numItems,
            itemsOnPage: perPage,
            prevText: "&laquo;",
            nextText: "&raquo;",
            onPageClick: function(pageNumber) {
              var showFrom = perPage * (pageNumber - 1);
              var showTo = showFrom + perPage;
              items
                .hide()
                .slice(showFrom, showTo)
                .show();
            }
          });
      })
    }
  });
});


app.route('/', () => {
  var index_recent_activity_page = new Vue({
    el: '#index-page-recent-activity',
    mixins: [mixin_recent_activity],
    created: function(){
      this.fetchRecentActivity(5);
    },
  })
});


app.route('/dashboard', () => {
  user_activity_list.$mount('#user-activity-list');
  userList.$mount('#user-list');
  friendList.$mount('#friend-list');
  postListDashBoard.$mount('#post-list-dashboard');
});

app.route('/i', () => {
  user_activity_list.$mount('#user-activity-list');
  userList.$mount('#user-list');
  friendList.$mount('#friend-list');
});

app.route('/personalinfo', () => {
  user_activity_list.$mount('#user-activity-list');
  userList.$mount('#user-list');
  friendList.$mount('#friend-list');
  postListDashBoard.$mount('#post-list-dashboard');

  var postList = new Vue({
    el: '#post-list', 
    mixin: [social_mixin],
    data: {
      posts: []
    },
    methods: {
      getPostList: async function(){
        await $.get('/personalinfo/getPosts', {}, (response) => {
          console.log('post', response);
          
          var objs = JSON.parse(response);
          
          for(var i=0; i<objs.length; i++){
            objs[i].content = JSON.parse(objs[i].content);
          }
          this.posts = objs;
          
          let ckeditor = document.createElement('script');    
          ckeditor.setAttribute('src',"https://platform-api.sharethis.com/js/sharethis.js#property=5d409348919c2c0012611ed5&product=custom-share-buttons");
          document.head.appendChild(ckeditor);
        });
      }
    },
    created: function() {
      this.getPostList();
    }
  });
});

function addFriend(other_user_id){
  let params = {
    id: other_user_id,
  };
  $.post('/addFriend', params, (response) => {
    if(response.added) notificationToast(`You are now friend with ${other_user_id}`);
  });
}

function updatePersonalInfo(){
    var formData = getFormData($('#update-personal-info-form'));
  
    formData.user_interest = $('#user-interest-select').val().split(',');
    console.log("post updatePersonalInfo", formData);
  
    console.log('formData', formData);

    $.post('/personalinfo/update', formData, function(response){
      console.log('response personalinfo update', response);
    });
}

function handleCreateIdeaForm(){
  var formData = getFormData($('#create-idea-form'));
  formData.tags = $('#selectize-post-tags').val().split(',');
  formData.content = {
    pin: formData.pin,
    text : formData.text,
  };
  console.log("post idea formData", formData);

  $.post('/createIdea', formData, (response) => {
    console.log("added", response);
    var obj = JSON.parse(response)[0];
    obj.content = JSON.parse(obj.content);
    window.location.href = `http://ideachain.glitch.me/i?post_id=${obj.post_id}`;
  });
}

function bootboxManageAccount(){
  let manage_account_form_template = `
        <div class="form-group">
          <label class="col-lg-3 control-label">Email:</label>
          <div class="col-lg-8">
            <input class="form-control" type="text" name="email" value='test'>
          </div>
        </div>

        <div class="form-group">
          <label class="col-md-3 control-label">Username:</label>
          <div class="col-md-8">
            <input class="form-control" type="text" value="janeuser">
          </div>
        </div>
        <div class="form-group">
          <label class="col-md-3 control-label">Password:</label>
          <div class="col-md-8">
            <input class="form-control" type="password" value="11111122333">
          </div>
        </div>
        <div class="form-group">
          <label class="col-md-3 control-label">Confirm password:</label>
          <div class="col-md-8">
            <input class="form-control" type="password" value="11111122333">
          </div>
        </div>
        <div class="form-group">
          <label class="col-md-3 control-label"></label>
          <div class="col-md-8">
            <input type="button" class="btn btn-primary" onclick="updateAccountInfo();" value="Save Changes">
            <span></span>
            <input type="reset" class="btn btn-default" value="Cancel">
          </div>
        </div>
  `;
  let manageAccountBoot = bootbox.dialog({
    backdrop: true,
    className: 'manage-account-boot',
    message: manage_account_form_template,
    onEscape: true, 
    size: 'large'
  })
}

function createUploadPostBootbox(){
  let upload_post_template = `
    <!--  >>>>>>>Upload post Panel -->
    <div class="card gedf-card">
      <div class="card-header">
        <ul class="nav nav-tabs card-header-tabs" id="myTab" role="tablist">
          <li class="nav-item">
            <a class="nav-link active" id="posts-tab" data-toggle="tab" href="#posts" role="tab" aria-controls="posts" aria-selected="true">Make
            a publication</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" id="images-tab" data-toggle="tab" role="tab" aria-controls="images" aria-selected="false" href="#images">Images</a>
          </li>
        </ul>
      </div>
      <div class="card-body">
        <div class="tab-content" id="myTabContent">
          <div class="tab-pane fade show active" id="posts" role="tabpanel" aria-labelledby="posts-tab">
            <form id="create-idea-form"> 
              <div class="row align-items-center">
                <div class="col">
                  <input type="text" name='title' class="form-control" placeholder="Idea Title">
                </div>
              </div>

              <div class="form-group mt-4">
                <div class="custom-file">

    <!--                     Toggle for input image pin -->
    <!--                     <input type="file" name='pin' class="custom-file-input">
                  <label class="custom-file-label" for="customFile">Idea Visualization</label> -->

                  <input type="text" name='pin' class="form-control" placeholder="Idea Visualization">
                </div>
              </div>

              <div class='row align-items-center mt-4'>
                <div class="form-group col">
                  <label class="sr-only" for="message">post</label>
                  <textarea class="form-control" name="text" form="create-idea-form" id="message" rows="3" placeholder="What are you thinking?"></textarea>
                </div>
              </div>

              <div class="row align-items-center">
                <div class="form-group col">
                  <input type="text" id='selectize-post-tags' class="form-control" placeholder="Tags">
                </div>
              </div>
            <form>
          </div>
          <div class="tab-pane fade" id="images" role="tabpanel" aria-labelledby="images-tab">
            <div class="form-group">
              <div class="custom-file">
                <input type="file" class="custom-file-input" id="customFile">
                <label class="custom-file-label" for="customFile">Upload image</label>
              </div>
            </div>
            <div class="py-4"></div>
          </div>

        </div>

        <div class="btn-toolbar justify-content-between">
          <div class="btn-group">
            <button type="button" class="btn btn-primary" onclick="handleCreateIdeaForm()">share</button>
          </div>
          <div class="btn-group">
            <button id="btnGroupDrop1" type="button" class="btn btn-link dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <i class="fa fa-globe"></i>
            </button>
            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="btnGroupDrop1">
              <a class="dropdown-item" href="#">
              <i class="fa fa-globe"></i> Public
              </a>
              <a class="dropdown-item" href="#">
              <i class="fa fa-users"></i> Friends
              </a>
              <a class="dropdown-item" href="#">
              <i class="fa fa-user"></i> Just me
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!--  <<<<<<Upload post Panel -->
  `;
  
  let uploadPostBoot = bootbox.dialog({
      backdrop: true,
      className: 'upload-post-boot',
      message: upload_post_template,
      onEscape: true, 
      size: 'large',
      centerVertical: true
  }).on('shown.bs.modal', function(){
      var selectize_post_tag = $('#selectize-post-tags').selectize({
          plugins: ["remove_button"],
          persist: true,
          maxItems: null,
          valueField: 'id',
          labelField: 'tag',
          searchField: ['tag'],
          options: [],
          loaded: false,
          preload: true, 
          render: {
            item: function(item, escape) {
              return (
                "<div>" +
                (item.tag
                  ? '<span class="name">' + escape(item.tag) + "</span>"
                  : "") +
                "</div>"
              );
            },
            option: function(item, escape) {
              var label = item.tag;
              return (
                "<div>" +
                '<span class="label">' +
                escape(label) +
                "</span>" +
                "</div>"
              );
            }
          },
          load: function(query, callback) {
              // if (!query.length) return callback();
            if(!this.loaded){
              this.loaded = true;
              $.ajax({
                  url: '/selectPostTags',
                  type: 'GET',
                  dataType: 'json',
                  error: function() {
                      console.log('Error loading ' + this.url);
                      callback();
                  },
                  success: function(res) {
                      console.log('Success loading ', res );
                      this.options = res;
                      callback(res);
                  }
              });
            }
          }
      });
    });

}
function handleUserFeedbackForm(){
  $.Toast.showToast({
    "title": "Sending feedback.",
    "icon": "loading"
  });
  var $form = $('#user-feedback-form');
  var formData = getFormData($form);
  console.log('user feedback form', formData);

  $.post('/submitUserFeedback', formData, function(response){
    console.log(response);
    $.Toast.hideToast();
    $form[0].reset();
    notificationToast(`Thank you for your feedback!`, "success");
  });
}


function createUserFeedbackBootbox(){
  let form_template = `
      <section>
        <div class="container">
          <div class="row justify-content-center">

  
            <div class="col-md-12">
              <div class="row">
                <div class="col text-center">
                  <h1>User Feedback</h1>
                  <p class="text-h3"></p>
                </div>
              </div>
<form id='user-feedback-form' type='get'>
              <label class="form-check-label" for="inlineFormCheck">
                Star rating
              </label>
              <div class='form-group'>
                <div class="form-check form-check-inline">
                  <input class="form-check-input" type="radio" name="star_rating" value="1" required />
                  <label class="form-check-label" for="inlineRadio1">1</label>
                </div>
                <div class="form-check form-check-inline">
                  <input class="form-check-input" type="radio" name="star_rating" value="2">
                  <label class="form-check-label" for="inlineRadio2">2</label>
                </div>
                <div class="form-check form-check-inline">
                  <input class="form-check-input" type="radio" name="star_rating" value="3">
                  <label class="form-check-label" for="inlineRadio3">3</label>
                </div>
                <div class="form-check form-check-inline">
                  <input class="form-check-input" type="radio" name="star_rating" value="4">
                  <label class="form-check-label" for="inlineRadio2">4</label>
                </div>
                <div class="form-check form-check-inline">
                  <input class="form-check-input" type="radio" name="star_rating" value="5">
                  <label class="form-check-label" for="inlineRadio3">5</label>
                </div>
              </div>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="feedback_type" value="issue" required />
                <label class="form-check-label" for="inlineRadio1">Issue</label>
              </div>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="feedback_type" value="suggestion" />
                <label class="form-check-label" for="inlineRadio2">Suggestion</label>
              </div>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="feedback_type" value="complaint" />
                <label class="form-check-label" for="inlineRadio3">Complaint</label>
              </div>
              <div class="form-group">
                <label for="exampleFormControlTextarea1"></label>
                <textarea class="form-control" name="feedback_message" form='user-feedback-form' rows="4" placeholder="Your message..." required></textarea>
              </div>
              <div class="row justify-content-center mt-4">
                <div class="col">

                  <button type='button' class="btn btn-primary mt-4" onclick='handleUserFeedbackForm();'>Submit</button>
                </div>
              </div>
            </div>
</form>

          </div>
        </div>
      </section>
  `;
  
  
    var userFeedbackBoot = bootbox.dialog({ 
      backdrop: true,
      className: 'user-feedback-boot',
      message: form_template,
      onEscape: true, 
      size: 'medium',
      centerVertical: true
    }).on('shown.bs.modal', function(){
      // $("#signup-form").validate({
      //   rules: {
      //     confirm:{
      //       required: true,
      //     }
      //   },
      // });
    });
}
function createUpdatePersonalInfoBootbox(_todelete){
  $.get('/personalinfo/getPersonalInfo', {}, (response) => {
    let person_info = JSON.parse(response);  
    let form_template_save=`
          <img src='${person_info.wallpaper_url}'></img><br>
          <img width='50' height='50' src='${person_info.avatar_url}'></img>
          <br><hr>
          <form id='update-personal-info-form'>
            <label>wallpaper_url <input name="wallpaper_url" value='${person_info.wallpaper_url}'></label>
            <label>avatar_url <input name="avatar_url" value='${person_info.avatar_url}'></label>
            <label>Email <input name="email" value='${person_info.email}'></label>
            <label>Name <input name="name" value='${person_info.name}'></label>
            <label>User interest <input type="text" id='user-interest-select' placeholder="Interest"></label>
            <label>Status <input name="status" value='${person_info.status}'></label>
            <input type = "button" class="db mv2 pa1 w5" name="data" onclick="updatePersonalInfo();" value="Update">
          </form>
    `;

    let form_template = `
    <div class="container">
      <div class="row">
          <!-- left column 
          <div class="col-md-3">
            <div class="text-center">
              <img src="${person_info.avatar_url}" class="avatar img-circle" alt="avatar">
              <h6>Upload a different photo...</h6>
              
              <input type="file" class="form-control">
            </div>
          </div>-->
          

      <div class="col-md-12">
        <div class="card profile-card-2">

          <div class="card-body pt-5">

            <div class="picture-container">
                <div class="avartar-picture">
                    <img src="https://lh3.googleusercontent.com/LfmMVU71g-HKXTCP_QWlDOemmWg4Dn1rJjxeEsZKMNaQprgunDTtEuzmcwUBgupKQVTuP0vczT9bH32ywaF7h68mF-osUSBAeM6MxyhvJhG6HKZMTYjgEv3WkWCfLB7czfODidNQPdja99HMb4qhCY1uFS8X0OQOVGeuhdHy8ln7eyr-6MnkCcy64wl6S_S6ep9j7aJIIopZ9wxk7Iqm-gFjmBtg6KJVkBD0IA6BnS-XlIVpbqL5LYi62elCrbDgiaD6Oe8uluucbYeL1i9kgr4c1b_NBSNe6zFwj7vrju4Zdbax-GPHmiuirf2h86eKdRl7A5h8PXGrCDNIYMID-J7_KuHKqaM-I7W5yI00QDpG9x5q5xOQMgCy1bbu3St1paqt9KHrvNS_SCx-QJgBTOIWW6T0DHVlvV_9YF5UZpN7aV5a79xvN1Gdrc7spvSs82v6gta8AJHCgzNSWQw5QUR8EN_-cTPF6S-vifLa2KtRdRAV7q-CQvhMrbBCaEYY73bQcPZFd9XE7HIbHXwXYA=s200-no" class="picture-src" id="wizardPicturePreview" title="">
                    <input type="file" id="wizard-picture" class="">
                </div>
                 <h6 class="">Choose Picture</h6>

            </div>
            <h5 class="card-title">Landon Hunt</h5>
            <div class='row'>
                <!-- edit form column -->
                <div class="col-md-12 personal-info">
                  <div class="alert alert-info alert-dismissable">
                    <a class="panel-close close" data-dismiss="alert">×</a> 
                    <i class="fa fa-coffee"></i>
                    This is an <strong>.alert</strong>. User alert
                  </div>
                  <h3>Edit Profile</h3>

                  <form class="form-horizontal" role="form" id='update-personal-info-form'>
                    <div class="form-group">
                      <label class="col-lg-3 control-label">Full Name:</label>
                      <div class="col-lg-8">
                        <input class="form-control" type="text" name="fullname" value='${person_info.fullname}'>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-3 control-label">User Interest:</label>
                      <div class="col-lg-8">
                        <input class="form-control" type="text" id='user-interest-select' placeholder="Interest">
                      </div>
                    </div>
         <!--           <div class="form-group">
                      <label class="col-lg-3 control-label">Time Zone:</label>
                      <div class="col-lg-8">
                        <div class="ui-select">
                          <select id="user_time_zone" class="form-control">
                            <option value="Hawaii">(GMT-10:00) Hawaii</option>
                            <option value="Alaska">(GMT-09:00) Alaska</option>
                            <option value="Pacific Time (US &amp; Canada)">(GMT-08:00) Pacific Time (US &amp; Canada)</option>
                            <option value="Arizona">(GMT-07:00) Arizona</option>
                            <option value="Mountain Time (US &amp; Canada)">(GMT-07:00) Mountain Time (US &amp; Canada)</option>
                            <option value="Central Time (US &amp; Canada)" selected="selected">(GMT-06:00) Central Time (US &amp; Canada)</option>
                            <option value="Eastern Time (US &amp; Canada)">(GMT-05:00) Eastern Time (US &amp; Canada)</option>
                            <option value="Indiana (East)">(GMT-05:00) Indiana (East)</option>
                          </select>
                        </div>
                      </div>
                    </div> -->
                    <div class="form-group">
                      <label class="col-md-3 control-label"></label>
                      <div class="col-md-8">
                        <input type="button" class="btn btn-primary" onclick="updatePersonalInfo();" value="Save Changes">
                        <span></span>
                        <input type="reset" class="btn btn-default" value="Cancel">
                      </div>
                    </div>
                  </form>
                </div>
            </div>
          </div>
        </div>
      </div>



      </div>
    </div>`;

    var updatePersonInfoBoot = bootbox.dialog({ 
      backdrop: true,
      className: 'update-personal-info-boot',
      message: form_template,
      onEscape: true, 
      size: 'large',
      centerVertical: true
    }).on('shown.bs.modal', function(){
      let $form = $('#update-personal-info');
      var selectize_user_interest = $('#user-interest-select').selectize({
          plugins: ["remove_button"],
          persist: true,
          maxItems: null,
          valueField: 'id',
          labelField: 'val',
          searchField: ['val'],
          options: [],
          loaded: false,
          preload: true, 
          render: {
            item: function(item, escape) {
              return (
                "<div>" +
                (item.val
                  ? '<span class="name">' + escape(item.val) + "</span>"
                  : "") +
                "</div>"
              );
            },
            option: function(item, escape) {
              var label = item.val;
              return (
                "<div>" +
                '<span class="label">' +
                escape(label) +
                "</span>" +
                "</div>"
              );
            }
          },
          load: function(query, callback) {
              // if (!query.length) return callback();
            if(!this.loaded){
              this.loaded = true;
              $.ajax({
                  url: '/selectUserInterest',
                  type: 'GET',
                  dataType: 'json',
                  error: function() {
                      console.log('Error loading ' + this.url);
                      callback();
                  },
                  success: function(res) {
                      console.log('Success loading ', res );
                      this.options = res;
                      callback(res);
                  }
              });
            }
          }
      });
    });
    
    
  });
  

}


function getFormData($form){
    var formData = $form.serializeArray();
    var data = {};
    $.map(formData, n=>data[n['name']] = n['value']);
    return data;
}

function createUser(){
    var message = "Creating new user";
    var formData = getFormData($('#signup-form'));
    $.post('/signup', formData, function(response){
      console.log(response);
    });
}

function notificationToast (message, toast_type='info'){
//https://codeseven.github.io/toastr/demo.html
  toastr[toast_type](message)

  toastr.options = {
    "closeButton": true,
    "debug": false,
    "newestOnTop": true,
    "progressBar": false,
    "positionClass": "toast-top-right",
    "preventDuplicates": false,
    "onclick": null,
    "showDuration": "300",
    "hideDuration": "1000",
    "timeOut": "5000",
    "extendedTimeOut": "1000",
    "showEasing": "swing",
    "hideEasing": "linear",
    "showMethod": "fadeIn",
    "hideMethod": "fadeOut"
  }
}

/***********************Social media share**********************/
app.listen(() =>{
  console.log(`Start IdeaChain App @ '${location.pathname}'`)
});