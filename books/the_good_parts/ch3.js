// Object Literals
//
var stooge = {
  "first-name": "Jerome",
  "last-name":  "Howard",
  "nickname": "Curly"
}

var flight = {
  airline: "Oceanic",
  number: 815,
  departure: {
    IATA: "SYD",
    time: "2004-09-22 14:55",
    city: "Sydney"
  },
  arrival: {
    IATA: "LAX",
    time: "2004-09-23 10:42",
    city: "Los Angeles"
  }
};

// Retrieval
//
stooge["first-name"]     // => 'Jerome'
flight.departure.IATA    // => 'SYD'
flight.equipment         // => undefined
flight.equipment.model   // => throw TypeError
flight.equipment && flight.equipment.model   // => undefined

// Update
//
stooge['first-name'] = 'Bob'
flight.status = 'late'

// Prototype
//
if (typeof Object.create !== 'function') {
  Object.create = function (o) {
    var F = function () {};
    F.prototype = o;
    return new F();
  }
}

// Inherit fron another object
//
var another_stooge = Object.create(stooge);
another_stooge['first-name'] = 'Harry';
another_stooge['middle-name'] = 'Moses';
another_stooge.nickname = 'Moe';

// inheritance is dynamic
//
stooge.profession = 'actor';
another_stooge.profession

// Reflection
//
typeof flight.number        // => 'number'
typeof flight.status        // => 'string'

// inherited properties
typeof flight.toString      // => 'function'
typeof flight.constructor   // => 'function'

flight.hasOwnProperty('number')  // => true
flight.hasOwnProperty('constructor')  // => false

// Enumeration
//
var name;
for (name in another_stooge) {
  if (typeof another_stooge[name] !== 'function') {
    console.log(name + ': ' + another_stooge[name])
  }
}

// ordered enumeration
//
var i;
var properties = ['first-name', 'middle-name', 'last-name', 'profession'];
for (i = 0; i < properties.length; i+=1){
  console.log(properties[i] + ': ' + another_stooge[properties[i]])
}

// deleting properties
//
delete another_stooge.nickname;
another_stooge.nickname          // => 'Curly'
