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

Python
```
import pathlib

def es_capicua(s: str) -> bool:
    return s == s[::-1]

def validar(linea: str) -> None:
    linea = linea.strip()
    if not linea:
        return
    if set(linea) - {'0', '1'}:
        print("No acepta")
    else:
        print("Acepta" if es_capicua(linea) else "No acepta")

archivo = pathlib.Path(__file__).with_name("texto.txt")
with archivo.open() as f:
    for ln in f:
        validar(ln)
```

Imagen 
![Img 1](https://github.com/nico-lesmes1/Gramaticas/blob/ca874078c811f37be7b823271fb11396d5b1c6e4/Gramatica/Img/Ej1.png)

## Ejercicio 2

### Codigo 
Ej2.l
```
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
```
Ej2.y
```
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
```
Python
```
import sys
import os

def acepta(cadena: str) -> bool:

    cadena = cadena.rstrip("\n\r")
    i = 0
    while i < len(cadena) and cadena[i] == 'a':
        i += 1
    j = i
    while j < len(cadena) and cadena[j] == 'b':
        j += 1
    if j != len(cadena):
        return False
    n, m = i, j - i
    return m == n + 1

def main():
    archivo = "texto.txt" if len(sys.argv) < 2 else sys.argv[1]
    if not os.path.isfile(archivo):
        print("No acepta")
        return
    with open(archivo, "r", encoding="utf-8") as f:
        for linea in f:
            linea = linea.rstrip("\n\r")
            if acepta(linea):
                print("Acepta")
            else:
                print("No acepta")

if __name__ == "__main__":
    main()
```

Imagen 
![Img 2](https://github.com/nico-lesmes1/Gramaticas/blob/588acd6e1867eda95cb73b5ecb4887e1ebed5b76/Gramatica/Img/Ej2.png)

## Ejercicio 3

### Codigo 
Ej3.l
```
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
.           { return BAD; }  
%%

int yywrap(void) { return 1; }
```
Ej3.y
```
%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);

int forma_correcta(const char *as, const char *bs);
%}

%union { char *s; }

%token <s> ASEQ BSEQ
%token NL BAD

%%
input:
    | input line
    ;

line: ASEQ BSEQ NL {
        printf("%s\n",
               forma_correcta($1, $2) ? "Acepta" : "No acepta");
        free($1); free($2);
    }
    | BAD NL { printf("No acepta\n"); }
    | NL     { /* línea vacía */ }
    ;
%%

int forma_correcta(const char *as, const char *bs) {
    int na = strlen(as);
    int nb = strlen(bs);
    return na + 1 == nb;
}

void yyerror(const char *s) { }
int main(void) { yyparse(); return 0; }
```
Python
```
import pathlib
import re

def forma_correcta(as_seq: str, bs_seq: str) -> bool:
    return len(as_seq) + 1 == len(bs_seq)

def validar(linea: str) -> None:
    linea = linea.strip()
    if not linea:
        return
    m = re.fullmatch(r'(a+)(b+)', linea)
    if not m:
        print("No acepta")
    else:
        as_seq, bs_seq = m.groups()
        print("Acepta" if forma_correcta(as_seq, bs_seq) else "No acepta")

archivo = pathlib.Path(__file__).with_name("texto.txt")
with archivo.open() as f:
    for ln in f:
        validar(ln)
```
Imagen 
![Img 3](https://github.com/nico-lesmes1/Gramaticas/blob/588acd6e1867eda95cb73b5ecb4887e1ebed5b76/Gramatica/Img/Ej3.png)

## Ejercicio 4

### Codigo 
Ej4.l
```
%{
#include <stdio.h>
#include <string.h>
#include "Ej4.tab.h"
%}

%%
ab          { yylval.s = strdup(yytext); return AB; }
abb         { yylval.s = strdup(yytext); return ABB; }
\n          { return NL; }
[ \t\r]     { }
.           { return BAD; }
%%

int yywrap(void) { return 1; }
```
Ej4.y
```
%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
%}

%union { char *s; }

%token <s> AB ABB
%token NL BAD

%%
input:
    | input line
    ;

line: AB  NL { printf("Acepta\n");  free($1); }
    | ABB NL { printf("Acepta\n");  free($1); }
    | BAD NL { printf("No acepta\n"); }
    | NL     { }
    ;
%%

void yyerror(const char *s) { }
int main(void) { yyparse(); return 0; }
```
Python
```
import pathlib

def validar(linea: str) -> None:
    linea = linea.strip()
    if not linea:
        return
    if linea in {"ab", "abb"}:
        print("Acepta")
    else:
        print("No acepta")

archivo = pathlib.Path(__file__).with_name("texto.txt")
with archivo.open() as f:
    for ln in f:
        validar(ln)
```
Imagen 
![Img 4](https://github.com/nico-lesmes1/Gramaticas/blob/588acd6e1867eda95cb73b5ecb4887e1ebed5b76/Gramatica/Img/Ej4.png)

## Ejercicio 5

### Codigo 
Ej5.l
```
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
```
Ej5.y
```
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
        if (i+1 >= n-1) return 0; 
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
```
Python
```
import pathlib
import re

def validar(linea: str) -> None:
    linea = linea.strip()
    if not linea:
        return
    if re.fullmatch(r'a(ab)*b', linea):
        print("Acepta")
    else:
        print("No acepta")

archivo = pathlib.Path(__file__).with_name("texto.txt")
with archivo.open() as f:
    for ln in f:
        validar(ln)
```

