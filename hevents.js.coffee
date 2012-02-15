`
/* Hevents micro framework implement an instanciable event stack
 * Projects home : http://github.com/yarmand/hevents
 * Version 0.1
 */
`
# From http://yehudakatz.com/2011/08/12/understanding-prototypes-in-javascript/
fromPrototype = (prototype, object) ->
  newObject = Object.create(prototype)
  `for(prop in object)
    {
      if(object.hasOwnProperty(prop))
        newObject[prop] = object[prop];
    }`
  return newObject

window.Hevents=fromPrototype Array,
  bind: (names, fun) ->
    if(typeof(names.forEach) != 'undefined')
      names.forEach (name) ->
        Hevents.bind(name,fun)
    else
      previously_registered=this[names]
      this[names]=() ->
        if(typeof(previously_registered) != 'undefined')
          previously_registered.call()
        fun.call()
    
    #names = single_or_array(names)
    #for n in names
    #  previously_registered=@[n]
    #  @[n]=() ->
    #    previously_registered.call() if typeof(previously_registered) isnt 'undefined'
    #    fun.call()
    #return fun

  call: (name) -> @[name]() if typeof(@[name]) isnt 'undefined'
  
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
  

