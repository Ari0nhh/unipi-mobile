module.exports =  function(router, passport, db)
{
    router.post('/auth', (req, res, next) =>{
        passport.authenticate('login', (err, user, info) =>{
            if(err)
                return next(err);

            if(!user)
                return res.status(401).end();

            return res.json(user);
        })(req, res, next);
    });
};