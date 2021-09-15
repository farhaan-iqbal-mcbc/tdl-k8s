-- Undo changes if required
DROP TABLE IF EXISTS TMN_DES_CONFIG;
DROP TABLE IF EXISTS TMN_DES_AVRO_SCHEMA_EVENT;
DROP TABLE IF EXISTS TMN_DES_EVENT_ERROR;
DROP TABLE IF EXISTS TMN_DES_EVENT;
DROP TABLE IF EXISTS TMN_DES_EVENT_ROUTER;
DROP TABLE IF EXISTS TMN_DES_EPA_FAILOVER_LOCK;
DROP TABLE IF EXISTS TMN_DES_CONFIG_INSTALL_LOG;


-- DDL to populate the Streaming database (T24DATA field uses VARCHAR instead of CLOB for backward compatibility with H2 1.3.x)
CREATE TABLE TMN_DES_EVENT (ID VARCHAR(255) NOT NULL PRIMARY KEY, DATAEVENTID VARCHAR(255), DATAEVENTINDEX INT, CREATEDTIME TIMESTAMP, STAGINGTIME TIMESTAMP, EVENTTYPE VARCHAR(2), ENTITYNAME VARCHAR(40), ENTITYID VARCHAR(255), EVENTDATA BLOB, REQUESTID VARCHAR(255), PARTITIONID INT);
CREATE TABLE TMN_DES_EVENT_ROUTER (ID VARCHAR(255) NOT NULL PRIMARY KEY, DATAEVENTID VARCHAR(255), DISPATCHEDTIME TIMESTAMP, PARTITIONID INT);
CREATE TABLE TMN_DES_EVENT_ERROR (ID VARCHAR(255) NOT NULL PRIMARY KEY, DATAEVENTID VARCHAR(255), DATAEVENTSIZE INT, DATAEVENTINDEX INT, CREATEDTIME TIMESTAMP, FAILURETIME TIMESTAMP, EVENTTYPE VARCHAR(2), ENTITYNAME VARCHAR(40), ENTITYID VARCHAR(255), EVENTDATA BLOB, DESCRIPTION VARCHAR(255), ERRORTYPE VARCHAR(150), REQUESTID VARCHAR(255), ERRORSOURCE VARCHAR(150), METADATA VARCHAR(4000));
CREATE TABLE TMN_DES_AVRO_SCHEMA_EVENT (TABLENAME VARCHAR(255) NOT NULL, AVROSCHEMA BLOB, FROMDATE TIMESTAMP NOT NULL, TODATE TIMESTAMP NOT NULL, SERIALIZATIONID VARCHAR(255) DEFAULT 'N/A', STATUS VARCHAR(20), CONSTRAINT TMN_DES_AVRO_SCHEMA_EVENT_PK PRIMARY KEY (TABLENAME, FROMDATE, SERIALIZATIONID));
CREATE TABLE TMN_DES_CONFIG (CONFIGURATION_ID VARCHAR(255) NOT NULL, PROPERTY_KEY VARCHAR(255) NOT NULL, PROPERTY_VALUE VARCHAR(4000), DATE_MODIFIED VARCHAR(255), USER_NAME VARCHAR(255) NOT NULL, CONSTRAINT TMN_DES_CONFIG_PK PRIMARY KEY (CONFIGURATION_ID, PROPERTY_KEY));
CREATE TABLE TMN_DES_EPA_FAILOVER_LOCK (LOCK_KEY VARCHAR(50), INSTANCE_ID VARCHAR(50), MODIFIED_DATE TIMESTAMP NOT NULL, CONSTRAINT TMN_DES_EPA_FAILOVER_LOCK_PK PRIMARY KEY (LOCK_KEY));
CREATE TABLE TMN_DES_CONFIG_INSTALL_LOG(REFERENCE VARCHAR(255) NOT NULL PRIMARY KEY, TIME TIMESTAMP, STATUS VARCHAR(16), DETAILS VARCHAR);