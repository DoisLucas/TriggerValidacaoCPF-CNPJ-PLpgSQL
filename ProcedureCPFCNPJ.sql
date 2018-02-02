CREATE OR REPLACE FUNCTION loja_v2.cliente_cpfcnpj()
  RETURNS trigger AS
$BODY$
DECLARE

	param_cpf VARCHAR := NEW.cpf_cnpj;
	digts VARCHAR[];
	tempp integer := 0;
	counter integer := 0;
	multi INTEGER := 10;
	verif1 INTEGER := 0;
	verif2 INTEGER := 0;
	counterfalse integer := 0;
	cnpj1 INTEGER[];
	cnpj2 INTEGER[];
	
BEGIN
	if(length(param_cpf) = 11) then

		digts := ('{'|| substring(param_cpf,1,1) ||', '|| substring(param_cpf,2,1) ||', '|| substring(param_cpf,3,1) 
		||', '|| substring(param_cpf,4,1)  ||', '||  substring(param_cpf,5,1)      ||', '|| substring(param_cpf,6,1) 
		||', '|| substring(param_cpf,7,1)  ||', '||  substring(param_cpf,8,1)      ||', '||  substring(param_cpf,9,1) 
		||', '|| substring(param_cpf,10,1) ||', '||  substring(param_cpf,11,1)     ||'}');

		for counter IN 1..11 LOOP
			IF(digts[counter] = digts[1]) then
				counterfalse = counterfalse + 1;
			end if;
		end LOOP;

		if(counterfalse = 11) then
			RAISE EXCEPTION 'CPF INVALIDO';
		else 
		
			-- Calculo 1º Digito Verificador (CPF)
			for counter IN 1..9 LOOP
				tempp := digts[counter];
				verif1 := verif1 + (tempp * multi);
				multi := multi - 1;
			END LOOP;

			verif1 := ((verif1  % 11));
			
			if(verif1 < 2) THEN
				verif1 := 0;
			ELSE
				verif1 := 11 - verif1;
			end if;

			multi := 11;

			-- Calculo 2º Digito Verificador (CPF)
			for counter IN 1..10 LOOP
				tempp := digts[counter];
				verif2 := verif2 + (tempp * multi);
				multi := multi - 1;
			END LOOP;

			verif2 := ((verif2  % 11));
			
			if(verif2 < 2) THEN
				verif2 := 0;
			ELSE
				verif2 := 11 - verif2;
			end if;

			--Validação Final
		        if (verif1::varchar = substring(param_cpf,10,1)) AND (verif2::varchar = substring(param_cpf,11,1)) THEN
				RAISE NOTICE 'ok';
				return new;
		        ELSE 
				RAISE EXCEPTION 'CPF INVALIDO';
		        END IF;
		end if;
		
	elsif (length(param_cpf) = 14) THEN

		digts := ('{'|| substring(param_cpf,1,1) ||', '|| substring(param_cpf,2,1) ||', '|| substring(param_cpf,3,1) 
		||', '|| substring(param_cpf,4,1)  ||', '||  substring(param_cpf,5,1)      ||', '|| substring(param_cpf,6,1) 
		||', '|| substring(param_cpf,7,1)  ||', '||  substring(param_cpf,8,1)      ||', '|| substring(param_cpf,9,1) 
		||', '|| substring(param_cpf,10,1) ||', '||  substring(param_cpf,11,1)     ||', '|| SUBSTRING(param_cpf,12,1) 
		||', '||  substring(param_cpf,13,1)     ||', '|| SUBSTRING(param_cpf,14,1) ||'}');

		for counter IN 1..14 LOOP
			IF(digts[counter] = digts[1]) then
				counterfalse = counterfalse + 1;
			end if;
		end LOOP;
 
		if(counterfalse = 14) then
			RAISE EXCEPTION 'CNPJ INVALIDO';
		else 

		-- Multiplicadores CNPJ
		cnpj1 := ('{'||5||','||4||','||3||','||2||','||9||','||8||','||7||','||6||','||5||','||4||','||3||','||2||'}');
		cnpj2 := ('{'||6||','||5||','||4||','||3||','||2||','||9||','||8||','||7||','||6||','||5||','||4||','||3||','||2||'}');
	
			-- Calculo 1º Digito Verificador (CNPJ)
			for counter IN 1..12 LOOP
				tempp := digts[counter];
				verif1 := verif1 + (tempp * cnpj1[counter]);
				
			END LOOP;	

			verif1 := ((verif1  % 11));
			
			if(verif1 < 2) THEN
				verif1 := 0;
			ELSE
				verif1 := 11 - verif1;
			end if;

			-- Calculo 2º Digito Verificador (CNPJ)
			for counter IN 1..13 LOOP
				tempp := digts[counter];
				verif2 := verif2 + (tempp * cnpj2[counter]);
			END LOOP;

			verif2 := ((verif2  % 11));
			
			if(verif2 < 2) THEN
				verif2 := 0;
			ELSE
				verif2 := 11 - verif2;
			end if;

			if (verif1::varchar = substring(param_cpf,13,1)) AND (verif2::varchar = substring(param_cpf,14,1)) THEN
				RAISE NOTICE 'ok';
				return new;
		        ELSE 
				RAISE EXCEPTION 'CNPJ INVALIDO';
		        END IF;
		end if;
	
	ELSE
		raise EXCEPTION 'INFORME UM CPF OU CNPJ';
	END IF;      	
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION loja_v2.cliente_cpfcnpj()
  OWNER TO postgres;
