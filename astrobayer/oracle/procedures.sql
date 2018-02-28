CREATE OR REPLACE PROCEDURE solarMass(roundingPrecision IN NUMBER DEFAULT 2) AS

BEGIN

    DECLARE   
    fetchedDesignation stellarParameters.designation%TYPE;
    fetchedBolometricLuminosity stellarParameters.bolometricLuminosity%TYPE;
    constantMass FLOAT := 0.256;
    
    CURSOR stellarCursor IS SELECT designation, bolometricLuminosity FROM stellarParameters;

    /*CURSOR OPENING, UPDATE LOOP AND CURSOR CLOSING*/
    BEGIN
        OPEN stellarCursor;
        LOOP
            
            FETCH stellarCursor INTO fetchedDesignation, fetchedBolometricLuminosity;
            EXIT WHEN stellarCursor%NOTFOUND;
            
            UPDATE stellarParameters 
                SET solarMass = ROUND(POWER(fetchedBolometricLuminosity, constantMass), roundingPrecision) 
            WHERE designation LIKE fetchedDesignation;
        
        END LOOP;
        CLOSE stellarCursor;
    END;
END;
/

CREATE OR REPLACE PROCEDURE absoluteLuminosity(roundingPrecision IN NUMBER DEFAULT 2) AS

BEGIN

	DECLARE 
    fetchedDesignation stellarParameters.designation%TYPE;
	fetchedAbsoluteMagnitude stellarParameters.absoluteMagnitude%TYPE;
    constantAbsoluteSolar FLOAT := 4.83;
    
    CURSOR stellarCursor IS SELECT designation, absoluteMagnitude FROM stellarParameters;
	
    /*CURSOR OPENING, UPDATE LOOP AND CURSOR CLOSING*/
	BEGIN
        OPEN stellarCursor;
        LOOP
        
            FETCH stellarCursor INTO fetchedDesignation, fetchedAbsoluteMagnitude;
            EXIT WHEN stellarCursor%NOTFOUND;
            
            UPDATE stellarParameters 
                SET absoluteLuminosity = ROUND(POWER(10, (constantAbsoluteSolar - fetchedAbsoluteMagnitude) / 2.5), roundingPrecision) 
            WHERE designation LIKE fetchedDesignation;
        
        END LOOP;        
        CLOSE stellarCursor;
    END;        
END;
/

CREATE OR REPLACE PROCEDURE bolometricLuminosity(roundingPrecision IN NUMBER DEFAULT 2) AS

BEGIN

	DECLARE 
    fetchedDesignation stellarParameters.designation%TYPE;
	fetchedBolometricMagnitude stellarParameters.bolometricMagnitude%TYPE;
    constantBolometricSolar FLOAT := 4.75;

	CURSOR stellarCursor IS SELECT designation, bolometricMagnitude FROM stellarParameters;	

	/*CURSOR OPENING, UPDATE LOOP AND CURSOR CLOSING*/	
    BEGIN 
        OPEN stellarCursor;
        LOOP
            
            FETCH stellarCursor INTO fetchedDesignation, fetchedBolometricMagnitude;
            EXIT WHEN stellarCursor%NOTFOUND;
            
            UPDATE stellarParameters 
                SET bolometricLuminosity = ROUND(POWER(10, ((constantBolometricSolar - fetchedBolometricMagnitude) / 2.5)), roundingPrecision) 
            WHERE designation LIKE fetchedDesignation;
            
        END LOOP;
        CLOSE stellarCursor;
    END;	
END;
/

CREATE OR REPLACE PROCEDURE absoluteMagnitude(roundingPrecision IN NUMBER DEFAULT 2) AS

