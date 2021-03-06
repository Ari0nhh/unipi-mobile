module.exports =  function(router, passport, db)
{
    router.post('/REST/add_event', (req, res) => {
        passport.authenticate('bearer', {session : false}, (err, user, info) => {
            if(!user.usAdmin)
                return res.status(403).end();

            let data = {};
            data.evtName = req.body.evtName;
            data.evtDateStart = req.body.evtStart;
            data.evtDateEnd = req.body.evtEnd;
            data.evtAddress = req.body.evtAddress;
            data.evtDescr = req.body.evtDescr;
            data.evtInternal = req.body.evtInternal;
            data.evtLattitude = 0;
            let Event = db.Model.DwEvent;

            data.evtLongitude = 0;
            Event.create(data).then(cEvent=>{
                res.json({id : cEvent.evtId, status : 'ok'});
            }).catch(error =>{
                res.json({status : 'error', what : error});
            });
        })(req, res);
    });
};