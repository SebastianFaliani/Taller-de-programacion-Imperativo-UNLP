 PROGRAM Pra4Eje2;
Const 
	dimF=8;
Type
	ranGenero=1..dimF;
	rPelicula=record
		codP:integer;
		codG:ranGenero;
		puntaje:integer;
	end;
	lista=^nodo;
	nodo=record
		dato:rPelicula;
		sig:lista;
	end;
	vPeliculas=array[ranGenero] of lista;


	//Punto a
	Procedure CargarPeliculas(var vP:vPeliculas);
		Procedure InicializarListas(var vP:vPeliculas);
		Var
			i:integer;
		begin
			for i:=1 to dimF do
				vP[i]:=nil;
		End;
		
		Procedure LeerPelicula(var rP:rPelicula);
		Begin
			rP.codP:=random(51);writeln('Ingrese Codigo de Pelicula: ',rP.codP); 
			if rP.codP<>0 then begin
				 rP.codG:=random(8)+1;writeln('Ingrese el Genero [1..8]: ',rP.codG);
				 rP.puntaje:=random(10)+1;writeln('Ingrese Puntaje de la Critica: ',rP.puntaje); 
			end;
		End;
		
		Procedure AgregarOrdenado(var l:lista;rP:rPelicula);
		Var
			ant,Act,Aux:lista;
		Begin
			new(aux);
			aux^.dato:=rP;
			act:=l;
			while (act<> nil) and (rP.codP>act^.dato.codP) do begin
				ant:=act;
				act:=act^.sig;
			end;
			if act=l then
				l:=aux
			else
				ant^.sig:=aux;
			aux^.sig:=act;
		End;


		
	Var
		rP:rPelicula;
	Begin
		InicializarListas(vP);
		LeerPelicula(rP);
		while rP.codP<> 0 do begin
			AgregarOrdenado(vP[rP.codG],rP);
			LeerPelicula(rP);
		end;
	End;

	//Punto b
	Procedure Merge(vP:vPeliculas;var l:lista);
		Procedure Minimo(var vP:vPeliculas; var rP:rPelicula);
		var
			i,indice:integer;
		Begin
			rP.codP:=999;
			For i:=1 to dimF do begin
				if vP[i]<>nil then
					if vP[i]^.dato.codP<rP.codP then begin
						rP:=vP[i]^.dato;
						indice:=i;
					end;
			end;
			if rP.codP<>999 then
				vP[indice]:=vP[indice]^.sig;			
		end;
		Procedure AgregarAtras(var l,ult:lista;rP:rPelicula);
		var
			aux:lista;
		Begin
			new(aux);
			aux^.dato:=rP;
			aux^.sig:=nil;
			if l=nil then
				l:=aux
			else
				ult^.sig:=aux;
			ult:=aux
		end;
		
	Var
		rP:rPelicula;
		ult:lista;
	Begin
		l:=nil;
		Minimo(vP,rP);
		while (rP.codP<>999) do begin
			AgregarAtras(l,ult,rP);
			Minimo(vP,rP);
		end;
	End;

	procedure Imprimir(l:lista);
	begin
		while l<>nil do begin
			writeln(l^.dato.codP,' - ' ,l^.dato.codG,' - ' ,l^.dato.puntaje);
			l:=l^.sig;
		end;
	end;
	procedure Imprimirvector(vP:vPeliculas);
	var
		i:integer;
	begin
		for i:=1 to dimF do begin
			if vP[i]<> nil then
				Imprimir(vP[i])
			else
				writeln('Lista Vacia para el Genero[',i,']');
			readln();
		end;
	end;
	
VAR
	vP:vPeliculas;
	l:lista;
BEGIN
	Randomize;
	CargarPeliculas(vP);
	Merge(vP,l);
	Imprimirvector(vP);
	Imprimir(l);
END.
