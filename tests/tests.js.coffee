
module 'Hevents'

test 'API', () ->
  equal typeof Hevents, 'object', 'Hevents should be an object'
  equal typeof Hevents.bind, 'function', 'Hevents.bind should be a function'
  equal typeof Hevents.call, 'function', 'Hevents.bind should be a function'


test 'simple bind()/call()',() ->
  Hevents.bind 'simple_1', () ->
    "AAA"
  equal typeof Hevents.simple_1, 'function', 'Hevents.simple_1 should be a function'
  equal typeof Hevents['simple_1'], 'function', 'Hevents["simple_1"] should be a function'
  equal typeof Hevents.simple_1(), 'string', 'Hevents.simple_1() should return a string'
  equal typeof Hevents.call('simple_1'), 'string', 'Hevents.call("simple_1") should return a string'

  equal Hevents.simple_1(), 'AAA', 'Hevents.simple_1() should return "AAA"'
  equal Hevents.call('simple_1'), 'AAA', 'Hevents.call("simple_1") should return "AAA"'


test 'simple cascade bind()/call()',() ->
  value = ""
  Hevents.bind 'simple_2', () ->
    value += "AAA"
  Hevents.bind 'simple_2', () ->
    value += "BBB"
  
  Hevents.simple_2()
  ok value == "AAABBB", 'value should contains "AAABBB" after calling Hevents.simple_2() -- value = '+value


test 'bind 2 events', () ->
  Hevents.bind ['evt1','evt2'], () ->
    "AAA"
  
  equal Hevents.evt1(), 'AAA', 'Hevents.evt1() should return "AAA"'
  equal Hevents.evt2(), 'AAA', 'Hevents.evt2() should return "AAA"'


test 'commulative multi events', () ->
  value = ""
  Hevents.bind ['cumul_1','cumul_2'], () ->
    value += "AAA"
  Hevents.bind ['cumul_1','cumul_3'], () ->
    value += "BBB"

  Hevents.cumul_1()
  ok value == "AAABBB", 'value should contains "AAABBB" after calling Hevents.cumul_1() -- value = ' + value


