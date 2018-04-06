/* eslint new-cap: "off", global-require: "off" */

module.exports = (sequelize, DataTypes) => {
    return sequelize.define('DwImage', {
        imgId: {
            type: DataTypes.INTEGER,
            field: 'img_id',
            allowNull: false,
            primaryKey: true
        },
        imgData: {
            type: DataTypes.BLOB,
            field: 'img_data',
            allowNull: true
        },
        imgKind: {
            type: DataTypes.STRING(50),
            field: 'img_kind',
            allowNull: true,
            comment: 'Тип изображения, например image/png'
        }
    }, {
        schema: 'public',
        tableName: 'dw_images',
        timestamps: false
    });
};

module.exports.initRelations = () => {
    delete module.exports.initRelations; // Destroy itself to prevent repeated calls.

    const model = require('../index');
    const DwImage = model.DwImage;
    const DwEventSpeaker = model.DwEventSpeaker;
    const DwUser = model.DwUser;

    DwImage.hasMany(DwEventSpeaker, {
        as: 'DwEventSpeakerDwImagesFks',
        foreignKey: 'es_photo',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

    DwImage.hasMany(DwUser, {
        as: 'DwUserDwImagesFks',
        foreignKey: 'us_photo',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

};
