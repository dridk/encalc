 Qt.include("mathcontext.js")
 Qt.include("bigdecimal.js")

var state = { //Output refresh states
    display:    true, //enable if screen needs refreshing
    print:      false  //enable if printer needs refreshing
};

var options = { //App options
    saveSessionOnClose: true, //Should app save current session on app close
    restoreSessionOnOpen: true, //Should app restore last saved session on open
    saveMemoryInHistory: true, //Should the memory state be undoable
    decimalPlaces: -1, //how many decimal places do we want after the decimal point? -1 = as many as necessary
    taxRate: 0 //tax rate for +TAX calculation
}

var sessionHistory = new Array();

/*
*   Generic connector funcrtion to the calclulator script
*
*/


function process(obj){ //Process the input from user
    doOperation(obj);
    return; //returns nothing
}

/*
*   Generic getters and setters
*
*/

function getOption(option){
    return options[option];
}

function setOption(key,val){
    options[key]=val;
}

function getOptions(){
    return options;
}

function setOptions(o){
    options = o;
}

function getSessions(){
    return sessionHistory;
}

function getSessionsLingth(){
    return sessionHistory.length;
}

function setSessions(s){
    sessionHistory = s;
}

function getSate(){ //Get current number for the display/print
    return (displayText); //returns string
}

function getMemory(){ //Get current memory state
    return (memory); //returns string
}

function getOperator(){ //Get current opration
    return (displayCurrentOperation); //returns string
}

function getBrakets(){ //Show braket status
    return (false); //returns true/false
}

function getErros(){ //If there were any errors - display them
    return (displayError); //returns true/false
}

function getDecimals(){ //How many decimal places after the point
    return (options.decimalPlaces); //returns number of decimal places, or -1 if any
}

function setDecimals(d){ //How many decimal places after the point
    options.decimalPlaces=d; //returns number of decimal places, or -1 if any
}

function getTaxRate(){ //How many decimal places after the point
    return (options.taxRate); //returns number of decimal places, or -1 if any
}

function setTaxRate(d){ //How many decimal places after the point
    options.taxRate=d.replace(/[^\d.]/g, ""); //returns number of decimal places, or -1 if any
}


/*
*   Printer functions
*   Compile and format printer output
*/

var printLine = 0;

function getPrintState(){ //What are we sending to the printer output
    var o = printerText;
    state.print = false; //Disable printe refresh
    printerText = new Array(); //Clear the printer memory
    printLine = 0;
    return (o); //returns string
}

function printNewLine(){
    state.print = true; //Enable printer refresh
    printerText.push({
                         print: "",
                         margin: ""
                     });
    printLine = printerText.length-1;
}

function printOn(t){
    state.print = true; //Enable printer refresh
    printerText[printLine].print = t;
}

function printOnMargin(t){
    state.print = true; //Enable printer refresh
    printerText[printLine].margin = t;
}

/*
*   History functions
*   Undo(), Redo(), historyRestoreAt(p[position in history]), historyDo()
*/

var history = new Array();
var historyPosition = 0;

function isUndo(){
    return (historyPosition>0)?false:true;
}

function isRedo(){
    return (historyPosition<history.length-1)?false:true;
}

function undo(){ //go back in history
    if(historyPosition==history.length)historyPosition--;
    if((historyPosition--)>0){
        console.log("undo");
        historyRestoreAt(historyPosition);
    }else{
        console.log("nothing to undo")
        historyPosition=0;
    }
}

function redo(){ //go forward in hostory
    if((historyPosition++)<history.length){
        console.log("redo")
        historyRestoreAt(historyPosition);
    }else{
        console.log("nothing to redo")
        historyPosition=history.length-1;
    }
}

function historyRestoreAt(p){ //goto position p in history
    if(p==history.length||p==-1)return;
        console.log("Going in history to position "+p);
        var obj = history[p];
        displayText =           obj.v0;
        curVal=                 obj.v1;
        lastOp=                 obj.v2;
        memory=                 (options.saveMemoryInHistory&&obj.v3)?obj.v3:memory;
        displayCurrentOperation=obj.v4;
        displayError=           obj.v5;
}

