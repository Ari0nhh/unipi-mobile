module.exports =  function(router, passport, db)
{
    router.get('/REST/event/:evtId', (req, res, next) => {
        passport.authenticate('bearer', {session : false}, (err, user, info) => {
            let query = {};
            query.where = {};
            query.where.evt_id = req.params["evtId"];

            db.Model.DwEvent.findOne(query).then(event => {
                if (!event)
                    return res.status(404).end();

                if (event.evtInternal === '1' && (!user || !user.usEmpl))
                    return res.status(404).end();

                let qPeriods = {
                    where: {ep_event: query.where.evt_id},
                    include: [{model: db.Model.DwEventAction, as: 'actions'}]
                };
                db.Model.DwEventPeriod.findAll(qPeriods).then(periods => {

                    event.dataValues["periods"] = periods;
                    res.json(event);
                });
            });
        })(req, res);
    });
};