module.exports =  function(router, passport, db)
{
    router.get("/REST/user/:userId", (req, res, next) => {
        let userId = req.params["userId"];
        if (!req.user || (req.user.usId !== userId)) //Пока не даём смотреть чужой профиль
        {
            return res.status(403).end();
        }

        let query = {where: {us_id: userId}};
        db.Model.DwUser.findOne(query).then(user => {
            if (!user)
                return res.status(404).end();

            res.json(user);
        });
    });
};