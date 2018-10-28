module.exports =  function(router, passport, db)
{
    router.post('/REST/edit_period', (req, res) => {
        passport.authenticate('bearer', {session : false}, (err, user, info) => {
            if(!user.usAdmin)
                return res.status(403).end();

            db.Model.DwEventPeriod.update(
                {
                    epName : req.body.period_name,
                    epStart : req.body.period_start,
                    epEnd : req.body.period_end
                },
                {where : {epId : req.body.period_id}}).then(result =>{
                res.json({status : 'ok'});
            }).catch(err =>{
                res.json({status : 'error', error : err});
            });

        })(req, res);
    });
};