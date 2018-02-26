USE bayer
GO

DROP PROCEDURE IF EXISTS solarMass
GO

CREATE PROCEDURE solarMass(@roundingPrecision INT) AS

BEGIN

	/*VARIABLE DECLARATION*/
	DECLARE @fetchedDesignation AS VARCHAR(45)
	DECLARE @fetchedBolometricLuminosity AS FLOAT
	DECLARE @constantMass AS FLOAT

	/*CURSOR DECLARATION AND CONSTANT INITIALISATION*/
	DECLARE stellarCursor CURSOR FOR SELECT designation, bolometricLuminosity FROM stellarParameters
	SET @constantMass = 0.256

	/*CURSOR OPENING, UPDATE LOOP AND CURSOR DEALLOCATION*/
	OPEN stellarCursor;
	FETCH NEXT FROM stellarCursor INTO @fetchedDesignation, @fetchedBolometricLuminosity

	WHILE @@FETCH_STATUS = 0
		BEGIN		
			UPDATE stellarParameters SET solarMass = ROUND(POWER(@fetchedBolometricLuminosity, @constantMass), @roundingPrecision) WHERE designation LIKE @fetchedDesignation
			FETCH NEXT FROM stellarCursor INTO @fetchedDesignation, @fetchedBolometricLuminosity
		END

	CLOSE stellarCursor
	DEALLOCATE stellarCursor
        
END
GO

DROP PROCEDURE IF EXISTS absoluteLuminosity
GO

CREATE PROCEDURE absoluteLuminosity(@roundingPrecision INT) AS

BEGIN

	/*VARIABLE DECLARATION*/
	DECLARE @fetchedDesignation AS VARCHAR(45)
	DECLARE @fetchedAbsoluteMagnitude AS FLOAT
    DECLARE @constantAbsoluteSolar AS FLOAT

	/*CURSOR DECLARATION AND CONSTANT INITIALISATION*/
	DECLARE stellarCursor CURSOR FOR SELECT designation, absoluteMagnitude FROM stellarParameters
	SET @constantAbsoluteSolar = 4.83
	
    /*CURSOR OPENING, UPDATE LOOP AND CURSOR DEALLOCATION*/
	OPEN stellarCursor;
	FETCH NEXT FROM stellarCursor INTO @fetchedDesignation, @fetchedAbsoluteMagnitude

	WHILE @@FETCH_STATUS = 0
		BEGIN
			UPDATE stellarParameters SET absoluteLuminosity = ROUND(POWER(10, (@constantAbsoluteSolar - @fetchedAbsoluteMagnitude) / 2.5), @roundingPrecision) WHERE designation LIKE @fetchedDesignation
			FETCH NEXT FROM stellarCursor INTO @fetchedDesignation, @fetchedAbsoluteMagnitude
		END
	        
    CLOSE stellarCursor
	DEALLOCATE stellarCursor

END
GO

DROP PROCEDURE IF EXISTS bolometricLuminosity
GO

CREATE PROCEDURE bolometricLuminosity(@roundingPrecision INT) AS

BEGIN

	/*VARIABLE DECLARATION*/
	DECLARE @fetchedDesignation AS VARCHAR(45)
	DECLARE @fetchedBolometricMagnitude AS FLOAT
    DECLARE @constantBolometricSolar AS FLOAT

	/*CURSOR DECLARATION AND CONSTANT INITIALISATION*/
	DECLARE stellarCursor CURSOR FOR SELECT designation, bolometricMagnitude FROM stellarParameters
	SET @constantBolometricSolar = 4.75

	/*CURSOR OPENING, UPDATE LOOP AND CURSOR DEALLOCATION*/
	OPEN stellarCursor
	FETCH NEXT FROM stellarCursor INTO @fetchedDesignation, @fetchedBolometricMagnitude
    
    WHILE @@FETCH_STATUS = 0            
		BEGIN
			UPDATE stellarParameters SET bolometricLuminosity = ROUND(POWER(10, ((@constantBolometricSolar - @fetchedBolometricMagnitude) / 2.5)), @roundingPrecision) WHERE designation LIKE @fetchedDesignation;
			FETCH NEXT FROM stellarCursor INTO @fetchedDesignation, @fetchedBolometricMagnitude
		END

    CLOSE stellarCursor
	DEALLOCATE stellarCursor
		
END
GO

DROP PROCEDURE IF EXISTS absoluteMagnitude
GO

CREATE PROCEDURE absoluteMagnitude(@roundingPrecision INT) AS

BEGIN

	/*VARIABLE DECLARATION*/
	DECLARE @fetchedDesignation AS VARCHAR(45)
    DECLARE @fetchedApparentMagnitude AS FLOAT
	DECLARE @fetchedParsecs AS FLOAT

	/*CURSOR DECLARATION*/    
    DECLARE stellarCursor CURSOR FOR SELECT designation, apparentMagnitude, parsecs FROM stellarParameters

	/*CURSOR OPENING, UPDATE LOOP AND CURSOR DEALLOCATION*/
	OPEN stellarCursor
	FETCH NEXT FROM stellarCursor INTO @fetchedDesignation, @fetchedApparentMagnitude, @fetchedParsecs

	WHILE @@FETCH_STATUS = 0
		BEGIN    
			UPDATE stellarParameters SET absoluteMagnitude = ROUND(@fetchedApparentMagnitude - (5 * (LOG(10, @fetchedParsecs / 10))), @roundingPrecision) WHERE designation LIKE @fetchedDesignation;
			FETCH NEXT FROM stellarCursor INTO @fetchedDesignation, @fetchedApparentMagnitude, @fetchedParsecs
        END

    CLOSE stellarCursor
	DEALLOCATE stellarCursor
		       
END
GO