BEGIN

	DECLARE 
    fetchedDesignation stellarParameters.designation%TYPE;	
    fetchedApparentMagnitude stellarParameters.apparentMagnitude%TYPE;
	fetchedParsecs stellarParameters.parsecs%TYPE;
    
    CURSOR stellarCursor IS SELECT designation, apparentMagnitude, parsecs FROM stellarParameters;

	/*CURSOR OPENING, UPDATE LOOP AND CURSOR CLOSING*/
    BEGIN
        OPEN stellarCursor;
        LOOP
        
            FETCH stellarCursor INTO fetchedDesignation, fetchedApparentMagnitude, fetchedParsecs;
            EXIT WHEN stellarCursor%NOTFOUND;
            
            UPDATE stellarParameters 
                SET absoluteMagnitude = ROUND(fetchedApparentMagnitude - (5 * (LOG(10, fetchedParsecs / 10))), roundingPrecision) 
            WHERE designation LIKE fetchedDesignation;
        
        END LOOP;
        CLOSE stellarCursor;
    END;        
END;
/

CREATE OR REPLACE PROCEDURE apparentMagnitude(roundingPrecision IN NUMBER DEFAULT 2) AS

BEGIN

	DECLARE 
    fetchedDesignation stellarParameters.designation%TYPE;
    fetchedAbsoluteMagnitude stellarParameters.absoluteMagnitude%TYPE;
	fetchedParsecs stellarParameters.parsecs%TYPE;

	CURSOR stellarCursor IS SELECT designation, absoluteMagnitude, parsecs FROM stellarParameters;

	/*CURSOR OPENING, UPDATE LOOP AND CURSOR CLOSING*/	
    BEGIN
        OPEN stellarCursor;
        LOOP
            
            FETCH stellarCursor INTO fetchedDesignation, fetchedAbsoluteMagnitude, fetchedParsecs;
            EXIT WHEN stellarCursor%NOTFOUND;
            
            UPDATE stellarParameters 
                SET apparentMagnitude = ROUND(fetchedAbsoluteMagnitude - (5 * (1 - LOG(10, fetchedParsecs))), roundingPrecision) 
            WHERE designation LIKE fetchedDesignation;
            
        END LOOP;
        CLOSE stellarCursor;
    END;    
END;
/

CREATE OR REPLACE PROCEDURE bolometricMagnitude(roundingPrecision IN NUMBER DEFAULT 2) AS

BEGIN

	DECLARE 
    fetchedDesignation stellarBolometricsTransient.designation%TYPE;
	fetchedAbsoluteMagnitude stellarBolometricsTransient.absoluteMagnitude%TYPE;
	fetchedMagnitudeCorrection stellarBolometricsTransient.magnitudeCorrection%TYPE;

	CURSOR stellarCursor IS SELECT designation, absoluteMagnitude, magnitudeCorrection FROM stellarBolometricsTransient;

	/*CURSOR OPENING, UPDATE LOOP AND CURSOR CLOSING*/
    BEGIN    
        OPEN stellarCursor;
        LOOP
        
            FETCH stellarCursor INTO fetchedDesignation, fetchedAbsoluteMagnitude, fetchedMagnitudeCorrection;
            EXIT WHEN stellarCursor%NOTFOUND;
            
            UPDATE stellarParameters 
                SET bolometricMagnitude = ROUND((fetchedAbsoluteMagnitude + fetchedMagnitudeCorrection), roundingPrecision) 
            WHERE designation LIKE fetchedDesignation;
        
        END LOOP;
        CLOSE stellarCursor;
    END;        
END;
/

CREATE OR REPLACE PROCEDURE distanceConversion(preferredConversion IN NUMBER DEFAULT 0, roundingPrecision IN NUMBER DEFAULT 2) AS

