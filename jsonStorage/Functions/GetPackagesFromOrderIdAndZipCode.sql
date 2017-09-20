CREATE FUNCTION GetPackagesFromOrderIdAndZipCode
(
    @orderid int, 
    @zipCode nvarchar(64)
)
RETURNS TABLE
AS
RETURN
(
	SELECT @orderId AS OrderId, @zipCode AS OriginZipCode, OP.* 
	FROM 
		dbo.ShippingCalculatorResponse UM
	CROSS APPLY
	OPENJSON(UM.ResponseAsJSon, '$.shippingQuotePerZipCode') AM
	CROSS APPLY
	OPENJSON(AM.value, '$.carrierPackages') 
	WITH
	(
		packageType int,
        freightClass float,
        height decimal(8, 3),
        width decimal(8, 3),
        length decimal(8, 3),
        weight decimal(8, 3),
        billableWeight decimal(8, 3),
        volume decimal(8, 3),
        value decimal(8, 3),
        packageQuantity int,
        isStandardPackage bit
	)
	OP
	WHERE UM.OrderId = 1 AND JSON_VALUE(AM.value, '$.originZipCode') LIKE @zipCode
);
GO