/*TRIGGER para atualizar o n�mero de coletas e retiradas das tabelas catadores e usuarios depois de um INSERT na tabela coletas */


CREATE OR REPLACE TRIGGER TG_NROCOLETAS_AFTER_INSERT
AFTER INSERT
ON coletas


DECLARE
    v_coletas coletas%ROWTYPE;
    v_nrocoletas NUMBER(19,0);
    v_retiradas NUMBER(19,0);

BEGIN
    SELECT  * INTO v_coletas FROM coletas
    WHERE id = (SELECT MAX(id) FROM coletas);
    v_nrocoletas := v_coletas.catadorid_id;
    v_retiradas := v_coletas.usuarioid_id;

    /*Atualiza o n�mero de coletas do catador do usu�rio usando o ID de refer�ncia da tabela coletas*/    
    UPDATE catadores
    SET nro_coletas = nro_coletas + 1
    WHERE id = v_nrocoletas;

    /*Atualiza o n�mero de retiradas do usu�rio usando o ID de refer�ncia da tabela coletas*/
    UPDATE usuarios
    SET nro_retiradas = nro_retiradas + 1
    WHERE id = v_retiradas;
    
    COMMIT;
END;
/