var bCrypt = require("bcrypt-nodejs");

module.exports = function(passport, user) {
    var User = user;
    var LocalStrategy = require("passport-local").Strategy;

    passport.use('local-signup', new LocalStrategy(
        {
            usernameField : 'email',
            passwordField : 'password',
            passReqToCallback : true
        },

        (req, email, password, done) =>
        {
            var generateHash = function(password, user)
            {
                return bCrypt.hashSync(password, User.usSalt);
            };

            User.findOne({
                where : {usEmail: email}
            }).then((user) =>
            {
                if(!user)
                    return done(null, false);

                var pass = generateHash(password, user);

                if(pass != user.usPassw)
                    return(done(null, false));

                return done(null, user);
            })
        }
    ));

    passport.serializeUser((user, done) =>{
       done(null, user.usId);
    });

    passport.deserializeUser((id, done) =>
    {
        User.findById(id).then((user)=>
        {
            if(user)
            {
                done(null, user.get());
            }else
            {
                done(user.errors, null);
            }
        });
    });
}