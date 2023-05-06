%{
   #include <stdio.h>
   #include<string.h>
   #include<stdlib.h>
   #include "BMM_Parser.tab.h"
   //{return NEWLINE;}
%}
%%


[ ]         
"PRINT"           {printf("PRINT\n");return PRINT;}
"LET"              { printf("LET\n");return LET;}    
"REM"              { printf("REM\n");return REM;} 
\+            {printf("op\n"); return PLUS;}
\-               {printf("op\n"); return MINUS;}
\/               {printf("op\n"); return DIVIDE;}
\*               {printf("op\n"); return MULTIPLY;}
\(               {printf("op\n"); return OPEN_BRACKET;}
\)               {printf("op\n"); return CLOSE_BRACKET;}
"<"           return LESS;
">"           return BIGGER;
"<="          return LESSEQ;
">="          return BIGEQ;
"IF"          return IF;
"THEN"        return THEN;
"ELSE"        return ELSE;
"WHILE"       return WHILE;
"DO"          return DO;
"AND"         return AND;
"OR"          return OR;
\;           return SEMICOLON;
\,           return COMMA;
"STOP"       return STOP;
"RETURN"     return RETURN;
[A-Z]       { printf("Variable\n"); yylval = *yytext ; return VARIABLE_NAME;}
[0-9]+            {yylval = atoi(yytext) ;printf("NUMBER %d\n",yylval);return NUMBER;}
[A-Z0-9]+ { printf("STRING\n");yylval = yytext ;return STRING;}
\".\"          { printf("STRING2\n");yylval = yytext ;return STRING;}




%%

int yywrap(){
    return 1;
}
