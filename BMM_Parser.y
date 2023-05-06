%{
   #include <stdio.h>
   #include <stdlib.h>
   int symbol_table[500];
   extern FILE *yyin;
   extern FILE *f1,*f2;
   extern int yylineno;
   extern char *yytext;
   void yyerror(char *s);
   int a =-1,b=-1;
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
   stmt program  {fprintf(f2,"0 compile\n");}
   | stmt   {fprintf(f2,"0 compile\n");}
  ;



stmt:
    variable_def     {if($$>a){ a=$$;}else{yyerror("Wrong LINE NUMBERs");}}
    | print           {if($$>a){a=$$;}else{yyerror("Wrong LINE NUMBERs");}}    
    | comment         {if($$>a){a=$$;}else{yyerror("Wrong LINE NUMBERs");}}
    | assignment      {if($$>a){a=$$;}else{yyerror("Wrong LINE NUMBERs");}}
    | stop             {if($$>a){a=$$;}else{yyerror("Wrong LINE NUMBERs");}}
    | return           {if($$>a){a=$$;}else{yyerror("Wrong LINE NUMBERs");}}
    | goto             {if($$>a){a=$$;}else{yyerror("Wrong LINE NUMBERs");}}
    | gosub           {if($$>a){a=$$;}else{yyerror("Wrong LINE NUMBERs");}}
    | dim              {if($$>a){a=$$;}else{yyerror("Wrong LINE NUMBERs");}}
    | end               {if($$>a){a=$$;}else{yyerror("Wrong LINE NUMBERs");}}
    | input               {if($$>a){a=$$;}else{yyerror("Wrong LINE NUMBERs");}}
    | def_fn               {if($$>a){a=$$;}else{yyerror("Wrong LINE NUMBERs");}}
    | if               {if($$>a){a=$$;}else{yyerror("Wrong LINE NUMBERs");}}
    | for                {if($$>a){a=$$;}else{yyerror("Wrong LINE NUMBERs");}}
    | data               {if($$>a){a=$$;}else{yyerror("Wrong LINE NUMBERs");}}
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
    NUMBER FOR variable_name EQUALS expr TO expr   next   {fprintf(f2,"for compile\n\n");  $$=$1;}
    |NUMBER FOR variable_name EQUALS expr TO expr stmt stmt  next   {fprintf(f2,"for compile\n\n");  $$=$1;}
    |NUMBER FOR variable_name EQUALS expr TO expr stmt stmt stmt next   {fprintf(f2,"for compile\n\n"); $$=$1; }
    
    | NUMBER FOR variable_name EQUALS expr TO expr STEP expr stmt next  {fprintf(f2,"for compile\n\n");  $$=$1;}
    | NUMBER FOR variable_name EQUALS expr TO expr STEP expr stmt stmt next  {fprintf(f2,"for compile\n\n"); $$=$1; }
    | NUMBER FOR variable_name EQUALS expr TO expr STEP expr stmt stmt stmt next  {fprintf(f2,"for compile\n\n"); $$=$1; }
    ; 
next :
  NUMBER NEXT variable_name {fprintf(f2,"next compile\n\n"); $$=$1; }
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
  | variable_name OPEN_BRACKET NUMBER CLOSE_BRACKET {fprintf(f2,"VAR compile\n\n"); }
  | variable_name COMMA VAR {fprintf(f2,"VAR compile\n\n"); }
  | variable_name OPEN_BRACKET NUMBER CLOSE_BRACKET COMMA VAR{fprintf(f2,"VAR compile\n\n"); }
  
  ;  
end : 
  NUMBER END {fprintf(f2,"end compile\n\n");  $$=$1;}
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
  NUMBER STOP {fprintf(f2,"stop compile\n\n");  $$=$1; return 0;}
  ;
variable_def :
  NUMBER LET variable_name EQUALS expr   { fprintf(f2,"variable_def compile \n\n"); $$=$1;};
  ;
variable_name :
  VARIABLE_NAME {fprintf(f2,"variable_name compile\n\n"); }
  | VARIABLE_NAME HASH {fprintf(f2,"variable_name compile\n\n"); }
  | VARIABLE_NAME PERCENTAGE {fprintf(f2,"variable_name compile\n\n"); }
  | VARIABLE_NAME DOLLAR {fprintf(f2,"variable_name compile\n\n"); }
  | VARIABLE_NAME EXCLAMATION {fprintf(f2,"variable_name compile\n\n"); }
  
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
  fprintf(stderr, "Line no.%d  %s\n",yylineno, s);

} 



int main(int argc, char *argv[]) {
    f1 = fopen("lex.txt", "w");
    f2 = fopen("yacc.txt", "w");
    yyin = fopen(argv[1], "r");
    yyparse();
    fclose(yyin);
    
}

