// implied globals can be deleted
//
a = 1
var b = 2;
delete a;  // true
delete b;  // false

// getting the global object (not in ECMA5)
//
var global = (function () { return this; })

// Single var pattern

function func() {
  var a = 1,
      b = 2,
      c = 3;
  console.log(a + b + c)
}()

// variable hoisting
//
myname = 'global'
function func() {
  console.log(myname)   // => undefined
  var myname = 'local'
  console.log(myname)
}()

// parameter caching
//
myarray = [1,2,3,4,5]
for (var i = 0, max = myarray.length; i < max; i++) {
  //do stuff
}

// countdown microoptimization 
//
var i, myarray = []
for (i = myarray.length; i--;){ 
  // do stuff
}

// eval() vs new Function()
//
var jsstring = "var un = 1";
eval(jsstring);

var jsstring = "var deux = 2";
new Function(jsstring);

console.log(un);
console.log(deux); // undefined (local to function scope)

// number conversions
//
var month = "09"
parseInt(month);  // => 0 (octal)
parseInt(month, 10);  // => 9

+"09"        // => 9
+"0 abc"     // => NaN
Number("09") // => 9
Number("09 ab") // => NaN
parseInt("09 ab", 10) // => 9

// naming conventions
//
var myFunction = function (){};
var MyConstructor = function (){};
var my_variable = 1;
var MY_CONSTANT = 3.14;

