module.exports =  function(router, passport, db)
{
    router.post('/REST/add_period', (req, res) => {
        passport.authenticate('bearer', {session : false}, (err, user, info) => {
            if(!user.usAdmin)
                return res.status(403).end();

            let data = {};
            data.epName = req.body.period_name;
            data.epStart = req.body.period_start;
            data.epEnd = req.body.period_end;
            data.epEvent = req.body.event_id;

            let Period = db.Model.DwEventPeriod;
            Period.create(data).then(cPeriod=>{
                res.json({id : cPeriod.epId, status : 'ok'});
            }).catch(error =>{
                res.json({status : 'error', what : error});
            });
        })(req, res);
    });
};