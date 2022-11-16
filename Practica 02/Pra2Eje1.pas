PROGRAM Pra2Eje1;
CONST
	dimF=10;
TYPE
	vector=array[1..dimF] of char;
	lista=^nodo;
	nodo=record
		dato:char;
		sig:lista;
	end;
	
	//PUNTO A
	procedure LeerSecuenciaVector (var v:vector;var dimL:integer);
		Procedure Leer(var v:vector;var dimL:integer);
		var
			car:char;
		Begin
			write('Ingrese un caracter: ');readln(car);
			if (dimL<dimF) and (car<>'.') then begin
				dimL:=dimL+1;
				v[dimL]:=car;
				Leer(v,dimL);
			end;
		end;
	
	BEGIN
		dimL:=0;
		Leer(v,dimL);
	END;
	
	//PUNTO B
	Procedure ImprimirVector(v:vector; dimL:integer);
	VAR
		i:integer;
	BEGIN
		for i:=1 to dimL do begin
			writeln('Caracter:',v[i]);
		end;
	END;
	
	//PUNTO C
	Procedure ImprimirVectorRecursiva(v:vector; dimL:integer);
	BEGIN
		if (dimL>0) then begin
			writeln('Caracter:',v[dimL]);
			dimL:=dimL-1;
			ImprimirVectorRecursiva(v,dimL);
		end;
	END;
	
	//PUNTO D
	function Leer():integer;
	VAR
		car:char;
	BEGIN
		write('Ingrese un caracter: ');readln(car);
		if (car<>'.') then 
			Leer:=Leer()+1
		else
			Leer:=0;
	END;
	
	//PUNTO E
	procedure LeerSecuenciaLista (var l:lista);
		Procedure Leer(var l:lista);
		var
			car:char;
			aux:lista;
		Begin
			write('Ingrese un caracter: ');readln(car);
			if (car<>'.') then begin
				new(aux);
				aux^.dato:=car;
				aux^.sig:=l;
				l:=aux;
				Leer(l);
			end;
		end;
	
	BEGIN
		l:=nil;
		Leer(l);
	END;
	
	//PUNTO F
	Procedure ImprimirLista(l:lista);
	
	BEGIN
		if (l<>nil) then begin
			writeln('Caracter:',l^.dato);
			ImprimirLista(l^.sig);
		end;
	END;
	
	//PUNTO F
	Procedure ImprimirListaInverso(l:lista);
	BEGIN
	
		if (l<>nil) then begin
			ImprimirListaInverso(l^.sig);
			writeln('Caracter:',l^.dato);		
		end;
	
	END;

	
VAR
	v:vector;
	dimL:integer;
	
	l:lista;
BEGIN
	LeerSecuenciaVector(v,dimL);
	ImprimirVector(v,dimL);
	readln();
	ImprimirVectorRecursiva(v,dimL);
	writeln(Leer());
	LeerSecuenciaLista(l);
	ImprimirLista(l);
	writeln('');
	ImprimirListaInverso(l);
END.

