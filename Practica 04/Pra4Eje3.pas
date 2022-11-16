PROGRAM Pra4Eje3;
Const
	dimF=4;
type
	ranDias=1..31;
	ranMes=1..12;
	ranAnio=2000..2022;
	ranSucursal=1..4;
	rFecha=record
		dia:ranDias;
		mes:ranMes;
		anio:ranAnio;
	end;
	rProducto=record
		fecha:rFecha;
		codP:integer;
		codS:ranSucursal;
		cant:integer;
	end;
	rTotalVendido=record
		codP:integer;
		total:integer;
	end;
	lista=^nodo;
	nodo=record
		dato:rProducto;
		sig:lista;
	end;
	lTotal=^nodo1;
	nodo1=record
		dato:rTotalVendido;
		sig:lTotal;
	end;
	vVentas=array[ranSucursal]of lista;

	Procedure CargarVentas(var vV:vVentas);
		Procedure IniciarLista(var vV:vVentas);
		var
			i:integer;
		Begin
			for i:=1 to dimF do
				vV[i]:=nil;
		end;
		
		Procedure LeerProducto(var rP:rProducto);
			Procedure LeerFecha(var rF:rFecha);
			Begin
				rF.dia:=random(31)+1;
				rF.mes:=random(12)+1;
				rF.anio:=random(21)+2001;
			End;

		begin
			rP.codP:=random(51);
			if rP.codP<>0 then begin
				LeerFecha(rP.fecha);
				rP.codS:=random(4)+1;
				rP.cant:=random(10)+1;
			end;
		end;
	
		Procedure AgregarOrdenado(var l:lista; rP:rProducto);
		var
			ant,act,aux:lista;
		begin
			new(aux);
			aux^.dato:=rP;
			act:=l;
			while (act<>nil) and (rP.codP>act^.dato.codP) do begin
				ant:=act;
				act:=act^.sig;
			end;
			if act=l then
				l:=aux
			else
				ant^.sig:=aux;
			aux^.sig:=act;
		end;
   
  	var
		rP:rProducto;
	Begin
		IniciarLista(vV);
		LeerProducto(rP);
		while (rP.codP<>0) do begin
			AgregarOrdenado(vV[rP.codS],rP);
			LeerProducto(rP);
		end;
	End;
	
	Procedure TotalPorCodigo(vV:vVentas; var l:lTotal);
		Procedure Minimo(var vV:vVentas; var codMin,cant:integer);
		var
			i,indice:integer;
		Begin
			codMin:=999;
			For i:=1 to dimF do begin
				if vV[i]<>nil then
					if vV[i]^.dato.codP<=codMin then begin
						codMin:=vV[i]^.dato.codP;
						indice:=i;
					end;
			end;

			if codMin<>999 then begin
				cant:=vV[indice]^.dato.cant;
				vV[indice]:=vV[indice]^.sig;
				end;
		end;
		Procedure AgregarAtras(var l,ult:lTotal;rT:rTotalVendido);
		var
			aux:lTotal;
		begin
			new(aux);
			aux^.dato:=rT;
			aux^.sig:=nil;
			if (l=nil) then
				l:=aux
			else
				ult^.sig:=aux;
			ult:=aux;
		end;
	Var
		rT:rTotalVendido;
		ult:lTotal;
		codPActual:integer;
		codMin,cant,total:integer;
		
	Begin
		l:=nil;
		minimo(vV,codMin,cant);
		while(codMin<>999) do begin
			codPActual:=codMin;
			total:=0;
			while(codMin<>999) and (codPActual=codMin) do begin
				total:=total+cant;
				minimo(vV,codMin,cant);
			end;
			rT.codP:=codPActual;
			rT.total:=total;
			AgregarAtras(l,ult,rT);
			
		end;
	End;
	

	
	procedure Imprimir(l:lista);
	begin
		while l<>nil do begin
			writeln(l^.dato.fecha.dia,'/',l^.dato.fecha.mes,'/',l^.dato.fecha.anio,'-',l^.dato.codP,'-' ,l^.dato.codS,'-' ,l^.dato.cant);
			
			l:=l^.sig;
		end;
	end;
	
	procedure Imprimirvector(var vV:vVentas);
	var
		i:integer;
	begin
		for i:=1 to dimF do begin
			if vV[i]<> nil then
				Imprimir(vV[i])
			else
				writeln('Lista Vacia para el Sucursal[',i,']');
			readln();
		end;
	end;
	procedure Imprimir2(l:lTotal);
	begin
		while l<>nil do begin
			writeln(l^.dato.codP,'-' ,l^.dato.total);
			
			l:=l^.sig;
		end;
	end;
	
	
VAR
	vV:vVentas;
	l:lTotal;
BEGIN
	Randomize;
	CargarVentas(vV);
	Imprimirvector(vV);
	TotalPorCodigo(vV, l);
	Imprimir2(l);
END.

