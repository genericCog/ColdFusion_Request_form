USE [vaintradb]
GO

/****** Object:  Table [dbo].[labs_valid]    Script Date: 03/28/2018 10:27:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[labs_valid](
	[lab_id] [int] IDENTITY(1,1) NOT NULL,
	[lab_abbr] [varchar](50) NULL,
	[lab_name] [varchar](150) NOT NULL,
	[lab_desc] [varchar](1000) NULL,
	[lab_location] [varchar](100) NULL,
	[active] [bit] NULL,
 CONSTRAINT [PK_labs_valid] PRIMARY KEY CLUSTERED 
(
	[lab_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[labs_valid] ADD  CONSTRAINT [DF_labs_valid_active]  DEFAULT ((1)) FOR [active]
GO

