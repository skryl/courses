// object constructors and delegation
//
var d = new Date();
var s = new String();
var o = new Object();
var a = new Array();

var o = new Object(1);
console.log(typeof o);           // => object
console.log(o.constructor);      // => [Function: Number]
var o = new Object('a string');
console.log(typeof o);           // => object
console.log(o.constructor);      // => [Function: String]
var o = new Object(true);
console.log(typeof o);           // => object
console.log(o.constructor);      // => [Function: Boolean]
var o = new Object([1,2,3])
console.log(typeof o);           // => object
console.log(o.constructor);      // => [Function: Array]

// object literal vs constructor
//
o = new Object(1);
console.log(typeof o);  // => object (primitive wrapper)
o = 1;
console.log(typeof o);  // => number

o = new String('string');
console.log(typeof o);  // => object (primitive wrapper)
o = 'abc';
console.log(typeof o);  // => string

o = new Boolean()
console.log(typeof o);  // => object (primitive wrapper)
o = true
console.log(typeof o);  // => boolean

o = new Date()
console.log(typeof o);  // => object (primitive wrapper)
o = Date()
console.log(typeof o);  // => string

a = new Array()
console.log(typeof a)   // => object
a = [1,2,3]
console.log(typeof a)   // => object

// primitives are autoconverted to objects when needed
//
"abc".length
"monkey".slice(2,5)
(22 / 7).toPrecision(3); 


// constructor always returns an object || this
//
var Objectmaker1 = function () {
  this.name = "This is it";
  var that = {};
  that.name = "That is that"
  return that;
}

var Objectmaker2 = function () {
  this.name = "This is it";
  return 5;
}

var o = new Objectmaker1();
console.log(o.name);          // => That is that

var o = new Objectmaker2();
console.log(o.name);          // => This is it

// forgetting new skips binding of this, changes return behavior, and doesn't
// link prototype
//
function Waffle() {
  this.tastes = "yummy"
}

var w = new Waffle();
console.log(typeof w) // => object
console.log(w.tastes) // => yummy

var w = Waffle();
console.log(typeof w) // => undefined
console.log(this.tastes) // => yummy (global!)

// skipping new, prototype still unlinked
//

function Waffle() {
  var that = {};
  that.tastes = "yummy";
  return that;
}

function Waffle() {
  return {
    tastes: "yummy"
  };
}

// self invoking constructor
//

function Waffle() {
  if (!(this instanceof Waffle)) {
    return new Waffle();
  }

  this.tastes = "yummy"
}
Waffle.prototype.wantAnother = true;

var first = new Waffle(),
    second = Waffle();

console.log(first.tastes);        // => yummy
console.log(second.tastes);       // => yummy

console.log(first.wantAnother);   // => true
console.log(second.wantAnother);  // => true

// checking for Arrayness
//
if (typeof Array.isArray === 'undefined') {
  Array.isArray = function (arg) {
    return Object.prototype.toString.call(arg) === "[object Array]";
  };
}

// JSON
//
var jstr = '{"mykey": "my value"}';
ar data = JSON.parse(jstr);

var dog = {name: 'Fido', dob: new Date(), legs: [1,2,3,4]};
var jstr = JSON.stringify(dog)

// Regex
//
var re = /pattern/gmi;
var no_letters = "abc123XYZ".replace(/[a-z]/gi, "") // => 123

var dynamic_re = new RegExp("[a-z]" + "123")

// Error Objects
//
try {
  throw {
    name: "SomeError",
    message: "oops"
  };
} catch (e) {
  console.log(e.message);  // => oops
}


