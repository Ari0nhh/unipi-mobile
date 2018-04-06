/* eslint new-cap: "off", global-require: "off" */

module.exports = (sequelize, DataTypes) => {
    return sequelize.define('DwUser', {
        usId: {
            type: DataTypes.INTEGER,
            field: 'us_id',
            allowNull: false,
            primaryKey: true
        },
        usName: {
            type: DataTypes.STRING(200),
            field: 'us_name',
            allowNull: true
        },
        usEmpl: {
            type: DataTypes.CHAR(1),
            field: 'us_empl',
            allowNull: true
        },
        usEmail: {
            type: DataTypes.STRING(200),
            field: 'us_email',
            allowNull: true
        },
        usPhone: {
            type: DataTypes.STRING(200),
            field: 'us_phone',
            allowNull: true
        },
        usOrg: {
            type: DataTypes.STRING(200),
            field: 'us_org',
            allowNull: true
        },
        usShow: {
            type: DataTypes.INTEGER,
            field: 'us_show',
            allowNull: true
        },
        usPhoto: {
            type: DataTypes.INTEGER,
            field: 'us_photo',
            allowNull: false,
            references: {
                model: 'dw_images',
                key: 'img_id'
            },
            onUpdate: 'NO ACTION',
            onDelete: 'NO ACTION'
        },
        usPassw: {
            type: DataTypes.STRING(100),
            field: 'us_passw',
            allowNull: true
        },
        usSalt: {
            type: DataTypes.STRING(100),
            field: 'us_salt',
            allowNull: true
        }
    }, {
        schema: 'public',
        tableName: 'dw_user',
        timestamps: false
    });
};

module.exports.initRelations = () => {
    delete module.exports.initRelations; // Destroy itself to prevent repeated calls.

    const model = require('../index');
    const DwUser = model.DwUser;
    const DwFavEvent = model.DwFavEvent;
    const DwFavUser = model.DwFavUser;
    const DwPartcipation = model.DwPartcipation;
    const DwImage = model.DwImage;
    const DwEvent = model.DwEvent;

    DwUser.hasMany(DwFavEvent, {
        as: 'DwFavEventsDwUserFks',
        foreignKey: 'us_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

    DwUser.hasMany(DwFavUser, {
        as: 'DwFavUsersDwUserFks',
        foreignKey: 'us_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

    DwUser.hasMany(DwFavUser, {
        as: 'DwFavUsersDwUserFkv2s',
        foreignKey: 'fav_us_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

    DwUser.hasMany(DwPartcipation, {
        as: 'DwPartcipationDwUserFks',
        foreignKey: 'us_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

    DwUser.belongsTo(DwImage, {
        as: 'RelatedUsPhoto',
        foreignKey: 'us_photo',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

    DwUser.belongsToMany(DwEvent, {
        as: 'DwFavEventEvts',
        through: DwFavEvent,
        foreignKey: 'us_id',
        otherKey: 'evt_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

    DwUser.belongsToMany(DwUser, {
        as: 'DwFavUserFavUs',
        through: DwFavUser,
        foreignKey: 'us_id',
        otherKey: 'fav_us_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

    DwUser.belongsToMany(DwUser, {
        as: 'DwFavUserUs',
        through: DwFavUser,
        foreignKey: 'fav_us_id',
        otherKey: 'us_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

    DwUser.belongsToMany(DwEvent, {
        as: 'DwPartcipationEvts',
        through: DwPartcipation,
        foreignKey: 'us_id',
        otherKey: 'evt_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

};
