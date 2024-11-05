-- Table Conference
CREATE TABLE CONFERENCE (
    ID INT PRIMARY KEY,
    PARTICIPANT_COUNT INT CHECK (PARTICIPANT_COUNT > 0),
    EVENT_DATE DATE CHECK (EVENT_DATE > CURRENT_DATE),
    LOCATION VARCHAR(100),
    ORGANIZER VARCHAR(50),
    TOPIC VARCHAR(100),
    DURATION FLOAT CHECK (DURATION > 0),
    STATUS VARCHAR(50) CHECK (STATUS IN ('Active', 'Planned', 'Cancelled'))
);


-- Table Speaker
CREATE TABLE Speaker (
    id INT PRIMARY KEY,
    conference_id INT REFERENCES Conference(id),
    speaker VARCHAR(100)
);

-- Table Participant
CREATE TABLE Participant (
    id INT PRIMARY KEY,
    conference_id INT REFERENCES Conference(id),
    participant VARCHAR(100)
);

CREATE TABLE API (
    ID INT PRIMARY KEY,
    TYPE VARCHAR(50) CHECK (TYPE IN ('REST', 'SOAP')),
    VERSION VARCHAR(10) CHECK (VERSION ~ '^[0-9]+\\.[0-9]+$'), 
    URL VARCHAR(255) CHECK (URL ~ '^(https?|ftp)://[\\w\\-]+(\\.[\\w\\-]+)+[/#?]?.*$'),
    AUTHORIZATION VARCHAR(100) CHECK (AUTHORIZATION IN ('Token-based', 'OAuth'))
);

-- Table SupportedMethodsAPI
CREATE TABLE SupportedMethodsAPI (
    id INT PRIMARY KEY,
    api_id INT REFERENCES API(id),
    method VARCHAR(20) CHECK (method IN ('GET', 'POST', 'PUT', 'DELETE'))
);

-- Table TemperatureAPI
CREATE TABLE TemperatureAPI (
    id INT PRIMARY KEY,
    api_id INT REFERENCES API(id),
    currentTemperature FLOAT,
    targetTemperature FLOAT,
    minTemperature FLOAT,
    maxTemperature FLOAT,
    lastUpdated DATETIME CHECK (lastUpdated > CURRENT_TIMESTAMP - INTERVAL '1 DAY'), -- Must be recent
    sensorStatus VARCHAR(50) CHECK (sensorStatus IN ('Active', 'Inactive', 'Faulty'))
);

-- Table Configuration
CREATE TABLE Configuration (
    id INT PRIMARY KEY,
    parameters VARCHAR(200),
    autoUpdateInterval INT CHECK (autoUpdateInterval > 0),
    locale VARCHAR(20) CHECK (locale IN ('en-US', 'uk-UA')),
    dateFormat VARCHAR(20) CHECK (dateFormat IN ('DD/MM/YYYY', 'MM/DD/YYYY')),
    temperatureFormat VARCHAR(5) CHECK (temperatureFormat IN ('°C', '°F'))
);
