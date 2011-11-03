# Hevents micro framework implement an instanciable event stack
# Projects home : http://github.com/yarmand/hevents
# Version 0.1

window.Hevents=fromPrototype Array,
  bind: (names, fun) ->
    names = single_or_array(names)
    for n in names
      previously_registered=this[n]
      this[n]=() ->
        if(typeof(previously_registered) != 'undefined')
          previously_registered.call()
        fun.call()
    return fun

  call: (name) ->
    if(typeof(this[name]) != 'undefined')
      this[name]()

  unbind: (names,fun) ->
    names = single_or_array(names)
    for n in names
      this[n] = remove_from_chain(this[n],fun)
    return this[n]

remove_from_chain = (list, fun) ->
  if(list == fun)
    return list.previously_registered
  if(typeof(list.previously_registered) == 'undefined')
    return list
  list=remove_from_chain(list.previously_registered,fun)
  return list
  

single_or_array = (names) ->
  if(typeof(names.forEach) == 'undefined') # single name or an array ?
    n=names
    names=[n]
  return names
  
# From http://yehudakatz.com/2011/08/12/understanding-prototypes-in-javascript/
fromPrototype = (prototype, object) ->
  newObject = Object.create(prototype)
  `for(prop in object)
    {
      if(object.hasOwnProperty(prop))
        newObject[prop] = object[prop];
    }`
  return newObject
