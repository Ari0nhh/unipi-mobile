module.exports =  function(router, passport, db)
{
    router.post('/REST/edit_event', (req, res) => {
        passport.authenticate('bearer', {session : false}, (err, user, info) => {
            let resp = {};
            resp.status = 'ok';

            res.json(resp);
        })(req, res);
    });
}