%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);

int es_capicua(const char *s);
%}

%union { char *s; }
%token <s> BIN
%token NL BAD

%%
input:
    | input line
    ;

line: BIN NL {
        printf("%s\n", es_capicua($1) ? "Acepta" : "No acepta");
        free($1);
    }
    | BAD NL { printf("No acepta\n"); } 
    | NL     { }
    ;
%%

int es_capicua(const char *s) {
    int n = strlen(s);
    for (int i = 0; i < n/2; ++i)
        if (s[i] != s[n-1-i]) return 0;
    return 1;
}

void yyerror(const char *s) { }
int main(void) { yyparse(); return 0; }