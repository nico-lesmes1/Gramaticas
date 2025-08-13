%{
#include "Ej2.tab.h"
%}

%%
a           { return A; }
b           { return B; }
\n          { return NL; }
[ \t\r]+    {  }
.           { return *yytext; }
%%

int yywrap(void) { return 1; }