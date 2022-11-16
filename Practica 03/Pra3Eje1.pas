program Pra3Eje1;
type
	str20=string[20];
	rSocio=record
		nro:integer;
		nombre:str20;
		edad:integer
	end;

	arbol=^nodo;
	nodo=record
		dato:rSocio;
		HI:arbol;
		HD:arbol;
	end;
	
	//PUNTO a
	procedure CargarArbol(var a:arbol);
		procedure LeerSocio(var rS:rSocio);
		begin
			rS.nro:=random(101);
			{write('Nro Socio: ');readln(rS.nro);
			if (rS.nro<>0) then begin
				write('Nombre: ');readln(rS.nombre);
				write('Edad: ');readln(rS.edad);
			end;}
		end;
		
		procedure Cargar(var a:arbol; rS:rSocio);
		begin
			if (a=nil) then begin
				new(a);
				a^.dato:=rS;
				a^.HI:=nil;
				a^.HD:=nil;
			end
			else
				if (rS.nro<a^.dato.nro) then
					Cargar(a^.HI,rS)
				else
					Cargar(a^.HD,rS);
		end;
		
	VAR
		rS:rSocio;
	BEGIN
		a:=nil;
		LeerSocio(rS);
		while (rS.nro<>0) do begin
			Cargar(a,rS);
			LeerSocio(rS);
		end;
	END;
	
	//PUNTO b.i
	Procedure SocioMasGrande(a:arbol);
		function Maximo (a:arbol):integer;
		begin
			if (a=nil) then maximo:=-1
			else if (a^.HD=nil) then maximo:=a^.dato.nro
			else maximo:=maximo(a^.HD);
		end;
		
	BEGIN
		writeln(maximo(a));
	END;
	
	//PUNTO b.ii
	Procedure SocioMasChico(a:arbol);
		function Minimo (a:arbol):arbol;
		begin
			if (a=nil) or (a^.HI=nil) 
			then Minimo:=a
			else Minimo:=Minimo(a^.HI);
		end;
	VAR
		min:arbol;
	BEGIN
		min:=Minimo(a);
		if min=nil then
			writeln ('Sin datos')
		else
		writeln ('Socio con numero mas chico: ', min^.dato.nro, ' Nombre: ', min^.dato.nombre, ' Edad: ', min^.dato.edad); 
		
	END;
	
	//Punto b.iii
	PROCEDURE InformarMayorEdad(a:arbol);
		Procedure MayorEdad(a:arbol;var maxNro,maxEdad:integer);
			Procedure Mayor(nro,edad:integer; var maxNro,maxEdad:integer);
			begin
				if edad>maxEdad then begin
					maxEdad:=edad;
					maxNro:=nro;
				end;
			end;
		Begin
			if (a<>nil) then begin
				MayorEdad(a^.hi,maxNro,maxEdad);
				Mayor(a^.dato.nro,a^.dato.edad,maxNro,maxEdad);
				MayorEdad(a^.hd,maxNro,maxEdad);
				
			end;
		End;
	VAR
		maxNro,maxEdad:integer;
	BEGIN
		maxEdad:=-1;
		MayorEdad(a,maxNro,maxEdad);
		writeln ('El Nro. de Socio con mayor edad es: ', maxNro); 
	END;
	
	//Punto b.iv
	PROCEDURE AumentarEdad(var a:arbol);
	BEGIN
		if (a<>nil) then begin
			a^.dato.edad:=a^.dato.edad+1;
			AumentarEdad(a^.HI);
			AumentarEdad(a^.HD);
		end;
	END;
	
	//Punto b.v
	PROCEDURE BuscarPorNro(a:arbol);
		Function Buscar(a:arbol;num:integer):boolean;
		begin
			if (a<>nil) then begin
				if num=a^.dato.nro then
					Buscar:=true
				else
					if num<a^.dato.nro then
						Buscar:=Buscar(a^.HI,num)
					else
						Buscar:=Buscar(a^.HD,num);
			end
			else
				Buscar:=false;
		end;
	VAR
		num:integer;
	BEGIN
		write('Ingrese el Nro. de Socio a Buscar: '); readln(num);
		writeln(Buscar(a,num));
	END;
	
	//Punto b.vi
	PROCEDURE InformarExistenciaNombreSocio(a:arbol);
		Function Buscar(a:arbol;nom:str20):boolean;
		begin
			if (a<>nil)  then begin
				if nom=a^.dato.nombre then
					Buscar:=true
				else begin
					buscar:=Buscar(a^.hi,nom);
					buscar:=Buscar(a^.hd,nom);
				end
			end
			else
				Buscar:=false;
		end;
	VAR
		nom:str20;
	BEGIN
		write('Ingrese el Nombre del Socio a Buscar: '); readln(nom);
		writeln(Buscar(a,nom));
	END;
	
	//Punto b.vii
	Procedure InformarCantidadSocios (a:arbol);
		Function Contar(a:arbol):integer;
		begin
			if (a<>nil) then 
				Contar:=Contar(a^.hi)+Contar(a^.hd)+1
			else
				Contar:=0;
		end;
	begin
		writeln('Cantidad de Socios: ',Contar(a));
	end;

	
	//Punto b.viii
	Procedure InformarPromedioDeEdad (a:arbol);
		Procedure SumaryContar(a:arbol;var suma,cont:integer);
		begin
			if (a<>nil) then begin
				SumaryContar(a^.hi,suma,cont);
				suma:=suma+a^.dato.edad;
				cont:=cont+1;
				SumaryContar(a^.hd,suma,cont);
			end;
		end;
	VAR
		Suma,cont:integer;
	BEGIN
		Suma:=0;
		cont:=0;
		SumaryContar(a,suma,cont);
		writeln('Promedio de edad: ',(suma/cont):8:2);
	END;
	
	//Punto b.ix
	PROCEDURE InformarCantidadSociosEnRango(a:arbol);
		Function Contar(a:arbol;num1,num2:integer):integer;
		begin
			if (a<>nil) then
				if (a^.dato.nro>=num1) and (a^.dato.nro<= num2) then 
					Contar:=Contar(a^.HI,num1,num2)+Contar(a^.HD,num1,num2)+1
				else
				if (a^.dato.nro<num1) then
						Contar:=Contar(a^.HD,num1,num2)
					else
						Contar:=Contar(a^.HI,num1,num2)
			else
				Contar:=0;
		end;
	VAR
		num1,num2:integer;
	BEGIN
		write('Ingrese el 1er Rango: '); readln(num1);
		write('Ingrese el 2er Rango: '); readln(num2);
		writeln(Contar(a,num1,num2));
	END;
	
	//Punto b.x
	PROCEDURE InformarNumerosSociosOrdenCreciente(a:arbol);
	BEGIN
		if (a<>nil) then begin
			InformarNumerosSociosOrdenCreciente(a^.hi);
			writeln(a^.dato.nro);
			InformarNumerosSociosOrdenCreciente(a^.hd);
		end;
	END;

	//Punto b.xi
	PROCEDURE InformarNumerosSociosOrdenDeCreciente(a:arbol);
		Function EsPar(num:integer):boolean;
		begin
			EsPar:=(num mod 2 =0)
		end;
	BEGIN
		if (a<>nil) then begin
			InformarNumerosSociosOrdenDeCreciente(a^.hd);
				if EsPar(a^.dato.nro) then
					writeln(a^.dato.edad);
			InformarNumerosSociosOrdenDeCreciente(a^.hi);
		end;
	END;

VAR
	a:arbol;
BEGIN
	randomize;
	CargarArbol(a);
	SocioMasGrande(a);
	//SocioMasChico(a);
	//InformarMayorEdad(a);
	//AumentarEdad(a);
	//InformarExistenciaNombreSocio(a);
	//InformarCantidadSocios(a);
	//InformarPromedioDeEdad(a);
	//InformarCantidadSociosEnRango(a);
	//InformarNumerosSociosOrdenCreciente(a);
	//InformarNumerosSociosOrdenDeCreciente(a);
END.
