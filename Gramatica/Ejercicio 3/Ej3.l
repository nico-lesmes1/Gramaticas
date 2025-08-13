%{
#include <stdio.h>
#include <string.h>
#include "Ej3.tab.h"
%}

%%
a+          { yylval.s = strdup(yytext); return ASEQ; }
b+          { yylval.s = strdup(yytext); return BSEQ; }
\n          { return NL; }
[ \t\r]     { /* ignorar */ }
.           { return BAD; }   /* cualquier otro carácter */
%%

int yywrap(void) { return 1; }