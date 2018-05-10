let createError = require('http-errors');
let express = require('express');
let path = require('path');
let logger = require('morgan');
let app = express();

let cookieParser = require('cookie-parser');
let bodyParser = require('body-parser');
let session = require('express-session');

let passport = require('passport');
let db = require('./model');

require('./auth')(passport, db.Model.DwUser);
require('./auth/bearer')(passport, db.Model.DwUser);

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

app.use(logger('dev'));

app.use(session({secret : 'old donkey ears',
    resave : true,
    saveUninitialized : false}));
app.use(cookieParser());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended : true}));

app.use(passport.initialize());
app.use(passport.session());

var indexRouter = require('./routes/index')(passport, db);
app.use('/', indexRouter);

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
