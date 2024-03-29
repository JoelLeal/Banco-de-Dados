DECLARE
	/*VARIAVEIS CRIADAS*/
	v_ra ALUNO.RA%TYPE;
	v_nome ALUNO.NOME%TYPE;
	v_disciplina TBDISCIPLINA.CODIGO%TYPE;
	v_media NUMERIC(10,2);
	v_presenca NUMERIC(10,2);
	v_situacao TBSITUACAO.SITUACAO%TYPE;
	/*CRIANDO CURSOR */
	CURSOR ALUNO_CURSOR IS 
		SELECT RA, NOME
		FROM ALUNO;

BEGIN
	/*LIMPA TABEL*/
	DELETE FROM TBSITUACAO;
	OPEN ALUNO_CURSOR;
	LOOP
		/*PREENCHE O CURSOR*/
		FETCH ALUNO_CURSOR INTO v_ra, v_nome;
		EXIT WHEN ALUNO_CURSOR%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('RA: ' || v_ra);
		DBMS_OUTPUT.PUT_LINE('NOME: ' || v_nome);