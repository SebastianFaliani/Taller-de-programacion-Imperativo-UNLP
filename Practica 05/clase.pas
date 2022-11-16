program practica5eje3;
CONST
	dimF=10;
TYPE
	rangorubro=1..dimF;
	rProducto=record
		cod:integer;
		rubro:rangorubro;
		precio:real;
		stock:integer;
		end;
	arbol=^nodo;
	nodo= record
		dato:rProducto;
		hd:arbol;
		hi:arbol;
		end;
	vProductos= array [rangorubro] of arbol;
	rMaximoProducto=record
		cod:integer;
		stock:integer;
		end;
	vMaximoProductos= array [rangorubro] of rMaximoProducto;


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
	
	PROCEDURE BuscarProducto(vP:vProductos;r:rangorubro;p:integer;var ok:boolean);
		function Buscar(a:arbol;p:integer):boolean;
		begin
			if (a<>nil) then 
				begin
					if(a^.dato.cod = p) then 
						Buscar:=true
					else	
						if(a^.dato.cod < p) then 
							Buscar:=Buscar(a^.hi,p)
					else
						Buscar:=Buscar(a^.hd,p);
				end
			else
				Buscar:=false;
		end;	
	
	BEGIN
		ok:=Buscar(vP[r],p);
	END;
	
	
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

	PROCEDURE ImprimirVectorArbol(var vP:vProductos);
		procedure Imprimir(a:arbol);
		begin
			if a<>nil then begin
				Imprimir(a^.hi);
				writeln('(',a^.dato.rubro,')',a^.dato.cod,'-',a^.dato.stock,'-' ,(a^.dato.precio):2:2);
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
			writeln('Lista [',i,'] Codigo:',vM[i].cod,' Stock:',vM[i].stock);
			readln();
		end;
	END;
	
VAR
	vP:vProductos;
	ok:boolean;
	vM:vMaximoProductos;
BEGIN
	Randomize;
	GenerarEstructura(vP);
	ImprimirVectorArbol(vP);
	BuscarProducto (vP,1,13,ok);
	writeln (ok);
	readln();
	BuscarMaximo(vP,vM);
	ImprimirVector(vM);
END.
