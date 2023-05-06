%{
   #include <stdio.h>
   #include <stdlib.h>
   int symbol_table[500];
   extern FILE *yyin;
   extern FILE *f1,*f2,*f3;
   extern int yylineno;
   extern char *yytext;
   void yyerror(char *s);
   int a =-1;
   %}

%token  PRINT LET REM EQUALS VARIABLE_NAME NUMBER STRING PLUS MINUS DIVIDE MULTIPLY OPEN_BRACKET CLOSE_BRACKET LESS BIGGER LESSEQ BIGEQ IF THEN AND OR SEMICOLON COMMA STOP RETURN STRING1 GOTO GOSUB DIM END INPUT DEF_FN NOTEQUALS FOR NEXT STEP TO DATA NOT XOR POWER HASH PERCENTAGE DOLLAR EXCLAMATION

%left NOT AND OR XOR
%left EQUALS NOTEQUALS LESS BIGGER LESSEQ BIGEQ
%left PLUS MINUS
%left MULTIPLY DIVIDE
%left POWER


%start program
%%

program :
   stmt program  
   | stmt  
  ;



stmt:
    variable_def     {if($1>a){ a=$1;}else{yyerror("Wrong LINE NUMBERs");}
                       if($1<1 || $1>9999){yyerror("Line Number should be in between 1 and 9999");}}
    | print           { if($1>a){ a=$1;}else{yyerror("Wrong LINE NUMBERs");} if($1<1 || $1>9999){yyerror("Line Number should be in between 1 and 9999");}}    
    | comment         { if($1>a){ a=$1;}else{yyerror("Wrong LINE NUMBERs");} if($1<1 || $1>9999){yyerror("Line Number should be in between 1 and 9999");}}
    | assignment      {if($1>a){a=$1;}else{yyerror("Wrong LINE NUMBERs");}  if($1<1 || $1>9999){yyerror("between 1 and 9999");}}
    | stop             {if($1>a){a=$1;}else{yyerror("Wrong LINE NUMBERs");}  if($1<1 || $1>9999){yyerror("Line Number should be in between 1 and 9999");}}
    | return           {if($1>a){a=$1;}else{yyerror("Wrong LINE NUMBERs");}  if($1<1 || $1>9999){yyerror("Line Number should be in between 1 and 9999");}}
    | goto             {if($1>a){a=$1;}else{yyerror("Wrong LINE NUMBERs");}  if($1<1 || $1>9999){yyerror("Line Number should be in between 1 and 9999");}}
    | gosub           {if($1>a){a=$1;}else{yyerror("Wrong LINE NUMBERs");}  if($1<1 || $1>9999){yyerror("Line Number should be in between 1 and 9999");}}
    | dim              {if($1>a){a=$1;}else{yyerror("Wrong LINE NUMBERs");}  if($1<1 || $1>9999){yyerror("Line Number should be in between 1 and 9999");}}
    | end               {if($1>a){a=$1;}else{yyerror("Wrong LINE NUMBERs");}  if($1<1 || $1>9999){yyerror("Line Number should be in between 1 and 9999");}}
    | input               {if($1>a){a=$1;}else{yyerror("Wrong LINE NUMBERs");}  if($1<1 || $1>9999){yyerror("Line Number should be in between 1 and 9999");}}
    | def_fn               {if($1>a){a=$1;}else{yyerror("Wrong LINE NUMBERs");}  if($1<1 || $1>9999){yyerror("Line Number should be in between 1 and 9999");}}
    | if               {if($1>a){a=$1;}else{yyerror("Wrong LINE NUMBERs");}  if($1<1 || $1>9999){yyerror("Line Number should be in between 1 and 9999");}}
    | for                {  if($1<1 || $1>9999){yyerror("Line Number should be in between 1 and 9999");}}
    | data               {if($1>a){a=$1;}else{yyerror("Wrong LINE NUMBERs");}  if($1<1 || $1>9999){yyerror("Line Number should be in between 1 and 9999");}}
    | error 
    ;


expr:
   NUMBER {fprintf(f2,"NUMBER compile  \n \n"); $$=$1; }
  | variable_name {fprintf(f2,"VARIABLE compile\n\n"); }
  | STRING1 {fprintf(f2,"STRING compile\n\n"); }
  | arithmetic_expr {fprintf(f2,"expr compile\n\n"); }
  | relation_expr {fprintf(f2,"expr compile\n\n"); }
  | logical_expr {fprintf(f2,"expr compile\n\n"); }
  |OPEN_BRACKET expr CLOSE_BRACKET {fprintf(f2,"condition compile\n\n"); }
  |variable_name OPEN_BRACKET expr CLOSE_BRACKET 
   ;
