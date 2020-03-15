%{
#include <stdio.h>
#include <string.h>
int i = 0;
int errores = 0;
char *palabras[100];

void Comparar(char* palabras[]) {
  int j = 0, s = 1;
  char *palabra = yytext;
  while(s!=0 && j<i){ 
    char* aux = palabras[j];
    s = strcmp(palabra, aux);
    if(s == 0)
      printf(" id%d=%s ", j+1, palabras[j]);
    j++; 
  }
  
  if (i == j && s != 0) { 
    palabras[i] = malloc(10*sizeof(palabra));
    strcpy(palabras[i], palabra);
    printf(" id%d=%s", i+1, palabras[i]);
    i++;
  }

}
void mostrarId(){
  printf("\nn= %d\n", i);
  for(int a = 0;a<i; a = a+1){
    printf(" id%d=%s\n", a+1,palabras[a]);
  }

}

%}
digit     [0-9]
letter    [A-Za-z]
id         ("_"|{letter})({letter}|{digit}|"_")*
entero    [+|-]?{digit}+
%%
"if"           {printf("IF");};
"and"          {printf("AND");};
"break"        {printf("BREAK");};
"continue"     {printf("CONTINUE");};
"def"          {printf("DEF");};
"elif"         {printf("ELIF");};
"else"         {printf("ELSE");};
"for"          {printf("FOR");};
"import"       {printf("IMPORT");};
"in"           {printf("IN");};
"is"           {printf("IS");};
"not"          {printf("NOT");};
"or"           {printf("OR");};
"pass"         {printf("PASS");};
"print"        {printf("PRINT");};
"return"       {printf("RETURN");};
"while"        {printf("WHILE");};
"+"            {printf(" suma=+");};
"-"            {printf(" resta=-");};
"*"            {printf(" mult=*");};
"**"           {printf(" exp=**");};
"/"            {printf(" div=/");};
"//"            {printf(" divEntera=/ /");};
"%"            {printf(" mod=porc");};
"<<"            {printf(" shiftIzq= <<");};
">>"            {printf(" shiftDer= >>");};
"&"            {printf(" binAnd=&");};
"|"            {printf(" binOr=|");};
"^"            {printf(" XOR=^");};
"~"            {printf(" not=~");};
"<"            {printf(" menorQue= <");};
">"            {printf(" mayorQue= >");};
"<="           {printf(" menorOigual= <=");};
">="           {printf(" mayorOigual= >=");};
"=="           {printf(" igualQue= ==");};
"!="           {printf(" diferenteQue= !=");};
"<>"           {printf(" diferenteQue= <>");};
"range"        {printf(" RANGE");};
"True"         {printf(" TRUE");};
"False"        {printf(" FALSE");};
"("            {printf(" parabre=(");};
")"            {printf(" parcierr=)");};
"="             {printf(" asign= =");};
"["            {printf(" corabre=[");};
"]"            {printf(" corcierr=]");};
":"            {printf(" dospunt=:");};
","            {printf(" coma=,");};
("\"")([^"\n"]*)("\"")      {printf(" cadena=%s", yytext);};
("'")([^"\n"]*)("'")      {printf(" cadena=%s", yytext);};
{id}           {Comparar(palabras);};
"#".*          { /* DO NOTHING */ };      
{entero}       {printf(" entero=%s", yytext);};
{entero}[L|l]  {printf(" enteroLong=%s", yytext);};
[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)? {printf(" Real=%s", yytext);};
[-+]?[0-9]*\.?[0-9]+([jJ])             {printf(" Imaginario=%s", yytext);};
" "+ {};
. {printf("ERROR=%s", yytext);}
%%

int main(int argc, char* argv[]) {
  
  FILE *archivo;

  /* ./a.out archivo.py */
  char const* const nombreArchivo = argv[1];
  archivo = fopen(nombreArchivo, "r");

  yyset_in(archivo);
  yylex();
  mostrarId();

  printf("Numero de errores: %d\n", errores);

  fclose(archivo);

  return 0;
}