function historyDo(){ //add new history event
    if((history.length-1)>historyPosition){
         //see if we undone some of the history, then remove the preciding array elements
        history.splice(historyPosition,((history.length-1)-historyPosition))
    }
    history.push({
                     v0:displayText,
                     v1:curVal,
                     v2:lastOp,
                     v3:(options.saveMemoryInHistory)?memory:false,
                     v4:displayCurrentOperation,
                     v5:displayError/*,
                     v6:taxRate,
                     v7:printerText*/
                 })
    historyPosition++;
}

function getCurrentSession(){
    var l = history.length;
    if(l>0){
        var c=0;
        var obj;
        var r="[";
        for(var i = 0;i<l;i++){
            obj = history[i];
            r+=(i==0)?"{":",{";
            c = 0;
            for(var key in obj){
                r+=(c==0)?"":", ";
                r+=String(key)+": '"+String(obj[key])+"'";
                c++;
            }
            r+="}"
        }
        r+="]";
        return r;
    }else{
        return "";
    }
}

function restroreLastSession(){
    if(sessionHistory.length>0){
        history = eval(sessionHistory[sessionHistory.length-1]);
        historyPosition=history.length-1;
        historyRestoreAt(historyPosition);
        return true;
    }
    return false;
}

/*
*   Mathmatical functions and calculator
*
*/


function getDate(){
    var now = new Date();
    return ((now.getMonth()+1) + "/" + now.getDate() + "/" + now.getFullYear())
}

var displayText = "0"
var printerText = new Array();
var displayCurrentOperation = ""
var displayError = false

var curVal = 0
var memory = 0
var lastOp = ""

historyDo();


function disabled(op) {    
    if (op == "." && displayText.toString().search(/\./) != -1) {
        displayError = true;
        return true
    } else if (op == "st" &&  displayText.toString().search(/-/) != -1) {
        displayError = true;
        return true
    } else if (op == "1x" &&  displayText*1 == 0) {
        displayError = true;
        return true
    } else {
        displayError = false;
        return false
    }
}

