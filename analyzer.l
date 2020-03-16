%{
#include <stdio.h>
#include <string.h>
int i = 0;
int errores = 0;
char *palabras[100];
FILE *salida;

void Comparar(char* palabras[], FILE *ptr) {
  int j = 0, s = 1;
  char *palabra = yytext;
  while(s!=0 && j<i){ 
    char* aux = palabras[j];
    s = strcmp(palabra, aux);
    if(s == 0)
      fprintf(ptr, " id%d=%s ", j+1, palabras[j]);
    j++; 
  }
  
  if (i == j && s != 0) { 
    palabras[i] = malloc(10*sizeof(palabra));
    strcpy(palabras[i], palabra);
    fprintf(ptr, " id%d=%s", i+1, palabras[i]);
    i++;
  }

}
void mostrarId(FILE *ptr){
  fprintf(ptr, "\nn= %d\n", i);
  for(int a = 0;a<i; a = a+1){
    fprintf(ptr, " id%d=%s\n", a+1,palabras[a]);
  } 
}
void Eliminar(){
  int s=0;
 for(int a = 0;a<strlen(yytext); a = a+1){
    if(yytext[a]=='\\'){
      if(yytext[a+1]=='n'){
        fprintf(salida, " ERROR=%s", yytext);
        errores++;
        s=1;
      }
    }
     
  } 
  if(s==0)
  fprintf(salida, " cadena=%s", yytext);

}

%}
digit     [0-9]
letter    [A-Za-z]
id         ("_"|{letter})({letter}|{digit}|"_")*
entero    {digit}+
%%
"if"           {fprintf(salida, "IF");};
"and"          {fprintf(salida, "AND");};
"break"        {fprintf(salida, "BREAK");};
"continue"     {fprintf(salida, "CONTINUE");};
"def"          {fprintf(salida, "DEF");};
"elif"         {fprintf(salida, "ELIF");};
"else"         {fprintf(salida, "ELSE");};
"for"          {fprintf(salida, "FOR");};
"import"       {fprintf(salida, "IMPORT");};
"in"           {fprintf(salida, "IN");};
"is"           {fprintf(salida, "IS");};
"not"          {fprintf(salida, "NOT");};
"or"           {fprintf(salida, "OR");};
"pass"         {fprintf(salida, "PASS");};
"print"        {fprintf(salida, "PRINT");};
"return"       {fprintf(salida, "RETURN");};
"while"        {fprintf(salida, "WHILE");};
"+"            {fprintf(salida, " suma=+");};
"-"            {fprintf(salida, " resta=-");};
"*"            {fprintf(salida, " mult=*");};
"**"           {fprintf(salida, " exp=**");};
"/"            {fprintf(salida, " div=/");};
"//"            {fprintf(salida, " divEntera=/ /");};
"%"            {fprintf(salida, " mod=porc");};
"<<"            {fprintf(salida, " shiftIzq= <<");};
">>"            {fprintf(salida, " shiftDer= >>");};
"&"            {fprintf(salida, " binAnd=&");};
"|"            {fprintf(salida, " binOr=|");};
"^"            {fprintf(salida, " XOR=^");};
"~"            {fprintf(salida, " not=~");};
"<"            {fprintf(salida, " menorQue= <");};
">"            {fprintf(salida, " mayorQue= >");};
"<="           {fprintf(salida, " menorOigual= <=");};
">="           {fprintf(salida, " mayorOigual= >=");};
"=="           {fprintf(salida, " igualQue= ==");};
"!="           {fprintf(salida, " diferenteQue= !=");};
"<>"           {fprintf(salida, " diferenteQue= <>");};
"range"        {fprintf(salida, " RANGE");};
"True"         {fprintf(salida, " TRUE");};
"False"        {fprintf(salida, " FALSE");};
"("            {fprintf(salida, " parabre=(");};
")"            {fprintf(salida, " parcierr=)");};
"="             {fprintf(salida, " asign= =");};
"["            {fprintf(salida, " corabre=[");};
"]"            {fprintf(salida, " corcierr=]");};
":"            {fprintf(salida, " dospunt=:");};
","            {fprintf(salida, " coma=,");};
["]([^"]|\\(.|["\n"]))*["]      {Eliminar();};
[']([^']|\\(.|["\n"]))*[']     {Eliminar();};
{id}           {Comparar(palabras, salida);};
"#".*          { /* DO NOTHING */ };      
{entero}       {fprintf(salida, " entero=%s", yytext);};
{entero}[L|l]  {fprintf(salida, " enteroLong=%s", yytext);};
[0-9]*\.?[0-9]+([eE[0-9]+)? {fprintf(salida, " Real=%s", yytext);};
[0-9]*\.?[0-9]+([jJ])             {fprintf(salida, " Imaginario=%s", yytext);};
" "+ {};
[\n] {fprintf(salida,"\n");}
. {fprintf(salida, "ERROR=%s", yytext); errores++;}
%%

int main(int argc, char* argv[]) {
  
  FILE *archivo;
  
  // Recibe el nombre del archivo como argumento a ./a.out
  char const* const nombreArchivo = argv[1];

  // Lectura y creación de los archivos
  salida = fopen("./salida.txt", "w");
  archivo = fopen(nombreArchivo, "r");

  if (salida == NULL || archivo == NULL) {
    printf("Error relacionado con archivos");
    exit(1);
  }

  yyset_in(archivo);
  yylex();
  mostrarId(salida);
  fprintf(salida, "\nNumero de errores: %d", errores);

  fclose(archivo);
  fclose(salida);

  return 0;
}