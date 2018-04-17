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
            let generateHash = function(password, account)
            {
                return bCrypt.hashSync(password, account.usSalt);
            };

            console.log('Password::login');
            user.findOne({where : {usEmail: username}}).then((locUser) =>
            {
                console.log(locUser);
                if(!locUser)
                    return done(null, false);

                let pass = generateHash(password, locUser);

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
};