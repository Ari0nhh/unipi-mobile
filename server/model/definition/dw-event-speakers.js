/* eslint new-cap: "off", global-require: "off" */

module.exports = (sequelize, DataTypes) => {
    return sequelize.define('DwEventSpeaker', {
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
        esId: {
            type: DataTypes.INTEGER,
            field: 'es_id',
            allowNull: false,
            references: {
                model: 'dw_event_speaker',
                key: 'es_id'
            },
            onUpdate: 'NO ACTION',
            onDelete: 'NO ACTION'
        }
    }, {
        schema: 'public',
        tableName: 'dw_event_speakers',
        timestamps: false
    });
};

module.exports.initRelations = () => {
    delete module.exports.initRelations; // Destroy itself to prevent repeated calls.

    const model = require('../index');
    const DwEventSpeaker = model.DwEventSpeaker;
    const DwEventAction = model.DwEventAction;
    const DwEventSpeaker = model.DwEventSpeaker;

    DwEventSpeaker.belongsTo(DwEventAction, {
        as: 'Ea',
        foreignKey: 'ea_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

    DwEventSpeaker.belongsTo(DwEventSpeaker, {
        as: 'E',
        foreignKey: 'es_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

};
