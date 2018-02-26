USE flamsteed
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

	/*CURSOR OPENING, MANIPULATION LOOP AND CURSOR DEALLOCATION*/
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
	
    /*CURSOR OPENING, MANIPULATION LOOP AND CURSOR DEALLOCATION*/
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

	/*CURSOR OPENING, MANIPULATION LOOP AND CURSOR DEALLOCATION*/
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

	/*CURSOR OPENING, MANIPULATION LOOP AND CURSOR DEALLOCATION*/
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

DROP PROCEDURE IF EXISTS apparentMagnitude
GO

CREATE PROCEDURE apparentMagnitude(@roundingPrecision INT) AS

BEGIN

	/*VARIABLE DECLARATION*/
	DECLARE @fetchedDesignation AS VARCHAR(45)
    DECLARE @fetchedAbsoluteMagnitude AS FLOAT
	DECLARE @fetchedParsecs AS FLOAT

	/*CURSOR DECLARATION*/
	DECLARE stellarCursor CURSOR FOR SELECT designation, absoluteMagnitude, parsecs FROM stellarParameters

	/*CURSOR OPENING, MANIPULATION LOOP AND CURSOR DEALLOCATION*/	
	OPEN stellarCursor
	FETCH NEXT FROM stellarCursor INTO @fetchedDesignation, @fetchedAbsoluteMagnitude, @fetchedParsecs

	WHILE @@FETCH_STATUS = 0
		BEGIN
			UPDATE stellarParameters SET apparentMagnitude = ROUND(@fetchedAbsoluteMagnitude - (5 * (1 - LOG(10, @fetchedParsecs))), @roundingPrecision) WHERE designation LIKE @fetchedDesignation
            FETCH NEXT FROM stellarCursor INTO @fetchedDesignation, @fetchedAbsoluteMagnitude, @fetchedParsecs
        END
		 
    CLOSE stellarCursor
    DEALLOCATE stellarCursor

END
GO

DROP PROCEDURE IF EXISTS bolometricMagnitude
GO

CREATE PROCEDURE bolometricMagnitude(@roundingPrecision INT) AS

BEGIN

	/*VARIABLE DECLARATION*/
	DECLARE @fetchedDesignation AS VARCHAR(45)
	DECLARE @fetchedAbsoluteMagnitude AS FLOAT
	DECLARE @fetchedMagnitudeCorrection AS FLOAT

	/*CURSOR DECLARATION*/
	DECLARE stellarCursor CURSOR FOR SELECT designation, absoluteMagnitude, magnitudeCorrection FROM stellarBolometricsTransient

	/*CURSOR OPENING, MANIPULATION LOOP AND CURSOR DEALLOCATION*/
	OPEN stellarCursor
	FETCH NEXT FROM stellarCursor INTO @fetchedDesignation, @fetchedAbsoluteMagnitude, @fetchedMagnitudeCorrection

		BEGIN  
			UPDATE stellarParameters SET bolometricMagnitude = ROUND((@fetchedAbsoluteMagnitude + @fetchedMagnitudeCorrection), @roundingPrecision) WHERE designation LIKE @fetchedDesignation
			FETCH NEXT FROM stellarCursor INTO @fetchedDesignation, @fetchedAbsoluteMagnitude, @fetchedMagnitudeCorrection
        END

    CLOSE stellarCursor
	DEALLOCATE stellarCursor

END    
GO

DROP PROCEDURE IF EXISTS distanceConversion
GO

CREATE PROCEDURE distanceConversion(@preferredConversion INT, @roundingPrecision INT) AS

BEGIN

	/*VARIABLE DECLARATION*/
	DECLARE @fetchedDesignation AS VARCHAR(45)
	DECLARE @fetchedParsecs AS FLOAT
	DECLARE @fetchedLightYears AS FLOAT
    
	/*CONSTANT DECLARATION AND INITIALISATION*/
    DECLARE @constantParsecsConversion AS FLOAT = 0.306594845
    DECLARE @constantLightYearsConversion AS FLOAT = 3.261633440
    
	/*CURSOR DECLARATION*/
    DECLARE stellarCursor CURSOR FOR SELECT designation, parsecs, lightYears FROM stellarParameters
    			
	/*CURSOR OPENING, CURSOR DEALLOCATION*/
	OPEN stellarCursor
	FETCH NEXT FROM stellarCursor INTO @fetchedDesignation, @fetchedParsecs, @fetchedLightYears
    
    /*MANIPULATION LOOP WITH CONDITIONAL LOGIC DEPENDENT ON THE OPTION SPECIFIED*/    
    WHILE @@FETCH_STATUS = 0 BEGIN
		IF @preferredConversion = 0 BEGIN
			UPDATE stellarParameters SET parsecs = ROUND((@fetchedLightYears * @constantParsecsConversion), @roundingPrecision) WHERE designation LIKE @fetchedDesignation
			FETCH NEXT FROM stellarCursor INTO @fetchedDesignation, @fetchedParsecs, @fetchedLightYears
		END
		ELSE IF @preferredConversion = 1 BEGIN
			UPDATE stellarParameters SET lightYears = ROUND((@fetchedParsecs * @constantLightYearsConversion), @roundingPrecision) WHERE designation LIKE @fetchedDesignation
			FETCH NEXT FROM stellarCursor INTO @fetchedDesignation, @fetchedParsecs, @fetchedLightYears
		END
	END

    CLOSE stellarCursor
	DEALLOCATE stellarCursor 

