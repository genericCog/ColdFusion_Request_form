USE [vaintradb]
GO

/****** Object:  Table [dbo].[itnss_network_type_link]    Script Date: 4/27/2018 8:11:43 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[itnss_network_type_link](
	[itnss_requirement_id] [int] NOT NULL,
	[itnss_network_type_id] [int] NOT NULL
) ON [PRIMARY]
GO

