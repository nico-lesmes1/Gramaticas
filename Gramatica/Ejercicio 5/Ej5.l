%option noyywrap
%{
#include <stdio.h>
#include <string.h>
#include "Ej5.tab.h"
%}

%%
[^\n]*\n    { yylval.s = strdup(yytext);
              yylval.s[strcspn(yylval.s, "\r\n")] = 0;
              return LINE; }
%%

int main(void) { yyparse(); return 0; }