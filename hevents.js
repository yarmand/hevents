(function() {
  
/* Hevents micro framework implement an instanciable event stack
 * Projects home : http://github.com/yarmand/hevents
 * Version 0.1
 */
;  var fromPrototype, remove_from_chain, single_or_array;
  window.Hevents = fromPrototype(Array, {
    bind: function(names, fun) {
      var n, previously_registered, _i, _len;
      names = single_or_array(names);
      for (_i = 0, _len = names.length; _i < _len; _i++) {
        n = names[_i];
        previously_registered = this[n];
        this[n] = function() {
          if (typeof previously_registered !== 'undefined') {
            previously_registered.call();
          }
          return fun.call();
        };
      }
      return fun;
    },
    call: function(name) {
      if (typeof this[name] !== 'undefined') {
        return this[name]();
      }
    },
    unbind: function(names, fun) {
      var n, _i, _len;
      names = single_or_array(names);
      for (_i = 0, _len = names.length; _i < _len; _i++) {
        n = names[_i];
        this[n] = remove_from_chain(this[n], fun);
      }
      return this[n];
    }
  });
  remove_from_chain = function(list, fun) {
    if (list === fun) {
      return list.previously_registered;
    }
    if (typeof list.previously_registered === 'undefined') {
      return list;
    }
    list = remove_from_chain(list.previously_registered, fun);
    return list;
  };
  single_or_array = function(names) {
    var n;
    if (typeof names.forEach === 'undefined') {
      n = names;
      names = [n];
    }
    return names;
  };
  fromPrototype = function(prototype, object) {
    var newObject;
    newObject = Object.create(prototype);
    for(prop in object)
    {
      if(object.hasOwnProperty(prop))
        newObject[prop] = object[prop];
    };
    return newObject;
  };
}).call(this);
