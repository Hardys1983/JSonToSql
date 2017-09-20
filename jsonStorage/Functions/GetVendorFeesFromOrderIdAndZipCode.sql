CREATE FUNCTION GetVendorFeesFromOrderIdAndZipCode
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
	OPENJSON(AM.value, '$.vendorDropShipFees') 
	WITH
	(
		vendor varchar(128),
		fee decimal(8, 3)
	)
	OP
	WHERE UM.OrderId = 1 AND JSON_VALUE(AM.value, '$.originZipCode') LIKE @zipCode
);
GO