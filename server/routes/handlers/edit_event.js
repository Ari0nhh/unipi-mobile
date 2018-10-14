module.exports =  function(router, passport, db)
{
    router.post('/REST/edit_event', (req, res) => {
        passport.authenticate('bearer', {session : false}, (err, user, info) => {
            if(!user.usAdmin)
                return res.status(403).end();

            db.Model.DwEvent.update(
                {
                    evtName : req.body.evtName,
                    evtDateStart : req.body.evtStart,
                    evtDateEnd : req.body.evtEnd,
                    evtAddress : req.body.evtAddress,
                    evtDescr : req.body.evtDescr,
                    evtInternal : req.body.evtInternal
                },
                {where : {evtId : req.body.evtId}}).then(result =>{
                    res.json({status : 'ok'});
            }).catch(err =>{
                res.json({status : 'error', error : err});
            });
        })(req, res);
    });
}