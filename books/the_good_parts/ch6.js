// Array Literals
//
var empty = [];
var numbers = [ 'zero', 'one', 'two', 'three' ];

empty[1]     // => undefined
numbers[1]   // => 'one'

empty.length   // => 0
numbers.length // => 4

var numbers_object = {
  '0': 'zero', '1': 'one', '2': 'two', '3': 'three'
}

numbers_object[1]       // => 'one'
numbers_object.slice()  // => TypeError
numbers_object.length   // => undefined

// Length
//
var myArray = [];
myArray.length             // => 0
myArray[100] = true;
myArray.length             // => 101
myArray.length = 10
myArray.push(5)            // => 11

// Delete
//
delete numbers[1];         // => true
numbers                    // => ['zero', undefined, 'two', 'three']
numbers.splice(1,1)        // => ['zero', 'two', 'three']

// Enumeration
//
for (i = 0; i < numbers.length; i++) {
  console.log(numbers[i])
}

// TypeOf
//

typeof numbers // => 'object' WTF?

// better
var is_array = function (value) {
  return value && typeof value === 'object' && value.constructor === Array;
}

//best
var is_array = function (value) {
  return Object.prototype.toString.apply(value) === '[object Array]'
}

// Methods
//
Array.method('reduce', function (f, value) {
  var i;
  for (i = 0; i < this.length; i += 1) {
    value = f(this[i], value);
  }
  return value;
});

var add = function (a,b) { return a + b; }

// modify array instance
//
var data = [1,2,3,4,5]

data.total = function () {
  return this.reduce(add, 0);
}


