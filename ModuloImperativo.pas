PROGRAM ModuloImperativo;
Const
	dimF=100;
Type
	ranDimL=0..dimF;
	rRegistro=record
		cod:integer;
		otro:integer;
	end;
	Vector=array [1..dimF] of rRegistro;
	
	lista=^nodo;
	nodo=record
		dato:integer;
		sig:lista;
	end;


	rAuto=record
		patente:integer;
		marca:integer;
	end;
	
	arbol=^nodo2;
	nodo2=record
		dato:rAuto;
		hi:arbol;
		hd:arbol;
	end;

	
	//MINIMO LISTA RECURSIVA
	FUNCTION Minimo(l:lista):integer;
	VAR
		numMin:integer;
	BEGIN
		if l<>nil then 
			minimo:=999
		else
		begin
			numMin:=minimo(l^.sig);
			if l^.dato<numMin then
				minimo:=l^.dato
			else
				minimo:=numMin
		end;
	END;
		
	//BUSCAR LISTA RECURSIVA
	FUNCTION BuscarNum(l:lista; dato:integer ):boolean;
	BEGIN
		 if(l <> nil) and (l^.dato <> dato) then 
			  BuscarNum:=BuscarNum(l^.sig, dato)
		 else
				BuscarNum:= l <> nil;
	END;
	
	//SUMAR LISTA RECURSIVA
	FUNCTION SumaLista(l:lista):integer;
	BEGIN
		 if(l=nil) then
			  SumaLista:=0
		 else
			  SumaLista:=SumaLista(l^.sig)+l^.dato
	END;
	
	//****************************************************************//
	
	//ORDENAR POR INSERCION
	Procedure OrdenarInsersion(var v:Vector; dimL:ranDimL);
	VAR
		i,j:ranDimL;
		aux:rRegistro;
	BEGIN
		for i:=2 to dimL do begin
			aux:=v[i];
			j:=i-1;
			while (j>0) and (v[j].cod>aux.cod) do begin
				v[j+1]:=v[j];
				j:=j-1;
			end;
			v[j+1]:=aux;
		end;
	END;
	
	//INSERTAR EN ARBOL
	Procedure InsertarElemento (var a: arbol; elem: rAuto);
	Begin
		if (a = nil) then begin
			new(a);
			a^.dato:= elem; 
			a^.HI:= nil; 
			a^.HD:= nil;
		end
		else 
			if (elem.patente < a^.dato.patente) then
				InsertarElemento(a^.HI, elem)
			else 
				InsertarElemento(a^.HD, elem); 
	End;
  
  	//BUSCAR EN UN ARBOL
	function Buscar (a: arbol; num: integer): boolean;
	begin
		if (a = nil) then 
			Buscar:= false
		else If (a^.dato.numero = num) then
			Buscar:= true
		else If (num < a^.dato.numero) then 
			Buscar:= Buscar (a^.HI, num)
		else 
			Buscar:= Buscar (a^.HD, num)
	end;
  
    //BUSCAR EL MIMIMO EN ARBOL
	function SocioMasChico (a: arbol): arbol;
	begin
		if ((a = nil) or (a^.HI = nil)) then 
			SocioMasChico:= a
		else 
			SocioMasChico:= SocioMasChico (a^.HI);
	end;
	
	//BUSCAR EN ARBOL Y CONTAR
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
	
	//MENORES QUE UN VALOR
	procedure imprimirLegajoInferior(a: arbol; n: integer);
	begin
		if(a <> nil) then begin
			if(a^.datos.leg < n) then begin
				writeln(a^.datos.dni,' - ',a^.datos.anio);
				imprimirLegajoInferior(a^.hi, n);
				imprimirLegajoInferior(a^.hd, n);
			end
			else
				imprimirLegajoInferior(a^.hi, n);
		end;
	end;

	//ENTRE DOS VALORES
	procedure informarEntre(a:arbol; min:integer;max:integer);
		begin
			if(a<>nil) then begin
				if a^.dato.legajo > min then
					informarEntre(a^.HI, min,max);
				if (a^.dato.legajo <= max) then begin
					if(a^.dato.legajo>= min )then 
						writeln(a^.datos.dni,' - ',a^.datos.anio);
					informarEntre(a^.HD,min,max);
				end;
			end
		end;	
	
	//MERGE
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
	
	//MERGE ACUMULADOR
	Procedure TotalEntradasPorObra(vE:vEntradas; var l:lista2);
		Procedure Minimo(var vE:vEntradas; var minCod:integer);
		var
			i,indice:integer;
		Begin
			minCod:=999;
			For i:=1 to dimF do begin
				if vE[i]<>nil then
					if vE[i]^.dato.cod<=minCod then begin
						minCod:=vE[i]^.dato.cod;
						indice:=i;
					end;
			end;

			if minCod<>999 then begin
				vE[indice]:=vE[indice]^.sig;
				end;
		end;
		
		Procedure AgregarAtras(var l,ult:lista2; rT:rTotalPorObra);
		var
			aux:lista2;
		Begin
			new(aux);
			aux^.dato:=rT;
			aux^.sig:=nil;
			if l=nil then
				l:=aux
			else
				ult^.sig:=aux;
			ult:=aux;
		end;
	Var
		total,minCod,actualCod:integer;
		rT:rTotalPorObra;
		ult:lista2;
	Begin
		l:=nil;
		Minimo(vE,minCod);
		while minCod<>999 do begin
			actualCod:=minCod;
			total:=0;
			while (minCod<>999) and (actualCod=minCod) do begin
				total:=total+1;
				Minimo(vE,minCod);
			end;
			rT.cod:=actualCod;
			rT.total:=total;
			AgregarAtras(l,ult,rT);
		end;
	End;
	
	//BUSCAR DICOTOMICA RECURSIVA
	Procedure busquedaDicotomica( v : Vector; ini,fin : indice; dato : integer; var pos : integer);
	var
		 medio : indice;
	begin
		 if (ini > fin ) then
				pos := -1
		 else begin
			 medio := (ini+ fin)  div 2;
			 if (dato = v[medio]) then
					pos := medio
			 else
				if(dato < v[medio]) then
					  busquedaDicotomica(v,ini,medio-1,dato,pos)
				else
					  busquedaDicotomica(v,medio+1,fin,dato,pos);
		 end;
	end;
	


BEGIN

END.