BEGIN

	DECLARE 
    fetchedDesignation stellarParameters.designation%TYPE;
	fetchedParsecs stellarParameters.parsecs%TYPE;
	fetchedLightYears stellarParameters.lightYears%TYPE;
    
    constantParsecsConversion FLOAT := 0.306594845;
    constantLightYearsConversion FLOAT := 3.261633440;
    
    CURSOR stellarCursor IS SELECT designation, parsecs, lightYears FROM stellarParameters;
    			
	/*CURSOR OPENING, UPDATE LOOP AND CURSOR CLOSING*/
    BEGIN
        OPEN stellarCursor;
        LOOP
        
            FETCH stellarCursor INTO fetchedDesignation, fetchedParsecs, fetchedLightYears;
            EXIT WHEN stellarCursor%NOTFOUND;
            
            IF preferredConversion = 0 THEN
            
                UPDATE stellarParameters 
                    SET parsecs = ROUND((fetchedLightYears * constantParsecsConversion), roundingPrecision) 
                WHERE designation LIKE fetchedDesignation;
                
            ELSIF preferredConversion = 1 THEN
            
                UPDATE stellarParameters 
                    SET lightYears = ROUND((fetchedParsecs * constantLightYearsConversion), roundingPrecision)
                WHERE designation LIKE fetchedDesignation;
                
            END IF;
            
        END LOOP;
        CLOSE stellarCursor;  
    END;
END;
/

CREATE OR REPLACE PROCEDURE goldilocksBoundaries(roundingPrecision IN NUMBER DEFAULT 2) AS

BEGIN

	DECLARE 
    fetchedDesignation stellarParameters.designation%TYPE;
	fetchedBolometricLuminosity stellarParameters.bolometricLuminosity%TYPE;

	CURSOR stellarCursor IS SELECT designation, bolometricLuminosity FROM stellarParameters;
		
	constantInnerBoundary FLOAT := 1.10;
	constantOuterBoundary FLOAT := 0.53;
	constantGoldilocks FLOAT := 2.795883;
	constantgregorianYear FLOAT := 365.2425;
    
    tempCurrentInner FLOAT;
    tempcurrentOuter FLOAT;

    /*CURSOR OPENING, UPDATE LOOP AND CURSOR CLOSING*/
    BEGIN
        OPEN stellarCursor;    
        LOOP
        
            FETCH stellarCursor INTO fetchedDesignation, fetchedBolometricLuminosity;
            EXIT WHEN stellarCursor%NOTFOUND;
            
            tempCurrentInner := (fetchedBolometricLuminosity / constantInnerBoundary);
            tempcurrentOuter := (fetchedBolometricLuminosity / constantOuterBoundary);
            
            UPDATE stellarParameters 
                SET
                innerBoundary = ROUND(SQRT(tempCurrentInner), roundingPrecision),
                outerBoundary = ROUND(SQRT(tempCurrentOuter), roundingPrecision),
                gregorianYear = ROUND((((tempCurrentInner + tempCurrentOuter) / constantGoldilocks) * constantGregorianYear), roundingPrecision)
            WHERE designation LIKE fetchedDesignation;
                
        END LOOP;    
        CLOSE stellarCursor;
    END;    
END;
/

CREATE OR REPLACE PROCEDURE stellarDiameter(roundingPrecision IN NUMBER DEFAULT 2) AS

BEGIN

	DECLARE 
    fetchedDesignation VARCHAR(45);
	fetchedTemperature FLOAT;
	fetchedBolometricMagnitude FLOAT;

	CURSOR stellarCursor IS SELECT designation, temperatureKelvin, bolometricMagnitude FROM stellarDiametersTransient;

	constantSolarTemperature FLOAT := 5777;
	constantSolarBolometric FLOAT := 4.75;
	constantPogson FLOAT := 2.511886431;
    
    tempPower1 FLOAT;
    tempPower2 FLOAT;
    tempPower3 FLOAT;

    /*CURSOR OPENING, UPDATE LOOP AND CURSOR CLOSING*/
    BEGIN
        OPEN stellarCursor;    
        LOOP
        
            FETCH stellarCursor INTO fetchedDesignation, fetchedTemperature, fetchedBolometricMagnitude;     
            
            tempPower1 := POWER((constantSolarTemperature / fetchedTemperature), 2);
            tempPower2 := POWER(constantPogson, (constantSolarBolometric - fetchedBolometricMagnitude));
            tempPower3 := POWER(tempPower2, 0.5);
            
            UPDATE stellarParameters 
                SET solarDiameter = ROUND((tempPower1 * tempPower3), roundingPrecision) 
            WHERE designation LIKE fetchedDesignation;
            
        END LOOP;    
        CLOSE stellarCursor;
    END;        
END;
/
