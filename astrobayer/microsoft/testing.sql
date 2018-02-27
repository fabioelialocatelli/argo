USE bayer
GO

EXECUTE solarMass @roundingPrecision = 2
GO

EXECUTE absoluteLuminosity @roundingPrecision = 2
GO

EXECUTE bolometricLuminosity @roundingPrecision = 2
GO

EXECUTE absoluteMagnitude @roundingPrecision = 2
GO

EXECUTE apparentMagnitude @roundingPrecision = 2
GO

EXECUTE bolometricMagnitude @roundingPrecision = 2
GO

EXECUTE distanceConversion @preferredConversion = 0, @roundingPrecision = 2
GO

EXECUTE distanceConversion @preferredConversion = 1, @roundingPrecision = 2
GO

EXECUTE goldilocksBoundaries @roundingPrecision = 2
GO

EXECUTE stellarDiameter @roundingPrecision = 2
GO
