{Una cadena de gimnasios que tiene 5 sucursales necesita procesar las asistencias de los clientes.
Implementar un programa en Pascal con:
a) Un módulo que lea la información de las asistencias realizadas en cada sucursal y que genere
un árbol ordenado por dni de cliente, donde cada nodo contenga dni de cliente, còdigo y la
cantidad total de minutos asistidos en todas las sucursales. De cada asistencia se lee: código
de sucursal (1..5), dni del cliente, código del cliente, fecha y cantidad de minutos que asistió. La
lectura finaliza con el dni de cliente -1, el cual no se procesa.
b) Un módulo que reciba el árbol generado en a) y un dni de cliente y devuelva una lista con los
dni de los clientes cuyo dni es mayor al dni ingresado y el total de minutos es impar}
Program parcial_01;
const
	dimF=5;
type
	ranSucursal=1..dimF;
	ranDia=1..31;
	ranMes=1..12;
	ranAnio=2022..2050;
	
	rCliente=record
		dni:integer;
		cod:integer;
		totalMin:integer;
	end;

	
	arbol=^nodo;
	nodo=record
		dato:rCliente;
		hi:arbol;
		hd:arbol;
	end;
	
	Procedure GenerarArbolClientes(var a:arbol);
		Procedure LeerAsistencia(var rC:rCliente);
	
		Begin
			//write('ingrese dni');readln(rC.dni);
			rC.dni:=random(100);write('ingrese dni: ',rC.dni);
			if rC.dni<>0 then begin
				//write('Ingrese codigo: ');readln(rC.cod);
				rC.cod:=random(50)+1;write('    ingrese codigo: ',rC.cod);
					//write('Ingrese minutos: ');readln(rC.minutos);
				rC.totalMin:=random(60)+1;writeln('    ingrese minutos: ',rC.totalMin);
			end;
		End;
		procedure AgregarAlArbol(var a:arbol; rC:rCliente);
		Begin
			if a=nil then begin
				new(a);
				a^.dato:=rC;
				a^.hi:=nil;
				a^.hd:=nil;
			end
			else
				if rC.dni=a^.dato.dni then
					a^.dato.totalMin:=a^.dato.totalMin+rC.totalMin
				else if rC.dni<a^.dato.dni then
					AgregarAlArbol(a^.hi,rC)
				else
					AgregarAlArbol(a^.hd,rC);
		end;
	
	var
		rC:rCliente;
	Begin
		LeerAsistencia(rC);
		while rC.dni<>0 do begin
			AgregarAlArbol(a,rC);
			LeerAsistencia(rC);
		end;
	End;
		
	
	procedure informarEntre(a:arbol; min:integer;max:integer);
	begin
		if a<>nil then begin
			if min<a^.dato.dni then
				informarEntre(a^.hi,min,max);
			if max>=a^.dato.dni then begin
				if min<=a^.dato.dni then
					writeln(a^.dato.dni);
				informarEntre(a^.hd,min,max);
			end;	
		end;
	end;

	Procedure maximoTotal(a:arbol; var max:integer);
	
	begin
		if a<>nil then begin
			maximoTotal(a^.hi, max);
			if a^.dato.totalMin>max then
				max:=a^.dato.totalMin;
			maximoTotal(a^.hd, max);
		end;
	end;
	
{	Procedure Impares(a:arbol; var max:integer);
	
	begin
		if a<>nil then begin
			maximoTotal(a^.hi, max);
			if a^.dato.totalMin>max then
				max:=a^.dato.totalMin;
			maximoTotal(a^.hd, max);
		end;
	end;}
	
	PROCEDURE Imprimir(a:arbol);

	Begin
		if a<>nil then begin
			
			Imprimir(a^.hi);
			writeln(a^.dato.dni,' ', a^.dato.totalMin);
			Imprimir(a^.hd);
		end;	
	End;		
var
	a:arbol;
	max:integer;
begin
	randomize();
	GenerarArbolClientes(a);
	writeln();
	Imprimir(a);
	writeln();
	informarEntre(a,20,30);
	maximoTotal(a, max);
	writeln();
	writeln(max);
end.
