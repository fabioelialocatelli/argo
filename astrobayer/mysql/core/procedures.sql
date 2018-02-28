USE bayer;

DROP PROCEDURE IF EXISTS solarMass;
DELIMITER //
CREATE PROCEDURE solarMass(IN roundingPrecision INT)
SQL SECURITY INVOKER
BEGIN

	DECLARE fetchedDesignation VARCHAR(45);
	DECLARE fetchedBolometricLuminosity FLOAT;

	/*CURSOR AND ITS HANDLER*/
	DECLARE cursorHasFinished INT DEFAULT FALSE;
	DECLARE stellarCursor CURSOR FOR SELECT `designation`, `bolometricLuminosity` FROM `stellarParameters`;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursorHasFinished := TRUE;

	SET @massConstant := 0.256;

	/*CURSOR OPENING, UPDATE LOOP AND CURSOR CLOSING*/
	OPEN stellarCursor;

	FETCHINGLOOP: LOOP
    
		FETCH stellarCursor INTO fetchedDesignation, fetchedBolometricLuminosity;
		IF cursorHasFinished THEN
			LEAVE FETCHINGLOOP;
		END IF;
        
		UPDATE `stellarParameters` 
			SET `solarMass` = ROUND(POW(fetchedBolometricLuminosity, @massConstant), roundingPrecision) 
        WHERE `designation` LIKE fetchedDesignation;
        
	END LOOP;

	CLOSE stellarCursor;
        
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS absoluteLuminosity;
DELIMITER //
CREATE PROCEDURE absoluteLuminosity(IN roundingPrecision INT)
SQL SECURITY INVOKER
BEGIN

	DECLARE fetchedDesignation VARCHAR(45);
	DECLARE fetchedAbsoluteMagnitude FLOAT;

	/*CURSOR AND ITS HANDLER*/
	DECLARE cursorHasFinished INT DEFAULT FALSE;
	DECLARE stellarCursor CURSOR FOR SELECT `designation`, `absoluteMagnitude` FROM `stellarParameters`;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursorHasFinished := TRUE;
	
    SET @solarAbsoluteMagnitude := 4.83;
	
	/*CURSOR OPENING, UPDATE LOOP AND CURSOR CLOSING*/
	OPEN stellarCursor;  

	FETCHINGLOOP: LOOP
    
		FETCH stellarCursor INTO fetchedDesignation, fetchedAbsoluteMagnitude;
		IF cursorHasFinished THEN
			LEAVE FETCHINGLOOP;
		END IF;
        
		UPDATE `stellarParameters` 
			SET `absoluteLuminosity` = ROUND(POW(10, (@solarAbsoluteMagnitude - fetchedAbsoluteMagnitude) / 2.5), roundingPrecision) 
		WHERE `designation` LIKE fetchedDesignation;
        
	END LOOP;

	CLOSE stellarCursor;
        
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS bolometricLuminosity;
DELIMITER //
CREATE PROCEDURE bolometricLuminosity(IN roundingPrecision INT)
SQL SECURITY INVOKER
BEGIN

	DECLARE fetchedDesignation VARCHAR(45);
	DECLARE fetchedBolometricMagnitude FLOAT;

	/*CURSOR AND ITS HANDLER*/
	DECLARE cursorHasFinished INT DEFAULT FALSE;
	DECLARE stellarCursor CURSOR FOR SELECT `designation`, `bolometricMagnitude` FROM `stellarParameters`;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursorHasFinished := TRUE;

	SET @solarBolometricMagnitude := 4.75;

	/*CURSOR OPENING, UPDATE LOOP AND CURSOR CLOSING*/
	OPEN stellarCursor;

	FETCHINGLOOP: LOOP
    
		FETCH stellarCursor INTO fetchedDesignation, fetchedBolometricMagnitude;
		IF cursorHasFinished THEN
			LEAVE FETCHINGLOOP;
		END IF;
        
		UPDATE `stellarParameters` 
			SET `bolometricLuminosity` = ROUND(POW(10, ((@solarBolometricMagnitude - fetchedBolometricMagnitude) / 2.5)), roundingPrecision) 
		WHERE `designation` LIKE fetchedDesignation;
        
	END LOOP;

	CLOSE stellarCursor;
	
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS absoluteMagnitude;
DELIMITER //
CREATE PROCEDURE absoluteMagnitude(IN roundingPrecision INT)
SQL SECURITY INVOKER
BEGIN

	DECLARE fetchedDesignation VARCHAR(45);
	DECLARE fetchedApparentMagnitude FLOAT;
	DECLARE fetchedParsecs FLOAT;

	/*CURSOR AND ITS HANDLER*/
	DECLARE cursorHasFinished INT DEFAULT FALSE;
	DECLARE stellarCursor CURSOR FOR SELECT `designation`, `apparentMagnitude`, `parsecs` FROM `stellarParameters`;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursorHasFinished := TRUE;

	/*CURSOR OPENING, UPDATE LOOP AND CURSOR CLOSING*/
	OPEN stellarCursor;

	FETCHINGLOOP: LOOP
    
		FETCH stellarCursor INTO fetchedDesignation, fetchedApparentMagnitude, fetchedParsecs;
		IF cursorHasFinished THEN
			LEAVE FETCHINGLOOP;
		END IF;
        
		UPDATE `stellarParameters` 
			SET `absoluteMagnitude` = ROUND(fetchedApparentMagnitude - (5 * (LOG10(fetchedParsecs / 10))), roundingPrecision) 
		WHERE `designation` LIKE fetchedDesignation;
        
	END LOOP;

	CLOSE stellarCursor;
        
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS apparentMagnitude;
DELIMITER //
CREATE PROCEDURE apparentMagnitude(IN roundingPrecision INT)
SQL SECURITY INVOKER
BEGIN

	DECLARE fetchedDesignation VARCHAR(45);
	DECLARE fetchedAbsoluteMagnitude FLOAT;
	DECLARE fetchedParsecs FLOAT;

	/*CURSOR AND ITS HANDLER*/
	DECLARE cursorHasFinished INT DEFAULT FALSE;
	DECLARE stellarCursor CURSOR FOR SELECT `designation`, `absoluteMagnitude`, `parsecs` FROM `stellarParameters`;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursorHasFinished := TRUE;

	/*CURSOR OPENING, UPDATE LOOP AND CURSOR CLOSING*/
	OPEN stellarCursor;

	FETCHINGLOOP: LOOP
    
		FETCH stellarCursor INTO fetchedDesignation, fetchedAbsoluteMagnitude, fetchedParsecs;
		IF cursorHasFinished THEN
			LEAVE FETCHINGLOOP;
		END IF;
        
		UPDATE `stellarParameters` 
			SET `apparentMagnitude` = ROUND(fetchedAbsoluteMagnitude - (5 * (1 - LOG10(fetchedParsecs))), roundingPrecision) 
		WHERE `designation` LIKE fetchedDesignation;
        
	END LOOP;

	CLOSE stellarCursor;
        
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS bolometricMagnitude;
DELIMITER //
CREATE PROCEDURE bolometricMagnitude(IN roundingPrecision INT)
SQL SECURITY INVOKER
BEGIN

	DECLARE fetchedDesignation VARCHAR(45);
	DECLARE fetchedAbsoluteMagnitude FLOAT;
	DECLARE fetchedMagnitudeCorrection FLOAT;

	/*CURSOR AND ITS HANDLER*/
	DECLARE cursorHasFinished INT DEFAULT FALSE;
	DECLARE stellarCursor CURSOR FOR SELECT `designation`, `absoluteMagnitude`, `magnitudeCorrection` FROM `stellarBolometricsTransient`;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursorHasFinished := TRUE;

	/*CURSOR OPENING, UPDATE LOOP AND CURSOR CLOSING*/
	OPEN stellarCursor;

	FETCHINGLOOP: LOOP
    
		FETCH stellarCursor INTO fetchedDesignation, fetchedAbsoluteMagnitude, fetchedMagnitudeCorrection;
		IF cursorHasFinished THEN
			LEAVE FETCHINGLOOP;
		END IF;
        
		UPDATE `stellarParameters` 
			SET `bolometricMagnitude` = ROUND((fetchedAbsoluteMagnitude + fetchedMagnitudeCorrection), roundingPrecision) 
		WHERE `designation` LIKE fetchedDesignation;
        
	END LOOP;

	CLOSE stellarCursor;
        
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS distanceConversion;
DELIMITER //
CREATE PROCEDURE distanceConversion(IN preferredConversion INT, IN roundingPrecision INT)
SQL SECURITY INVOKER
BEGIN

	DECLARE fetchedDesignation VARCHAR(45);
	DECLARE fetchedParsecs FLOAT;
	DECLARE fetchedLightYears FLOAT;

	/*CURSOR AND ITS HANDLER*/
	DECLARE cursorHasFinished INT DEFAULT FALSE;
	DECLARE stellarCursor CURSOR FOR SELECT `designation`, `parsecs`, `lightYears` FROM `stellarParameters`;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursorHasFinished := TRUE;

	SET @conversionParsecs := 0.306594845;
	SET @conversionLightYears := 3.261633440;
    
    /*CURSOR OPENING, UPDATE LOOP AND CURSOR CLOSING*/
	OPEN stellarCursor;
    
    FETCHINGLOOP: LOOP
    
		FETCH stellarCursor INTO fetchedDesignation, fetchedParsecs, fetchedLightYears;
        IF cursorHasFinished THEN
			LEAVE FETCHINGLOOP;
		END IF;
        
        IF preferredConversion = 0 THEN
        
			UPDATE `stellarParameters`
				SET `parsecs` = ROUND((fetchedLightYears * @conversionParsecs), roundingPrecision) 
			WHERE `designation` LIKE fetchedDesignation;       
            
        ELSEIF preferredConversion = 1 THEN
        
			UPDATE `stellarParameters` 
				SET `lightYears` = ROUND((fetchedParsecs * @conversionLightYears), roundingPrecision) 
			WHERE `designation` LIKE fetchedDesignation;
            
        END IF;
        
    END LOOP;

	CLOSE stellarCursor;
        
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS goldilocksBoundaries;
DELIMITER //
CREATE PROCEDURE goldilocksBoundaries(IN roundingPrecision INT)
SQL SECURITY INVOKER
BEGIN

	DECLARE fetchedDesignation VARCHAR(45);
	DECLARE fetchedBolometricLuminosity FLOAT;

	/*CURSOR AND ITS HANDLER*/
	DECLARE cursorHasFinished INT DEFAULT FALSE;
	DECLARE stellarCursor CURSOR FOR SELECT `designation`, `bolometricLuminosity` FROM `stellarParameters`;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursorHasFinished := TRUE;
		
	SET @constantInnerBoundary := 1.10;
	SET @constantOuterBoundary := 0.53;
	SET @constantGoldilocks := 2.795883;
	SET @gregorianYear := 365.2425;

	/*CURSOR OPENING, UPDATE LOOP AND CURSOR CLOSING*/
	OPEN stellarCursor;

	FETCHINGLOOP: LOOP
    
		FETCH stellarCursor INTO fetchedDesignation, fetchedBolometricLuminosity;
		IF cursorHasFinished THEN
			LEAVE FETCHINGLOOP;
		END IF;
		
		SET @currentInner := (fetchedBolometricLuminosity / @constantInnerBoundary);
		SET @currentOuter := (fetchedBolometricLuminosity / @constantOuterBoundary);
		
		UPDATE `stellarParameters` 
			SET
			`innerBoundary` = ROUND(SQRT(@currentInner), roundingPrecision),
			`outerBoundary` = ROUND(SQRT(@currentOuter), roundingPrecision),
			`gregorianYear` = ROUND((((@currentInner + @currentOuter) / @constantGoldilocks) * @gregorianYear), roundingPrecision)
		WHERE `designation` LIKE fetchedDesignation;
			
	END LOOP;

	CLOSE stellarCursor;
        
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS solarDiameter;
DELIMITER //
CREATE PROCEDURE solarDiameter(IN roundingPrecision INT)
SQL SECURITY INVOKER
BEGIN

	DECLARE fetchedDesignation VARCHAR(45);
	DECLARE fetchedTemperature FLOAT;
	DECLARE fetchedBolometricMagnitude FLOAT;

	/*CURSOR AND ITS HANDLER*/
	DECLARE cursorHasFinished INT DEFAULT FALSE;
	DECLARE stellarCursor CURSOR FOR SELECT `designation`, `temperatureKelvin`, `bolometricMagnitude` FROM `stellarDiametersTransient`;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursorHasFinished := TRUE;

	SET @solarTemperature := 5777;
	SET @solarBolometricMagnitude := 4.75;
	SET @constantPogson := 2.511886431;

	/*CURSOR OPENING, UPDATE LOOP AND CURSOR CLOSING*/
	OPEN stellarCursor;

	FETCHINGLOOP: LOOP
		FETCH stellarCursor INTO fetchedDesignation, fetchedTemperature, fetchedBolometricMagnitude;
		IF cursorHasFinished
		THEN
		  LEAVE FETCHINGLOOP;
		END IF;
		
		SET @tempPower1 := POW((@solarTemperature / fetchedTemperature), 2);
		SET @tempPower2 := POW(@constantPogson, (@solarBolometricMagnitude - fetchedBolometricMagnitude));
		SET @tempPower3 := POW(@tempPower2, 0.5);
		
		UPDATE `stellarParameters` 
			SET `solarDiameter` = ROUND((@tempPower1 * @tempPower3), roundingPrecision) 
		WHERE `designation` LIKE fetchedDesignation;
		
	END LOOP;

	CLOSE stellarCursor;
        
END //
DELIMITER ;
