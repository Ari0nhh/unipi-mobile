module.exports =  function(router, passport, db)
{
    router.get('/REST/events', (req, res) => {
        passport.authenticate('bearer', {session : false}, (err, user, info) => {
            const Op = db.Sequelize.Op;
            let query = {};
            query.attributes = ['evt_id', 'evt_name', 'evt_date_start', 'evt_date_end', 'evt_internal'];
            query.where = {evt_date_end: {[Op.gte]: new Date()}};

            if (!err && user && user.usEmpl)
            {
                db.Model.DwEvent.findAll(query).then(events => {
                    res.json(events);
                });
            } else {
                query.where.evt_internal = '0';
                db.Model.DwEvent.findAll(query).then(events => {
                    res.json(events);
                });
            }
        })(req, res);
    });
};