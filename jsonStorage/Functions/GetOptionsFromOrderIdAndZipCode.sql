CREATE FUNCTION GetOptionsFromOrderIdAndZipCode
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
	OPENJSON(AM.value, '$.options')
	WITH
	(
		carrierName varchar(128),
		billingWeight decimal(8, 3),
		costVariable varchar(64),
		cost decimal(8, 3),
		deliveryDays decimal(8, 3),
		netCharge decimal(8, 3),
		method varchar(64),
		methodGuid varchar(64),
		liftGateFee decimal(8, 3),
		residentialFee decimal(8, 3),
		oversizePackageFee decimal(8, 3),
		groundOversizePackageFee decimal(8, 3),
		hazardousGroundFee decimal(8, 3)
	) AS OP
	WHERE UM.OrderId = 1 AND JSON_VALUE(AM.value, '$.originZipCode') LIKE @zipCode
);
GO