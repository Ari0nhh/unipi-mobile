/* eslint new-cap: "off", global-require: "off" */

module.exports = (sequelize, DataTypes) => {
    return sequelize.define('DwVideo', {
        vId: {
            type: DataTypes.INTEGER,
            field: 'v_id',
            allowNull: false,
            primaryKey: true
        },
        vName: {
            type: DataTypes.STRING(200),
            field: 'v_name',
            allowNull: true
        },
        vData: {
            type: DataTypes.BLOB,
            field: 'v_data',
            allowNull: true
        }
    }, {
        schema: 'public',
        tableName: 'dw_video',
        timestamps: false
    });
};

module.exports.initRelations = () => {
    delete module.exports.initRelations; // Destroy itself to prevent repeated calls.

    const model = require('../index');
    const DwVideo = model.DwVideo;
    const DwEventActionVideo = model.DwEventActionVideo;
    const DwEventAction = model.DwEventAction;

    DwVideo.hasMany(DwEventActionVideo, {
        as: 'DwEventActionVideoDwVideoFks',
        foreignKey: 'v_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

    DwVideo.belongsToMany(DwEventAction, {
        as: 'DwEventActionVideoEas',
        through: DwEventActionVideo,
        foreignKey: 'v_id',
        otherKey: 'ea_id',
        onDelete: 'NO ACTION',
        onUpdate: 'NO ACTION'
    });

};
