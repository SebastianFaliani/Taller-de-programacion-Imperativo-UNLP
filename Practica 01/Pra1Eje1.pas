Program ImperativoPra1Eje1;
Const
	dimF=20;
	
Type
	ranCod=0..15;
	ranUnidad=1..99;
	ranVector=0..dimF;
	rVenta=record
		cod:ranCod;
		cant:ranUnidad;
	end;
	
	vVentas=array[1..dimF] of rVenta;
	
	lista=^nodo;
	nodo=record
		dato:rVenta;
		sig:lista;
	end;
	
	Procedure CargarVector(var vV:vVentas; var dimL:ranVector);
		Procedure LeerVector (var rV:rVenta);
		begin
			rV.cod:=random(15);
			if rV.cod<>0 then begin
				write('Codigo:',rV.cod,' Cantidad [1..99]:');readln(rV.cant);
			end;
		end;

	VAR
		rV:rVenta;
	BEGIN
		dimL:=0;
		LeerVector (rV);
		while (dimL<dimF) and (rv.cod<>0) do begin
			dimL:=dimL+1;
			vV[dimL]:=rV;
			LeerVector (rV);
		end;
	END;
	
	Procedure ImprimirVector(vV:vVentas; dimL:ranVector);
	VAR
		i:ranVector;
	BEGIN
		for i:=1 to dimL do begin
			writeln('Codigo:',vV[i].cod,' Cantidad:',vV[i].cant);
		end;
	END;
	
	Procedure OrdenarCod(var vV:vVentas; dimL:ranVector);
	VAR
		aux:rVenta;
		i,j:ranVector;
	BEGIN
		for i:=2 to dimL do begin
			aux:=vV[i];
			j:=i-1;
			while (j>0) and (vV[j].cod>aux.cod) do begin
				vV[j+1]:=vV[j];
				j:=j-1;
			end;
			vV[j+1]:=aux
		end;
	END;
	
	Procedure EliminarOrdenado(var vV:vVentas; var dimL:ranVector);
		Procedure Eliminar(var vV:vVentas; var dimL:ranVector; var ok:boolean; pos:ranVector);
		var
			i:ranVector;
		begin
			ok:=false;
			if (pos>0) and (pos<=dimL) then begin
				ok:=true;
				for i:=pos to dimL-1 do
					vV[i]:=vV[i+1];
				dimL:=dimL-1;
			end;
		end;
	VAR
		val1,val2:ranCod;
		pos:ranVector;
		ok:boolean;
	BEGIN
		write('ELIMINAR DESDE [1..15]: '); readln(val1);
		write('ELIMINAR HASTA [',val1+1,'..15]: '); readln(val2);
		pos:=1;
		while (dimL>0) and (pos<=dimL) do begin
			while (vV[pos].cod>=val1) and (vV[pos].cod<=val2) and (pos<=dimL)do
				Eliminar(vV,dimL,ok,pos);
			pos:=pos+1;
		end;
	END;
	
	Procedure GenerarLista(vV:vVentas; dimL:ranVector; var l:lista);
		Procedure AgregarAtras(var l,ult:lista; rV:rVenta);
		var
			aux:lista;
		begin
			new(aux);
			aux^.dato:=rV;
			aux^.sig:=nil;
			if l=nil then
				l:=aux
			else
				ult^.sig:=aux;
			ult:=aux;
		end;
		
		function EsPar(num:ranCod):boolean;
		begin
			EsPar:=(num mod 2) =0;
		end;
		
	VAR
		i:ranVector;
		ult:lista;
	BEGIN
		for i:=1 to dimL do begin
			if EsPar(vV[i].cod) then begin
				AgregarAtras(l,ult,vV[i]);
			end;
		end;
	END;
	
	Procedure ImprimirLista(l:lista);
	begin
		while l<>nil do begin
			writeln('Codigo:',l^.dato.cod,' Cantidad:',l^.dato.cant);
			l:=l^.sig;
		end;
	end;

VAR
	vV:vVentas; 
	dimL:ranVector;
	l:lista;
BEGIN
	l:=nil;
	CargarVector(vV,dimL);
	ImprimirVector(vV,dimL);}
	OrdenarCod(vV,dimL);
	ImprimirVector(vV,dimL);
	EliminarOrdenado(vV,dimL);
	ImprimirVector(vV,dimL);
	GenerarLista(vV,dimL,l);
	ImprimirLista(l);
END.

