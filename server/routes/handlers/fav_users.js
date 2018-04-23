module.exports =  function(router, passport, db)
{
    router.get('/REST/fav_users', (req, res, next) => {
        const Op = db.Sequelize.Op;
        db.sequelize.query('SELECT u.us_name, u.us_email, u.us_phone, u.us_photo, u.us_org ' +
            'FROM dw_user u, dw_fav_users ' +
            'WHERE dw_fav_users.us_id = :id and ' +
            'u.us_id = dw_fav_users.fav_us_id',
            {replacements: {id: 1}, type: db.sequelize.QueryTypes.SELECT}).then(favUsers => {
            if(!favUsers)
                return res.status(404).end();
            res.json(favUsers);
        });
        //if (req.user && req.user.usEmpl) {
            /*let query = {};
            query.attributes = ['fav_us_id'];
            query.where = {us_id: 1};//req.user.usId;
            db.Model.DwFavUser.findAll(query).then(users_ids => {
                if(!users_ids)
                    return res.status(404).end();

                let qFavUsers;
                qFavUsers = {
                    attributes: ['us_name', 'us_photo', 'us_email', 'us_phone', 'us_org', 'us_phone'],
                    where: {us_id:users_ids}
                };
                db.Model.DwUser.findAll(qFavUsers).then(favUsers => {
                    if(!favUsers)
                        return res.status(404).end();
                    res.json(favUsers);
                });
            });*/
       // } else {
       //     return res.status(404).end();
       // }
    });
};