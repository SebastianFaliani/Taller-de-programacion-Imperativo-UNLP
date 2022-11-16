PROGRAM Pra3Eje3;
type
	rAlumno=record
		leg:integer;
		dni:integer;
		anio:integer;
	end;
	arbol=^nodo;
	nodo=record
		datos:rAlumno;
		HI:arbol;
		HD:arbol;
	end;
	
	Procedure GenerarArbol(var a:arbol);
		Procedure LeerAlumno(var rA:rAlumno);
		Begin
			write('Ingrese el Ano de Ingreso: ');readln(rA.anio);
			if rA.anio>0 then begin
				write('Ingrese el Legajo: ');//readln(rA.leg);
				rA.leg:=rA.anio;
				write('Ingrese el DNI: ');readln(rA.dni);
			end;
		End;
		Procedure AgregarAlumno(var a:arbol; rA:rAlumno);
		Begin
			if a=nil then begin
				new(a);
				a^.datos:=rA;
				a^.HI:=nil;
				a^.HD:=nil;
			end
			else if (rA.leg>=a^.datos.leg) then
				AgregarAlumno(a^.HD,rA)
			else
				AgregarAlumno(a^.HI,rA);
		End;
		
		
	Var
		rA:rAlumno;
	Begin
		a:=nil;
		LeerAlumno(rA);
		while rA.anio>0 do begin
			AgregarAlumno(a,rA);
			LeerAlumno(rA);
		end;
	End;
	
	
	Procedure InformarDNIyAnio(a:arbol; leg:integer);
	Begin
		if a<>nil then begin
			if leg> a^.datos.leg then begin
				writeln(a^.datos.dni,' - ',a^.datos.anio);
				InformarDNIyAnio(a^.HI, leg);
				InformarDNIyAnio(a^.HD, leg);
			end
			else
				InformarDNIyAnio(a^.HI, leg);
		end;
	End;
	
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
		
	//****IMPRIMIR
	PROCEDURE Imprimir(a:arbol);
	BEGIN
		if (a<>nil) then begin
			writeln(a^.datos.anio, '-', a^.datos.leg);
			Imprimir(a^.hi);
			Imprimir(a^.hd);
		end;
	END;


VAR
	a:arbol;
BEGIN
	GenerarArbol(a);
	InformarDNIyAnio(a, 26);
	//imprimirLegajoInferior(a,26);
	Imprimir(a);
END.

