DECLARE
	v_matricula FUNCIONARIO.MATRICULA%TYPE;
	v_nome FUNCIONARIO.NOME%TYPE;
	v_verba VERBA.CODIGO%TYPE;
	v_descricao VERBA.DESCRICAO%TYPE;
	v_qtde LANCAMENTO.QTDE%TYPE;
	v_valor PAGAMENTO.VALOR%TYPE;

	v_salario_base FUNCIONARIO.SALARIO_BASE%TYPE;
	v_porcentagem VERBA.PORCENTAGEM%TYPE;
	v_jornada FUNCIONARIO.JORNADA%TYPE;
	v_referencia VERBA.REFERENCIA%TYPE;

	CURSOR CURSOR_PAGAMENTO IS
		SELECT F.MATRICULA, F.NOME, F.SALARIO_BASE, F.JORNADA,
			   V.CODIGO, V.DESCRICAO, V.PORCENTAGEM, V.REFERENCIA,
			   L.QTDE
			   FROM FUNCIONARIO F INNER JOIN LANCAMENTO L ON(F.MATRICULA = L.MATRICULA)
			   						INNER JOIN VERBA V ON (V.CODIGO = L.VERBA);


	BEGIN
		DELETE FROM PAGAMENTO;
		OPEN CURSOR_PAGAMENTO;
		LOOP
			FETCH CURSOR_PAGAMENTO INTO v_matricula, v_nome, v_salario_base, v_jornada,
										v_verba, v_descricao, v_porcentagem, v_referencia,
										v_qtde;
			EXIT WHEN CURSOR_PAGAMENTO%NOTFOUND;

			IF v_referencia = 'P'
				THEN v_valor := (v_salario_base*v_porcentagem)/100;
			ELSIF v_referencia = 'H'
				THEN v_valor := ((v_salario_base/v_jornada)*v_qtde)*v_porcentagem;  
			ELSIF v_referencia = 'D'
				THEN v_valor := (v_salario_base/30)*v_qtde;
			END IF;

			INSERT INTO PAGAMENTO VALUES(v_matricula, v_nome, v_verba, v_descricao, v_qtde, v_valor);
			END LOOP;
			CLOSE CURSOR_PAGAMENTO;
	END;