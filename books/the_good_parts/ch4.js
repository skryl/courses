// Function Literal
//

var add = function (a, b) {
  return a + b;
}

// Method Invocation
//

var myObject = {
  value: 0,
  increment: function (inc) {
    this.value += typeof inc === 'number' ? inc : 1;
  }
}

myObject.increment();
console.log(myObject.value)  // => 1

// Function Invocation
//

var sum = add(3,4)

// broken this binding for functions
//
myObject.double = function () {
  var that = this;

  var helper = function () {
    that.value = add(that.value, that.value);
  };
  
  helper();
}

// Constructor Invocation
//

var Quo = function (status) {
  this.status = status;
}; 

Quo.prototype.get_status = function () {
  return this.status;
}

var myQuo = new Quo("confused");
console.log(myQuo.get_status());

// Apply Invocation
//

var array = [3,4]
var sum = add.apply(null, array);

var statusObject = {
  status: 'a-ok'
};

var status = Quo.prototype.get_status.apply(statusObject);

// Arguments
//

var sum = function () {
  var i, sum = 0;
  for (i = 0; i < arguments.length; i += 1){
    sum += arguments[i];
  }
  return sum;
};

// Augmenting Core Types
//

Function.prototype.method = function (name, func) {
  this.prototype[name] = func;
  return this;
}

Number.method('integer', function () {
  return Math[this < 0 ? 'ceil' : 'floor'](this);
});

String.method('trim', function () {
  return this.replace(/^\s+|\s+$/g, '');
});

// Recursion
//

var hanoi = function hanoi(disc, src, aux, dst) {
  if (disc > 0) {
    hanoi(disc - 1, src, dst, aux);
    console.log('Move disc ' + disc + ' from ' + src + ' to ' + dst);
    hanoi(disc - 1, aux, src, dst);
  }
};

// no tail recursion :(
//
var factorial = function factorial(i, a) {
  a = a || 1;
  if (i < 2) {
    return a;
  }
  return factorial(i - 1, a * i);
}

// Closure
//

var myObject = (function () {
  var value = 0;

  return {
    increment : function (inc) {
      value += typeof inc === 'number' ? inc : 1;
    },
    getValue: function () {
      return value;
    }           
  };
}());

// currying
//

Function.method('curry', function () {
  var slice = Array.prototype.slice;
  var args = slice.apply(arguments);
  that = this;
  return function () {
    return that.apply(null, args.concat(slice.apply(arguments)));
  }
});

var add1 = add.curry(1)
console.log(add1(6))

// memoization
//

// regular fib
var fibonacci = function (n) {
  return n < 2 ? n : fibonacci(n - 1) + fibonacci(n - 2);
}

for ( var i = 0; i <= 10; i += 1 ) {
  console.log('// ' + i + ': ' + fibonacci(i));
}

// memo fib
//
var fibonacci = (function () {
  var memo = [0, 1];
  var fib = function (n) {
    var result = memo[n];
    if (typeof result !== 'number') {
      result = fib(n-1) + fib(n-2);
      memo[n] = result;
    }
    return result;
  };
  return fib;
}());


// general memo
//
var memoizer = function (memo, formula) {
  var recur = function (n) {
    var result = memo[n];
    if (typeof result !== 'number') {
      result = formula(recur, n);
      memo[n] = result
    }
    return result;
  };
  return recur;
};

// build fib
//
var fibonacci = memoizer([0,1], function (recur, n) {
  return recur(n-1) + recur(n-2);
});

// build factorial
//
var factorial = memoizer([1,1], function (recur, n) {
  return n * recur(n-1);
});
