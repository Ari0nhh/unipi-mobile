let express = require('express');
let router = express.Router();

let db = require("../model");
const Op = db.Sequelize.Op;

router.get('/REST/events', (req, res, next) =>
{
    let query = {};
    query.attributes = ['evt_id', 'evt_name', 'evt_date_start', 'evt_date_end', 'evt_internal'];
    query.where = { evt_date_end : { [Op.gte] : new Date() }};

    if( req.user && req.user.usEmpl)
    {
        db.Model.DwEvent.findAll(query).then(events =>{
            res.json(events);
        });
    }else
    {
        query.where.evt_internal = '0';
        db.Model.DwEvent.findAll(query).then(events =>{
            res.json(events);
        });
    }
});

router.get('/REST/events/archive', (req, res, next) =>
{
    let query = {};
    query.attributes = ['evt_id', 'evt_name', 'evt_date_start', 'evt_date_end', 'evt_internal'];
    query.where = { evt_date_end : { [Op.lt] : new Date() }};

    if( req.user && req.user.usEmpl)
    {
        db.Model.DwEvent.findAll(query).then(events =>{
            res.json(events);
        });
    }else
    {
        query.where.evt_internal = '0';
        db.Model.DwEvent.findAll(query).then(events =>{
            res.json(events);
        });
    }
});

router.get('/REST/event/:evtId', (req, res, next) =>{
    let query = {};
    query.where = {};
    query.where.evt_id = req.params["evtId"];

    db.Model.DwEvent.findOne(query).then( event => {
        if(!event)
            return res.status(404).end();

        if(event.evtInternal === '1' && (!req.user || !req.user.usEmpl))
            return res.status(404).end();

        let qPeriods = {
            where   : {ep_event : query.where.evt_id},
            include : [{model : db.Model.DwEventAction, as : 'actions'}]
        };
        db.Model.DwEventPeriod.findAll(qPeriods).then(periods =>{

            event.dataValues["periods"] = periods;
            res.json(event);
        });

        //res.json(event);
    });
});

router.get("/REST/image/:imgId", (req, res, next) =>{
    let query = { where : {img_id : req.params["imgId"]} };

    db.Model.DwImage.findOne(query).then(image =>{
        res.type(image.imgKind).send(image.imgData);
    });
});

router.get("/REST/user/:userId", (req, res, next) =>{
    let userId = req.params["userId"];
    if(!req.user || (req.user.usId !== userId)) //Пока не даём смотреть чужой профиль
    {
        return res.status(403).end();
    }

    let query = { where : {us_id : userId}};
    db.Model.DwUser.findOne(query).then(user =>{
        if(!user)
            return res.status(404).end();

        res.json(user);
    });
});

router.post('/auth', (req, res, next)=>
{
    passport.authenticate("passport-local", (req, res) =>{
        res.json({ id : req.user.usId});
    });
});

module.exports = router;
