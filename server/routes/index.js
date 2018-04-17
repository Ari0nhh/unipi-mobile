module.exports = function(passport, db)
{
    let express = require('express');
    let router = express.Router();

    require('./handlers/events')(router, passport, db);
    require('./handlers/archive')(router, passport, db);
    require('./handlers/event_data')(router, passport, db);
    require('./handlers/image')(router, passport, db);
    require('./handlers/profile')(router, passport, db);
    require('./handlers/auth')(router, passport, db);
    require('./handlers/register')(router, passport, db);

    return router;
};