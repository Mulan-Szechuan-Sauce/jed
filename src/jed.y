%{
    #include "../src/jed.hpp"
    #include <json.hpp>
    #include <string>
    #include <iostream>
    using json = nlohmann::json;

    int yyerror(const char *s);
    int yylex(void);

    Root *program_root;
%}

%error-verbose

%union {
    int64_t int_val;
    std::string *str_val;
    Root *root_val;
    Node *node_val;
    std::list<std::string *> *str_list_val;
}

%start program

%token INT STR ID
%token '(' ')' '[' ']' '.' '|' '{' '}'
%type <int_val> INT
%type <str_val> STR ID idstr
%type <node_val> sexpr
%type <str_list_val> listOfIds

%%

program: sexpr { program_root = new NodeRoot($1); }
       | INT { program_root = new IntRoot($1); }
       | STR { program_root = new StrRoot($1); }
;

idstr: ID { $$ = $1; }
     | STR { $$ = $1; }
;

sexpr: '.' idstr { $$ = new IdNode($2); }
     | '.' '{' listOfIds '}' { $$ = new IdListNode($3); }
     | sexpr '.' idstr { $$->add_next(new IdNode($3)); }
     | sexpr '.' '{' listOfIds '}' { $$->add_next(new IdListNode($4)); }
     //         | sexpr '[' INT ']' { $$->add_next(); }
     //         | sexpr '(' STR ')' { $$->add_next(); }
;

listOfIds: idstr { $$ = new std::list<std::string *>(); $$->push_front($1); }
         | idstr ',' listOfIds { $3->push_front($1); $$ = $3; }
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
    /*
    json j2 = {
               {"pi", 3.5},
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
    */

    yyin = stdin;
    yyparse();

    std::cout << program_root->repr() << std::endl;
    return 0;
}
