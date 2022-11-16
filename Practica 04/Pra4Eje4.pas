PROGRAM Pra4Eje3;
const
	dimF=7;
type
	ranDia=1..7;
	rEntrada=record
		dia:ranDia;
		cod:integer;
		asiento:integer;
		monto:real;
	end;
	lista=^nodo;
	nodo=record
		dato:rEntrada;
		sig:lista;
	end;
	
	rTotalPorObra=record
		cod:integer;
		total:integer;
	end;
	lista2=^nodo2;
	nodo2=record
		dato:rTotalPorObra;
		sig:lista2;
	end;
	
	vEntradas=array[ranDia] of lista;
	
	
	Procedure GenerarListas(var vE:vEntradas);
		Procedure InicializarListas(var vE:vEntradas);
		Var
			i:integer;
		Begin
			for i:=1 to dimF do
				vE[i]:=nil;
		End;

		Procedure LeerEntrada(var rE:rEntrada);
		begin
			rE.cod:=random(51);
			if rE.cod<> 0 then begin
				rE.dia:=random(7)+1;
				rE.asiento:=random(101)+1;
				rE.monto:=random(1000)/13;
			end;
		end;

		Procedure AgregarOrdenado(var l:lista;rE:rEntrada);
		var
			ant,act,aux:lista;
		Begin
			new(aux);
			aux^.dato:=rE;
			act:=l;
			
			while (act<>nil) and (rE.cod>act^.dato.cod) do begin
				ant:=act;
				act:=act^.sig;
			end;
			if act=l then
				l:=aux
			else
				ant^.sig:=aux;
			aux^.sig:=act;
		End;
	var
		rE:rEntrada;	
	Begin
		InicializarListas(vE);
		LeerEntrada(rE);
		while rE.cod<>0 do begin
			AgregarOrdenado(vE[rE.dia],rE);
			LeerEntrada(rE);
		end;
	end;
	
	
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
	
	
	
	
	procedure Imprimirvector(var vE:vEntradas);
		procedure Imprimir(l:lista);
		begin
			while l<>nil do begin
				writeln(l^.dato.dia,'-',l^.dato.cod,'-' ,l^.dato.asiento,'-' ,(l^.dato.monto):6:2);
				
				l:=l^.sig;
			end;
		end;
	var
		i:integer;
	begin
		for i:=1 to dimF do begin
			if vE[i]<> nil then
				Imprimir(vE[i])
			else
				writeln('Lista Vacia [',i,']');
			readln();
		end;
	end;
	
		procedure Imprimir2(l:lista2);
		begin
			while l<>nil do begin
				writeln(l^.dato.cod,'-' ,l^.dato.total);
				
				l:=l^.sig;
			end;
		end;
VAR
	vE:vEntradas;
	l:lista2;
BEGIN
	Randomize;
	GenerarListas(vE);
	Imprimirvector(vE);
	TotalEntradasPorObra(vE,l);
	Imprimir2(l);
END.
		
