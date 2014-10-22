.pragma library

.import QtQuick.LocalStorage 2.0 as LS

var db_inst = null;

// Partly taken from weechatrelay/qml/js/storage.js
// © Mikko Ahlroth 2014

function connect() {
    // Connect if not already connected, otherwise just return instance
    if (db_inst === null) {
        db_inst = LS.LocalStorage.openDatabaseSync("screen-message", "1.0", "StorageDatabase", 10240);

        db_inst.transaction(function(tx) {
            tx.executeSql("CREATE TABLE IF NOT EXISTS settings \
                            (key TEXT PRIMARY KEY, value TEXT);");
        });
    }

    return db_inst;
}

function readSetting(key, defVal) {
    var setting = null;
    var db=connect();

    db.readTransaction(function(tx) {
        var rows = tx.executeSql("SELECT value AS val FROM settings WHERE key=?;", [key]);

        if (rows.rows.length !== 1) {
            setting = null;
        }
        else {
            setting = rows.rows.item(0).val;
        }
    });

    if (setting === 'true') {
        setting = true;
    }
    else if (setting === 'false') {
        setting = false;
    }
    // If setting has never been read (doesn't exist), use default value
    else if (setting === null) {
        setting = defVal;
    }

    return setting;
}

function storeSetting(key, value) {
    var db=connect();

    if (value === true) {
        value = 'true';
    }
    else if (value === false) {
        value = 'false';
    }

    db.transaction(function(tx) {
        tx.executeSql("INSERT OR REPLACE INTO settings VALUES (?, ?);", [key, value]);
        tx.executeSql("COMMIT;");
    });
}
