PROGRAM PracticaARBOL;
type
	arbol=^nodo;
	nodo=record
		dato:integer;
		hi:arbol;
		hd:arbol;
	end;
	
	PROCEDURE CrearArbol(var a:arbol);
		Procedure Cargar(var a:arbol;num:integer);
		Begin
			if (a=nil)then begin
				new(a);	
				a^.dato:=num;
				a^.hi:=nil;
				a^.hd:=nil;
			end
			else
			begin	
				if (num<a^.dato) then
					Cargar(a^.hi,num)
				else
					Cargar(a^.hd,num);
			end;
		End;
	VAR
		num:integer;
	BEGIN
		a:=nil;
		write('Ingrese un Numero: ');readln(num);
		while num<>0 do begin
			Cargar(a,num);
			write('Ingrese un Numero: ');readln(num);
		end;
	END;
	
	PROCEDURE Imprimir(a:arbol);
	BEGIN
		if (a<>nil) then begin
			Imprimir(a^.hi);
			writeln(a^.dato);
			Imprimir(a^.hd);
			
		end;
	END;
	
	PROCEDURE Sumar(a:arbol;var sum:integer);
	BEGIN
		if (a<>nil) then begin
			Sumar(a^.hi,sum);
			sum:=sum+(a^.dato);
			Sumar(a^.hd,sum);
		end;
		
	END;

	FUNCTION Suma(a:arbol):integer;
	BEGIN
		if (a<>nil) then 
			Suma:=(Suma(a^.hi)+Suma(a^.hd)+a^.dato)
		else
		suma:=0;
	END;
	
	
	
	
VAR
	a:arbol;
	
		sum:integer;
BEGIN
	sum:=0;
	CrearArbol(a);
	//Imprimir(a);
	Sumar(a,sum);
	writeln(sum);
	writeln(Suma(a));
END.
