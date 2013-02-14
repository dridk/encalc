// number formatting function
// copyright Stephen Chapman 24th March 2006, 22nd August 2008
// permission to use this function is granted provided
// that this copyright notice is retained intact

Number.prototype.countDecimals = function(){
    var s=this+"";
    if (s.indexOf(".")>-1)
        return s.length-s.indexOf(".")-1;
    else
        return 0;
}
Number.prototype.countNumerals = function(){
    var s=this+"";
    if (s.indexOf(".")>-1)
        return s.length-(s.length-s.indexOf(".")-1);
    else
        return 0;
}
Number.prototype.length = function(){
    var s=this+"";
        return s.length;
}

String.prototype.repeat = function( num )
{
    return new Array( num + 1 ).join( this );
}

String.prototype.fill = function(n){
    var gap = Math.floor((n-this.length)/2);
    var r = String(" ").repeat(gap)+this;
    r+=String(" ").repeat(n-r.length);
    return r;
}

function format(num,dec,thou,pnt,curr1,curr2,n1,n2) {
    var x = Math.round(num * Math.pow(10,dec));
    if (x >= 0) n1=n2='';
    var y = (''+Math.abs(x)).split('');
    var z = y.length - dec;
    if (z<0) z--;
    for(var i = z; i < 0; i++) y.unshift('0');
    if (z<0) z = 1; y.splice(z, 0, pnt);
    if(y[0] == pnt) y.unshift('0');
    while (z > 3) {
        z-=3;
        y.splice(z,0,thou);
    }
    var r = curr1+n1+y.join('')+n2+curr2;

    //r = (Number(r).countDecimals()==0)?r.replace(".", ""):r;

    if(r.length>14){
        var n = num;
        if(n<0)n*=-1;
        r = (n.toExponential(9)).toString();
    }

    return r;
}
