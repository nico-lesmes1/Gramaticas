%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);

int ok2(const char *s) {
    int n = strlen(s);
    if (n < 3 || s[0] != 'a' || s[n-1] != 'b') return 0;
    int a = 1, b = 1;
    for (int i = 1; i < n-1; ++i) {
        if (s[i] == 'a') ++a;
        else if (s[i] == 'b') ++b;
        else return 0;
    }
    return a + 1 == b;
}
%}

%union { char *s; }
%token <s> LINE

%%
lines:
    | lines LINE { puts(ok2($2) ? "acepto" : "no acepto"); free($2); }
    ;
%%

void yyerror(const char *s) { /* vacío */ }