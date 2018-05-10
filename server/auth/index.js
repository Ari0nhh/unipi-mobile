module.exports = function(passport, user) {
    let bCrypt = require('bcrypt-nodejs');
    let LocalStrategy = require('passport-local').Strategy;

    passport.use('login', new LocalStrategy(
        {
            usernameField : 'email',
            passwordField : 'password',
            passReqToCallback : true
        },

        (req, username, password, done) =>
        {
            user.findOne({where : {usEmail: username}}).then((locUser) =>
            {
                if(!locUser)
                    return done(null, false);

                if(!bCrypt.compareSync(password, locUser.usPassw))
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
                done(null, login);
            }else
            {
                done(login.errors, null);
            }
        });
    });
};