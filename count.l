%{
int i = 0;
%}
digit     [0-9]
letter    [A-Za-z]
id        {letter}({letter}|{digit})*
entero    [+|-]?{digit}+
%%
"if"           {printf("IF");} ;
"and"          {printf("AND");} ;
"break"        {printf("BREAK");} ;
"continue"     {printf("CONTINUE");} ;
"def"          {printf("DEF");} ;
"elif"         {printf("ELIF");} ;
"else"         {printf("ELSE");} ;
"for"          {printf("FOR");} ;
"import"       {printf("IMPORT");} ;
"in"           {printf("IN");} ;
"is"           {printf("IS");} ;
"not"          {printf("NOT");} ;
"or"           {printf("OR");} ;
"pass"         {printf("PASS");} ;
"print"        {printf("PRINT");} ;
"return"       {printf("RETURN");} ;
"while"        {printf("WHILE");} ;
\"(.*?)\"      {printf("cadena=%s", yytext);};
\'(.*?)\'      {printf("cadena=%s", yytext);};
{id}           {printf("id%d=%s", i, yytext); i = i+1;};
"+"            {printf("suma=+");};
"-"            {printf("resta=-");};
"*"            {printf("mult=*");};
"**"           {printf("exp=**");};
"/"            {printf("div=/");};
"//"            {printf("divEntera=//");};
"%"            {printf("mod=porc");};
"<<"            {printf("shiftIzq= <<");};
">>"            {printf("shiftDer= >>");};
"&"            {printf("binAnd=&");};
"|"            {printf("binOr=|");};
"^"            {printf("XOR=^");};
"~"            {printf("not=~");};
"<"            {printf("menorQue= <");};
">"            {printf("mayorQue= >");};
"<="            {printf("menorOigual= <=");};
">="            {printf("mayorOigual= >=");};
"=="            {printf("igualQue= ==");};
"!="            {printf("diferenteQue= !=");};
"<>"            {printf("diferenteQue= <>");};
{entero}       {printf("entero=%s", yytext);};
{entero}[L|l]  {printf("enteroLong=%s", yytext);};
%%

int yywrap() {}

int main(int argc, char* argv[]) {

  FILE *archivo;

  /* ./a.out archivo.py */
  char const* const nombreArchivo = argv[1];
  archivo = fopen(nombreArchivo, "r");

  yyset_in(archivo);
  yylex();

  fclose(archivo);

  return 0;
}