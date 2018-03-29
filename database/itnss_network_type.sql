USE [vaintradb]
GO

/****** Object:  Table [dbo].[itnss_network_type]    Script Date: 03/28/2018 10:25:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[itnss_network_type](
	[itnss_network_type_id] [int] NOT NULL,
	[network_type_name] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[itnss_network_type_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