function doOperation(op) {
    //Scan for logical erros
    if (disabled(op)) {
        return
    }

    //Process numbers
    if (op.toString().length==1 && ((op >= "0" && op <= "9") || op==".") ) {
        //        if (displayText.toString().length >= 14)
        //            return; // No arbitrary length numbers
        if (lastOp.toString().length == 1 && ((lastOp >= "0" && lastOp <= "9") || lastOp == ".") ) {
            displayText = displayText + op.toString()
        } else {
            displayText = op
        }
        lastOp = op
        return
    }
    lastOp = op

    //Process clearing operations
    if (op == "Off") {
           Qt.quit();
       } else if (op == "cl") {
           displayText = "0"
        return;
       } else if (op == "ac") {
           curVal = 0
           memory = 0
           lastOp = ""
           displayCurrentOperation = ""
           displayText ="0"
           printNewLine();printOn("----"+getDate()+"----");printOnMargin("AC");
        return;
       } else if (op == "mc") {
        if(memory==0)return;
            printNewLine();printOn(" ");printOnMargin("MC");
        memory = 0;
        return;
    }


    //Process two item operations
    if (displayCurrentOperation == "+") {
            printNewLine();printOn(curVal);printOnMargin("+");
            printNewLine();printOn(displayText);
        var varA = new BigDecimal(curVal);
        var varB = new BigDecimal(displayText);
        displayText = varA.add(varB).toString();//displayText*1 + curVal*1;
            printNewLine();printOn(displayText);printOnMargin("=");
    } else if (displayCurrentOperation == "-") {
            printNewLine();printOn(curVal);printOnMargin("-");
            printNewLine();printOn(displayText);
        var varA = new BigDecimal(curVal);
        var varB = new BigDecimal(displayText);
        displayText = varA.subtract(varB).toString();//curVal.valueOf() - displayText.valueOf();
            printNewLine();printOn(displayText);printOnMargin("=");
    } else if (displayCurrentOperation == "×") {
        if(op== "%"){
                printNewLine();printOn(curVal);printOnMargin("×");
                printNewLine();printOn(displayText);printOnMargin("%");
            var varA = new BigDecimal(curVal);
            var varB = new BigDecimal(displayText);
            displayText = varA.multiply(varB.multiply(new BigDecimal('0.01'))).toString(); //(curVal*1)*(displayText*1)/100
                printNewLine();printOn(displayText);printOnMargin("=");
            curVal = 0
            displayCurrentOperation = ""
            return
        }else{
                printNewLine();printOn(curVal);printOnMargin("×");
                printNewLine();printOn(displayText);
            var varA = new BigDecimal(curVal);
            var varB = new BigDecimal(displayText);
            displayText = varA.multiply(varB).toString();//(curVal*1)*(displayText*1);
                printNewLine();printOn(displayText);printOnMargin("=");
        }
    } else if (displayCurrentOperation == "÷") {
            printNewLine();printOn(curVal);printOnMargin("÷");
            printNewLine();printOn(displayText);
        var varA = new BigDecimal(curVal);
        var varB = new BigDecimal(displayText);
        displayText = varA.divide(varB, 12, 0).toString();//(curVal*1)/(displayText*1);
            printNewLine();printOn(displayText);printOnMargin("=");
    } else if (displayCurrentOperation == "pw") {
            printNewLine();printOn(curVal);printOnMargin("PW");
            printNewLine();printOn(displayText);
        var varA = new BigDecimal(curVal);
        var varB = new BigDecimal(displayText);
        displayText = varA.pow(varB).toString();
            printNewLine();printOn(displayText);printOnMargin("=");
    } else if (displayCurrentOperation == "=") {
    }


    if (op == "+" || op == "-" || op == "×" || op == "÷" || op == "pw") {
        displayCurrentOperation = op
        curVal = displayText.valueOf()
        return
    }

    //Process single item operations
    if (op != "mr"){
        curVal = 0
        displayCurrentOperation = ""
    }

    if (op == "1x") {
            printNewLine();printOn(displayText);printOnMargin("1/x");
        var varB = new BigDecimal(displayText);
        displayText = new BigDecimal('1').divide(varB, 12, 0).toString();//1/(displayText*1);
            printNewLine();printOn(displayText);printOnMargin("=");
    } else if (op == "s2") {
        printNewLine();printOn(displayText);printOnMargin("x^2");
    var varB = new BigDecimal(displayText);
    displayText = varB.pow(new BigDecimal('2')).toString();//(displayText*1)*(displayText*1);
        printNewLine();printOn(displayText);printOnMargin("=");
    } else if (op == "ex") {
            printNewLine();printOn(displayText);printOnMargin("Ex");
        displayText = Math.exp(displayText*1);
            printNewLine();printOn(displayText);printOnMargin("=");
    } else if (op == "%") {
            printNewLine();printOn(displayText);printOnMargin("%");
        var varB = new BigDecimal(displayText);
        displayText = varB.multiply(new BigDecimal('0.01')).toString();//(displayText*1)/100;
            printNewLine();printOn(displayText);printOnMargin("=");
    } else if (op == "tx") {
        var varB = new BigDecimal(displayText);
        var tax = new BigDecimal(getTaxRate()+"");
        var tmp = varB.multiply(tax.multiply(new BigDecimal('0.01')));//1*displayText*(taxRate/100);
            printNewLine();printOn(displayText);printOnMargin("+");
            printNewLine();printOn(tmp.toString());printOnMargin("TAX");
        displayText = varB.add(tmp).format(-1,2);//(displayText*1)+tmp;
            printNewLine();printOn(displayText);printOnMargin("=");
    } else if (op == "+-") {
        var varB = new BigDecimal(displayText);
        displayText = varB.negate().toString();//(displayText*-1);
    } else if (op == "st") {
            printNewLine();printOn(displayText);printOnMargin("√");
        displayText = Math.sqrt(displayText*1);
            printNewLine();printOn(displayText);printOnMargin("=");
    } else if (op == "m+") {
        if(1*displayText.valueOf()!=0){
            if(memory!=0){printNewLine();printOn(memory);printOnMargin("M+");}
            printNewLine();printOn(displayText);printOnMargin(">M");
        memory += 1*displayText.valueOf()
            printNewLine();printOn(memory);printOnMargin("MR");
        }
    } else if (op == "mr") {
        displayText = memory.toString()
    } else if (op == "m-") {
        if(1*displayText.valueOf()!=0){
            if(memory!=0){printNewLine();printOn(memory);printOnMargin("M-");}
            printNewLine();printOn(displayText);printOnMargin(">M");
        memory -= 1*displayText.valueOf()
            printNewLine();printOn(memory);printOnMargin("MR");
        }
    } else if (op == "back") {
        displayText = displayText.toString().slice(0, -1)
        if (displayText.length == 0) {
            displayText = "0"
        }
    }
}

