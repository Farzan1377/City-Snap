let firebase = require("firebase");
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'hbs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/users', usersRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;

function gridify(lat, long){
    let zero_lat = 43.642551;
    let zero_long = -79.386853;

    let ten_m_in_lat = 0.00009000476;
    let ten_m_in_long = 0.00012393705;

    let lat_grid_diff = (lat - zero_lat) / ten_m_in_lat;
    let long_grid_diff = (long - zero_long) / ten_m_in_long;

    return {
        "lat_grid" : Math.floor(lat_grid_diff),
        "long_grid" : Math.floor(long_grid_diff),
    }
}

function ungridify(latgrid, longgrid) {
    let zero_lat = 43.642551;
    let zero_long = -79.386853;
    let ten_m_in_lat = 0.00009000476;
    let ten_m_in_long = 0.00012393705;
    return {lat: latgrid*ten_m_in_lat+zero_lat,
            long: longgrid*ten_m_in_long+zero_long};
}


function rate(count, importance) {
    return (importance + Math.sqrt(count))
}


let config_dirty = {
    apiKey: "AIzaSyCPYzrCVv18y3WlbtJqlA3xr4UDe9C3RZk",
    authDomain: "citysnap-67ae4.firebaseapp.com",
    //databaseURL: "https://citysnap-67ea4.firebaseio.com/",
    projectId: "citysnap-67ae4",
    storageBucket: "citysnap-67ae4.appspot.com",
    messagingSenderId: "97486797291"
};

//firebase.initializeApp(config_dirty);

const dirty = firebase.initializeApp({
    databaseURL: "https://citysnap-67ae4.firebaseio.com/"
});

const clean = firebase.initializeApp({
    databaseURL: "https://citysnap-clean.firebaseio.com/"
}, 'clean');


let dirty_ref = firebase.database(dirty).ref();
let clean_ref = firebase.database(clean).ref();

//dirty_ref.push({lat: 43.664147, lng: -79.398428, category: "traffic light", likes: 1});

let value_dict = {'damaged bin': 3, 'graffiti': 2,'overflow': 3, 'sidewalk litter': 2,
                  'potholes': 4, 'sidewalk damage': 3, 'signs': 6, 'traffic light': 9,
                  'water': 9, 'dead animal': 5, 'removal of tree': 7,
                   'icy surface': 7, 'snow piled up': 5, 'snowplough damage': 4,
                  'emergency': 50, 'non emergency': 11};

dirty_ref.on("child_added", function(snapshot, prevChildKey) {
    let found_flag = false;
    let details = snapshot.val();
    let grid = gridify(details.lat, details.lng);
    let centered_coords = ungridify(grid.lat_grid, grid.long_grid);
    let gridstring = "" + grid.lat_grid + "," + grid.long_grid;
    let category = details.category;
    let importance = value_dict[category];
    let imglink = details.image;
    // looking for the correct category in clean db
    clean_ref.child(category).once('value', function (snapshot) {
        snapshot.forEach(function (childSnapshot) {
            if (gridstring === childSnapshot.key) {
                // we found
                found_flag = true;
                let clean_details = childSnapshot.val();
                let count = clean_details.count;
                count++;
                clean_ref.child(category + "/" + gridstring + "/count").set(count);
                console.log(childSnapshot.key);
                let rating = rate(count, importance);
                clean_ref.child(category + "/" + gridstring + "/rating").set(rating);
                let images_string = clean_details.images + " " + imglink;
                clean_ref.child(category + "/" + gridstring + "/images").set(images_string);
            }
        })
    });
    if (!found_flag) {
        //console.log(imglink);
        clean_ref.child(category + "/" + gridstring).set({
            count: 1,
            images: imglink,
            rating: rate(1, importance),
            lat: centered_coords.lat,
            long: centered_coords.long
        });
        //create new record w/ info
    }
 //   console.log(grid);
});

clean_ref.on("child_added", function(snapshot, prevChildKey) {
   // console.log(snapshot.val()["239,-94"]);
});


