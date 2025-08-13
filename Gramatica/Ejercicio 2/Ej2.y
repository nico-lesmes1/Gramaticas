%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex(void);
extern FILE *yyin;
void yyerror(const char *s);
%}

%token A B NL

start : S NL          { printf("Acepta\n"); }
      | NL            { printf("Acepta\n"); }   
      | error NL      { printf("No acepta\n"); }
      ;

S     : A S B
      | B
      ;
%%

int main(int argc, char **argv) {
    if (argc > 1) yyin = fopen(argv[1], "r");
    else          yyin = fopen("texto.txt", "r");
    if (!yyin) { perror("fopen"); return 1; }
    return yyparse();
}

void yyerror(const char *s) { }