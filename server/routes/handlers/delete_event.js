module.exports =  function(router, passport, db)
{
    router.delete('/REST/delete_event/:evtId', (req, res, next) => {
        passport.authenticate('bearer', {session : false}, (err, user, info) => {
            if(!user.usAdmin)
                return res.status(403).end();

            let id = req.params["evtId"];
            db.Model.DwEvent.destroy({
                where : {
                    evt_id : id
                }
            }).then((nRowsDeleted)=>{
                if(nRowsDeleted === 1)
                    return res.status(200).end();

                return res.status(417).end();
            })
        })(req, res);
    });
};