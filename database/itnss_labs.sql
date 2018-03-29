USE [vaintradb]
GO

/****** Object:  Table [dbo].[itnss_labs]    Script Date: 03/28/2018 10:25:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[itnss_labs](
	[itnss_requirement_id] [int] NOT NULL,
	[lab_id] [int] NOT NULL,
 CONSTRAINT [PK_itnss_labs] PRIMARY KEY CLUSTERED 
(
	[itnss_requirement_id] ASC,
	[lab_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

