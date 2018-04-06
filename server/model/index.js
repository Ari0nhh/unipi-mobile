var fs = require("fs");
var path = require("path");
var Sequelize = require("sequelize");

var config = require(path.join(__dirname, "..", "/", "config", "config.json"))["connection"];
var sequelize = new Sequelize(config.database, config.username, config.password, config);
var db = {};

var database = require("./database");
db.Model = database.init(sequelize);
db.Sequelize = Sequelize;
db.sequelize = sequelize;

module.exports = db;