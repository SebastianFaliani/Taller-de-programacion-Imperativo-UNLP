Program ImperativoPra1Eje4;
CONST
	dimF=8;
	dimFRubro3=30;
TYPE
	ranRubro=1..dimF;
	ranRubro3=1..dimFrubro3;
	rProducto=record
		cod:integer;
		rubro:ranRubro;
		precio:real;
	end;
	lista=^nodo;
	nodo=record
		dato:rProducto;
		sig:lista;
	end;
	vProductos=array[ranRubro] of lista;
	vRubro3=array[ranRubro3] of rProducto;
	
	//PUNTO A
	Procedure CargarProductos(var vP:vProductos);
		Procedure IniciarVectorListas(var vP:vProductos);
		Var
			i:ranRubro;
		Begin
			for i:=1 to dimF do
				vP[i]:=nil;
		End;
		Procedure LeerProducto(var rP:rProducto);
		Begin
			write('Precio: ');readln(rP.precio);
			if rP.precio<>0 then begin
				write('codigo: ');readln(rP.cod);
				write('Rubro [1..8]: ');readln(rP.rubro);
			end;
		End;
		Procedure AgregarOrdenado(var l:lista; rP:rProducto);
		Var
			ant,act,aux:lista;
		Begin
			new(aux);
			aux^.dato:=rP;
			act:=l;
			while (act<>nil) and (rP.cod>act^.dato.cod) do begin
				ant:=act;
				act:=act^.sig;
			end;
			if (act=l) then
				l:=aux
			else
				ant^.sig:=aux;
			aux^.sig:=act;
		End;
		
	VAR 
		rP:rProducto;
	BEGIN
		IniciarVectorListas(vP);
		LeerProducto(rP);
		while rP.precio<>0 do begin
			AgregarOrdenado(vP[rP.rubro],rP);
			LeerProducto(rP);
		end;
	END;
	
	//PUNTO B
	Procedure ImprimirVectorDeListas(vM:vProductos);
	VAR
		i:ranRubro;
	BEGIN
		for i:=1 to dimF do begin
			while vM[i]<>nil do begin
				writeln('Codigo:',vM[i]^.dato.cod);
				vM[i]:=vM[i]^.sig;
			end;
		end;
	END;
	
	//PUNTO C
	Procedure CargarProductosRubro3(var vR:vRubro3; var dimL:integer; vP:vProductos);
		Procedure AgregarProducto(var vR:vRubro3; var dimL:integer; rP:rProducto);
		Begin
			if (dimL>=0) and (dimL<DimFRubro3) then begin
				dimL:=dimL+1;
				vR[dimL]:=rP;
			end;
		End;

	BEGIN
		dimL:=0;
		while (vP[3]<>nil) and (dimL<30) do begin
			AgregarProducto(vR,dimL, vP[3]^.dato);
			vP[3]:=vP[3]^.sig;
		end;
	END;

	//PUNTO D
	Procedure OrdenarInsersion (var vR:vRubro3; dimL:integer );
	VAR 
		i,j:integer;
		actual:rProducto;	
	 BEGIN
		for i:=2 to dimL do begin 
			actual:= vR[i];
			j:= i-1; 
			while (j>0) and (vR[j].precio>actual.precio) do Begin
				vR[j+1]:= vR[j];
				j:=j-1;                  
			end;  
			vR[j+1]:= actual; 
		end;
	END;
	
	//PUNTO E
	Procedure ImprimirVectorOrdenado(vR:vRubro3; dimL:integer);
	VAR
		i:integer;
	BEGIN
		for i:=1 to dimL do begin
			writeln('Codigo:',vR[i].precio);
		end;
	END;

VAR
	vP:vProductos;
	vR:vRubro3;
	dimL:integer;
BEGIN
	CargarProductos(vP);
	ImprimirVectorDeListas(vP);
	CargarProductosRubro3(vR,dimL,vP);
END.

