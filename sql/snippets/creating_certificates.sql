SELECT *
  FROM sys.certificates

CREATE CERTIFICATE [TrustyTheCert] 
   WITH SUBJECT = 'As secure as the moment I leave it in my desk',
    START_DATE='03/01/2015', --make sure this is a day prior to the current date
    EXPIRY_DATE='03/01/2030'; --make sure this is set out 10-20 years
GO

-- Technically not needed, but this is how you assign it to an endpoint
ALTER ENDPOINT SomeEndpointIWantToSecure 
FOR SERVICE_BROKER (AUTHENTICATION = CERTIFICATE [TrustyTheCert]) -- Can also be a replication endpoint
GO
