Hevents: an instanciable event stack
=
Introduction
=
The purpose of Hevents is to make easy communication between pieces of code which don't live in the same source file.

Bind event handler
=
You can bind any function to an named event.

Calling bind() several times on the same name cumulate handlers

<code>
  Hevents.bind('mytest', function(){console.log('AAA')})
  Hevents.bind('mytest', function(){console.log('BBB')})
</code>

A single handler can be bind to several events

<code>
  Hevents.bind(['persons_new','persons_edit'], function(){console.log('editing a Person')})
</code>

Fire an event
=
Te fire an event, use .call() function or directly call a function with same name as event.

<code>
  Hevents.call('mytest');
  Hevents.mytest();
</code>

Instanciate a new event stack
=
If you want to isolate an event stack in a particular namespace, you can instanciate it.

<code>
  var my_stack=new Hevents();
  
  my_stack.bind('hello', function(){console.log('hello from my_stack')})
  Hevents.bind('hello', function(){console.log('hello from global')})
  
  my_stack.hello();
  Hevents.hello();
  
  == RESULT ==
  hello from my_stack
  hello from global
</code>