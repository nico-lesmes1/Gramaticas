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