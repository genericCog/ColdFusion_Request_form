USE [vaintradb]
GO

/****** Object:  Table [dbo].[process]    Script Date: 03/28/2018 10:31:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[process](
	[process_id] [int] IDENTITY(1,1) NOT NULL,
	[process_name] [varchar](150) NOT NULL,
	[process_desc] [varchar](1500) NULL,
	[process_org] [varchar](10) NOT NULL,
	[poc_primary] [varchar](50) NULL,
	[active] [bit] NULL,
 CONSTRAINT [PK_process] PRIMARY KEY CLUSTERED 
(
	[process_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[process] ADD  CONSTRAINT [DF_process_active]  DEFAULT ((1)) FOR [active]
GO

