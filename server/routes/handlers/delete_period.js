module.exports =  function(router, passport, db)
{
    router.delete('/REST/delete_period/:pId', (req, res, next) => {
        passport.authenticate('bearer', {session : false}, (err, user, info) => {
            if(!user.usAdmin)
                return res.status(403).end();

            let id = req.params["pId"];
            db.Model.DwEventPeriod.destroy({
                where : {
                    ep_id : id
                }
            }).then((nRowsDeleted)=>{
                if(nRowsDeleted === 1)
                    return res.status(200).end();

                return res.status(417).end();
            })
        })(req, res);
    });
};