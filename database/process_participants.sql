USE [vaintradb]
GO

/****** Object:  Table [dbo].[process_participants]    Script Date: 03/28/2018 10:31:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[process_participants](
	[process_participant_id] [int] IDENTITY(1,1) NOT NULL,
	[process_id] [int] NOT NULL,
	[role_id] [int] NOT NULL,
	[active] [bit] NULL,
	[sequence] [int] NULL,
	[participant_displayname] [varchar](150) NULL,
 CONSTRAINT [PK_process_participants] PRIMARY KEY CLUSTERED 
(
	[process_participant_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[process_participants] ADD  CONSTRAINT [DF_process_participants_active]  DEFAULT ((1)) FOR [active]
GO

