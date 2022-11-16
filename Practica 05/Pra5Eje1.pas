PROGRAM Pra5Eje1;
CONST
	dimF=300;
TYPE
	ranVector=1..dimF;
	rOficina=record
		cod:integer;
		dni:integer;
		valor:real;
	end;
	Vector=array[ranVector] of rOficina;
	
	Procedure GenerarVector(var v:Vector; var dimL:integer);
		Procedure LeerOficina(var rO:rOficina);
		Begin
			rO.cod:=random(101);
			if rO.cod<>0 then begin
				rO.dni:=random(32000);
				rO.valor:=random(5000)/13;
			end;
		End;
		
		procedure Agregar(var v:vector; var dimL:integer; rO:rOficina);
		begin
			if diml<DimF then begin
				dimL:=dimL+1;
				v[diml]:=rO;
			end;
		end;
	var
		rO:rOficina;
	begin
		dimL:=0;
		LeerOficina(rO);
		while rO.cod<>0 do begin
			Agregar(v,dimL,rO);
			LeerOficina(rO);	
		end;
	end;
	
	Procedure OrdenarInsercion(var v:Vector;dimL:integer);
	var
		i,j:integer;
		act:rOficina;
	Begin
		for i:=2 to dimL do begin
			act:=v[i];
			j:=i-1;
			while ((j>0) and (v[j].cod>act.cod)) do begin
				v[j+1]:=v[j];
				j:=j-1;
			end;
			v[j+1]:=act;
		end;
	End;
	
	Procedure Busqueda(v:vector; fin,cod:integer);
		function BusquedaDicotomica(v:vector; fin,cod:integer):integer;
		var
			ini,medio:integer;
		begin
			ini:=1;
			medio:=(ini+fin) div 2;
			while (ini<fin) and (cod<>v[medio].cod) do begin
				if cod>v[medio].cod then
					ini:=medio+1
				else
					fin:=medio-1;
				medio:=(ini+fin) div 2;
			end;
			if cod=v[medio].cod then
				BusquedaDicotomica:=v[medio].dni
			else
				BusquedaDicotomica:=-1
		end;
	var
	res:integer;
	begin
		res:=BusquedaDicotomica(v,fin,cod);
			if res<>-1 then
				writeln('DNI Propietario: ', res)
			else
				writeln('El codigo no exite');
	end;
	
	Procedure ImprimirVector(v:vector;dimL:integer);
	var
		i:integer;
	Begin
		for i:=1 to dimL do
			writeln(v[i].cod,' ',v[i].dni,' ',(v[i].valor):2:2);
	end;

VAR
	v:vector;
	dimL:integer;
BEGIN
	randomize;
	GenerarVector(v,dimL);
	OrdenarInsercion(v,dimL);
	ImprimirVector(v,dimL);
	Busqueda(v,dimL,15);
END.
