{Una agencia dedicada a la venta de autos ha organizado su stock y, dispone en papel de la información de los autos en venta.
Implementar un programa que:
a)	Genere un árbol binario de búsqueda ordenado por patente identificatoria del auto en venta.
*  Cada nodo del árbol debe contener patente, año de fabricación (2010..2018), la marca y el modelo.
b)	Invoque a un módulo que reciba el árbol generado en a) y una marca y retorne la cantidad de autos de dicha marca que posee la agencia. Mostrar el resultado. 
c)	Invoque a un módulo que reciba el árbol generado en a) y retorne una estructura con la información de los autos agrupados por año de fabricación.
d)	Contenga un módulo que reciba el árbol generado en a) y una patente y devuelva el año de fabricación del auto con dicha patente. Mostrar el resultado. 
}

PROGRAM Pra5Eje2;
const
	dimF=2018;
TYPE
	ranAnio=2010..2018;
	rAuto=record
		patente:integer;
		anio:ranAnio;
		marca:integer;
		modelo:integer;
	end;
	arbol=^nodo;
	nodo=record
		dato:rAuto;
		hi:arbol;
		hd:arbol;
	end;
	
	lista=^nodo2;
	nodo2=record
		dato:rAuto;
		sig:lista;
	end;
	
	vAutosPorAnio=array[ranAnio] of lista;
	
	//A
	PROCEDURE CargarAutos(var a:arbol);
		Procedure LeerAuto(var rA:rAuto);
		Begin
			rA.patente:=random(25);writeln('Patente: ',rA.patente); 
			if rA.patente<>0 then begin
				rA.anio:=random(9)+2010;writeln('Anio: ',rA.anio); 
				rA.marca:=random(10)+1;writeln('Marca: ',rA.marca);
				rA.modelo:=random(15)+1;writeln('Modelo: ',rA.modelo); 
			end;
		End;
		Procedure AgregarArbol(var a:arbol; rA:rAuto);
		Begin
			if a=nil then begin
				new(a);
				a^.dato:=rA;
				a^.hi:=nil;
				a^.hd:=nil;
			end
			else
				if (rA.patente<a^.dato.patente) then
					AgregarArbol(a^.hi,rA)
				else
					AgregarArbol(a^.hd,rA);
		End;
		
		
	VAR
		rA:rAuto;
	BEGIN
		LeerAuto(rA);
		while rA.patente<>0 do begin
			AgregarArbol(a,rA);
			LeerAuto(rA);
		end;
	END;
	//B
	FUNCTION TotalPorMarca(a:arbol;marca:integer):integer;
	BEGIN
		if a=nil then
			TotalPorMarca:=0
		else
			if a^.dato.marca=marca then
				TotalPorMarca:=TotalPorMarca(a^.hi,marca) + TotalPorMarca(a^.hd,marca) + 1
			else
				TotalPorMarca:=TotalPorMarca(a^.hi,marca) + TotalPorMarca(a^.hd,marca);
	END;
	//C
	PROCEDURE AutosPorAnio(a:arbol; var vA:vAutosPorAnio);
		Procedure IniciarVectorLista(var vA:vAutosPorAnio);
		Var
			i:integer;
		Begin
			for i:=2010 to dimF do 
				vA[i]:=nil;
		End;
		
		Procedure AgregarAdelante(var l:lista; rA:rAuto);
		var
			aux:lista;
		Begin
			new(aux);
			aux^.dato:=rA;
			aux^.sig:=l;
			l:=aux;
		end;
	
		Procedure CargarVector(a:arbol; var vA:vAutosPorAnio);
		Begin
			if a<>nil then begin
				AgregarAdelante(vA[a^.dato.anio],a^.dato);			
				CargarVector(a^.hd,vA);
				CargarVector(a^.hi,vA);
			end;
		end;	

		
	BEGIN
		IniciarVectorLista(vA);
		CargarVector(a,vA);
	END;
	
	//C
	PROCEDURE BucarPatente(a:arbol; patente:integer);
		Function Buscar(a:arbol; patente:integer):integer;
		Begin
			if a=nil then 
				Buscar:=-1
			else
				if a^.dato.patente=patente then
					buscar:=a^.dato.anio
				else 
					if a^.dato.patente>patente then
						buscar:=Buscar(a^.hi,patente)
					else
						buscar:=Buscar(a^.hd,patente);
		End;
	VAR
		paten:integer;
	BEGIN
		paten:=Buscar(a,patente);
		if paten=-1 then
			writeln('La patente no exite')
		else
			writeln('La patente: ',patente,' es Anio: ',paten);
	END;
	
	//IMPRIMIR
	PROCEDURE Imprimir(vA:vAutosPorAnio);
	Var
		i:integer;
		Begin
			for i:=2010 to dimF do  begin
				while vA[i]<>nil do begin
					writeln('[',vA[i]^.dato.anio,'] ',vA[i]^.dato.patente);
					vA[i]:=vA[i]^.sig;
				end;
			end;
		End;
	

	
VAR
	a:arbol;
	vA:vAutosPorAnio;
BEGIN
	randomize;
	CargarAutos(a);
	//writeln(TotalPorMarca(a,2));
	AutosPorAnio(a,vA);
	readln();
	Imprimir(vA);
	BucarPatente(a,10);
END.
