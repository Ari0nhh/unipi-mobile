/* eslint new-cap: "off", global-require: "off" */

module.exports = (sequelize, DataTypes) => {
    return sequelize.define('DwFile', {
        fId: {
            type: DataTypes.INTEGER,
            field: 'f_id',
            allowNull: false,
            primaryKey: true
        },
        fName: {
            type: DataTypes.STRING(200),
            field: 'f_name',
            allowNull: true
        },
        fData: {
            type: DataTypes.BLOB,
            field: 'f_data',
            allowNull: true
        }
    }, {
        schema: 'public',
        tableName: 'dw_files',
        timestamps: false
    });
};

module.exports.initRelations = () => {
    delete module.exports.initRelations; // Destroy itself to prevent repeated calls.

    const model = require('../index');
    const DwFile = model.DwFile;
    const DwEventActionFile = model.DwEventActionFile;
    const DwEventAction = model.DwEventAction;

    DwFile.hasMany(DwEventActionFile, {
        as: 'DwEventActionFilesDwFilesFks',
        foreignKey: 'f_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

    DwFile.belongsToMany(DwEventAction, {
        as: 'DwEventActionFileEas',
        through: DwEventActionFile,
        foreignKey: 'f_id',
        otherKey: 'ea_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

};
