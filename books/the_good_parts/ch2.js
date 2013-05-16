//comment

/* 
  block comment
*/

// All numbers are floats
//
100 === 100.0    // => true
1/2              // => 0.5
Math.floor(1.2)  // => 1
Math.ceil(1.2)   // => 2

// NaN
//
isNaN(10)       // => false
isNaN(1/'a')    // => true
isNaN(Infinity) // => false

// Infinity
//
Infinity
1/0             // => Infinity
1.8e309         // => Infinity 

// Strings
//
"Abc" + "def"
'lmnop'
'c' + 'a' + 't' === 'cat'  // => true
'cat'.toUpperCase() === 'CAT'

// Falsyness
//
false
null
undefined
''
0
NaN

// if statement
//
if(true) {
  console.log('true');
} else {
  console.log('false');
}

// switch statement
//
switch(3) {
  case 1:
    console.log('1');
    break;
  case 2:
    console.log('2');
    break;
  default:
    console.log('default');
}

// switch statement
//
switch(3) {
  case 1:
    console.log('1');
    break;
  case 2:
    console.log('2');
    break;
  default:
    console.log('default');
}

// while statement
//
var i = 0
while(i < 10) {
  console.log(i);
  i++;
}

// do-while statement
//
var i = 0
do {
  console.log(i);
  i++;
} while(i<0)

// for statement
//
for(var i=0;i<10;i++) {
  console.log(i);
  break;
}

// for-in statement
//
obj = {a: 1, b: 2, c: 3};

for (p in obj) {
  console.log(p);
  console.log(obj[p]);
}

// try statement
//
try {
  throw 'abc'
} catch(e) {
  console.log(e);
}

// return and undefined
//
a = function () { return 3; }();   // => 3
b = function () {}();              // => undefined

// prefix ops
//
+'3'    // => 3
-4      // => -4
!false  // => true
typeof false // => 'boolean'

// object literals
//
o = {a: 1, b: 2, c: function () {return 3;} }
o.a            // => 1
o['b']         // => 2
o.c()          // => 3

// array literal
//
[1,2,3]

// regexp literal
//
/a.b*/

// function literal
//
b = function blah () { console.log( 'blah' )}
b();
