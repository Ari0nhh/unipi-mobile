module.exports = function(router, passport, db)
{
    router.post('/register', (req, res, next) =>{
        let bCrypt = require('bcrypt-nodejs');
        let data = {};
        data.usName = req.body.username;
        data.usEmpl = '0';
        data.usEmail = req.body.email;
        data.usPhone = req.body.phone;
        data.usOrg = req.body.org;
        data.usPhoto = 1;
        data.usPassw = bCrypt.hashSync(req.body.password);

        let User = db.Model.DwUser;

        User.create(data).then(cUser =>{
            res.json({id : cUser.usId})
        }).catch(error => {
           //res.status(500).end();
            res.json(error);
        });
    });
};