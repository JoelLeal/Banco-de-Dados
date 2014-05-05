DECLARE
  v_codigo ALUNO.RA%TYPE;
  v_nome ALUNO.NOME%TYPE;
  v_sexo ALUNO.SEXO%TYPE;
  CURSOR aluno_cursor IS
    SELECT RA,NOME,SEXO
    FROM ALUNO;
BEGIN
  DELETE FROM aluno_f;
  DELETE FROM aluno_m;
  OPEN aluno_cursor;
  LOOP
      FETCH aluno_cursor INTO v_codigo, v_nome, v_sexo;
      EXIT WHEN aluno_cursor%NOTFOUND;
      IF v_sexo='F' THEN
         INSERT INTO aluno_f (ra,nome) values(v_codigo,v_nome);
      ELSE
         INSERT INTO aluno_m (ra,nome) values(v_codigo,v_nome);
      END IF;
  END LOOP;
  COMMIT;
  CLOSE aluno_cursor;
END;
/