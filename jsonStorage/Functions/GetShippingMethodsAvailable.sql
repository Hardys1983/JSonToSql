CREATE FUNCTION GetShippingMethodsAvailable
(
    @orderid int
)
RETURNS TABLE
AS
RETURN
(
	SELECT AM.methodName, AM.methodGuid, AM.netCharge, AM.cost, AM.discount FROM dbo.ShippingCalculatorResponse UM
	CROSS APPLY
	OPENJSON(UM.ResponseAsJSon, '$.shippingMethodsAvailableForUserSelection')
		WITH 
		(
			methodName  varchar(128) N'$.methodName',   
			methodGuid  varchar(128) N'$.methodGuid',
			netCharge  decimal(8, 3) N'$.netCharge',
			cost  decimal(8, 3) N'$.cost',
			discount  decimal(8, 3) N'$.discount'
		) AS AM
		WHERE UM.OrderId = @orderid
	);
GO