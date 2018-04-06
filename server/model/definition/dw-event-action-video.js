/* eslint new-cap: "off", global-require: "off" */

module.exports = (sequelize, DataTypes) => {
    return sequelize.define('DwEventActionVideo', {
        eaId: {
            type: DataTypes.INTEGER,
            field: 'ea_id',
            allowNull: false,
            references: {
                model: 'dw_event_action',
                key: 'ea_id'
            },
            onUpdate: 'NO ACTION',
            onDelete: 'NO ACTION'
        },
        vId: {
            type: DataTypes.INTEGER,
            field: 'v_id',
            allowNull: false,
            references: {
                model: 'dw_video',
                key: 'v_id'
            },
            onUpdate: 'NO ACTION',
            onDelete: 'NO ACTION'
        }
    }, {
        schema: 'public',
        tableName: 'dw_event_action_video',
        timestamps: false
    });
};

module.exports.initRelations = () => {
    delete module.exports.initRelations; // Destroy itself to prevent repeated calls.

    const model = require('../index');
    const DwEventActionVideo = model.DwEventActionVideo;
    const DwEventAction = model.DwEventAction;
    const DwVideo = model.DwVideo;

    DwEventActionVideo.belongsTo(DwEventAction, {
        as: 'Ea',
        foreignKey: 'ea_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

    DwEventActionVideo.belongsTo(DwVideo, {
        as: 'V',
        foreignKey: 'v_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

};
