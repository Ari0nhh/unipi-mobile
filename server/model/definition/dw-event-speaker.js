/* eslint new-cap: "off", global-require: "off" */

module.exports = (sequelize, DataTypes) => {
    return sequelize.define('DwEventSpeaker', {
        esId: {
            type: DataTypes.INTEGER,
            field: 'es_id',
            allowNull: false,
            primaryKey: true
        },
        esName: {
            type: DataTypes.STRING(200),
            field: 'es_name',
            allowNull: true
        },
        esPhoto: {
            type: DataTypes.INTEGER,
            field: 'es_photo',
            allowNull: false,
            references: {
                model: 'dw_images',
                key: 'img_id'
            },
            onUpdate: 'NO ACTION',
            onDelete: 'NO ACTION'
        },
        esEmpl: {
            type: DataTypes.CHAR(1),
            field: 'es_empl',
            allowNull: true
        },
        esOrg: {
            type: DataTypes.STRING(200),
            field: 'es_org',
            allowNull: true
        }
    }, {
        schema: 'public',
        tableName: 'dw_event_speaker',
        timestamps: false
    });
};

module.exports.initRelations = () => {
    delete module.exports.initRelations; // Destroy itself to prevent repeated calls.

    const model = require('../index');
    const DwEventSpeaker = model.DwEventSpeaker;
    const DwImage = model.DwImage;
    const DwEventAction = model.DwEventAction;

    DwEventSpeaker.hasMany(DwEventSpeaker, {
        as: 'SDwEventSpeakerFks',
        foreignKey: 'es_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

    DwEventSpeaker.belongsTo(DwImage, {
        as: 'RelatedEsPhoto',
        foreignKey: 'es_photo',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

    DwEventSpeaker.belongsToMany(DwEventAction, {
        as: 'DwEventSpeakerEas',
        through: DwEventSpeaker,
        foreignKey: 'es_id',
        otherKey: 'ea_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

};
