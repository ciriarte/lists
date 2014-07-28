DECLARE @owner_login VARCHAR(MAX)
SELECT @owner_login = SL.Name
FROM master..sysdatabases SD 
JOIN master..syslogins SL ON  SD.SID = SL.SID
WHERE  SD.Name = DB_NAME()
PRINT @owner_login

DECLARE @dropUserCommand VARCHAR(MAX) = 'SP_DROPUSER [<<owner_login>>]'

SELECT @dropUserCommand = REPLACE(@dropUserCommand, '<<owner_login>>', @owner_login)

PRINT @dropUserCommand
EXEC(@dropUserCommand)

DECLARE @Command VARCHAR(MAX) = 'ALTER AUTHORIZATION ON DATABASE::<<DatabaseName>> TO 
[<<LoginName>>]' 

SELECT @Command = REPLACE(REPLACE(@Command 
            , '<<DatabaseName>>', SD.Name)
            , '<<LoginName>>', SL.Name)
FROM master..sysdatabases SD 
JOIN master..syslogins SL ON  SD.SID = SL.SID
WHERE  SD.Name = DB_NAME()

PRINT @Command
EXEC(@Command)
