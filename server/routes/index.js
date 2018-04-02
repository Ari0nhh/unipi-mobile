var express = require('express');
var router = express.Router();

router.get('/', function(req, res, next)
{
    res.status(400).end();
});

router.get('/REST/events', function(req, res, next) {
    let data = [];

    let tJs = {};
    tJs.id = 1;
    tJs.name = "Тестовое мероприятие №1";
    tJs.period = "10-05-2018 / 12-05-2018";
    tJs.internal = false;
    data.push(tJs);

    tJs.id = 2;
    tJs.name = "Тестовое мероприятие №2";
    tJs.period = "18-06-2018 / 25-06-2018";
    tJs.internal = true;
    data.push(tJs);

    res.send(JSON.stringify(data));
});

module.exports = router;
