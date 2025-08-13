%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);

int validate_grammar(const char *s) {
    int n = strlen(s);
    if (n < 2) return 0;  // Mínimo "ab" (n=2)
    if (s[0] != 'a' || s[n-1] != 'b') return 0;
    
    // Verificar el patrón a(ab)*b
    for (int i = 1; i < n-1; i += 2) {
        if (i+1 >= n-1) return 0;  // Longitud impar no válida
        if (s[i] != 'b' || s[i+1] != 'a') return 0;
    }
    return 1;
}
%}

%union { char *s; }
%token <s> LINE

%%
lines:
    | lines LINE { puts(validate_grammar($2) ? "Acepta" : "No acepta"); free($2); }
    ;
%%

void yyerror(const char *s) { /* vacío */ }