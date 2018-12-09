/* Mini Calculator */
/* calc.y */

%{
    #include "../src/jed.hpp"
    #include <json.hpp>
    #include <string>
    #include <iostream>
    using json = nlohmann::json;

    int yyerror(const char *s);
    int yylex(void);
%}

%error-verbose

%union {
    int64_t int_val;
    std::string *str_val;
    Root *root_val;
    Node *node_val;
}

%start program

%token INT STR ID
%token '(' ')' '[' ']' '.' '|' '{' '}'
%type <int_val> INT
%type <str_val> STR ID idstr
%type <root_val> program
%type <node_val> sexpr

%%

program: sexpr { $$ = new NodeRoot($1); }
       | INT { $$ = new IntRoot($1); }
       | STR { $$ = new StrRoot($1); }
;

idstr: ID { $$ = $1; }
     | STR { $$ = $1; }
;

sexpr: '.' idstr { $$ = new Node(); }
     | '.' '{' listOfIds '}' { $$ = new Node(); }
     | sexpr '[' INT ']' { $$ = new Node(); }
     | sexpr '(' STR ')' { $$ = new Node(); }
     | sexpr '.' idstr { $$ = new Node(); }
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
    json j2 = {
               {"pi", 3.141},
               {"happy", true},
               {"name", "Niels"},
               {"nothing", nullptr},
               {"answer", {
                           {"everything", 42}
                   }},
               {"list", {1, 0, 2}},
               {"object", {
                           {"currency", "USD"},
                           {"value", 42.99}
                   }}
    };

    std::cout << typeid(j2["pi"]).name() << std::endl;

    return 0;
    yyin = stdin;
    yyparse();

    return 0;
}
