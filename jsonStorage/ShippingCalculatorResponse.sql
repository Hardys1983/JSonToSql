CREATE TABLE [dbo].[ShippingCalculatorResponse]
(
	[ShippingCalculatorResponseId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[RequestAsJson] [nvarchar](max) NOT NULL,
	[ResponseAsJSon] [nvarchar](max) NOT NULL,
	[Date] [datetime] NOT NULL,
 CONSTRAINT [PK_ShippingCalculatorResponse] PRIMARY KEY CLUSTERED 
(
	[ShippingCalculatorResponseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'An Order Id in the Shopping Cart' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ShippingCalculatorResponse', @level2type=N'COLUMN',@level2name=N'OrderId'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Stores the rate request to the Shipping Calculator in JSON format' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ShippingCalculatorResponse', @level2type=N'COLUMN',@level2name=N'RequestAsJson'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Stores the rate response from the Shipping Calculator in JSON format' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ShippingCalculatorResponse', @level2type=N'COLUMN',@level2name=N'ResponseAsJSon'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date when the row was added' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ShippingCalculatorResponse', @level2type=N'COLUMN',@level2name=N'Date'
GO

