Program GUI;

const

limiteCadastro = 20;

type

registro = record
 			existe: boolean;
 			nome: string;
 			sexo: String;
 			idade: integer; 		
		 end;

var

menuAtual, linha, atual, menuSair, anterior, antes, espaUsado: integer;
erro, saiu, cadastroCheio: boolean;
cadastro:array[1..limiteCadastro] of registro;

procedure limpaCadastro;
  var i:integer;
  begin
  	for i := 1 to limiteCadastro do
  	  begin
  		cadastro[i].existe := false;
  		cadastro[i].nome := '';
  		cadastro[i].sexo := '';
  		cadastro[i].idade := 0;
  	  end
  end;
  
procedure teste;
  begin
	cadastro[5].existe := true;	
  end;

procedure contarCadastro;
  var i:integer;
  begin
  	espaUsado := 0;
  	
  	for i := 1 to limiteCadastro do
  	  begin
  		if (cadastro[i].existe) then espaUsado := espaUsado + 1;
  	  end;
  end;  

procedure temEspaco;
  var i:integer;
  begin
	cadastroCheio := true;
	for i := 1 to limiteCadastro do
	  begin
		if (not cadastro[i].existe) then cadastroCheio := false;
	  end;
  end;
  
procedure verificaID(id:integer);
  var i:integer;
  begin
	while (cadastro[id].existe) do
	  begin
	  	writeln('');
		writeln('ja existe um cadastro com esse id.');
		gotoxy(1,1);
		write('insira um ID(1~', limiteCadastro,'):         ');
		gotoxy(21,1);
		readln(id);	
	  end;
	gotoxy(1,2);
	for i := 1 to 5 do writeln('                                       ');
	gotoxy(1,2)		
  end;
  
