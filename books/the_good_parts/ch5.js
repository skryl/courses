// augmenting prototype
//
var Mammal = function (name) {
  this.name = name;
};

Mammal.prototype.get_name = function () {
  return this.name;
};

Mammal.prototype.says = function () {
  return this.saying || '';
};

var myMammal = new Mammal('Herb the Mammal');
var name = myMammal.get_name();

// pseudoclassical prototype inheritance
//
var Cat = function (name) {
  this.name = name;
  this.saying = 'meow';
}

Cat.prototype = new Mammal();

Cat.prototype.purr = function () {
  return 'prrrrrrr';
}

Cat.prototype.get_name = function () {
  return this.says() + ' ' + this.name + ' ' + this.says();
};

var myCat = new Cat('Henrietta');
myCat.says();         // => 'meow'
myCat.purr();         // => 'prrrrrrr'
myCat.get_name();     // => 'meow Henrietta meow'

// making pseudoclassical inheritance nicer
//
Function.method('inherits', function (Parent) {
  this.prototype = new Parent();
  return this;
});

// differential inheritance 
//

var myCat = Object.create(myMammal);
myCat.name = 'Henrietta';
myCat.saying = 'meow';
myCat.purr = function () { return 'prrrrrrr' };
myCat.get_name = function () { return this.says() + ' ' + this.name + ' ' + this.says(); }

// functional inheritance
//

var mammal = function (spec) {
  var that = {};

  that.get_name = function () {
    return spec.name;
  };

  that.says = function () {
    return spec.saying || '';
  };

  return that;
}

var myMammal = mammal({name: 'Herb'});

var cat = function (spec) {
  spec.saying = spec.saying || 'meow';
  var that = mammal(spec);
  that.purr = function () { return 'prrrrrrr' }; 
  that.get_name = function () { return this.says() + ' ' + spec.name + ' ' + this.says(); };
  return that;
}

var myCat = cat({name: 'Henrietta'});

// calling super
//

Object.method('superior', function (name) {
  var that = this,
      method = that[name];
  return function () {
    return method.apply(that, arguments);
  };
});

var coolcat = function (spec) {
  var that = cat(spec),
      super_get_name = that.superior('get_name');

  that.get_name = function (n) {
    return 'like ' + super_get_name() + ' baby';
  };
  return that;
}

var myCoolCat = coolcat({name: 'Bix'});
