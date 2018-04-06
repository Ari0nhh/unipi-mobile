var express = require('express');
var router = express.Router();
var passport = require("Passport");

router.get('/', function(req, res, next)
{

});


router.post('/auth', (req, res, next)=>
{
    passport.authenticate("passport-local", (req, res) =>{
        res.json({ id : req.user.usId});
    });
});

module.exports = router;
