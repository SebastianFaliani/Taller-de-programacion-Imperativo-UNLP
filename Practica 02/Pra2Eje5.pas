PROGRAM Pra2Ej5;
Const
	dimF=20;
Type
	indice=-1..dimF;
	vector=array[1..dimF] of integer;
	
	PROCEDURE CargarVector(var v:vector);
	VAR
		i:integer;
	BEGIN
		for i:=1 to dimF do
			v[i]:=i*3;
	END;
	
	
	PROCEDURE BusquedaDicotomica (v:vector; ini,fin:indice; dato:integer; var pos:indice); 
	VAR
		medio:indice;
	BEGIN
		medio:=(ini+fin)div 2;
		if (ini<=fin) and (dato<>v[medio]) then begin
			if dato<v[medio] then
				fin:=medio-1
			else
				ini:=medio+1;
			medio:=(ini+fin)div 2;
			BusquedaDicotomica(v,ini,fin,dato,pos);
		end
		else
			pos:=-1;
		if (ini<=fin) and (dato=v[medio]) then
			pos:=medio
		
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
	ini,fin,pos:indice;
	dato:integer;
BEGIN
	CargarVector(v);
	ImprimirVector(v);
	ini:=1;
	fin:=dimF;
	write('Ingrese un numero a buscar: ');Readln(dato);
	BusquedaDicotomica (v,ini,fin,dato,pos);
	writeln(pos);
END.
