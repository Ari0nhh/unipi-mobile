/* eslint new-cap: "off", global-require: "off" */

module.exports = (sequelize, DataTypes) => {
    return sequelize.define('DwEventPeriod', {
        epId: {
            type: DataTypes.INTEGER,
            field: 'ep_id',
            allowNull: false,
            primaryKey: true
        },
        epEvent: {
            type: DataTypes.INTEGER,
            field: 'ep_event',
            allowNull: false,
            references: {
                model: 'dw_events',
                key: 'evt_id'
            },
            onUpdate: 'NO ACTION',
            onDelete: 'NO ACTION'
        },
        epName: {
            type: DataTypes.STRING(200),
            field: 'ep_name',
            allowNull: true
        },
        epStart: {
            type: DataTypes.DATE,
            field: 'ep_start',
            allowNull: true
        },
        epEnd: {
            type: DataTypes.DATE,
            field: 'ep_end',
            allowNull: true
        }
    }, {
        schema: 'public',
        tableName: 'dw_event_period',
        timestamps: false
    });
};

module.exports.initRelations = () => {
    delete module.exports.initRelations; // Destroy itself to prevent repeated calls.

    const model = require('../index');
    const DwEventPeriod = model.DwEventPeriod;
    const DwEventAction = model.DwEventAction;
    const DwEvent = model.DwEvent;

    DwEventPeriod.hasMany(DwEventAction, {
        as: 'DwEventActionDwEventPeriodFks',
        foreignKey: 'ea_period',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

    DwEventPeriod.belongsTo(DwEvent, {
        as: 'RelatedEpEvent',
        foreignKey: 'ep_event',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

};