relation_expr:
    expr LESS expr {fprintf(f2,"condition compile\n\n"); }
    | expr BIGGER expr {fprintf(f2,"condition compile\n\n"); }
    | expr LESSEQ expr {fprintf(f2,"condition compile\n\n"); }
    | expr BIGEQ expr {fprintf(f2,"condition compile\n\n"); }
    | expr EQUALS expr {fprintf(f2,"condition compile\n\n"); }
    | expr NOTEQUALS expr {fprintf(f2,"condition compile\n\n"); }
    
    ;
  
logical_expr :
    expr AND expr {fprintf(f2,"logical compile\n\n"); }
    | expr OR expr {fprintf(f2,"logical compile\n\n"); }
    | NOT expr {fprintf(f2,"logical compile\n\n"); }
    | expr XOR expr {fprintf(f2,"logical compile\n\n"); }
  
    ;

arithmetic_expr : 
  | expr PLUS expr {fprintf(f2,"expr op compile\n\n"); }
  | expr MINUS expr {fprintf(f2,"expr op compile\n\n"); }
  | expr MULTIPLY expr {fprintf(f2,"expr op compile\n\n"); }
  | expr DIVIDE expr {fprintf(f2,"expr op compile\n\n"); }
  | expr POWER expr {fprintf(f2,"expr op compile\n\n"); }
  ;   

data:
  NUMBER DATA value {fprintf(f2,"data compile\n\n");  $$=$1;}
  ;

value:
    expr COMMA value {fprintf(f2,"value compile\n\n"); }
    | STRING1 COMMA value {fprintf(f2,"value compile\n\n"); }
    | expr {fprintf(f2,"value compile\n\n"); }
    | STRING1 {fprintf(f2,"value compile\n\n"); }


for:
    NUMBER FOR variable_name EQUALS expr TO expr  NUMBER NEXT variable_name   {fprintf(f2,"for compile\n\n");  $$=$1; if($3!=$10){
    yyerror("Wrong For Loop Syntax, Next should be followed by same Variable as followed by FOR");}}
    |NUMBER FOR variable_name EQUALS expr TO expr stmt NUMBER NEXT variable_name   {fprintf(f2,"for compile\n\n");  $$=$1; if($3!=$11){
    yyerror("Wrong For Loop Syntax, Next should be followed by same Variable as followed by FOR");}}
    |NUMBER FOR variable_name EQUALS expr TO expr stmt stmt  NUMBER NEXT variable_name   {fprintf(f2,"for compile\n\n");  $$=$1;
    if($3!=$12){
    yyerror("Wrong For Loop Syntax, Next should be followed by same Variable as followed by FOR");}}
    |NUMBER FOR variable_name EQUALS expr TO expr stmt stmt stmt NUMBER NEXT variable_name   {fprintf(f2,"for compile\n\n"); $$=$1; if($3!=$13){
    yyerror("Wrong For Loop Syntax, Next should be followed by same Variable as followed by FOR");}}
  
    
        | NUMBER FOR variable_name EQUALS expr TO expr STEP expr NUMBER NEXT variable_name  {fprintf(f2,"for compile\n\n");  $$=$1;
    if($3!=$12==0){
    yyerror("Wrong For Loop Syntax, Next should be followed by same Variable as followed by FOR");}}
    | NUMBER FOR variable_name EQUALS expr TO expr STEP expr stmt NUMBER NEXT variable_name  {fprintf(f2,"for compile\n\n");  $$=$1;
    if($3!=$13==0){
    yyerror("Wrong For Loop Syntax, Next should be followed by same Variable as followed by FOR");}}
    | NUMBER FOR variable_name EQUALS expr TO expr STEP expr stmt stmt NUMBER NEXT variable_name  {fprintf(f2,"for compile\n\n"); $$=$1; if($3!=$14){
    yyerror("Wrong For Loop Syntax, Next should be followed by same Variable as followed by FOR");}}
    | NUMBER FOR variable_name EQUALS expr TO expr STEP expr stmt stmt stmt NUMBER NEXT variable_name  {fprintf(f2,"for compile\n\n"); $$=$1;if($3!=$15){
    yyerror("Wrong For Loop Syntax, Next should be followed by same Variable as followed by FOR");} }
    ; 
   

if:
  NUMBER IF relation_expr THEN NUMBER {fprintf(f2,"if compile\n\n");  $$=$1;}
  ;

