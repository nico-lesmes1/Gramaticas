%{
#include <stdio.h>
#include <string.h>
#include "Ej4.tab.h"
%}

%%
ab          { yylval.s = strdup(yytext); return AB; }
abb         { yylval.s = strdup(yytext); return ABB; }
\n          { return NL; }
[ \t\r]     { /* ignorar */ }
.           { return BAD; }
%%

int yywrap(void) { return 1; }