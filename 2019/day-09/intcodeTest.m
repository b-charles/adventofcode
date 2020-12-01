function tests = exampleTest
tests = functiontests(localfunctions);
end

function checkCodes( testCase, codes, expected )
  [ out, ~, ask ] = intcode( codes, [] );
  verifyEqual( testCase, out, int64(expected) );
  verifyFalse( testCase, ask );
end

function checkOut( testCase, codes, in, expected )
  [ ~, out, ask ] = intcode( codes, in );
  verifyEqual( testCase, out, int64(expected) );
  verifyFalse( testCase, ask );
end

%% Day 2

function testDay2_1( testCase )
  checkCodes( testCase, [1,0,0,0,99], [2,0,0,0,99] );
end

function testDay2_2( testCase )
  checkCodes( testCase, [2,3,0,3,99], [2,3,0,6,99] );
end

function testDay2_3( testCase )
  checkCodes( testCase, [2,4,4,5,99,0], [2,4,4,5,99,9801] );
end

function testDay2_4( testCase )
  checkCodes( testCase, [1,1,1,4,99,5,6,0,99], [30,1,1,4,2,5,6,0,99] );
end

function testDay5_1_1( testCase )
  checkOut( testCase, [3,9,8,9,10,9,4,9,99,-1,8], 7, 0 );
  checkOut( testCase, [3,9,8,9,10,9,4,9,99,-1,8], 8, 1 );
end

function testDay5_1_2( testCase )
  checkOut( testCase, [3,9,7,9,10,9,4,9,99,-1,8], 7, 1 );
  checkOut( testCase, [3,9,7,9,10,9,4,9,99,-1,8], 8, 0 );
end

function testDay5_1_3( testCase )
  checkOut( testCase, [3,3,1108,-1,8,3,4,3,99], 7, 0 );
  checkOut( testCase, [3,3,1108,-1,8,3,4,3,99], 8, 1 );
end

function testDay5_1_4( testCase )
  checkOut( testCase, [3,3,1107,-1,8,3,4,3,99], 7, 1 );
  checkOut( testCase, [3,3,1107,-1,8,3,4,3,99], 8, 0 );
end

function testDay5_1_5( testCase )
  checkOut( testCase, [3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9], 0, 0 );
  checkOut( testCase, [3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9], 42, 1 );
end

function testDay5_1_6( testCase )
  checkOut( testCase, [3,3,1105,-1,9,1101,0,0,12,4,12,99,1], 0, 0 );
  checkOut( testCase, [3,3,1105,-1,9,1101,0,0,12,4,12,99,1], 42, 1 );
end

function testDay5_1_7( testCase )
  codes = [3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99];
  checkOut( testCase, codes, 7, 999 );
  checkOut( testCase, codes, 8, 1000 );
  checkOut( testCase, codes, 9, 1001 );
end

function testDay9_1( testCase )
  codes = [109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99];
  checkOut( testCase, codes, [], codes );
end

function testDay9_2( testCase )
  checkOut( testCase, [1102,34915192,34915192,7,4,7,99,0], [], 1219070632396864 );
end

function testDay9_3( testCase )
  v = int64(1125899906842624);
  codes = [ int64(104), v, int64(99) ];
  checkOut( testCase, codes, [], v );
end

