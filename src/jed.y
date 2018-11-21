/* Mini Calculator */
/* calc.y */

%{
    #include "../src/jed.hpp"
    #include <string>
    #include <iostream>

    int yyerror(const char *s);
    int yylex(void);
%}

%error-verbose

%union {
    int int_val;
    std::string *str_val;
}

%start program

%token INT STR ID
%token '(' ')' '[' ']' '.' '|'
%type <int_val> INT
%type <str_val> STR ID idstr

%%

program: /* empty */
       | program edge
       | INT
       | STR
;

edge: '.' sexpr
    | '[' INT ']'
;

idstr: ID
     | STR
;

sexpr: idstr
     | idstr '[' INT ']'
     | idstr '(' STR ')'
     | '[' listOfIds ']'
;

listOfIds: idstr
         | idstr ',' listOfIds
;

%%

#include "../obj/jed.yy.c"

int yyerror(const char *s)
{
    extern int yylineno;
    extern char *yytext;
     
    fprintf(stderr, "Parse error: %s on line %d\n", s, yylineno);
    exit(1);
}

int main() {
    yyin = stdin;
    yyparse();

    return 0;
}
