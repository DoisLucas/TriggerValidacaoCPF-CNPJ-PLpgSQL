## VALIDAÇÃO CPF E CNPJ (PLpgSQL)



![GitHub issue age](https://img.shields.io/github/issues/detail/age/badges/shields/979.svg) 
![Github file size](https://img.shields.io/github/size/webcaetano/craft/build/phaser-craft.min.js.svg)
[![Coverage Status](https://coveralls.io/repos/github/DoisLucas/TXTsToBD/badge.svg?branch=master)](https://coveralls.io/github/DoisLucas/TXTsToBD?branch=master)



**SOBRE:**

> Procedure que retorna uma Trigger que é disparada ao inserir um novo
> registro na tabela "Cliente", capturando o CPF/CNPJ no momento da
> inserção, identificando se é um CPF (9 Digitos) ou CNPJ (14 Digitos) e
> realizando a validação dos digitos verificadores, caso não passe na
> verificação a operação é abortada, lançando uma exceção.


**TABELA E TRIGGER (SQL):**


```SQL
CREATE TABLE public.cliente
(
    id_cliente integer NOT NULL DEFAULT nextval('cliente_id_cliente_seq'::regclass),
    nome character varying COLLATE pg_catalog."default" NOT NULL,
    idade character varying COLLATE pg_catalog."default" NOT NULL,
    cpf_cnpj character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT cliente_pkey PRIMARY KEY (id_cliente)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

CREATE TRIGGER validacpfcnpj
    BEFORE INSERT
    ON public.cliente
    FOR EACH ROW
    EXECUTE PROCEDURE public.cliente_cpfcnpj();
```

