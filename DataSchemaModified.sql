-- Table Conference
CREATE TABLE CONFERENCE (
    ID INT PRIMARY KEY,
    PARTICIPANT_COUNT INT CHECK (PARTICIPANT_COUNT > 0),
    EVENT_DATE DATE CHECK (EVENT_DATE > CURRENT_DATE), -- Date must be in the future
    LOCATION VARCHAR(100) CHECK (
        LOCATION ~ '^[A-Za-z0-9\\s,]+$' -- Only letters, numbers, spaces, and commas
    ),
    ORGANIZER VARCHAR(50),
    TOPIC VARCHAR(100),
    DURATION FLOAT CHECK (DURATION > 0),
    STATUS VARCHAR(50) CHECK (STATUS IN ('Active', 'Planned', 'Cancelled'))
);

-- Table Speaker
CREATE TABLE SPEAKER (
    ID INT PRIMARY KEY,
    CONFERENCE_ID INT REFERENCES CONFERENCE(ID),
    SPEAKER VARCHAR(100)
);

-- Table Participant
CREATE TABLE PARTICIPANT (
    ID INT PRIMARY KEY,
    CONFERENCE_ID INT REFERENCES CONFERENCE(ID),
    PARTICIPANT VARCHAR(100)
);

-- Table API
CREATE TABLE API (
   CREATE TABLE API (
    id INT PRIMARY KEY,
    type VARCHAR(50) CHECK (type IN ('REST', 'SOAP')),
    version VARCHAR(10) CHECK (version SIMILAR TO '[0-9]+\\.[0-9]+'), -- Using SIMILAR TO
    url VARCHAR(255) CHECK (
        url SIMILAR TO '(https?|ftp)://[\\w\\-]+(\\.[\\w\\-]+)+[/#?]?.*'
    ), -- Replacing ~ with SIMILAR TO for SQLFluff compatibility
    authorization VARCHAR(100) CHECK (authorization IN ('Token-based', 'OAuth'))
);

-- Table SupportedMethodsAPI
CREATE TABLE SUPPORTED_METHODS_API (
    ID INT PRIMARY KEY,
    API_ID INT REFERENCES API(ID),
    METHOD VARCHAR(20) CHECK (METHOD IN ('GET', 'POST', 'PUT', 'DELETE'))
);

-- Table TemperatureAPI
CREATE TABLE TEMPERATURE_API (
    ID INT PRIMARY KEY,
    API_ID INT REFERENCES API(ID),
    CURRENT_TEMPERATURE FLOAT,
    TARGET_TEMPERATURE FLOAT,
    MIN_TEMPERATURE FLOAT,
    MAX_TEMPERATURE FLOAT,
    LAST_UPDATED TIMESTAMP CHECK (
        LAST_UPDATED > CURRENT_TIMESTAMP - INTERVAL '1 DAY' -- Must be recent
    ),
    SENSOR_STATUS VARCHAR(50) CHECK (SENSOR_STATUS IN ('Active', 'Inactive', 'Faulty'))
);

-- Table Configuration
CREATE TABLE CONFIGURATION (
    ID INT PRIMARY KEY,
    PARAMETERS VARCHAR(200),
    AUTO_UPDATE_INTERVAL INT CHECK (AUTO_UPDATE_INTERVAL > 0),
    LOCALE VARCHAR(20) CHECK (LOCALE IN ('en-US', 'uk-UA')),
    DATE_FORMAT VARCHAR(20) CHECK (DATE_FORMAT IN ('DD/MM/YYYY', 'MM/DD/YYYY')),
    TEMPERATURE_FORMAT VARCHAR(5) CHECK (TEMPERATURE_FORMAT IN ('°C', '°F'))
);
