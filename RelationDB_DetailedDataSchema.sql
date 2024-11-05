-- RelationDB_DetailedDataSchema.sql

-- Table Conference
CREATE TABLE Conference (
    id INT PRIMARY KEY,
    participantCount INT CHECK (participantCount > 0),
    eventDate DATE CHECK (eventDate > CURRENT_DATE), -- Date must be in the future
    location VARCHAR(100) CHECK (location ~ '^[A-Za-z0-9\\s,]+$'), -- Only letters, numbers, spaces, and commas
    organizer VARCHAR(50),
    topic VARCHAR(100),
    duration FLOAT CHECK (duration > 0),
    status VARCHAR(50) CHECK (status IN ('Active', 'Planned', 'Cancelled'))
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

-- Table API
CREATE TABLE API (
    id INT PRIMARY KEY,
    type VARCHAR(50) CHECK (type IN ('REST', 'SOAP')),
    version VARCHAR(10) CHECK (version ~ '^[0-9]+\\.[0-9]+$'), -- Format like "1.0"
    url VARCHAR(255) CHECK (url ~ '^(https?|ftp)://[\\w\\-]+(\\.[\\w\\-]+)+[/#?]?.*$'), -- Valid URL format
    authorization VARCHAR(100) CHECK (authorization IN ('Token-based', 'OAuth'))
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
