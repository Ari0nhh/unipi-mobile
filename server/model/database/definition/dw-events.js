/* eslint new-cap: "off", global-require: "off" */

module.exports = (sequelize, DataTypes) => {
    return sequelize.define('DwEvent', {
        evtId: {
            type: DataTypes.INTEGER,
            field: 'evt_id',
            allowNull: false,
            primaryKey: true,
            autoIncrement : true
        },
        evtName: {
            type: DataTypes.STRING(100),
            field: 'evt_name',
            allowNull: true
        },
        evtDateStart: {
            type: DataTypes.DATE,
            field: 'evt_date_start',
            allowNull: true
        },
        evtDateEnd: {
            type: DataTypes.DATE,
            field: 'evt_date_end',
            allowNull: true
        },
        evtAddress: {
            type: DataTypes.STRING(500),
            field: 'evt_address',
            allowNull: true
        },
        evtDescr: {
            type: DataTypes.TEXT,
            field: 'evt_descr',
            allowNull: true
        },
        evtInternal: {
            type: DataTypes.CHAR(1),
            field: 'evt_internal',
            allowNull: true
        },
        evtLattitude: {
            type: DataTypes.FLOAT,
            field: 'evt_lat',
            allowNull: true
        },
        evtLongitude: {
            type: DataTypes.FLOAT,
            field: 'evt_long',
            allowNull: true
        }
    }, {
        schema: 'public',
        tableName: 'dw_events',
        timestamps: false
    });
};

module.exports.initRelations = () => {
    delete module.exports.initRelations; // Destroy itself to prevent repeated calls.

    const model = require('../index');
    const DwEvent = model.DwEvent;
    const DwEventPeriod = model.DwEventPeriod;
    const DwFavEvent = model.DwFavEvent;
    const DwPartcipation = model.DwPartcipation;
    const DwUser = model.DwUser;

    DwEvent.hasMany(DwEventPeriod, {
        as: 'DwEventPeriodDwEventsFks',
        foreignKey: 'ep_event',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

    DwEvent.hasMany(DwFavEvent, {
        as: 'DwFavEventsDwEventsFks',
        foreignKey: 'evt_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

    DwEvent.hasMany(DwPartcipation, {
        as: 'DwPartcipationDwEventsFks',
        foreignKey: 'evt_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

    DwEvent.belongsToMany(DwUser, {
        as: 'DwFavEventUs',
        through: DwFavEvent,
        foreignKey: 'evt_id',
        otherKey: 'us_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

    DwEvent.belongsToMany(DwUser, {
        as: 'DwPartcipationUs',
        through: DwPartcipation,
        foreignKey: 'evt_id',
        otherKey: 'us_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

};
