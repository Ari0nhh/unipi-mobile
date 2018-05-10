module.exports = function(passport, user)
{
    let BearerStrategy = require('passport-http-bearer').Strategy;

    passport.use(new BearerStrategy((token, done) =>
    {
        user.findOne({where : {usToken: token}}).then((locUser) =>
        {
            if(locUser)
                return done(null, locUser);

            return done(null, false);
        });
    }));
};