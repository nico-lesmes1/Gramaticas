%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);

int forma_correcta(const char *as, const char *bs);
%}

%union { char *s; }

%token <s> ASEQ BSEQ
%token NL BAD

%%
input:
    | input line
    ;

line: ASEQ BSEQ NL {
        printf("%s\n",
               forma_correcta($1, $2) ? "Acepta" : "No acepta");
        free($1); free($2);
    }
    | BAD NL { printf("No acepta\n"); }
    | NL     { /* línea vacía */ }
    ;
%%

int forma_correcta(const char *as, const char *bs) {
    int na = strlen(as);
    int nb = strlen(bs);
    return na + 1 == nb;
}

void yyerror(const char *s) { }
int main(void) { yyparse(); return 0; }