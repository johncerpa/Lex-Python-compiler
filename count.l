%{
int mayusculas = 0;
%}

%%
[A-Z] { printf("%s Mayuscula:\n", yytext); mayusculas++; }

. { printf("%s No mayuscula\n", yytext); }
%%

int yywrap() {}

int main(int argc, char* argv[]) {

  FILE *archivo;
  char const* const nombreArchivo = argv[1];

  archivo = fopen(nombreArchivo, "r");
  yyset_in(archivo);
  yylex();

  printf("\nMayusculas: %d\n", mayusculas);

  fclose(archivo);

  return 0;
}