/* eslint new-cap: "off", global-require: "off" */

module.exports = (sequelize, DataTypes) => {
    return sequelize.define('DwFavUser', {
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
        favUsId: {
            type: DataTypes.INTEGER,
            field: 'fav_us_id',
            allowNull: false,
            references: {
                model: 'dw_user',
                key: 'us_id'
            },
            onUpdate: 'NO ACTION',
            onDelete: 'NO ACTION'
        }
    }, {
        schema: 'public',
        tableName: 'dw_fav_users',
        timestamps: false
    });
};

module.exports.initRelations = () => {
    delete module.exports.initRelations; // Destroy itself to prevent repeated calls.

    const model = require('../index');
    const DwFavUser = model.DwFavUser;
    const DwUser = model.DwUser;

    DwFavUser.belongsTo(DwUser, {
        as: 'U',
        foreignKey: 'us_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

    DwFavUser.belongsTo(DwUser, {
        as: 'FavU',
        foreignKey: 'fav_us_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

};
