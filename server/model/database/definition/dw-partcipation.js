/* eslint new-cap: "off", global-require: "off" */

module.exports = (sequelize, DataTypes) => {
    return sequelize.define('DwPartcipation', {
        evtId: {
            type: DataTypes.INTEGER,
            field: 'evt_id',
            allowNull: false,
            references: {
                model: 'dw_events',
                key: 'evt_id'
            },
            onUpdate: 'NO ACTION',
            onDelete: 'NO ACTION'
        },
        usId: {
            type: DataTypes.INTEGER,
            field: 'us_id',
            allowNull: false,
            references: {
                model: 'dw_user',
                key: 'us_id'
            },
            onUpdate: 'NO ACTION',
            onDelete: 'NO ACTION'
        },
        evtReg: {
            type: DataTypes.CHAR(1),
            field: 'evt_reg',
            allowNull: true
        }
    }, {
        schema: 'public',
        tableName: 'dw_partcipation',
        timestamps: false
    });
};

module.exports.initRelations = () => {
    delete module.exports.initRelations; // Destroy itself to prevent repeated calls.

    const model = require('../index');
    const DwPartcipation = model.DwPartcipation;
    const DwEvent = model.DwEvent;
    const DwUser = model.DwUser;

    DwPartcipation.belongsTo(DwEvent, {
        as: 'Evt',
        foreignKey: 'evt_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

    DwPartcipation.belongsTo(DwUser, {
        as: 'U',
        foreignKey: 'us_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

};
