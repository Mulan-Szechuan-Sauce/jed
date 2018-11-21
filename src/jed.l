%{
    /* Jed Lexer */
    #include <string>
%}

%option yylineno
%option noyywrap

%{
    /* REGEX Variable Initialization */
%}
ws            [ ]|[\t]
integers      -?[0-9]+
str           \"(\\.|[^\"])*\"
identifiers   ([a-zA-Z_])([a-zA-Z0-9_])*

%%

{integers}      { yylval.int_val = atoi(yytext); return INT; }
{str}           { *yylval.str_val = std::string(yytext); return STR; }
{identifiers}   return ID;
","             return ',';
"|"             return '|';
"("             return '(';
")"             return ')';
"["             return '[';
"]"             return ']';
"."             return '.';

%{
// Strips whitespace
%}
{ws}

. {
    fprintf(stderr, "Invalid token: '%s' on line %d\n", yytext, yylineno);
    exit(1);
}

