/* eslint global-require: "off" */
const model = {};
let initialized = false;

/**
 * Initializes sequelize models and their relations.
 * @param   {Object} sequelize  - Sequelize instance.
 * @returns {Object}            - Sequelize models.
 */
function init(sequelize) {
    delete module.exports.init; // Destroy itself to prevent repeated calls and clash with a model named 'init'.
    initialized = true;
    // Import model files and assign them to `model` object.
    model.DwEventAction = sequelize.import('./definition/dw-event-action.js');
    model.DwEventActionFile = sequelize.import('./definition/dw-event-action-files.js');
    model.DwEventActionVideo = sequelize.import('./definition/dw-event-action-video.js');
    model.DwEventPeriod = sequelize.import('./definition/dw-event-period.js');
    model.DwEventSpeaker = sequelize.import('./definition/dw-event-speaker.js');
    model.DwEventSpeakers = sequelize.import('./definition/dw-event-speakers.js');
    model.DwEvent = sequelize.import('./definition/dw-events.js');
    model.DwFavEvent = sequelize.import('./definition/dw-fav-events.js');
    model.DwFavUser = sequelize.import('./definition/dw-fav-users.js');
    model.DwFile = sequelize.import('./definition/dw-files.js');
    model.DwImage = sequelize.import('./definition/dw-images.js');
    model.DwPartcipation = sequelize.import('./definition/dw-partcipation.js');
    model.DwUser = sequelize.import('./definition/dw-user.js');
    model.DwVideo = sequelize.import('./definition/dw-video.js');

    // All models are initialized. Now connect them with relations.
    require('./definition/dw-event-action.js').initRelations();
    require('./definition/dw-event-action-files.js').initRelations();
    require('./definition/dw-event-action-video.js').initRelations();
    require('./definition/dw-event-period.js').initRelations();
    require('./definition/dw-event-speaker.js').initRelations();
    require('./definition/dw-event-speakers.js').initRelations();
    require('./definition/dw-events.js').initRelations();
    require('./definition/dw-fav-events.js').initRelations();
    require('./definition/dw-fav-users.js').initRelations();
    require('./definition/dw-files.js').initRelations();
    require('./definition/dw-images.js').initRelations();
    require('./definition/dw-partcipation.js').initRelations();
    require('./definition/dw-user.js').initRelations();
    require('./definition/dw-video.js').initRelations();
    return model;
}

// Note: While using this module, DO NOT FORGET FIRST CALL model.init(sequelize). Otherwise you get undefined.
module.exports = model;
module.exports.init = init;
module.exports.isInitialized = initialized;
