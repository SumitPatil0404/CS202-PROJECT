%{
   #include <stdio.h>
   int symbol_table[500];
   extern FILE *yyin;
   extern FILE *f1,*f2;
   
   %}

%token  PRINT LET REM EQUALS VARIABLE_NAME NUMBER STRING PLUS MINUS DIVIDE MULTIPLY OPEN_BRACKET CLOSE_BRACKET LESS BIGGER LESSEQ BIGEQ IF THEN AND OR SEMICOLON COMMA STOP RETURN STRING1 GOTO GOSUB DIM END INPUT DEF_FN NOTEQUALS FOR NEXT STEP TO DATA NOT XOR POWER
%left PLUS MINUS
%left MULTIPLY DIVIDE

%%

program :
   stmt program  {fprintf(f2,"0 compile\n");}
   | stmt
   | stmt program next {fprintf(f2,"0 compile\n");}
  ;



stmt:
    variable_def   
    | print               
    | comment
    | assignment
    | stop 
    | return
    | goto
    | gosub
    | dim
    | end
    | input
    | def_fn
    | if
    | for        {fprintf(f2,"stmt heelo compile\n\n");}
    | data
    ;

data:
  NUMBER DATA value {fprintf(f2,"data compile\n\n"); }
  ;

value:
    expr COMMA value {fprintf(f2,"value compile\n\n"); }
    | STRING1 COMMA value {fprintf(f2,"value compile\n\n"); }
    | expr {fprintf(f2,"value compile\n\n"); }
    | STRING1 {fprintf(f2,"value compile\n\n"); }


for:
    NUMBER FOR VARIABLE_NAME EQUALS expr TO expr   next   {fprintf(f2,"for compile\n\n"); }
    |NUMBER FOR VARIABLE_NAME EQUALS expr TO expr stmt stmt  next   {fprintf(f2,"for compile\n\n"); }
    |NUMBER FOR VARIABLE_NAME EQUALS expr TO expr stmt stmt stmt next   {fprintf(f2,"for compile\n\n"); }
    
    | NUMBER FOR VARIABLE_NAME EQUALS expr TO expr STEP expr stmt next  {fprintf(f2,"for compile\n\n"); }
    | NUMBER FOR VARIABLE_NAME EQUALS expr TO expr STEP expr stmt stmt next  {fprintf(f2,"for compile\n\n"); }
    | NUMBER FOR VARIABLE_NAME EQUALS expr TO expr STEP expr stmt stmt stmt next  {fprintf(f2,"for compile\n\n"); }
    ; 
next :
  NUMBER NEXT VARIABLE_NAME {fprintf(f2,"next compile\n\n"); }
  ;      

if:
  NUMBER IF relation_expr THEN NUMBER {fprintf(f2,"if compile\n\n"); }
  ;

relation_expr:
    expr LESS expr {fprintf(f2,"condition compile\n\n"); }
    | expr BIGGER expr {fprintf(f2,"condition compile\n\n"); }
    | expr LESSEQ expr {fprintf(f2,"condition compile\n\n"); }
    | expr BIGEQ expr {fprintf(f2,"condition compile\n\n"); }
    | expr EQUALS expr {fprintf(f2,"condition compile\n\n"); }
    | expr NOTEQUALS expr {fprintf(f2,"condition compile\n\n"); }
    |OPEN_BRACKET expr CLOSE_BRACKET {fprintf(f2,"condition compile\n\n"); }
    ;
  
logical_expr :
    expr AND expr {fprintf(f2,"logical compile\n\n"); }
    | expr OR expr {fprintf(f2,"logical compile\n\n"); }
    | NOT expr {fprintf(f2,"logical compile\n\n"); }
    | expr {fprintf(f2,"logical compile\n\n"); }
    | OPEN_BRACKET expr CLOSE_BRACKET {fprintf(f2,"logical compile\n\n"); }
    | expr XOR expr {fprintf(f2,"logical compile\n\n"); }
  
    ;

