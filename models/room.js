/**
 * Created with JetBrains WebStorm.
 * User: ias
 * Date: 6/7/12
 * Time: 7:01 PM
 * To change this template use File | Settings | File Templates.
 */
var Room = module.exports = {
    rooms: []
    , getAll: function() {
        return this.rooms.map(function(element) {
            return element.name;
        });
    }
}