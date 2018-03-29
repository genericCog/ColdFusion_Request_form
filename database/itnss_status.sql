USE [vaintradb]
GO

/****** Object:  Table [dbo].[itnss_status]    Script Date: 03/28/2018 10:27:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[itnss_status](
	[status_id] [int] IDENTITY(1,1) NOT NULL,
	[status_name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_itnss_status] PRIMARY KEY CLUSTERED 
(
	[status_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

