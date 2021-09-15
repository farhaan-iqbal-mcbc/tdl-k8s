DROP FUNCTION IF EXISTS GETPARTITIONS;$

CREATE FUNCTION GETPARTITIONS(@pConfigurationId NVARCHAR(4000))
    RETURNS INT
    AS
    BEGIN
    DECLARE @PARTITION INT;
        SELECT @PARTITION = CAST(PROPERTY_VALUE AS INT)
            FROM TAFJ_CONFIGURATION
                WHERE CONFIGURATION_ID = @pConfigurationId
                     AND PROPERTY_KEY = 'temn.cache.f.data.events.partition.size';
                        IF(@PARTITION IS NULL)
                          SET @PARTITION = 1;
            RETURN @PARTITION;
    END;$
	
DROP FUNCTION IF EXISTS GETPARTITIONID;$

CREATE FUNCTION GETPARTITIONID(@pConfigurationId NVARCHAR(4000) = 'EventStreamingConf', @nextSequenceValue INT)
    RETURNS INT
    BEGIN
        DECLARE @PARTITIONS INT,
                @PARTITIONID INT;
        exec @PARTITIONS = GETPARTITIONS @pConfigurationId;
        SET @PARTITIONID = (@nextSequenceValue % @PARTITIONS) +1;
             IF(@PARTITIONID IS NULL)
                 SET @PARTITIONID = NULL;
             RETURN @PARTITIONID;
    END;$