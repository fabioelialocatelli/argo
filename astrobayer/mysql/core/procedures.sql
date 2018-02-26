USE bayer;

DROP PROCEDURE IF EXISTS PROCEDURE_solarMass;
DELIMITER //
CREATE PROCEDURE PROCEDURE_solarMass()
SQL SECURITY INVOKER
BEGIN

	DECLARE fetchedDesignation VARCHAR(45);
	DECLARE fetchedBolometricLuminosity FLOAT;

	/*CURSOR AND ITS HANDLER*/
	DECLARE cursorHasFinished INT DEFAULT FALSE;
	DECLARE stellarCursor CURSOR FOR SELECT `designation`, `bolometricLuminosity` FROM `TABLE_stellarParameters`;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursorHasFinished := TRUE;

	SET @massConstant := 0.256;

	/*CURSOR OPENING, UPDATE LOOP AND CURSOR CLOSING*/
	OPEN stellarCursor;

	FETCHINGLOOP: LOOP
		FETCH stellarCursor INTO fetchedDesignation, fetchedBolometricLuminosity;
		IF cursorHasFinished
		THEN
		  LEAVE FETCHINGLOOP;
		END IF;
		UPDATE `TABLE_stellarParameters` SET `solarMass` = ROUND(POW(fetchedBolometricLuminosity, @massConstant), 2) WHERE `designation` LIKE fetchedDesignation;
	END LOOP;

	CLOSE stellarCursor;
        
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS PROCEDURE_absoluteLuminosity;
DELIMITER //
CREATE PROCEDURE PROCEDURE_absoluteLuminosity()
SQL SECURITY INVOKER
BEGIN

	DECLARE fetchedDesignation VARCHAR(45);
	DECLARE fetchedAbsoluteMagnitude FLOAT;

	/*CURSOR AND ITS HANDLER*/
	DECLARE cursorHasFinished INT DEFAULT FALSE;
	DECLARE stellarCursor CURSOR FOR SELECT `designation`, `absoluteMagnitude` FROM `TABLE_stellarParameters`;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursorHasFinished := TRUE;
	
    SET @solarAbsoluteMagnitude := 4.83;
	
	/*CURSOR OPENING, UPDATE LOOP AND CURSOR CLOSING*/
	OPEN stellarCursor;  

	FETCHINGLOOP: LOOP
		FETCH stellarCursor INTO fetchedDesignation, fetchedAbsoluteMagnitude;
		IF cursorHasFinished
		THEN
		  LEAVE FETCHINGLOOP;
		END IF;  
		UPDATE `TABLE_stellarParameters` SET `absoluteLuminosity` = ROUND(POW(10, (@solarAbsoluteMagnitude - fetchedAbsoluteMagnitude) / 2.5), 4) WHERE `designation` LIKE fetchedDesignation;
	END LOOP;

	CLOSE stellarCursor;
        
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS PROCEDURE_absoluteMagnitude;
DELIMITER //
CREATE PROCEDURE PROCEDURE_absoluteMagnitude()
SQL SECURITY INVOKER
BEGIN

	DECLARE fetchedDesignation VARCHAR(45);
	DECLARE fetchedApparentMagnitude FLOAT;
	DECLARE fetchedParsecs FLOAT;

	/*CURSOR AND ITS HANDLER*/
	DECLARE cursorHasFinished INT DEFAULT FALSE;
	DECLARE stellarCursor CURSOR FOR SELECT `designation`, `apparentMagnitude`, `parsecs` FROM `TABLE_stellarParameters`;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursorHasFinished := TRUE;

	/*CURSOR OPENING, UPDATE LOOP AND CURSOR CLOSING*/
	OPEN stellarCursor;

	FETCHINGLOOP: LOOP
		FETCH stellarCursor INTO fetchedDesignation, fetchedApparentMagnitude, fetchedParsecs;
		IF cursorHasFinished
		THEN
		  LEAVE FETCHINGLOOP;
		END IF;
		UPDATE `TABLE_stellarParameters` SET `absoluteMagnitude` = ROUND(fetchedApparentMagnitude - (5 * (LOG10(fetchedParsecs / 10))), 2) WHERE `designation` LIKE fetchedDesignation;
	END LOOP;

	CLOSE stellarCursor;
        
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS PROCEDURE_apparentMagnitude;
DELIMITER //
CREATE PROCEDURE PROCEDURE_apparentMagnitude()
SQL SECURITY INVOKER
BEGIN

	DECLARE fetchedDesignation VARCHAR(45);
	DECLARE fetchedAbsoluteMagnitude FLOAT;
	DECLARE fetchedParsecs FLOAT;

	/*CURSOR AND ITS HANDLER*/
	DECLARE cursorHasFinished INT DEFAULT FALSE;
	DECLARE stellarCursor CURSOR FOR SELECT `designation`, `absoluteMagnitude`, `parsecs` FROM `TABLE_stellarParameters`;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursorHasFinished := TRUE;

	/*CURSOR OPENING, UPDATE LOOP AND CURSOR CLOSING*/
	OPEN stellarCursor;

	FETCHINGLOOP: LOOP
		FETCH stellarCursor INTO fetchedDesignation, fetchedAbsoluteMagnitude, fetchedParsecs;
		IF cursorHasFinished
		THEN
		  LEAVE FETCHINGLOOP;
		END IF;
		UPDATE `TABLE_stellarParameters` SET `apparentMagnitude` = ROUND(fetchedAbsoluteMagnitude - (5 * (1 - LOG10(fetchedParsecs))), 2) WHERE `designation` LIKE fetchedDesignation;
	END LOOP;

	CLOSE stellarCursor;
        
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS PROCEDURE_bolometricLuminosity;
DELIMITER //
CREATE PROCEDURE PROCEDURE_bolometricLuminosity()
SQL SECURITY INVOKER
BEGIN

	DECLARE fetchedDesignation VARCHAR(45);
	DECLARE fetchedBolometricMagnitude FLOAT;

	/*CURSOR AND ITS HANDLER*/
	DECLARE cursorHasFinished INT DEFAULT FALSE;
	DECLARE stellarCursor CURSOR FOR SELECT `designation`, `bolometricMagnitude` FROM `TABLE_stellarParameters`;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursorHasFinished := TRUE;

	SET @solarBolometricMagnitude := 4.75;

	/*CURSOR OPENING, UPDATE LOOP AND CURSOR CLOSING*/
	OPEN stellarCursor;

	FETCHINGLOOP: LOOP
		FETCH stellarCursor INTO fetchedDesignation, fetchedBolometricMagnitude;
		IF cursorHasFinished
		THEN
		  LEAVE FETCHINGLOOP;
		END IF;
		UPDATE `TABLE_stellarParameters` SET `bolometricLuminosity` = ROUND(POW(10, ((@solarBolometricMagnitude - fetchedBolometricMagnitude) / 2.5)), 4) WHERE `designation` LIKE fetchedDesignation;
	END LOOP;

	CLOSE stellarCursor;
	
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS PROCEDURE_bolometricMagnitude;
DELIMITER //
CREATE PROCEDURE PROCEDURE_bolometricMagnitude()
SQL SECURITY INVOKER
BEGIN

	DECLARE fetchedDesignation VARCHAR(45);
	DECLARE fetchedAbsoluteMagnitude FLOAT;
	DECLARE fetchedMagnitudeCorrection FLOAT;

	/*CURSOR AND ITS HANDLER*/
	DECLARE cursorHasFinished INT DEFAULT FALSE;
	DECLARE stellarCursor CURSOR FOR SELECT `designation`, `absoluteMagnitude`, `magnitudeCorrection` FROM `VIEW_bolometricMagnitude`;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursorHasFinished := TRUE;

	/*CURSOR OPENING, UPDATE LOOP AND CURSOR CLOSING*/
	OPEN stellarCursor;

	FETCHINGLOOP: LOOP
		FETCH stellarCursor INTO fetchedDesignation, fetchedAbsoluteMagnitude, fetchedMagnitudeCorrection;
		IF cursorHasFinished
		THEN
		  LEAVE FETCHINGLOOP;
		END IF;
		UPDATE `TABLE_stellarParameters` SET `bolometricMagnitude` = ROUND((fetchedAbsoluteMagnitude + fetchedMagnitudeCorrection), 2) WHERE `designation` LIKE fetchedDesignation;
	END LOOP;

	CLOSE stellarCursor;
        
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS PROCEDURE_distanceConversion;
DELIMITER //
CREATE PROCEDURE PROCEDURE_distanceConversion(IN paramUnit INT)
SQL SECURITY INVOKER
BEGIN

	DECLARE fetchedDesignation VARCHAR(45);
	DECLARE fetchedParsecs FLOAT;
	DECLARE fetchedLightYears FLOAT;

	/*CURSOR AND ITS HANDLER*/
	DECLARE cursorHasFinished INT DEFAULT FALSE;
	DECLARE stellarCursor CURSOR FOR SELECT `designation`, `parsecs`, `lightYears` FROM `TABLE_stellarParameters`;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursorHasFinished := TRUE;

	SET @conversionParsecs := 0.306594845;
	SET @conversionLightYears := 3.261633440;
			
	CASE paramUnit
		WHEN 0 THEN
		
		/*CURSOR OPENING, UPDATE LOOP AND CURSOR CLOSING*/
		OPEN stellarCursor;

		FETCHINGLOOP: LOOP
			FETCH stellarCursor INTO fetchedDesignation, fetchedParsecs, fetchedLightYears;
			IF cursorHasFinished
			THEN
			  LEAVE FETCHINGLOOP;
			END IF;
			UPDATE `TABLE_stellarParameters` SET `parsecs` = ROUND((fetchedLightYears * @conversionParsecs), 2) WHERE `designation` LIKE fetchedDesignation;
		END LOOP;

		CLOSE stellarCursor;        
		
		WHEN 1 THEN
		
		/*CURSOR OPENING, UPDATE LOOP AND CURSOR CLOSING*/
		OPEN stellarCursor;

		FETCHINGLOOP: LOOP
			FETCH stellarCursor INTO fetchedDesignation, fetchedParsecs, fetchedLightYears;
			IF cursorHasFinished
			THEN
			  LEAVE FETCHINGLOOP;
			END IF;
			UPDATE `TABLE_stellarParameters` SET `lightYears` = ROUND((fetchedParsecs * @conversionLightYears), 2) WHERE `designation` LIKE fetchedDesignation;
		END LOOP;

		CLOSE stellarCursor;        
		
	END CASE;
        
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS PROCEDURE_goldilocksBoundaries;
DELIMITER //
CREATE PROCEDURE PROCEDURE_goldilocksBoundaries()
SQL SECURITY INVOKER
BEGIN

	DECLARE fetchedDesignation VARCHAR(45);
	DECLARE fetchedBolometricLuminosity FLOAT;

	/*CURSOR AND ITS HANDLER*/
	DECLARE cursorHasFinished INT DEFAULT FALSE;
	DECLARE stellarCursor CURSOR FOR SELECT `designation`, `bolometricLuminosity` FROM `TABLE_stellarParameters`;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursorHasFinished := TRUE;
		
	SET @constantInnerBoundary := 1.10;
	SET @constantOuterBoundary := 0.53;
	SET @constantGoldilocks := 2.795883;
	SET @gregorianYear := 365.2425;

	/*CURSOR OPENING, UPDATE LOOP AND CURSOR CLOSING*/
	OPEN stellarCursor;

	FETCHINGLOOP: LOOP
		FETCH stellarCursor INTO fetchedDesignation, fetchedBolometricLuminosity;
		IF cursorHasFinished
		THEN
		  LEAVE FETCHINGLOOP;
		END IF;
		
			SET @currentInner := ROUND((fetchedBolometricLuminosity / @constantInnerBoundary), 4);
			SET @currentOuter := ROUND((fetchedBolometricLuminosity / @constantOuterBoundary), 4);
			
			UPDATE `TABLE_stellarParameters` 
				SET
				`innerBoundary` = SQRT(@currentInner),
				`outerBoundary` = SQRT(@currentOuter),
				`gregorianYear` = ROUND((((@currentInner + @currentOuter) / @constantGoldilocks) * @gregorianYear), 4)
			WHERE `designation` LIKE fetchedDesignation;
			
	END LOOP;

	CLOSE stellarCursor;
        
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS PROCEDURE_solarDiameter;
DELIMITER //
CREATE PROCEDURE PROCEDURE_solarDiameter()
SQL SECURITY INVOKER
BEGIN

	DECLARE fetchedDesignation VARCHAR(45);
	DECLARE fetchedTemperature FLOAT;
	DECLARE fetchedBolometricMagnitude FLOAT;

	/*CURSOR AND ITS HANDLER*/
	DECLARE cursorHasFinished INT DEFAULT FALSE;
	DECLARE stellarCursor CURSOR FOR SELECT `designation`, `temperatureKelvin`, `bolometricMagnitude` FROM `VIEW_solarDiameter`;
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
		
		SET @power_1 := POW((@solarTemperature / fetchedTemperature), 2);
		SET @power_2 := POW(@constantPogson, (@solarBolometricMagnitude - fetchedBolometricMagnitude));
		SET @power_3 := POW(@power_2, 0.5);
		
		UPDATE `TABLE_stellarParameters` SET `solarDiameter` = ROUND((@power_1 * @power_3), 2) WHERE `designation` LIKE fetchedDesignation;
		
	END LOOP;

	CLOSE stellarCursor;
        
END //
DELIMITER ;
