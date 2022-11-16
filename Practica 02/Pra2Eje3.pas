program Pra2Eje3;
type
	lista=^nodo;
	nodo= record 
		dato:integer;
		sig:lista;
		end;
		
	//PUNTO A	
	PROCEDURE CargarLista(var l:lista);
		Procedure ListaNum (var l:lista);
			procedure AgregarAdelante(var l:lista;num:integer);
			var
				aux:lista;
			begin
				new(aux);
				aux^.dato:=num;
				aux^.sig:=l;
				l:=aux;
			end;
		Var
			num:integer;
		Begin
			num:=random(101);
			if (num<>0) then begin
				AgregarAdelante(l,num);
				ListaNum(l);
			end;
		End;
	BEGIN
		l:=nil;
		ListaNum(l);
	END;
	
	

	
	//PUNTO B
	{PROCEDURE NumeroMinimo(l:lista;var min:integer);
		Procedure ListaMin (l:lista; var min:integer);
			procedure Minimo (num:integer;var min:integer);
			begin
				if (num<min) then begin
					min:=num;
				end;
			end;
		
			
		Begin
			if (l<>nil) then begin
				min:=Minimo1 (l^.dato,min);
				ListaMin(l^.sig,min);
			end;
		End;
		
	BEGIN
		min:=999;
		ListaMin(l,min);
	END;}


		function minimo1(l:lista):integer;
		var
			numMin:integer;
		begin
			if l<>nil then begin
				numMin:=minimo1(l^.sig);
				if l^.dato<numMin then
					minimo1:=l^.dato
				else
					minimo1:=numMin
					
			end
			else
				minimo1:=999;
		end;

function minLista(l:lista):integer;
    var aux:integer;
    begin
        if l =nil then 
				minLista:= 999
        else 
        begin 
            aux:=minLista(l^.sig);
				if (aux <l^.dato ) then 
					minLista:=aux
				else 
					minLista := l^.dato
        end
    end;



	//PUNTO C
	PROCEDURE NumeroMaximo (l:lista;var max:integer);
		Procedure ListaMax (l:lista; var max:integer);
			procedure Maximo (num:integer; var max:integer);
			begin
				if (num>max) then begin
				max:= num;
				end;
			end;
		Begin
			if (l<>nil) then begin
				Maximo(l^.dato,max);
				ListaMax(l^.sig,max);
			end;
		End;
	BEGIN
		max:=-1;
		ListaMax(l,max);
	END;
	
	//PUNTO D
	FUNCTION BuscarNumero (l:lista; n:integer):boolean;
	BEGIN
		if (l<>nil) then begin
			if(l^.dato=n) then
				BuscarNumero:=true
			else
				BuscarNumero:=BuscarNumero(l^.sig,n);
			end
		else
			BuscarNumero:=false;
	END;

	PROCEDURE Imprimir (l:lista);
	BEGIN
		while (l<>nil) do	begin
			writeln(l^.dato);
			l:=l^.sig;
		end;
		read();
	END;
	
VAR
	l:lista;
	min:integer;
	max:integer;
BEGIN
	Randomize;
	CargarLista(l);
	Imprimir(l);
	//NumeroMinimo(l,min);
	NumeroMaximo(l,max);
	writeln('Minimo: ', minimo1(l));	
	writeln('Maximo: ', max);
	Writeln(BuscarNumero(l,25));
END.
