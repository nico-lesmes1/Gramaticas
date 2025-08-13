%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
%}

%union { char *s; }

%token <s> AB ABB
%token NL BAD

%%
input:
    | input line
    ;

line: AB  NL { printf("Acepta\n");  free($1); }
    | ABB NL { printf("Acepta\n");  free($1); }
    | BAD NL { printf("No acepta\n"); }
    | NL     { }
    ;
%%

void yyerror(const char *s) { }
int main(void) { yyparse(); return 0; }