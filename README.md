# Gramaticas

## Ejercicio 1

### Codigo 
Ej1.l
```
%{
#include <stdio.h>
#include <string.h>
#include "Ej1.tab.h"
%}

%%
[01]+      { yylval.s = strdup(yytext); return BIN; }
\n         { return NL; }
[ \t\r]    { }
[^ \t\r\n01]+  { return BAD; }
%%

int yywrap(void) { return 1; }
```
Ej1.y
```
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
```
Imagen 
!(https://github.com/nico-lesmes1/Gramaticas/blob/ca874078c811f37be7b823271fb11396d5b1c6e4/Gramatica/Img/Ej1.png)
