let bCrypt = require("bcrypt-nodejs");

module.exports = function(passport, user) {
    let LocalStrategy = require("passport-local").Strategy;

    passport.use('login', new LocalStrategy(
        {
            usernameField : 'email',
            passwordField : 'password',
            passReqToCallback : true
        },

        (req, email, password, done) =>
        {
            var generateHash = function(password, account)
            {
                return bCrypt.hashSync(password, account.usSalt);
            };

            user.findOne({where : {usEmail: email}}).then((locUser) =>
            {
                if(!locUser)
                    return done(null, false);

                var pass = generateHash(password, locUser);

                if(pass !== locUser.usPassw)
                    return(done(null, false));

                return done(null, locUser);
            });
        }
    ));

    passport.serializeUser((login, done) =>{
        done(null, login.usId);
    });

    passport.deserializeUser((id, done) =>
    {
        user.findById(id).then((login)=>
        {
            if(login)
            {
                done(null, login.get());
            }else
            {
                done(login.errors, null);
            }
        });
    });
}