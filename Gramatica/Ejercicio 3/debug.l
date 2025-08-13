%{
#include <stdio.h>
%}
%%
a       { printf("TOK_A "); }
b       { printf("TOK_B "); }
\n      { printf("NL\n"); }
[ \t\r] {}
.       { printf("BAD(%c) ", *yytext); }
%%
int yywrap(void) { return 1; }
int main() { yylex(); return 0; }