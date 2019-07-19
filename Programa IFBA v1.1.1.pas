//By Yure Pablo em 03/02/2016
//Programa construído para calcular a média por unidade e anual do primeiro ano no IFBA
//Mostra um ranking de melhores médias, percentual de queda e quanto precisa para passar

Program CalcularMedia ;
var  f,q,unidade,colun,disciplina:integer; 
	 NotaUnidade:array[1..12,1..4] of real; nome,Topnome:array[1..12] of string; 
     P,media,Peso,queda,Top12:array[1..12] of real; 
	 mediageral,porcent,maior,menor,mediageralq,aux,auxi,auxili:real;
     auxnome:string;
  Begin
	nome[1]:='Português'; nome[2]:='Matemática'; nome[3]:='História'; nome[4]:='Lógica de Programação'; 
	nome[5]:='Física'; nome[6]:='Informática'; nome[7]:= 'Artes'; nome[8]:='Educação Física'; 
	nome[9]:='Filosofia'; nome[10]:='Sociologia'; nome[11]:='Química'; nome[12]:='Desenho Técnico';
	for disciplina:=1 to 12 do
		P[disciplina]:=24; //Soma de pontos para passar de ano
	disciplina:=1;
	while (colun>4) or (colun<1) do
	begin
		Writeln('Informe o número de unidades que quer saber a nota: ');
		readln(colun);
		clrscr;
	end;
	for unidade:=1 to colun do
	begin
		writeln('Informe as médias da ',unidade,' Unidade: ');
		for disciplina:=1 to 12 do
		begin
			write(nome[disciplina],': ');
			read(NotaUnidade[disciplina,unidade]); 
			while (NotaUnidade[disciplina,unidade]<0) or (NotaUnidade[disciplina,unidade]>10) do
			begin
				writeln('VALOR INVÁLIDO. DIGITE NOVAMENTE.');
				write(nome[disciplina],': ');
				read(NotaUnidade[disciplina,unidade]);
			end;
			TOP12[disciplina]:=NotaUnidade[disciplina,unidade]+TOP12[disciplina];
			media[unidade]:=NotaUnidade[disciplina,unidade]+media[unidade];
			P[disciplina]:=(P[disciplina]-NotaUnidade[disciplina,unidade]);
			if unidade<4 then
				Peso[disciplina]:=P[disciplina]/(4-unidade);
		end;
		media[unidade]:=media[unidade]/12;
		mediageral:=media[unidade]+mediageral;
		porcent:=media[unidade]*10;
		clrscr;
    	Writeln('Sua média da ',unidade,' Unidade é ',media[unidade]:4:2,', ',porcent:4:2,' por cento.');
		Writeln('Quer saber se está passado ou quanto precisa nas unidades restantes?');
		Writeln('Digite 1 para sim ou 2 para não');
		readln(q);
		case q of
    		1: begin
			   for disciplina:=1 to 12 do
			   		if Peso[disciplina]<0 then 
    					Writeln('Você tem até mais em ',Nome[disciplina],', distribui aí pra quem tá precisando!')
  					else if Peso[disciplina]=0 then
    					Writeln('Conseguiu a meta em ',Nome[disciplina],' !')
					else if ((unidade=2) and (P[disciplina]>20)) or ((unidade=3) and (P[disciplina]>10)) or ((unidade=4) and (P[disciplina]>0)) then
	 					Writeln('XII! Vai pro conselho em ',Nome[disciplina],' !')
					else if Peso[disciplina]>0 then
						Writeln('Você precisa de ',Peso[disciplina]:4:2,' em cada unidade restante em ',nome[disciplina]);
			    readkey;
				clrscr;
			    end;
		end;
		Writeln('Quer ver o Top 12 das disciplinas?');
		Writeln('Digite 1 para sim ou 2 para não');
		readln(q);
		case q of
			1: begin
				for disciplina:=1 to 11 do
					for f:=disciplina+1 to 12 do
		  				if NotaUnidade[f,unidade]>NotaUnidade[disciplina,unidade] then
		    			begin
		      				aux:=NotaUnidade[disciplina,unidade]; auxnome:=Nome[disciplina];
							NotaUnidade[disciplina,unidade]:=NotaUnidade[f,unidade]; Nome[disciplina]:=Nome[f];
							NotaUnidade[f,unidade]:=aux; Nome[f]:=auxnome; 
							auxi:=P[disciplina]; 
							P[disciplina]:=P[f]; 
							P[f]:=auxi; 
							auxili:=Top12[disciplina]; 
							Top12[disciplina]:=Top12[f];
							Top12[f]:=auxili;
		    			end;    
				Writeln('------TOP 12-----');
				for disciplina:=1 to 12 do
					Writeln(disciplina,' - ',Nome[disciplina],': ',NotaUnidade[disciplina,unidade]);
				readkey;
				clrscr;
				end;
		end;
  		clrscr;
    end;
  	if colun>1 then
  		While q<>3 do
  		begin
			Writeln('1 - Top 12 Geral');
			Writeln('2 - Retrospectiva');
			Writeln('3 - Sair');
			Write('Digite: ');
			readln(q);
  			case q of 
  				1: begin
      				for disciplina:=1 to 11 do
		    			for f:=disciplina+1 to 12 do
		      				if Top12[f]>Top12[disciplina] then
		        			begin
								aux:=Top12[disciplina]; auxnome:=Nome[disciplina];
								Top12[disciplina]:=Top12[f]; Nome[disciplina]:=Nome[f];
								Top12[f]:=aux; Nome[f]:=auxnome; 
		        			end;    
		 			for disciplina:=1 to 12 do
			   			Writeln(disciplina,' - ',Nome[disciplina],': ',Top12[disciplina]/colun);
					readkey;
	 				clrscr;
					end;  
				2: begin
					for unidade:=1 to 3 do
						queda[unidade]:=(media[unidade]*10)-(media[unidade+1]*10);
					for unidade:=1 to colun do
					begin
						writeln('Media ',unidade,': ',media[unidade]:4:2,'  ');
						if unidade=1 then
							Writeln('Queda da I para a II unidade: ',queda[1]:4:2,' por cento.');
						if unidade=3 then
	 					begin
	 						Writeln('Queda da II para a III unidade: ',queda[2]:4:2,' por cento.');
	 						mediageralq:=queda[1]+queda[2];
	 						Writeln('Média geral de queda: ',mediageralq:4:2,' por cento.');
	 					end;
	 					if unidade>3 then
	   					begin
							Writeln('Queda da III para a IV unidade: ',queda[3]:4:2,' por cento.');
	    					mediageralq:=mediageralq+queda[3];
							Writeln('Média geral de queda: ',mediageralq:4:2,' por cento.');
						end;
					end;
					Writeln('Sua média geral é ',(mediageral/colun):4:2);
					readkey;
  					clrscr;
					end;
			end;
    	end; 
End.