module.exports =  function(router, passport, db)
{
    router.get("/REST/image/:imgId", (req, res, next) => {
        let query = {where: {img_id: req.params["imgId"]}};

        db.Model.DwImage.findOne(query).then(image => {
            res.type(image.imgKind).send(image.imgData);
        });
    });
};