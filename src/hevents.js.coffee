###
 Hevents micro framework implement an instanciable event stack
 Projects home : http://github.com/yarmand/hevents
 Version: 0.6

 Copyright 2012, Yann ARMAND
 Licenced under the BSD License.
###

### we begin with defining out module depending of our runtime (amd,node or DOM) ###
( (factory) ->
  if(typeof define == 'function' && define.amd)
    ### amd ###
    define(factory)
    true
  else if(typeof document == 'undefined' && typeof module == 'object')
    ### node ###
    module.exports = factory()
    true
  else
    ### DOM ###
    window.Hevents = factory()
    true
    ###
    if(typeof(top.Hevents) != 'undefined')
      console.log("binding top.Hevents to current window")
      window.Hevents = top.Hevents
      return
    console.log("binding current window Hevents to top window")
    top.Hevents = Hevents
    ###

)( ()->

  ### From http://yehudakatz.com/2011/08/12/understanding-prototypes-in-javascript/ ###
  fromPrototype = (prototype, object) ->
    newObject = Object.create(prototype)
    `for(prop in object)
      {
        if(object.hasOwnProperty(prop))
          newObject[prop] = object[prop];
      }`
    return newObject

  remove_from_chain = (list, fun) ->
    if(typeof(list) == 'undefined')
      return undefined
    if(list.current == fun)
      return list.next
    list.next = remove_from_chain(list.next,fun)
    return list
  he=fromPrototype Array,
    new: () ->
      Object.create(he)

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
        this[names].current = fun
        this[names].next = previously_registered
        fun

    bind_before: (names,fun) ->
      console.log('bind_before() :not yet implemented')

    bind_after: (names,fun) ->
      console.log('bind_after() :not yet implemented')

    call: (name) -> 
      @[name]() if typeof(@[name]) isnt 'undefined'

    unbind: (names,fun) ->
      if(typeof(names.forEach) != 'undefined')
        names.forEach (name) ->
          he.bind(name,fun)
      else
        this[names] = remove_from_chain(this[names],fun)

    unbind_all: (names) ->
      console.log('unbind_all() :not yet implemented')

    unbind_all_before: (names) ->
      console.log('unbind_all_before() :not yet implemented')

    unbind_all_after: (name) ->
      console.log('unbind_all_after() :not yet implemented')


)

 

