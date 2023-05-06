%{
   #include <stdio.h>
   int symbol_table[500];
   extern FILE *yyin;
   extern FILE *f1,*f2;
   
   %}

%token  PRINT LET REM EQUALS VARIABLE_NAME NUMBER STRING PLUS MINUS DIVIDE MULTIPLY OPEN_BRACKET CLOSE_BRACKET LESS BIGGER LESSEQ BIGEQ IF THEN ELSE WHILE DO AND OR SEMICOLON COMMA STOP RETURN STRING1
%left PLUS MINUS
%left MULTIPLY DIVIDE

%%

program :
   stmt program  {fprintf(f2,"0 compile\n");}
   | stmt
  ;



stmt:
    variable_def   
    | print 
    | comment
    | assignment
    | stop 
    | return
    ;

return : 
  NUMBER RETURN expr {fprintf(f2,"return compile\n\n"); }
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
expr : 
   NUMBER {fprintf(f2,"NUMBER compile  \n \n"); }
  | VARIABLE_NAME {fprintf(f2,"VARIABLE compile\n\n"); }
  | expr PLUS expr {fprintf(f2,"expr op compile\n\n"); }
  | expr MINUS expr {fprintf(f2,"expr op compile\n\n"); }
  | expr MULTIPLY expr {fprintf(f2,"expr op compile\n\n"); }
  | expr DIVIDE expr {fprintf(f2,"expr op compile\n\n"); }
  | OPEN_BRACKET expr CLOSE_BRACKET {fprintf(f2,"expr op compile\n\n"); }
  ;
print : 
  NUMBER PRINT expr1 {fprintf(f2,"print compile\n\n"); }
  |  NUMBER PRINT 
  ;

expr1 : 
     expr                 {fprintf(f2,"expr1  compile\n\n"); }
    | STRING1 COMMA expr1 {fprintf(f2,"expr1 String comma  compile\n\n"); }
    | STRING1 SEMICOLON expr1 {fprintf(f2,"expr1 String semicolon compile\n\n"); }
    | expr COMMA expr1 {fprintf(f2,"expr1 COmma compile\n\n"); }  
    | expr SEMICOLON expr1 {fprintf(f2,"expr1 SEMICLON compile\n\n"); }
      
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

