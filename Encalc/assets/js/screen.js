.pragma library
function addCommas(nStr,tho,dec)
{
        nStr += '';
        var s = nStr.split('.');
        var s1 = s[0];
        var s2 = s.length > 1 ? dec + s[1] : '';
        var rgx = /(\d+)(\d{3})/;
        while (rgx.test(s1)) {
                s1 = s1.replace(rgx, '$1' + tho + '$2');
        }
        return s1 + s2;
}
