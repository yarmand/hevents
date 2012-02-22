`
/* Hevents micro framework implement an instanciable event stack
 * Projects home : http://github.com/yarmand/hevents
 * Version 0.5
 */
`

#if(typeof(top.Hevents) != 'undefined')
#  console.log("binding top.Hevents to current window")
#  window.Hevents = top.Hevents
#  return

# From http://yehudakatz.com/2011/08/12/understanding-prototypes-in-javascript/
fromPrototype = (prototype, object) ->
  newObject = Object.create(prototype)
  `for(prop in object)
    {
      if(object.hasOwnProperty(prop))
        newObject[prop] = object[prop];
    }`
  return newObject

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

window.Hevents=(()->
  he=fromPrototype Array,
  bind: (names, fun) ->
    if(typeof(names.forEach) != 'undefined')
      names.forEach (name) ->
        he.bind(name,fun)
    else
      previously_registered=this[names]
      this[names]=() ->
        if(typeof(previously_registered) != 'undefined')
          previously_registered.call()
        fun.call()
    
  call: (name) -> @[name]() if typeof(@[name]) isnt 'undefined'
  
  unbind: (names,fun) ->
    names = single_or_array(names)
    for n in names
      this[n] = remove_from_chain(this[n],fun)
    return this[n]

  new: () ->
    Object.create(he)

  ).call(this)

#console.log("binding current window Hevents to top window")
#top.Hevents = Hevents

 

