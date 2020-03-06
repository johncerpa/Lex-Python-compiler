%{
#include <ctype.h>
int variables = 0;

void convertirAMayus(char *temp) {
  char* name;
  name = strtok(temp,":");

  char *s = name;
  while (*s) {
    *s = toupper((unsigned char) *s);
    s++;
  }
}
%}

%%
def { convertirAMayus(yytext); printf("%s Definicion de funcion\n", yytext); }

[a-zA-Z_$][a-zA-Z_$0-9]* { printf("%s Variable\n", yytext); variables++; }

. { printf("%s No mayuscula\n", yytext); }
%%

int yywrap() {}

int main(int argc, char* argv[]) {

  FILE *archivo;
  char const* const nombreArchivo = argv[1];
  archivo = fopen(nombreArchivo, "r");

  yyset_in(archivo);
  yylex();

  printf("Numero de variables: %d\n", variables);

  fclose(archivo);

  return 0;
}