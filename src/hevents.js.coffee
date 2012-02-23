###
#
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

  bind_one = (object, name, fun) ->
    previously_registered=object[name]
    object[name]=() ->
      if(typeof(previously_registered) != 'undefined')
        previously_registered.call()
      fun.call()
    object[name].current = fun
    object[name].next = previously_registered

  unbind_all_one = (object, name) ->
    object[name] = undefined

  ###
    following is exported
  ###
  fromPrototype Array,
    new: () ->
      Object.create(this)

    bind: (names, fun) ->
      if(typeof(names.forEach) != 'undefined')
        self = this
        names.forEach (name) ->
          bind_one(self, name, fun)
      else
        bind_one(this, names, fun)
      fun

    bind_before: (names,fun) ->
      console.log('bind_before() :not yet implemented')

    bind_after: (names,fun) ->
      console.log('bind_after() :not yet implemented')

    call: (name) -> 
      @[name]() if typeof(@[name]) isnt 'undefined'

    unbind_all: (names) ->
      if(typeof(names.forEach) != 'undefined')
        self = this
        names.forEach (name) ->
          unbind_all_one(self, name)
      else
        unbind_all_one(this, names)

    unbind_all_before: (names) ->
      console.log('unbind_all_before() :not yet implemented')

    unbind_all_after: (name) ->
      console.log('unbind_all_after() :not yet implemented')


)

 

