/* Mini Calculator */
/* calc.y */

%{
    #include <stdio.h>
    #include <stdlib.h>
    int yyerror(const char *s);
    int yylex(void);
%}

%error-verbose

%union {
    int int_val;
    char *str_val;
}

%start program

%token WS INT STR ID LPAREN RPAREN LSQUARE RSQUARE DOT
%type <int_val> INT
%type <str_val> STR ID
   
%%

program: /* empty */
       | program expr
;

expr: INT { printf("%d", $1); }
;

%%

#include "../obj/jed.yy.c"

int yyerror(const char *s)
{
    extern int yylineno;
    extern char *yytext;
     
    fprintf(stderr, "Error on line %d: %s", yylineno, yytext);
    exit(1);
}

int main() {
    yyin = stdin;
    yyparse();

    return 0;
}
