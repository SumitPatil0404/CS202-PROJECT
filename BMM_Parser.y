%{
   #include <stdio.h>
   int symbol_table[500];
   extern FILE *yyin;
%}

%token  PRINT LET REM EQUALS VARIABLE_NAME NUMBER STRING PLUS MINUS DIVIDE MULTIPLY OPEN_BRACKET CLOSE_BRACKET LESS BIGGER LESSEQ BIGEQ IF THEN ELSE WHILE DO AND OR SEMICOLON COMMA STOP RETURN
%left PLUS MINUS
%left MULTIPLY DIVIDE

%%

program :
   stmt program  {printf("0 compile\n");}
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
  NUMBER RETURN expr {printf("5 compile\n"); printf("return %d\n",$3);}
  ;
 stop : 
  NUMBER STOP {printf("6 compile\n"); printf("stop\n"); return 0;}
  ;
variable_def :
  NUMBER LET VARIABLE_NAME EQUALS expr   { printf("1 compile %d\n",$5); symbol_table[$3-'A'] = $5; };
  ;
assignment :
  NUMBER VARIABLE_NAME EQUALS expr {printf("4 compile\n"); symbol_table[$2-'A'] = $4; }
  ;  
expr : 
   NUMBER {printf("40 compile  \n "); $$ = $1;}
  | VARIABLE_NAME {printf("41 compile\n"); $$ = symbol_table[$1-'A'];}
  | expr PLUS expr {printf("42 compile\n"); $$ = $1 + $3;}
  | expr MINUS expr {printf("43 compile\n"); $$ = $1 - $3;}
  | expr MULTIPLY expr {printf("44 compile\n"); $$ = $1 * $3;}
  | expr DIVIDE expr {printf("45 compile\n"); $$ = $1 / $3;}
  | OPEN_BRACKET expr CLOSE_BRACKET {printf("46 compile\n"); $$ = $2;}
  ;
print : 
  NUMBER PRINT expr1 {printf("2 compile\n"); ;printf("%c = %d\n",$3,symbol_table[$3-'A']); }
  |  NUMBER PRINT 
  ;

expr1 : 
     expr
    | str COMMA expr1 {printf("20 compile\n"); printf("%s\n",$1); printf("%c = %d\n",$3,symbol_table[$3-'A']);}
    | str SEMICOLON expr1 {printf("20 compile\n"); printf("%s\n",$1); printf("%c = %d\n",$3,symbol_table[$3-'A']);}
    | expr COMMA expr1 {printf("21 compile\n"); printf("%c = %d\n",$1,symbol_table[$1-'A']);}  
    | expr SEMICOLON expr1 {printf("22 compile\n"); printf("%c = %d\n",$1,symbol_table[$1-'A']);}   
    ;  
comment : NUMBER REM str {printf("3 compile\n"); printf("Comment : %s\n",$3);}
  ;
str : 
    STRING str       {printf("30 compile\n"); $$ = $1;}
    |         
    ;



%%

 int yyerror(char *s) {
   fprintf(stderr, "Error: %s\n", s);
    return 0;
} 



int main(int argc, char *argv[]) {
    yyin = fopen(argv[1], "r");
    yyparse();
    fclose(yyin);
    
}

#define YYERROR \
    do { \
        fprintf(stderr, "Syntax error\n"); \
        return 1; \
    } while(0)