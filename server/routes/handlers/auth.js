module.exports =  function(router, passport, db)
{
    router.post('/auth', (req, res, next) =>{
        passport.authenticate('login', (err, user, info) =>{
            if(err)
                return next(err);

            if(!user)
                return res.status(401).end();

            let data = {};
            data.id = user.usId;
            data.admin = user.usAdmin;
            data.token = user.usToken;

            return res.json(data);
        })(req, res, next);
    });
};