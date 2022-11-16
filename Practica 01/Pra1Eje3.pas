Program ImperativoPra1Eje3;
Const
	dimF=8;
Type
	ranGenero=1..dimF;
	rPelicula=record
		cod:integer;
		genero:ranGenero;
		puntaje:real;
	end;
	rPeliculaMaxPuntaje=record
		cod:integer;
		puntaje:real;
	end;
	lista=^nodo;
	nodo=record
		datos:rPelicula;
		sig:lista;
	end;
	vPeliculas=array[ranGenero] of lista;
	
	vMaxPuntaje=array[ranGenero] of rPeliculaMaxPuntaje;
	

	
	//PUNTO A
	Procedure CargarPeliculas(var vP:vPeliculas);
		Procedure IniciarVectorListas(var vP:vPeliculas);
		Var
			i:ranGenero;
		Begin
			for i:=1 to dimF do
				vP[i]:=nil;
		End;
		Procedure LeerPelicula(var rP:rPelicula);
		Begin
			rP.cod:=random(50);writeln('Codigo: ',rP.cod);
			readln();
			if rP.cod<>0 then begin
				rP.genero:=random(8)+1;writeln('Genero: ',rP.genero);
				rP.puntaje:=random(41)/4;writeln('Puntaje Promedio: ',(rP.puntaje):2:2);
			end;
		End;
		procedure AgregarAdelante(var l:lista; rP:rPelicula);
		var
			aux:lista;
		begin
			new(aux);
			aux^.datos:=rP;
			aux^.sig:=l;
			l:=aux;
		end;
	
	VAR
		rP:rPelicula;
	BEGIN
		IniciarVectorListas(vP);
		LeerPelicula(rP);
		while rP.cod<>0 do begin
			AgregarAdelante(vP[rP.genero],rP);
			LeerPelicula(rP);
		end;
	END;
	
	//PUNTO B
	Procedure MaxPuntaje(var vM:vMaxPuntaje; vP:vPeliculas);
		Procedure Maximos(var maxCod:integer; var maxPuntaje:real;cod:integer;puntaje:real);
		begin
			if puntaje>maxPuntaje then begin
				maxPuntaje:=puntaje;
				maxCod:=cod;
			end;
		end;
	
	VAR
		i:ranGenero;
		maxCod:integer;
		maxPuntaje:real;
		dimL:integer;
	BEGIN
		dimL:=0;
		for i:=1 to dimF do begin
			maxPuntaje:=-1;
			maxCod:=-1;
			while vP[i]<>nil do begin
				dimL:=dimL+1;
				Maximos(maxCod,maxPuntaje,vP[i]^.datos.cod,vP[i]^.datos.puntaje);
				vP[i]:=vP[i]^.sig;
			end;
			vM[dimL].cod:=maxCod;
			vM[dimL].puntaje:=maxPuntaje;
		end;
	END;
	
	//PUNTO C
	Procedure OrdenarVector(var vM:vMaxPuntaje;dimL:integer);
	VAR
		i,j:integer;
		aux:rPeliculaMaxPuntaje;
	BEGIN
		for i:=2 to dimL do begin
			aux:=vM[i];
			j:=i-1;
			while (j>0) and (vM[j].puntaje>aux.puntaje) do begin
				vM[j+1]:=vM[j];
				j:=j-1;
			end;
			vM[j+1]:=aux;
		end;
	END;
	
	VAR
		vP:vPeliculas;
		vM:vMaxPuntaje;
		
BEGIN
	randomize;
	CargarPeliculas(vP);
	MaxPuntaje(vM,vP);
	OrdenarVector(vM);
	
	//PUNTO D
	writeln('El codigo de pelicula con mayor puntaje es:',vM[dimF].cod);
	writeln('El codigo de pelicula con menor puntaje es:',vM[1].cod);
END.

