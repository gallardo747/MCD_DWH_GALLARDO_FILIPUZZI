--STORED PROCEDURES

CREATE PROCEDURE LOG.DWH_Start_Log
    @JobId INT,
    @Status VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StatusId INT;

    -- Buscar el ID del estado
    SELECT @StatusId = AUDSP_Status_Id
    FROM LOG.AUDIT_STATUS_PROCESS
    WHERE AUDPD_Status = @Status AND AUDPD_ACTIVE_FLAG = 1;

    IF @StatusId IS NULL
    BEGIN
        RAISERROR('El estado "%s" no existe o está inactivo.', 16, 1, @Status);
        RETURN;
    END

    -- Insertar nuevo log de inicio
    INSERT INTO LOG.AUDIT_PROCESS_DATE (AUDPD_JobId, AUDPD_Start_Date, AUDPD_Status_ID)
    VALUES (@JobId, GETDATE(), @StatusId);
END;



CREATE PROCEDURE LOG.DWH_End_Log
    @JobId INT,
    @Status VARCHAR(50),
    @Observations VARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StatusId INT;

    -- Buscar el ID del estado
    SELECT @StatusId = AUDSP_Status_Id
    FROM LOG.AUDIT_STATUS_PROCESS
    WHERE AUDPD_Status = @Status AND AUDPD_ACTIVE_FLAG = 1;

    IF @StatusId IS NULL
    BEGIN
        RAISERROR('El estado "%s" no existe o está inactivo.', 16, 1, @Status);
        RETURN;
    END

    -- Actualizar el registro más reciente para el JobId (sin END date)
    UPDATE LOG.AUDIT_PROCESS_DATE
    SET AUDPD_END_Data = GETDATE(),
        AUDPD_Status_ID = @StatusId,
        AUDPD_Observations = @Observations
    WHERE AUDPD_JobId = @JobId
      AND AUDPD_END_Data IS NULL
      AND AUDPD_Start_Date = (
          SELECT MAX(AUDPD_Start_Date)
          FROM LOG.AUDIT_PROCESS_DATE
          WHERE AUDPD_JobId = @JobId AND AUDPD_END_Data IS NULL
      );

    IF @@ROWCOUNT = 0
    BEGIN
        RAISERROR('No se encontró un proceso activo para el JobId %d.', 16, 1, @JobId);
    END
END;



CREATE PROCEDURE LOG.Register_Data_Quality
    @EntityName VARCHAR(100),
    @TotalRecords INT,
    @InvalidRecords INT,
    @PercentInvalid DECIMAL(5,2),
    @CheckDate DATETIME = NULL,
    @JobId INT = NULL,
    @Observations VARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF @CheckDate IS NULL
        SET @CheckDate = GETDATE();

    INSERT INTO LOG.DATA_QUALITY_CHECKS (
        AUDDQ_ENTITY_NAME,
        AUDDQ_TOTAL_RECORDS,
        AUDDQ_INVALID_RECORDS,
        AUDDQ_PERCENT_INVALID,
        AUDDQ_CHECK_DATE,
        AUDDQ_JOB_ID,
        AUDDQ_OBSERVATIONS
    )
    VALUES (
        @EntityName,
        @TotalRecords,
        @InvalidRecords,
        @PercentInvalid,
        @CheckDate,
        @JobId,
        @Observations
    );
END;
