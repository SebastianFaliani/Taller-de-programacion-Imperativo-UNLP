PROGRAM Pra2Ej6;
	PROCEDURE DecimalBinario();
		Procedure Convertir(num:integer);
		Begin
			if num>0 then begin
				Convertir(num div 2);
				write(num mod 2);
			end;
		End;
	VAR
		num:integer;
	BEGIN
		repeat
			write('Ingrese un numero: ');readln(num);
			Convertir(num);
			writeln();
		until num=0;
		
	END;	


BEGIN
	DecimalBinario();
END.
