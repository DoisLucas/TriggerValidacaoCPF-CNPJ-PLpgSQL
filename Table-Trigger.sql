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