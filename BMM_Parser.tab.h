
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     PRINT = 258,
     LET = 259,
     REM = 260,
     EQUALS = 261,
     VARIABLE_NAME = 262,
     NUMBER = 263,
     PLUS = 264,
     MINUS = 265,
     DIVIDE = 266,
     MULTIPLY = 267,
     OPEN_BRACKET = 268,
     CLOSE_BRACKET = 269,
     LESS = 270,
     BIGGER = 271,
     LESSEQ = 272,
     BIGEQ = 273,
     IF = 274,
     THEN = 275,
     AND = 276,
     OR = 277,
     SEMICOLON = 278,
     COMMA = 279,
     STOP = 280,
     RETURN = 281,
     STRING1 = 282,
     GOTO = 283,
     GOSUB = 284,
     DIM = 285,
     END = 286,
     INPUT = 287,
     DEF_FN = 288,
     NOTEQUALS = 289,
     FOR = 290,
     NEXT = 291,
     STEP = 292,
     TO = 293,
     DATA = 294,
     NOT = 295,
     XOR = 296,
     POWER = 297,
     HASH = 298,
     PERCENTAGE = 299,
     DOLLAR = 300,
     EXCLAMATION = 301,
     END1 = 302
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


