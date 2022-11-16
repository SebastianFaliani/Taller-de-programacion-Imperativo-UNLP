Program ImperativoPra1Eje2;
Const
	dimF=300;
Type
	ranDimL=0..dimF;
	rOficina=record
		cod:integer;
		dni:longint;
		valor:real;
	end;
	vOficinas=array [1..dimF] of rOficina;
	
	
	//PUNTO A
	Procedure CargarVector(var vO:vOficinas; var dimL:ranDimL);
		Procedure LeerOficina(var rO:rOficina);
		Begin
			rO.cod:=random(300);writeln('Codigo: ',rO.cod);
			if rO.cod<>0 then begin
				rO.dni:=random(32001);writeln('DNI: ',rO.dni);
				rO.valor:=random(101)/1.14;writeln('Valor: ',(rO.valor):2:2);
			end;
		End;
		Procedure Agregar(var vO:vOficinas; var dimL:ranDimL; var ok:boolean; rO:rOficina);
		begin
			ok:=false;
			if (dimL<dimF) then begin
				dimL:=dimL+1;
				vO[dimL]:=rO;
				ok:=true;
			end;
		end;
	
	VAR
		rO:rOficina;
		ok:boolean;
	BEGIN
		dimL:=0;
		LeerOficina(rO);
		while (dimL<dimF) and (rO.cod<>0) do begin
			Agregar(vO,dimL,ok,rO);
			LeerOficina(rO);
		end;
	END;
	
	//PUNTO B
	Procedure OrdenarInsersion(var vO:vOficinas; dimL:ranDimL);
	VAR
		i,j:ranDimL;
		aux:rOficina;
	BEGIN
		for i:=2 to dimL do begin
			aux:=vO[i];
			j:=i-1;
			while (j>0) and (vO[j].cod>aux.cod) do begin
				vO[j+1]:=vO[j];
				j:=j-1;
			end;
			vO[j+1]:=aux;
		end;
	END;

	//PUNTO C
	Procedure OrdenarSeleccion(var vO:vOficinas; dimL:ranDimL);
	VAR
		i,j,p:ranDimL;
		aux:rOficina;
	BEGIN
		for i:=1 to dimL-1 do begin
			p:=i;
			for j:=i+1 to dimL do
				if vO[j].cod<vO[p].cod then
					p:=j;
			aux:=vO[i];
			vO[i]:=vO[p];
			vO[p]:=aux;
		end;
	END;
	
	Procedure ImprimirVector(vO:vOficinas; dimL:ranDimL);
	VAR
		i:integer;
	BEGIN
		for i:=1 to dimL do begin
			writeln('Codigo:',vO[i].cod);
		end;
	END;

VAR
	vO:vOficinas;
	dimL:ranDimL;
BEGIN
	randomize;
	CargarVector(vO,dimL);
	//OrdenarInsersion(vO,dimL);
	
	OrdenarSeleccion(vO,dimL);
	ImprimirVector(vO,dimL);
	readln();

END.

