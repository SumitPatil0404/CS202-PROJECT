%{
   #include <stdio.h>
   #include<string.h>
   #include<stdlib.h>
   #include "BMM_Parser.tab.h"
   //{return NEWLINE;}
   FILE *f1,*f2,*f3;
   void yyerror(char *s);
%}
%option yylineno 
%%


[ ]         
"PRINT"           {fprintf(f1,"PRINT\n");return PRINT;}
"LET"              {fprintf(f1,"LET\n");return LET;}    
"REM"[^\n]*              { fprintf(f1,"REM\n");return REM;} 
\+            {fprintf(f1,"op\n"); return PLUS;}
\-               {fprintf(f1,"op\n"); return MINUS;}
\^               {fprintf(f1,"op\n"); return POWER;}
\/               {fprintf(f1,"op\n"); return DIVIDE;}
\*               {fprintf(f1,"op\n"); return MULTIPLY;}
\(               {fprintf(f1,"op\n"); return OPEN_BRACKET;}
\)               {fprintf(f1,"op\n"); return CLOSE_BRACKET;}
"="             {fprintf(f1,"op\n"); return EQUALS;}
"<>"           return NOTEQUALS;
"<"           return LESS;
">"           return BIGGER;
"<="          return LESSEQ;
">="          return BIGEQ;
"IF"          return IF;
"THEN"        return THEN;
"AND"         return AND;
"OR"          return OR;
"#"           return HASH;
"%"           return PERCENTAGE;
"$"           return DOLLAR;
"!"           return EXCLAMATION;
";"       return SEMICOLON;
","           return COMMA;
"STOP"       return STOP;
"RETURN"     return RETURN;
"GOTO"      return GOTO;
"GOSUB"     return GOSUB;
"DIM"       return DIM;
"END"[\n]*([^\n]*)  return END1;
"END"[\n]*       {fprintf(f1,"old end\n");return END;}
"INPUT"     return INPUT;
"DEF FN"     return DEF_FN;
"FOR"        return FOR;
"NEXT"       {fprintf(f1,"next\n");return NEXT;}
"TO"         return TO;
"STEP"       return STEP;
"DATA"       return DATA;
"NOT"        return NOT;
"XOR"        return XOR;
[A-Z][0-9]?       { fprintf(f1,"Variable\n"); yylval = *yytext ; return VARIABLE_NAME;}
[0-9]+            {yylval = atoi(yytext) ;fprintf(f1,"NUMBER %d\n",yylval);return NUMBER;}
[0-9]+\.[0-9]+    {yylval = atof(yytext) ;fprintf(f1,"NUMBER %f\n",yylval);return NUMBER;}
\"[^\"]*\"          { fprintf(f1,"STRING2\n");yylval = yytext ;return STRING1;}




%%

int yywrap(){
    return 1;
}
