CREATE FUNCTION GetShippingZipCodesResponses
(
    @orderid int
)
RETURNS TABLE
AS
RETURN
(
	SELECT 
		AM.originZipCode, 
		AM.warehouseNumber, 
		AM.whiteGloveFee, 
		AM.warehouseSurcharge,
		AM.requestDateTime, 
		AM.hasResult
	FROM 
		dbo.ShippingCalculatorResponse UM
	CROSS APPLY
	OPENJSON(UM.ResponseAsJSon, '$.shippingQuotePerZipCode')
	WITH 
	(
		requestDateTime  DATETIME2 N'$.requestDateTime',   
		hasResult  BIT N'$.hasResult',
		originZipCode  varchar(12) N'$.originZipCode',
		warehouseNumber varchar(12) N'$.warehouseNumber',
		whiteGloveFee decimal(8, 3) N'$.whiteGloveFee',
		warehouseSurcharge decimal(8, 3) N'$.warehouseSurcharge'
	) AS AM
	WHERE UM.OrderId = @orderid
);
GO