END
GO

DROP PROCEDURE IF EXISTS goldilocksBoundaries
GO

CREATE PROCEDURE goldilocksBoundaries(@roundingPrecision INT) AS

BEGIN
	
	/*FETCHED VARIABLES DECLARATION*/
	DECLARE @fetchedDesignation AS VARCHAR(45)
	DECLARE @fetchedBolometricLuminosity AS FLOAT	
	
	/*CONSTANT VARIABLES DECLARATION AND INITIALISATION*/	
	DECLARE @constantInnerBoundary AS FLOAT = 1.10
	DECLARE @constantOuterBoundary AS FLOAT = 0.53
	DECLARE @constantGoldilocks AS FLOAT = 2.795883
	DECLARE @constantgregorianYear AS FLOAT = 365.2425
    
	/*TEMPORARY VARIABLES DECLARATION*/
    DECLARE @tempCurrentInner AS FLOAT
    DECLARE @tempcurrentOuter AS FLOAT

	/*CURSOR DECLARATION*/
	DECLARE stellarCursor CURSOR FOR SELECT designation, bolometricLuminosity FROM stellarParameters

    /*CURSOR OPENING, MANIPULATION LOOP AND CURSOR DEALLOCATION*/
	OPEN stellarCursor
	FETCH NEXT FROM stellarCursor INTO @fetchedDesignation, @fetchedBolometricLuminosity

    WHILE @@FETCH_STATUS = 0 BEGIN
            
		SET @tempCurrentInner = ROUND((@fetchedBolometricLuminosity / @constantInnerBoundary), @roundingPrecision)
		SET @tempcurrentOuter = ROUND((@fetchedBolometricLuminosity / @constantOuterBoundary), @roundingPrecision)
            
        UPDATE stellarParameters 
            SET
            innerBoundary = SQRT(@tempCurrentInner),
            outerBoundary = SQRT(@tempCurrentOuter),
            gregorianYear = ROUND((((@tempCurrentInner + @tempCurrentOuter) / @constantGoldilocks) * @constantGregorianYear), @roundingPrecision)
        WHERE designation LIKE @fetchedDesignation;
		FETCH NEXT FROM stellarCursor INTO @fetchedDesignation, @fetchedBolometricLuminosity
                
        END    
    CLOSE stellarCursor
	DEALLOCATE stellarCursor 
   
END
GO

DROP PROCEDURE IF EXISTS stellarDiameter
GO

CREATE PROCEDURE stellarDiameter(@roundingPrecision INT) AS

BEGIN

	/*FETCHED VARIABLES DECLARATION*/
	DECLARE @fetchedDesignation AS VARCHAR(45)
	DECLARE @fetchedTemperature AS FLOAT
	DECLARE @fetchedBolometricMagnitude AS FLOAT

	/*CONSTANT VARIABLES DECLARATION AND INITIALISATION*/
	DECLARE @constantSolarTemperature AS FLOAT = 5777
	DECLARE @constantSolarBolometric AS FLOAT = 4.75
	DECLARE @constantPogson AS FLOAT = 2.511886431
    
	/*TEMPORARY VARIABLES DECLARATION*/
    DECLARE @tempPower1 AS FLOAT
    DECLARE @tempPower2 AS FLOAT
    DECLARE @tempPower3 AS FLOAT

	/*CURSOR DECLARATION*/
	DECLARE stellarCursor CURSOR FOR SELECT designation, temperatureKelvin, bolometricMagnitude FROM stellarDiametersTransient

    /*CURSOR OPENING, MANIPULATION LOOP AND CURSOR DEALLOCATION*/
	OPEN stellarCursor
	FETCH NEXT FROM stellarCursor INTO @fetchedDesignation, @fetchedTemperature, @fetchedBolometricMagnitude

	WHILE @@FETCH_STATUS = 0 BEGIN

		SET @tempPower1 = POWER((@constantSolarTemperature / @fetchedTemperature), 2)
        SET @tempPower2 = POWER(@constantPogson, (@constantSolarBolometric - @fetchedBolometricMagnitude))
        SET @tempPower3 = POWER(@tempPower2, 0.5)
            
        UPDATE stellarParameters SET solarDiameter = ROUND((@tempPower1 * @tempPower3), @roundingPrecision) WHERE designation LIKE @fetchedDesignation
        FETCH NEXT FROM stellarCursor INTO @fetchedDesignation, @fetchedTemperature, @fetchedBolometricMagnitude
    END  
	  
    CLOSE stellarCursor
    DEALLOCATE stellarCursor

END
GO
