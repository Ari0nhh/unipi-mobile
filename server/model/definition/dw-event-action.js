/* eslint new-cap: "off", global-require: "off" */

module.exports = (sequelize, DataTypes) => {
    return sequelize.define('DwEventAction', {
        eaId: {
            type: DataTypes.INTEGER,
            field: 'ea_id',
            allowNull: false,
            primaryKey: true
        },
        eaPeriod: {
            type: DataTypes.INTEGER,
            field: 'ea_period',
            allowNull: false,
            references: {
                model: 'dw_event_period',
                key: 'ep_id'
            },
            onUpdate: 'NO ACTION',
            onDelete: 'NO ACTION'
        },
        eaName: {
            type: DataTypes.STRING(200),
            field: 'ea_name',
            allowNull: true
        },
        eaDesc: {
            type: DataTypes.TEXT,
            field: 'ea_desc',
            allowNull: true
        },
        eaStart: {
            type: DataTypes.DATE,
            field: 'ea_start',
            allowNull: true
        },
        eaEnd: {
            type: DataTypes.DATE,
            field: 'ea_end',
            allowNull: true
        },
        eaLocation: {
            type: DataTypes.STRING(500),
            field: 'ea_location',
            allowNull: true
        }
    }, {
        schema: 'public',
        tableName: 'dw_event_action',
        timestamps: false
    });
};

module.exports.initRelations = () => {
    delete module.exports.initRelations; // Destroy itself to prevent repeated calls.

    const model = require('../index');
    const DwEventAction = model.DwEventAction;
    const DwEventActionFile = model.DwEventActionFile;
    const DwEventActionVideo = model.DwEventActionVideo;
    const DwEventSpeaker = model.DwEventSpeaker;
    const DwEventPeriod = model.DwEventPeriod;
    const DwFile = model.DwFile;
    const DwVideo = model.DwVideo;

    DwEventAction.hasMany(DwEventActionFile, {
        as: 'FilesDwEventActionFks',
        foreignKey: 'ea_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

    DwEventAction.hasMany(DwEventActionVideo, {
        as: 'VideoDwEventActionFks',
        foreignKey: 'ea_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

    DwEventAction.belongsTo(DwEventPeriod, {
        as: 'RelatedEaPeriod',
        foreignKey: 'ea_period',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

    DwEventAction.belongsToMany(DwFile, {
        as: 'DwEventActionFileFs',
        through: DwEventActionFile,
        foreignKey: 'ea_id',
        otherKey: 'f_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

    DwEventAction.belongsToMany(DwVideo, {
        as: 'DwEventActionVideoVs',
        through: DwEventActionVideo,
        foreignKey: 'ea_id',
        otherKey: 'v_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

    DwEventAction.belongsToMany(DwEventSpeaker, {
        as: 'DwEventSpeakerEs',
        through: DwEventSpeaker,
        foreignKey: 'ea_id',
        otherKey: 'es_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

};
