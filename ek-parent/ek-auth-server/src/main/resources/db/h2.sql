;
CREATE USER IF NOT EXISTS ADMIN SALT 'f8105a41eee67577' HASH 'ad835da93878a6c1a54ed60c14ebfd076ac2845f56cdbf251add825d1a13a977' ADMIN;
CREATE SEQUENCE PUBLIC.HIBERNATE_SEQUENCE START WITH 1;
CREATE SEQUENCE PUBLIC.SYSTEM_SEQUENCE_3B78AF8E_FBFF_4BF3_875E_345427E46D39 START WITH 0 BELONGS_TO_TABLE;
CREATE SEQUENCE PUBLIC.SYSTEM_SEQUENCE_760D1959_3C21_451E_8DBB_B31158F386F4 START WITH 0 BELONGS_TO_TABLE;
CREATE CACHED TABLE PUBLIC.OAUTH_CLIENT_DETAILS(
    CLIENT_ID VARCHAR(256) NOT NULL,
    RESOURCE_IDS VARCHAR(256),
    CLIENT_SECRET VARCHAR(256),
    SCOPE VARCHAR(256),
    AUTHORIZED_GRANT_TYPES VARCHAR(256),
    WEB_SERVER_REDIRECT_URI VARCHAR(256),
    AUTHORITIES VARCHAR(256),
    ACCESS_TOKEN_VALIDITY INTEGER,
    REFRESH_TOKEN_VALIDITY INTEGER,
    ADDITIONAL_INFORMATION VARCHAR(4096),
    AUTOAPPROVE VARCHAR(256)
);
ALTER TABLE PUBLIC.OAUTH_CLIENT_DETAILS ADD CONSTRAINT PUBLIC.CONSTRAINT_A PRIMARY KEY(CLIENT_ID);
-- 1 +/- SELECT COUNT(*) FROM PUBLIC.OAUTH_CLIENT_DETAILS;
INSERT INTO PUBLIC.OAUTH_CLIENT_DETAILS(CLIENT_ID, RESOURCE_IDS, CLIENT_SECRET, SCOPE, AUTHORIZED_GRANT_TYPES, WEB_SERVER_REDIRECT_URI, AUTHORITIES, ACCESS_TOKEN_VALIDITY, REFRESH_TOKEN_VALIDITY, ADDITIONAL_INFORMATION, AUTOAPPROVE) VALUES
('client', 'elie-web', '$2a$10$osxShfLD0THyyDOJWg230.Z1uaUIipLHDsPJO2B84ULGRW8SIIkpC', 'account_info,photos', 'authorization_code,refresh_token', 'https://localhost:8443/ek-web/', 'ROLE_TRUSTED_CLIENT', 300, 600, '{}', 'false');
CREATE CACHED TABLE PUBLIC.OAUTH_CLIENT_TOKEN(
    TOKEN_ID VARCHAR(256),
    TOKEN LONGVARBINARY,
    AUTHENTICATION_ID VARCHAR(256) NOT NULL,
    USER_NAME VARCHAR(256),
    CLIENT_ID VARCHAR(256)
);
ALTER TABLE PUBLIC.OAUTH_CLIENT_TOKEN ADD CONSTRAINT PUBLIC.CONSTRAINT_E PRIMARY KEY(AUTHENTICATION_ID);
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.OAUTH_CLIENT_TOKEN;
CREATE CACHED TABLE PUBLIC.OAUTH_ACCESS_TOKEN(
    TOKEN_ID VARCHAR(256),
    TOKEN LONGVARBINARY,
    AUTHENTICATION_ID VARCHAR(256) NOT NULL,
    USER_NAME VARCHAR(256),
    CLIENT_ID VARCHAR(256),
    AUTHENTICATION LONGVARBINARY,
    REFRESH_TOKEN VARCHAR(256)
);
ALTER TABLE PUBLIC.OAUTH_ACCESS_TOKEN ADD CONSTRAINT PUBLIC.CONSTRAINT_D PRIMARY KEY(AUTHENTICATION_ID);
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.OAUTH_ACCESS_TOKEN;
CREATE CACHED TABLE PUBLIC.OAUTH_REFRESH_TOKEN(
    TOKEN_ID VARCHAR(256),
    TOKEN LONGVARBINARY,
    AUTHENTICATION LONGVARBINARY
);
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.OAUTH_REFRESH_TOKEN;
CREATE CACHED TABLE PUBLIC.OAUTH_CODE(
    CODE VARCHAR(256),
    AUTHENTICATION LONGVARBINARY
);
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.OAUTH_CODE;
CREATE CACHED TABLE PUBLIC.OAUTH_APPROVALS(
    USERID VARCHAR(256),
    CLIENTID VARCHAR(256),
    SCOPE VARCHAR(256),
    STATUS VARCHAR(10),
    EXPIRESAT TIMESTAMP,
    LASTMODIFIEDAT TIMESTAMP
);
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.OAUTH_APPROVALS;
CREATE CACHED TABLE PUBLIC.AUTHORITIES(
    USERNAME VARCHAR_IGNORECASE(50) NOT NULL,
    AUTHORITY VARCHAR_IGNORECASE(50) NOT NULL
);
-- 1 +/- SELECT COUNT(*) FROM PUBLIC.AUTHORITIES;
INSERT INTO PUBLIC.AUTHORITIES(USERNAME, AUTHORITY) VALUES
(CAST('elie' AS VARCHAR_IGNORECASE), CAST('ROLE_USER' AS VARCHAR_IGNORECASE));
CREATE UNIQUE INDEX PUBLIC.IX_AUTH_USERNAME ON PUBLIC.AUTHORITIES(USERNAME, AUTHORITY);
CREATE CACHED TABLE PUBLIC.GROUPS(
    ID BIGINT DEFAULT (NEXT VALUE FOR PUBLIC.SYSTEM_SEQUENCE_760D1959_3C21_451E_8DBB_B31158F386F4) NOT NULL NULL_TO_DEFAULT SEQUENCE PUBLIC.SYSTEM_SEQUENCE_760D1959_3C21_451E_8DBB_B31158F386F4,
    GROUP_NAME VARCHAR_IGNORECASE(50) NOT NULL
);
ALTER TABLE PUBLIC.GROUPS ADD CONSTRAINT PUBLIC.CONSTRAINT_7 PRIMARY KEY(ID);
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.GROUPS;
CREATE CACHED TABLE PUBLIC.GROUP_AUTHORITIES(
    GROUP_ID BIGINT NOT NULL,
    AUTHORITY VARCHAR(50) NOT NULL
);
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.GROUP_AUTHORITIES;
CREATE CACHED TABLE PUBLIC.GROUP_MEMBERS(
    ID BIGINT DEFAULT (NEXT VALUE FOR PUBLIC.SYSTEM_SEQUENCE_3B78AF8E_FBFF_4BF3_875E_345427E46D39) NOT NULL NULL_TO_DEFAULT SEQUENCE PUBLIC.SYSTEM_SEQUENCE_3B78AF8E_FBFF_4BF3_875E_345427E46D39,
    USERNAME VARCHAR(50) NOT NULL,
    GROUP_ID BIGINT NOT NULL
);
ALTER TABLE PUBLIC.GROUP_MEMBERS ADD CONSTRAINT PUBLIC.CONSTRAINT_F PRIMARY KEY(ID);
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.GROUP_MEMBERS;
CREATE CACHED TABLE PUBLIC.PERSISTENT_LOGINS(
    USERNAME VARCHAR(64) NOT NULL,
    SERIES VARCHAR(64) NOT NULL,
    TOKEN VARCHAR(64) NOT NULL,
    LAST_USED TIMESTAMP NOT NULL
);
ALTER TABLE PUBLIC.PERSISTENT_LOGINS ADD CONSTRAINT PUBLIC.CONSTRAINT_A3 PRIMARY KEY(SERIES);
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.PERSISTENT_LOGINS;
CREATE CACHED TABLE PUBLIC.PERSONAL_DATA(
    ID INTEGER NOT NULL,
    CHANGED TIMESTAMP,
    EMAIL VARCHAR(200) NOT NULL,
    FIRST_NAME VARCHAR(100) NOT NULL,
    LAST_NAME VARCHAR(100) NOT NULL,
    USERNAME VARCHAR(255) NOT NULL
);
ALTER TABLE PUBLIC.PERSONAL_DATA ADD CONSTRAINT PUBLIC.CONSTRAINT_DE PRIMARY KEY(ID);
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.PERSONAL_DATA;
CREATE CACHED TABLE PUBLIC.USERS(
    USERNAME VARCHAR_IGNORECASE(50) NOT NULL,
    PASSWORD VARCHAR_IGNORECASE(500) NOT NULL,
    ENABLED BOOLEAN NOT NULL,
    CHANGED TIMESTAMP
);
ALTER TABLE PUBLIC.USERS ADD CONSTRAINT PUBLIC.CONSTRAINT_4 PRIMARY KEY(USERNAME);
-- 1 +/- SELECT COUNT(*) FROM PUBLIC.USERS;
INSERT INTO PUBLIC.USERS(USERNAME, PASSWORD, ENABLED, CHANGED) VALUES
(CAST('elie' AS VARCHAR_IGNORECASE), CAST('$2a$10$osxShfLD0THyyDOJWg230.Z1uaUIipLHDsPJO2B84ULGRW8SIIkpC' AS VARCHAR_IGNORECASE), TRUE, TIMESTAMP '2017-03-05 12:31:58.091');
ALTER TABLE PUBLIC.PERSONAL_DATA ADD CONSTRAINT PUBLIC.UK_41J3WPXGTJMTWB27TVWLRYKCR UNIQUE(USERNAME);
ALTER TABLE PUBLIC.GROUP_MEMBERS ADD CONSTRAINT PUBLIC.FK_GROUP_MEMBERS_GROUP FOREIGN KEY(GROUP_ID) REFERENCES PUBLIC.GROUPS(ID) NOCHECK;
ALTER TABLE PUBLIC.PERSONAL_DATA ADD CONSTRAINT PUBLIC.FKQYIGENI2I3WV3YUOYGXDGIWF9 FOREIGN KEY(USERNAME) REFERENCES PUBLIC.USERS(USERNAME) NOCHECK;
ALTER TABLE PUBLIC.GROUP_AUTHORITIES ADD CONSTRAINT PUBLIC.FK_GROUP_AUTHORITIES_GROUP FOREIGN KEY(GROUP_ID) REFERENCES PUBLIC.GROUPS(ID) NOCHECK;
