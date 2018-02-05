# TriggerValidacaoCPF-CNPJ-PLpgSQL

Procedure que retorna uma Trigger que é disparada ao inserir um novo registro na tabela 'Cliente', capturando o CPF/CNPJ no momento da inserção, identificando se é um CPF (9 Digitos) ou CNPJ (14 Digitos) e realizando a validação dos digitos verificadores, caso não passe na verificação a operação é abortada, lançando uma exceção.
