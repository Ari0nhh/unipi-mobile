/* eslint new-cap: "off", global-require: "off" */

module.exports = (sequelize, DataTypes) => {
    return sequelize.define('DwEventActionFile', {
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
        fId: {
            type: DataTypes.INTEGER,
            field: 'f_id',
            allowNull: false,
            references: {
                model: 'dw_files',
                key: 'f_id'
            },
            onUpdate: 'NO ACTION',
            onDelete: 'NO ACTION'
        }
    }, {
        schema: 'public',
        tableName: 'dw_event_action_files',
        timestamps: false
    });
};

module.exports.initRelations = () => {
    delete module.exports.initRelations; // Destroy itself to prevent repeated calls.

    const model = require('../index');
    const DwEventActionFile = model.DwEventActionFile;
    const DwEventAction = model.DwEventAction;
    const DwFile = model.DwFile;

    DwEventActionFile.belongsTo(DwEventAction, {
        as: 'Ea',
        foreignKey: 'ea_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

    DwEventActionFile.belongsTo(DwFile, {
        as: 'F',
        foreignKey: 'f_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

};
