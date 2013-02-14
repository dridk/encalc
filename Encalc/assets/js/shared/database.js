var dbID = "EncalcStorageDB";
var dbVersion = "1.0";
var dbDescription = "History storage for Encalc - desktop calculator.";
var dbSize = 1000000;
var db=Object();

var optionsTable = "Options";
var sessionsTable = "Sessions";

var currentSessionID = -1;

function init() {
    try {
        db = openDatabaseSync(
                    dbID,           //identifier
                    dbVersion,      //version
                    dbDescription,  //description
                    dbSize          //estimated_size
                    //callback(db)
                    );
    }catch(err){
        console.log(err);
    }

     //Create tables if not there
    try {
        db.transaction(function(tx){
                           // Create the database if it doesn't already exist
                           var query = "CREATE TABLE IF NOT EXISTS `"+optionsTable+"` (`ID` INTEGER PRIMARY KEY AUTOINCREMENT, `key` VARCHAR(24), `value` VARCHAR(24));";
                           try{
                               tx.executeSql(query);
                           }catch(err){
                               console.log(err);
                               console.log(query);
                           }

                           query = "CREATE TABLE IF NOT EXISTS "+sessionsTable+" (ID INTEGER PRIMARY KEY AUTOINCREMENT, date DATE, tag VARCHAR(24), data TEXT)";
                           try{
                               tx.executeSql(query);
                           }catch(err){
                               console.log(err);
                               console.log(query);
                           }
                       });
    }catch(err){
        console.log(err);
    }
}

function isFirstRun(){

    return;
}

function getSessionList(){
    var sessionList = new Array();
    db.transaction( //Create tables if not there
                   function(tx) {
                       var query ="SELECT * FROM "+sessionsTable;
                       var rs;
                       try{
                           rs = tx.executeSql(query);
                       }catch(err){
                           console.log(err);
                           console.log(query);
                       }
                       if(rs.rows.length>0){
                           for(var i = 0; i < rs.rows.length; i++) {
                               sessionList.push({
                                            id: rs.rows.item(i).ID,
                                            date: rs.rows.item(i).date,
                                            tag: rs.rows.item(i).tag,
                                            data: rs.rows.item(i).data
                                           });
                           }
                           currentSessionID=sessionList[sessionList.length-1].id;
                       }else{
                           currentSessionID=0;
                       }
                   });
    return sessionList;
}

function saveSession(tag,data){
    if(data.length>0)
    {
        db.transaction(
                    function(tx) {
                        var query = "INSERT INTO "+sessionsTable+" (date, tag, data) VALUES(?, ?, ?)";
                        try{
                            tx.executeSql(query,[ new Date() , tag, data ]);
                        }catch(err){
                            console.log(err);
                            console.log(query);
                        }
                    });
    }
}

function updateSession(tag,data){
    if(data.length>0)
    {
        db.transaction(
                    function(tx) {
                        var query = "UPDATE "+sessionsTable+" SET `date`=? , `tag`=?, `data`=? WHERE `ID`=?";
                        try{
                            tx.executeSql(query,[ new Date() , tag, data, currentSessionID]);
                        }catch(err){
                            console.log(err);
                            console.log(query);
                        }
                    });
    }
}

/*
*   App Options Saving and loading
*/

function makeOptions(options){
    db.transaction(
                   function(tx) {
                    var query;
                    for(var key in options){
                        query = "INSERT INTO "+optionsTable+"(`key`,`value`) VALUES (?, ?)";
                        try{
                            tx.executeSql(query,[key, options[key]]);
                        }catch(err){
                            console.log(err);
                            console.log(query);
                        }
                    }
                   });
}

function updateOptions(options){
    db.transaction(
                   function(tx) {
                    var query;
                    for(var key in options){
                        query = "UPDATE "+optionsTable+" SET `value`=? WHERE `key`=?";
                        try{
                            tx.executeSql(query,[options[key], key]);
                        }catch(err){
                            console.log(err);
                            console.log(query);
                        }
                    }
                   });
}

function restoreOptions(){
    var options = {};
    db.transaction(
                   function(tx) {
                    var query="SELECT * FROM "+optionsTable;
                    try{
                        var rs = tx.executeSql(query);
                        for(var i = 0; i < rs.rows.length; i++) {
                            options[rs.rows.item(i).key] = rs.rows.item(i).value;
                        }
                    }catch(err){
                        console.log(err);
                        console.log(query);
                    }
                   });
    return options;
}

function deinint(){
    try{
        db.close();
    }catch(err){
        console.log(err);
    }
}

/*
*  Just in case stuff
*/

function emptyTables(){
    db.transaction(
                   function(tx) {
                    try{
                        tx.executeSql("DELETE FROM "+optionsTable);
                        tx.executeSql("DELETE FROM "+sessionsTable);
                        tx.executeSql("VACUUM;");
                    }catch(err){
                        console.log(err);
                    }
                   });
}
