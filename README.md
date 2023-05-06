B-- Compiler
This is a compiler for B-- language developed using Lex and Yacc. B-- is a toy programming language based on BASIC programming language. The interpreter supports various BASIC language features such as variable declaration, arithmetic operations, control structures, function definition, etc.



****
Files:

BMM_Scanner.l: Lex file containing rules to identify different tokens in the input program.
BMM_Parser.y: Yacc file containing grammar rules and semantic actions to parse and interpret the input program.
BMM_Parser.tab.h: Header file automatically generated by Yacc, which contains definitions for token codes and parse tree node types.
README.md: This file.



****
Usage:

To build the interpreter, use the following commands:

$ flex BMM_Scanner.l
$ bison -d BMM_Parser.y
$ gcc BMM_Scanner.c BMM_Parser.tab.c -o BMMcompiler
To run the interpreter, provide a BASIC program file as input:

$ ./BMMcompiler input.bmm
Supported Features
The interpreter supports the following features:



****
Statements:

PRINT <expression>: 					  Print the value of the expression to the console.
LET <variable> = <expression>: 			  Assign the value of the expression to the variable.
REM <comment>: 						  Add a comment to the code.
STOP: 							  Stop program execution.
RETURN: 							  Return from a subroutine.
GOTO <line_number>: 					  Jump to the specified line number.
GOSUB <line_number>: 					  Jump to the specified line number and save the current line number for later return.
DIM <variable>(<dimension>): 				  Declare an array with the specified dimensions.
INPUT <variable>: 					  Read a value from the console and assign it to the variable.
DEF FN <function_name>(<parameter>)=<expression>: Define a function with the specified name and parameter.



****
Control Structures:

IF <condition> THEN <line_number>: 	               Execute the following line if the condition is true.
FOR <variable> = <start> TO <end> [STEP <increment>]: Loop from the start value to the end value with the specified increment (default is 1).
NEXT <variable>: 				End the current loop iteration and increment the loop variable.
DATA <value1>,<value2>,...: 		Define a list of data values for use with the READ statement.
READ <variable>: 				Read the next data value and assign it to the variable.



****
Operators:

The following operators are supported:

+: Addition
-: Subtraction
*: Multiplication
/: Division
^: Exponentiation
=: Equality
<>: Inequality
<: Less than
>: Greater than
<=: Less than or equal to
>=: Greater than or equal to
AND: Logical AND
OR: Logical OR
NOT: Logical NOT
XOR: Logical XOR
#: String concatenation
%: Modulo
$: String length
!: Factorial


****
Data Types:

The interpreter supports the following data types:

Integer: Whole numbers.
Float: Real numbers.
String: Character arrays.


****
Variables:

LET <variable> = <expression>: Assign the value of the expression to the variable.
<variable>(<index>): Access an array element at the specified index.



****
Errors Shown:

1. For varname .... NEXT varname : Here varname should be same for both else it will give syntex error
2. 120 LET ... 
   130 PRINT ..
   100 LET ..
			Here it will give syntex error for LINE NO. as latter Line no. is smaller than the previous one.
3. Other syntex errors that doesn't match with the keywords defined for the language like PRIN, FO, EN which in reality should be PRINT, FOR, END, etc.