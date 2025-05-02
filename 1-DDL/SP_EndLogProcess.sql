USE [TP_DWH_MCD_2025]
GO
/****** Object:  StoredProcedure [LOG].[DWH_End_Log]    Script Date: 1/5/2025 22:45:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [LOG].[DWH_End_Log]
    @JobName VARCHAR(50),
    @StatusName VARCHAR(50),
    @Observations VARCHAR(100) = 'Fin automático'
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @JobId INT;
    DECLARE @StatusId INT;

    -- Obtener ID del Job activo
    SELECT @JobId = AUDJOB_Job_Id
    FROM [LOG].[AUDIT_JOBS]
    WHERE AUDJOB_Job_Name = @JobName
      AND AUDPD_ACTIVE_FLAG = 1;

    IF @JobId IS NULL
    BEGIN
        RAISERROR('No se encontró un Job activo con el nombre proporcionado.', 16, 1);
        RETURN;
    END

    -- Obtener ID del status activo
    SELECT @StatusId = AUDSP_Status_Id
    FROM [LOG].[AUDIT_STATUS_PROCESS]
    WHERE AUDPD_Status = @StatusName
      AND AUDPD_ACTIVE_FLAG = 1;

    IF @StatusId IS NULL
    BEGIN
        RAISERROR('No se encontró un estado activo con el nombre proporcionado.', 16, 1);
        RETURN;
    END

    -- Actualizar el último proceso sin finalizar del Job
	UPDATE LOG.AUDIT_PROCESS_DATE
	SET 
		AUDPD_END_Data = GETDATE(),
		AUDPD_Status_ID = @StatusId,
		AUDPD_Observations = @Observations
	WHERE 
		AUDPD_JobId = @JobId
		AND AUDPD_END_Data IS NULL
		AND AUDPD_Id = (
			SELECT MAX(AUDPD_Id)
			FROM LOG.AUDIT_PROCESS_DATE
			WHERE 
				AUDPD_JobId = @JobId
				AND AUDPD_END_Data IS NULL
		);


    -- Validación adicional si no se encontró ningún proceso para cerrar
    IF @@ROWCOUNT = 0
    BEGIN
        RAISERROR('No se encontró ninguna ejecución en curso para el Job especificado.', 16, 1);
    END
END;
