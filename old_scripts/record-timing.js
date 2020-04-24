var times = [];

// add an object with keycode and timestamp
$(document).keyup(function(evt) {
    times.push({"timestamp":evt.timeStamp,
                "keycode":evt.which})
});

// call this to get the string
function reportTimes() {
    var reportString = "";
    for(var i = 0; i < times.length - 1; ++i) {
         reportString += (i+1) + ": " + (times[i+1].timestamp - times[i].timestamp) + " ";
    }
    return reportString; // add this somewhere or alert it
}