procedure salvaDados(id: integer; nome:string; sexo:string; idade:integer);
  var i: integer;
  begin
  	for i := 1 to 5 do
  	  begin
  		cadastro[id].existe := true;
  		cadastro[id].nome := nome;
  		cadastro[id].sexo := sexo;
  		cadastro[id].idade := idade;
	  end;
	clrscr;
	writeln('CADASTRO INSERIDO COM SUCESSO');
	writeln('');
	writeln(' ', #16, 'OK');
	readkey;	
  end;
  
procedure removeDados(id:integer);
  var i: integer;
  begin
  	for i := 1 to 5 do
  	  begin
  		cadastro[id].existe := false;
  		cadastro[id].nome := '';
  		cadastro[id].sexo := '';
  		cadastro[id].idade := 0;
	  end;
	clrscr;
	writeln('CADASTRO REMOVIDO COM SUCESSO');
	writeln('');
	writeln(' ', #16, 'OK');
	readkey;
	gotoxy(1,3);	
  end; 

procedure mudarSeletorHorizontal(opcao1: integer; opcaon: integer; y: integer; larg:integer);
  var tecla: char;
  begin
  
  linha := opcao1;
  
  repeat
  	
	gotoxy(linha,y);
	writeln(' ');
	
	case tecla of
		#75: linha := linha - larg;
		#77: linha := linha + larg;
	end;
	
	if (linha < opcao1) then linha := opcaon;
	if (linha > opcaon) then linha := opcao1;
	
	gotoxy(linha,y);
	writeln(#16);
	
	gotoxy(1, (y + 6));
	
	tecla := readkey;
		
  until (tecla = #13);
  	
  end;

procedure mudarSeletorVertical(opcao1: integer; opcaon: integer; x: integer);
  var tecla: char;
  
  begin
  
  linha := opcao1;
  
  repeat
  	
	gotoxy(x,linha);
	writeln(' ');
	
	case tecla of
		#72: linha := linha - 1;
		#80: linha := linha + 1;
	end;
	
	if (linha < opcao1) then linha := opcaon;
	if (linha > opcaon) then linha := opcao1;
	
	gotoxy(x,linha);
	writeln(#16);
	
	gotoxy(1,(opcaon + 6));
	
	tecla := readkey;
		
  until (tecla = #13);
  	
  end;
  
function lerString(x : integer; y : integer; retorno : integer) : string;
 var valor : string;
 begin
 	gotoxy(x,y);
 	read(valor);
 	lerString := valor;
 	gotoxy(1, retorno);
 end;
 
function lerInteger(x : integer; y : integer; retorno : integer) : integer;
 var valor : integer;
 begin
 	gotoxy(x,y);
 	read(valor);
 	lerInteger := valor;
 	gotoxy(1, retorno);
 end;

procedure testes;
  begin
  	clrscr;
  	writeln('EM FASE DE TESTES');
  	writeln('');
  	writeln(' ', #16, 'OK');
  	writeln('');
  	readkey;
  	atual := 1;
  end;
  

procedure menu0;
  begin
  	contarCadastro;
  	clrscr;
  	writeln('Espaco em uso: ', espaUsado, '/', limiteCadastro);
	writeln('Selecione uma opcao:');
	writeln('');
	writeln('  Inserir Cadastro');
	writeln('  Visualizar Cadastro');
	writeln('  Remover Cadastro');
	writeln('  Sair');
	writeln('');
	writeln('--------------------------------------------------');
	writeln(#30, ' ', #31, ' - MUDA SELEÇÃO | ENTER - Entrar ');
	
	mudarSeletorVertical(4,7,2);
	
	case linha of
		4: atual := 2;
		5: atual := 3;
		6: atual := 4;
		7: begin
			atual := 0;
			menuSair := 0;
		   end;
	end;
  end;

procedure menu1;
  const retorno1 = 6;
  
  var id, idade:integer;
  	 nome, sexo:string;
  	 sai:boolean;
  begin
  	temEspaco;
  	clrscr;
  	if (not cadastroCheio) then
  	  begin
  	  	writeln('Insira um ID(1~', limiteCadastro,'): ');
  	  	writeln('');
  	  	writeln('Nome: ');
  		writeln('Sexo:  Masculino   Feminino');
  		writeln('Idade: ');
  		
  		id := lerInteger(22, 1,retorno1);
  		nome := lerString(7,3,retorno1);
  		
  		mudarSeletorHorizontal(7,19,4,12);
  		
  		case linha of
  			7: sexo := 'Masculino';
  			19: sexo := 'Feminino';
  		end;
  		
  		//gotoxy(1,5);
  		
  		idade := lerInteger(8, 5, retorno1);
  	  	writeln('');
  	  	writeln('  Salvar   Cancelar');
  	  	
  	  	mudarSeletorHorizontal(2,11,7,9);  		  
  		
  		case linha of
  			2: salvaDados(id, nome, sexo, idade);
  			11: begin
		 		 clrscr;
		  		 writeln('Se voce sair, vai perder os seus dados.');
		  		 writeln('Tem certeza que deseja sair SEM salvar?');
		  		 writeln('');
		  		 writeln('  SIM   NÃO');
		  		 mudarSeletorHorizontal(2,8,4,6);
		  	      
				 if	(linha = 8) then salvaDados(id, nome, sexo, idade);	  	
  		  	    end;
  		end;
  		
  	  	atual := 1;
  	  end
  	else
  	  begin
  		writeln('CADASTRO CHEIO');
  	  	writeln('');
  	  	writeln(' ', #16, 'OK');
  	  	writeln('');
  	  	readkey;
  	  	atual := 1;
  	  end;
  end;

procedure menu2;
  var linhas, id:integer;
  begin
     clrscr;
  	write('Entre com o ID do cadastro: ');
  	readln(id);
  	writeln('');
  	if (cadastro[id].existe) then
  	  begin
  	  	writeln('Nome: ', cadastro[id].nome);
		writeln('Sexo: ', cadastro[id].sexo);
		writeln('Idade: ', cadastro[id].idade);
		linhas := 7;		
  	  end
  	else
  	  begin
  	  	writeln('CADASTRO INEXISTENTE');
		linhas := 5;	
  	  end;
  	writeln('');
  	writeln('  REFAZER CONSULTA   VOLTAR');
  	
  	mudarSeletorHorizontal(2,21,linhas,19);
  	
  	if (linha = 21) then atual := 1;
  end;

procedure menu3;
  var id, linhas:integer;
  begin
     clrscr;
  	write('Insira o ID do cadastro que deseja remover: ');
  	readln(id);
  	writeln('');
  	if (cadastro[id].existe) then
  	  begin
  	  	linhas := 0;
  	  	writeln('DADOS A SER REMOVIDO:');
  	  	writeln('');
  	  	write('NOME: ');
  	  	writeln(cadastro[id].nome);
  	  	write('SEXO: ');
  	  	writeln(cadastro[id].sexo);
  	  	write('IDADE: ');
  	  	writeln(cadastro[id].idade);
		writeln('');  	  	
  	  	writeln('Tem certeza que deseja remover esse cadastro?');
  	  	writeln('');
  	  	writeln('  NÃO   SIM');
  	  	
  	  	mudarSeletorHorizontal(2,8,11,6);
  	  	gotoxy(1,11);
  	  	
  	  	if (linha = 8) then removeDados(id)
  	  	else
  	  	  begin
  	  	  	clrscr;
  	  	  	writeln('EXCLUÇÃO CANCELADA COM EXITO!!!');
  	  	  	writeln('');
  	  	  	writeln('');
  	  	  	linhas := 1;
  	  	  end;
  	  	
		linhas := linhas + 3;		
  	  end
  	else
  	  begin
  	  	writeln('CADASTRO INEXISTENTE');
  	  	writeln('');
  	  	writeln('');
		linhas := 6;	
  	  end;
  	writeln('  REMOVER OUTRO CADASTRO   VOLTAR');
  	
  	mudarSeletorHorizontal(2,27,linhas,25);
  	
  	if (linha = 27) then atual := 1;
  end;
  
procedure sair;
  begin
  	case menuSair of
  		0: begin
  	
 		 	clrscr;
			writeln('Tem certeza que deseja sair?');
			writeln('');
			writeln('  Nao   Sim');
			writeln('');
			writeln('--------------------------------------------------');
			writeln(#17, ' ', #16, ' - MUDA SELEÇÃO | ENTER - Entrar ');
	
			mudarSeletorHorizontal(2,8,3,6);
	
			case linha of
				2: atual := 1;
				8: saiu := true;
			end;
		   end;
	end;
  	
  end;  
  
  
Begin
atual := 1;

limpaCadastro;

//teste;

repeat

case atual of
	100:testes;
	0: sair;
	1: menu0;
	2: menu1;
	3: menu2;
	4: menu3;
end;

until saiu;
	 	
End.
