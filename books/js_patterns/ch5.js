// namespacing
//
var MYAPP = MYAPP || {};

MYAPP.Parent = function () {};
MYAPP.Child = function () {};

MYAPP.some_var = 1
MYAPP.modules = {};

// dependency declaration
//
function boo() {
  var event = YAHOO.util.Event,
      dom = YAHOO.util.Dom;
  // user event and dom
}

// private members
//
function Gadget () {
  var name = 'iPod';

  this.getName = funtion () {
    return name;
  }
}

// shared privilleged functions
//
Gadget.prototype = (function () {
  var browser = "Webkit"

  return { 
    getBrowser: function () {
      return browser;
    }
  };
}());

// static methods
//
var Gadget = function () {};

Gadget.isShiny = function () {
  return 'you bet';
}

// private static members
//
var Gadget = (function () {
  var Constr = function () {}
  var my_name = "my gadget";

  Constr.printName = function () {
    return my_name;
  }

  return Constr;
})();