def_fn:
  NUMBER DEF_FN variable_name OPEN_BRACKET variable_name CLOSE_BRACKET EQUALS expr {fprintf(f2,"def_fn compile\n\n"); $$=$1; }
  | NUMBER DEF_FN variable_name EQUALS expr {fprintf(f2,"def_fn compile\n\n"); $$=$1; }
  ;
input :
  NUMBER INPUT VAR {fprintf(f2,"input compile\n\n"); $$=$1; }
 
  ;

VAR :
  variable_name {fprintf(f2,"VAR compile\n\n"); }
  | variable_name OPEN_BRACKET variable_name CLOSE_BRACKET {fprintf(f2,"VAR compile\n\n"); }
  | variable_name OPEN_BRACKET NUMBER CLOSE_BRACKET {fprintf(f2,"VAR compile\n\n"); }
  | variable_name COMMA VAR {fprintf(f2,"VAR compile\n\n"); }
  | variable_name OPEN_BRACKET variable_name CLOSE_BRACKET COMMA VAR{fprintf(f2,"VAR compile\n\n"); }
  | variable_name OPEN_BRACKET NUMBER CLOSE_BRACKET COMMA VAR{fprintf(f2,"VAR compile\n\n"); }
  
  ;  
end : 
  NUMBER END {fprintf(f2,"end compile\n\n");  $$=$1; return 0;}
  ;
dim :
  NUMBER DIM variable_name OPEN_BRACKET NUMBER CLOSE_BRACKET {fprintf(f2,"dim compile\n\n");  $$=$1;}
  | NUMBER DIM variable_name OPEN_BRACKET NUMBER COMMA NUMBER CLOSE_BRACKET {fprintf(f2,"dim compile\n\n");  $$=$1;}
  ;
goto:
  NUMBER GOTO NUMBER {fprintf(f2,"goto compile\n\n"); $$=$1; }
  ;
gosub :
  NUMBER GOSUB NUMBER {fprintf(f2,"gosub compile\n\n");  $$=$1;}
  ; 
return : 
  NUMBER RETURN  {fprintf(f2,"return compile\n\n");  $$=$1; }
  ;
stop : 
  NUMBER STOP {fprintf(f2,"stop compile\n\n");  $$=$1; }
  ;
variable_def :
  NUMBER LET variable_name EQUALS expr   { fprintf(f2,"variable_def compile \n\n"); $$=$1;};
  ;
variable_name :
  VARIABLE_NAME {fprintf(f2,"variable_name compile\n\n"); $$=$1; }
  | VARIABLE_NAME HASH {fprintf(f2,"variable_name compile\n\n"); $$=$1;}
  | VARIABLE_NAME PERCENTAGE {fprintf(f2,"variable_name compile\n\n");$$=$1; }
  | VARIABLE_NAME DOLLAR {fprintf(f2,"variable_name compile\n\n"); $$=$1;}
  | VARIABLE_NAME EXCLAMATION {fprintf(f2,"variable_name compile\n\n");$$=$1; }
  
  ; 
assignment :
  NUMBER variable_name EQUALS expr {fprintf(f2,"Assignment compile\n\n"); $$=$1; }
  ;  

print : 
  NUMBER PRINT print_expr  {fprintf(f2,"print compile\n\n");  $$=$1;}
  ;

print_expr : 
     expr                 {fprintf(f2,"expr1  compile\n\n"); }
    | STRING1            {fprintf(f2,"expr1  compile\n\n"); }
    | STRING1 COMMA print_expr {fprintf(f2,"expr1 String comma  compile\n\n"); }
    | STRING1 SEMICOLON print_expr {fprintf(f2,"expr1 String semicolon compile\n\n"); }
    | expr COMMA print_expr {fprintf(f2,"expr1 COmma compile\n\n"); }  
    | expr SEMICOLON print_expr {fprintf(f2,"expr1 SEMICLON compile\n\n"); }
      
    ;  
comment : NUMBER REM {fprintf(f2,"comment compile\n\n");$$=$1; }
  ;




%%

 void yyerror(char *s) {
  fprintf(f3, "Line No. %d  %s\n",yylineno, s);

} 



int main(int argc, char *argv[]) {
    f1 = fopen("lex.txt", "w");
    f2 = fopen("yacc.txt", "w");
    f3 = fopen("errors.txt", "w");
    yyin = fopen(argv[1], "r");
    yyparse();
    fclose(yyin);
    fclose(f1);
    fclose(f2);
    fclose(f3);
    
}

