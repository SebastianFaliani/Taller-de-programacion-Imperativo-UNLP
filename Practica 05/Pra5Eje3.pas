program practica5eje3;
CONST
	dimF=10;
TYPE
	ranRubro=1..dimF;
	rProducto=record
		cod:integer;
		rubro:ranRubro;
		precio:real;
		stock:integer;
		end;
	arbol=^nodo;
	nodo= record
		dato:rProducto;
		hd:arbol;
		hi:arbol;
		end;
	vProductos= array [ranRubro] of arbol;
	rMaximoProducto=record
		cod:integer;
		stock:integer;
		end;
	vMaximoProductos= array [ranRubro] of rMaximoProducto;
	vCantidadProductos= array [ranRubro] of integer;

	//Punto A
	PROCEDURE GenerarEstructura (var vP:vProductos);
		procedure InicializarVector (var vP:vProductos);
		var
			i:integer;
		begin
			for i:= 1 to dimF do
				vP[i]:=nil;
		end;
		
		procedure LeerProducto (var rP:rProducto);
		begin
			rP.cod:=random(101);
			if (rP.cod<>0) then begin
				rP.rubro:=random(10) + 1;
				rP.precio:=random(1200)/13;
				rP.stock:=random(51) + 1;
			end;
		end;

		procedure CargarProducto (var a:arbol;rP:rProducto);
		begin
			if(a=nil) then begin
				new (a);
				a^.dato:=rP;
				a^.hi:=nil;
				a^.hd:=nil;
				end
			else begin
				if(a^.dato.cod >rP.cod) then 
					CargarProducto(a^.hi,rP)
				else
					CargarProducto(a^.hd,rP)
				end;
		end;
	VAR
		rP:rProducto;
	BEGIN
		InicializarVector(vP);
		LeerProducto(rP);
		while (rP.cod<>0) do
		begin
			CargarProducto(vP[rP.rubro],rP);
			LeerProducto(rP);
		end;
	END;

	//Punto B
	FUNCTION BuscarProducto(vP:vProductos;rubro:ranRubro;elem:integer):boolean;
		function Buscar(a:arbol;elem:integer):boolean;
		begin
			if (a<>nil) then 
				begin
					if(a^.dato.cod = elem) then 
						Buscar:=true
					else	
						if(a^.dato.cod < elem) then 
							Buscar:=Buscar(a^.hi,elem)
					else
						Buscar:=Buscar(a^.hd,elem);
				end
			else
				Buscar:=false;
		end;	
	BEGIN
		BuscarProducto:=Buscar(vP[rubro],elem);
	END;
	
	//Punto C
	PROCEDURE BuscarMaximo(vP:vProductos; var vM:vMaximoProductos);
		Procedure MasGrande(a:arbol; var rM:rMaximoProducto);
		Begin
			if a<>nil then begin
				if a^.hd=nil then begin
					rM.cod:=a^.dato.cod;
					rM.stock:=a^.dato.stock;
				end
				else
					MasGrande(a^.hd,rM);
			end	
			else
				rM.cod:=-1;	
		End;
	VAR
		i:integer;
		rM:rMaximoProducto;
	BEGIN
		for i:=1 to dimF do begin
			MasGrande(vP[i],rM);
			vM[i]:=rM;
		end;
	END;

	//Punto D
	PROCEDURE ProductosEntreDosValore(vP:vProductos; cod1,cod2:integer; var vC:vCantidadProductos);
		Function   Cantidad(a:arbol):integer;
		Begin
			if a<>nil then begin
				if a^.hd=nil then begin
					rM.cod:=a^.dato.cod;
					rM.stock:=a^.dato.stock;
				end
				else
					MasGrande(a^.hd,rM);
			end	
			else
				rM.cod:=-1;	
		End;
	VAR
		i:integer;
	BEGIN
		for i:=1 to dimF do
			vC[i]:=Cantidad(vP[i]);
	END;

	/// ***** MODULOS PARA IMPRIMIR ***** \\\
		
		PROCEDURE ImprimirVectorArbol(var vP:vProductos);
			procedure Imprimir(a:arbol);
			begin
				if a<>nil then begin
					Imprimir(a^.hi);
					writeln('[',a^.dato.rubro,'] ',a^.dato.cod,'-',a^.dato.stock,'-' ,(a^.dato.precio):2:2);
					Imprimir(a^.hd);
				end;
			end;
		VAR
			i:integer;
		BEGIN
			for i:=1 to dimF do begin
				if vP[i]<> nil then
					Imprimir(vP[i])
				else
					writeln('Lista Vacia [',i,']');
				readln();
			end;
		END;

		PROCEDURE ImprimirVector(var vM:vMaximoProductos);
		VAR
			i:integer;
		BEGIN
			for i:=1 to dimF do begin
				writeln('[',i,'] Codigo:',vM[i].cod,' Stock:',vM[i].stock);
				readln();
			end;
		END;
	
	/// ********************************* \\\
VAR
	vP:vProductos;
	vM:vMaximoProductos;
	vC:vCantidadProductos;
BEGIN
	Randomize;
	GenerarEstructura(vP);
	ImprimirVectorArbol(vP);
	writeln(BuscarProducto(vP,1,13));
	readln();
	BuscarMaximo(vP,vM);
	ImprimirVector(vM);
	ProductosEntreDosValore(vP,25,35,vC);
END.
