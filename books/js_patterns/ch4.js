// named and anonymous function expressions
//
var add = function add(a,b) {
  return a + b;
}
console.log(add.name);     // => add

var add = function (a,b) {
  return a + b;
}
console.log(add.name);     // => undefined


// function hoisting
//

function foo() {
  console.log("foo");
}

function bar() {
  console.log("bar");
}

function hoistMe() {
  console.log(typeof foo); // => function
  console.log(typeof bar); // => undefined

  foo();                   // => local foo
  bar();                   // => TypeError: bar is not a function

  function foo() {
    console.log("local foo");
  } 

  var bar = function () {
    console.log("local bar");
  }; 
}

// self defining functions
//
var scareMe = function () {
  console.log("Boo!");
  scareMe = function () {
    console.log("Double boo!");
  }
}

scareMe();  // => Boo!
scareMe();  // => Double boo!

// immediate functions
//
(function () {
  console.log('watch out!');
}());

// int-time branching
//
var f, window = {};
if (window.option1) {
  f = function () { console.log('option1') };
} else if (window.options2) {
  f = function () { console.log('option2') };
} else {
  f = function () { console.log('option3') };
}
f(); // => option3

// param objects
//
var newPerson = function (params) {
  console.log(params.name);
  console.log(params.age);
}

newPerson({name: "Alex", age: 25})

// call, apply
//
var alien = function (type) {
  console.log("Hello " + type)
}

alien.apply(null, ["Humans"])
alien.call(null, "Humans")
