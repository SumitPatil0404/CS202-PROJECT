
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
     STRING = 264,
     PLUS = 265,
     MINUS = 266,
     DIVIDE = 267,
     MULTIPLY = 268,
     OPEN_BRACKET = 269,
     CLOSE_BRACKET = 270,
     LESS = 271,
     BIGGER = 272,
     LESSEQ = 273,
     BIGEQ = 274,
     IF = 275,
     THEN = 276,
     AND = 277,
     OR = 278,
     SEMICOLON = 279,
     COMMA = 280,
     STOP = 281,
     RETURN = 282,
     STRING1 = 283,
     GOTO = 284,
     GOSUB = 285,
     DIM = 286,
     END = 287,
     INPUT = 288,
     DEF_FN = 289,
     NOTEQUALS = 290,
     FOR = 291,
     NEXT = 292,
     STEP = 293,
     TO = 294,
     DATA = 295,
     NOT = 296,
     XOR = 297,
     POWER = 298,
     HASH = 299,
     PERCENTAGE = 300,
     DOLLAR = 301,
     EXCLAMATION = 302
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


