.pragma library
String.prototype.chunk = function(n) {
if (typeof n=='undefined') n=2;
return this.match(RegExp('.{1,'+n+'}[^0-9]','g'));
};
function addNewLines(txt){
    var s = txt.chunk(20);
    var t="";
    for(var i=0;i<s.length-1;i++){
        t+=s[i]+"\n"
    }t+=s[s.length-1];
    t+=txt.substr(t.length,txt.length);
    return t;
}

function getAction(nStr){
    nStr+="";
    var s = nStr.split('=');
    if(s.length<2)return "";    
    //Formating negative numbers
    var rgx = /([^0-9]-\d+)/;
    s[0] = s[0].replace(rgx,"$1)");
        rgx = /(-\d+\))/;
        s[0] = s[0].replace(rgx,"($1");
    //Formating powers
    rgx = /pw(\d+)/
    s[0] = s[0].replace(rgx,"<sup>$1</sup>");
    //end formating
    return addNewLines(s[0])+"=";
}

function getAnswer(nStr){
    nStr+="";    
    var s = nStr.split('=');
    if(s.length<2)return "";
    var t = s[1];
    //Check if too long
    if(t.length>13){//Try 1
        t*=1;//Convert to a number
        t+="";//Back to string
    }
    if(t.length>13){//Try 2
        var n = new Number(t);//Convert to exponential format
        console.log("to exp");
        t=""+n.toExponential(4);//Back to string
    }
    return t;
}
