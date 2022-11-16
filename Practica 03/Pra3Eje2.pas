PROGRAM Pra3Eje2;
type
	randia=1..31;
	ranmes=1..12;
	ranAnio=1950..2100;
	rFecha=record
		dia:ranDia;
		mes:ranMes;
		anio:ranAnio;
	end;
	rVenta=record
		cod:integer;
		fechaV:rFecha;
		cantV:integer;
	end;
	rProducto=record
		cod:integer;
		cantV:integer;
	end;
	arbol=^nodo;
	nodo=record
		dato:rVenta;
		HI:arbol;
		HD:arbol;
	end;
	arbolP=^nodoP;
	nodoP=record
		dato:rProducto;
		HI:arbolP;
		HD:arbolP;
	end;
	
	PROCEDURE GenerarArbol(var a:arbol;var aP:arbolP);
		Procedure LeerProducto(var rV:rVenta; var rP:rProducto);
			Procedure LeerFecha(var rF:rFecha);
			Begin
				write('	Dia: ');readln(rF.dia);
				write('	Mes: ');readln(rF.mes);
				write('	Anio: ');readln(rF.anio);
			End;
		Begin
			write('Ingrese el codigo del producto: ');readln(rV.cod);
			if rV.cod<>0 then begin
				writeln('Ingrese la fecha de Venta');
				LeerFecha(rV.fechaV);
				write('Ingrese el codigo del Cantidad: ');readln(rV.cantV);
				rP.cod:=rV.cod;
				rP.cantV:=rV.cantV;
			end;
		End;
		Procedure AgregarVentas(var a:arbol; rV:rVenta);
		Begin
			if a=nil then begin
				new(a);
				a^.dato:=rV;
				a^.HI:=nil;
				a^.HD:=nil;
			end
			else
				if rv.cod>=a^.dato.cod then
					AgregarVentas(a^.HD,rV)
				else
					AgregarVentas(a^.HI,rV);
		End;
		
		Procedure AgregarProductos(var a:arbolP; rP:rProducto);
		Begin
			if a=nil then begin
				new(a);
				a^.dato:=rP;
				a^.HI:=nil;
				a^.HD:=nil;
			end
			else
				if rP.cod=a^.dato.cod then
					a^.dato.cantV:=a^.dato.cantV+rP.cantV
				else if rP.cod>a^.dato.cod then
					AgregarProductos(a^.HD,rP)
				else
					AgregarProductos(a^.HI,rP);
		end;
		
	VAR
		rV:rVenta;
		rP:rProducto;
	BEGIN
		a:=nil;
		aP:=nil;
		LeerProducto(rV,rP);
		while rV.cod<>0 do begin
			AgregarVentas(a,rV);
			AgregarProductos(aP,rP);
			LeerProducto(rV,rP);
		end;
	END;
	
	Function BuscarI(a:arbol;elem:integer):integer;
	Begin
		if a=nil then BuscarI:=0
		else if (elem=a^.dato.cod) then
			BuscarI:=BuscarI(a^.HD,elem)+a^.dato.cantV
		else if (elem<a^.dato.cod) then
			BuscarI:=BuscarI(a^.HI,elem)
		else if (elem>a^.dato.cod) then
			BuscarI:=BuscarI(a^.HD,elem)
	end;

	Function BuscarII(a:arbol;elem:integer):integer;
	Begin
		if a=nil then BuscarII:=0
		else if (elem=a^.dato.cod) then
			BuscarII:=a^.dato.cantV
		else if (elem<a^.dato.cod) then
			BuscarII:=BuscarII(a^.HI,elem)
		else 
			BuscarII:=BuscarII(a^.HD,elem)
	end;

	//****IMPRIMIR
	PROCEDURE Informar(a:arbol);
	BEGIN
		if (a<>nil) then begin
			writeln(a^.dato.cod, ' - ', a^.dato.cantV);
			Informar(a^.hi);
			Informar(a^.hd);
		end;
	END;
	
	//****IMPRIMIR
	PROCEDURE Imprimir(a:arbolP);
	BEGIN
		if (a<>nil) then begin
			Imprimir(a^.hi);
			writeln(a^.dato.cod, ' - ', a^.dato.cantV);
			Imprimir(a^.hd);
		end;
	END;

VAR
	a:arbol;
	aP:arbolP;
BEGIN
	GenerarArbol(a,aP);
	writeln(BuscarI(a,10));
	writeln(BuscarI(a,10));
	//Informar(a);
	//Imprimir(aP);
END.
