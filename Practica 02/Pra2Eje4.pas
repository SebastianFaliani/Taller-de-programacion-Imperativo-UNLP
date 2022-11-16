PROGRAM Pra2Ej4;
Const
	dimF=20;
Type
	indice=0..dimF;
	vector=array[1..dimF] of integer;
	
	//PUNTO A
	PROCEDURE CargarVector(var v:Vector);
		Procedure Leer(var v:Vector; var i:indice);
		Begin
			if (i<dimF) then begin
				i:=i+1;
				v[i]:=random(11);
				Leer(v,i);
			end;
		End;
	VAR
		i:indice;
	BEGIN
		i:=0;
		Leer(v,i);
	END;
	
	//PUNTO B
	FUNCTION Maximo(v:vector;i:indice):integer;
	VAR
		max:integer;
	BEGIN
			if i=1 then
				Maximo:= v[i]
			else begin
				max:= maximo(v,i-1);
				if max>v[i] then
					Maximo:=max
				else
					Maximo:=v[i];
			end;
	END;
	
	FUNCTION Sumar(v:vector;i:indice):integer;
	BEGIN
			if i=1 then
				Sumar:= v[i]
			else 
				sumar:= Sumar(v,i-1)+v[i];
	END;

	PROCEDURE ImprimirVector(v:Vector);
	VAR
		i:integer;
	BEGIN
		for i:=1 to dimF do begin
			writeln('Numero:',v[i]);
		end;
	END;
	
VAR
	v:vector;
BEGIN
	Randomize;
	CargarVector(v);
	ImprimirVector(v);
	writeln(Maximo(v,dimF));
	writeln(Sumar(v,dimF));
END.