arithmetic_expr : 
  NUMBER {fprintf(f2,"NUMBER compile  \n \n"); }
  | VARIABLE_NAME {fprintf(f2,"VARIABLE compile\n\n"); }
  | expr PLUS expr {fprintf(f2,"expr op compile\n\n"); }
  | expr MINUS expr {fprintf(f2,"expr op compile\n\n"); }
  | expr MULTIPLY expr {fprintf(f2,"expr op compile\n\n"); }
  | expr DIVIDE expr {fprintf(f2,"expr op compile\n\n"); }
  | expr POWER expr {fprintf(f2,"expr op compile\n\n"); }
  | MINUS expr {fprintf(f2,"expr compile\n\n"); }
  | OPEN_BRACKET expr CLOSE_BRACKET {fprintf(f2,"expr op compile\n\n"); }
  ;   


def_fn:
  NUMBER DEF_FN VARIABLE_NAME OPEN_BRACKET VARIABLE_NAME CLOSE_BRACKET EQUALS expr {fprintf(f2,"def_fn compile\n\n"); }
  | NUMBER DEF_FN VARIABLE_NAME EQUALS expr {fprintf(f2,"def_fn compile\n\n"); }
  ;
input :
  NUMBER INPUT VAR {fprintf(f2,"input compile\n\n"); }
 
  ;

VAR :
  VARIABLE_NAME {fprintf(f2,"VAR compile\n\n"); }
  | VARIABLE_NAME OPEN_BRACKET NUMBER CLOSE_BRACKET {fprintf(f2,"VAR compile\n\n"); }
  | VARIABLE_NAME COMMA VAR {fprintf(f2,"VAR compile\n\n"); }
  | VARIABLE_NAME OPEN_BRACKET NUMBER CLOSE_BRACKET COMMA VAR{fprintf(f2,"VAR compile\n\n"); }
  
  ;  
end : 
  NUMBER END {fprintf(f2,"end compile\n\n"); }
  ;
dim :
  NUMBER DIM VARIABLE_NAME OPEN_BRACKET NUMBER CLOSE_BRACKET {fprintf(f2,"dim compile\n\n"); }
  | NUMBER DIM VARIABLE_NAME OPEN_BRACKET NUMBER COMMA NUMBER CLOSE_BRACKET {fprintf(f2,"dim compile\n\n"); }
  ;
goto:
  NUMBER GOTO NUMBER {fprintf(f2,"goto compile\n\n"); }
  ;
gosub :
  NUMBER GOSUB NUMBER {fprintf(f2,"gosub compile\n\n"); }
  ; 
return : 
  NUMBER RETURN  {fprintf(f2,"return compile\n\n"); }
  ;
 stop : 
  NUMBER STOP {fprintf(f2,"stop compile\n\n"); return 0;}
  ;
variable_def :
  NUMBER LET VARIABLE_NAME EQUALS expr   { fprintf(f2,"variable_def compile \n\n");};
  ;
assignment :
  NUMBER VARIABLE_NAME EQUALS expr {fprintf(f2,"Assignment compile\n\n"); }
  ;  

print : 
  NUMBER PRINT print_expr {fprintf(f2,"print compile\n\n"); }
  |  NUMBER PRINT 
  ;
expr:
   NUMBER {fprintf(f2,"NUMBER compile  \n \n"); }
  | VARIABLE_NAME {fprintf(f2,"VARIABLE compile\n\n"); }
  | arithmetic_expr {fprintf(f2,"expr compile\n\n"); }
  | relation_expr {fprintf(f2,"expr compile\n\n"); }
  | logical_expr {fprintf(f2,"expr compile\n\n"); }
   ;
print_expr : 
     expr                 {fprintf(f2,"expr1  compile\n\n"); }
    | STRING1 COMMA print_expr {fprintf(f2,"expr1 String comma  compile\n\n"); }
    | STRING1 SEMICOLON print_expr {fprintf(f2,"expr1 String semicolon compile\n\n"); }
    | expr COMMA print_expr {fprintf(f2,"expr1 COmma compile\n\n"); }  
    | expr SEMICOLON print_expr {fprintf(f2,"expr1 SEMICLON compile\n\n"); }
      
    ;  
comment : NUMBER REM str {fprintf(f2,"comment compile\n\n");}
  ;
str : 
    STRING str       {fprintf(f2,"str compile\n\n"); $$ = $1;}
    |         
    ;



%%

 int yyerror(char *s) {
   fprintf(stderr, "Error: %s\n", s);
    return 0;
} 



int main(int argc, char *argv[]) {
    f1 = fopen("lex.txt", "w");
    f2 = fopen("yacc.txt", "w");
    yyin = fopen(argv[1], "r");
    yyparse();
    fclose(yyin);
    
}

