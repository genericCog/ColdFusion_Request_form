USE [vaintradb]
GO

/****** Object:  Table [dbo].[itnss_approvers]    Script Date: 03/28/2018 10:25:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[itnss_approvers](
	[approver_id] [int] IDENTITY(1,1) NOT NULL,
	[process_participant_id] [int] NOT NULL,
	[sequence] [int] NULL,
	[approved_by] [varchar](50) NULL,
	[approved_date] [datetime2](7) NULL,
	[status_id] [int] NULL,
	[itnss_requirement_id] [int] NOT NULL,
	[comments] [varchar](max) NULL,
 CONSTRAINT [PK_itnss_approvers] PRIMARY KEY CLUSTERED 
(
	[approver_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[itnss_approvers] ADD  CONSTRAINT [DF_itnss_approvers_sequence]  DEFAULT ((1)) FOR [sequence]
GO

ALTER TABLE [dbo].[itnss_approvers] ADD  CONSTRAINT [DF_itnss_approvers_status_id]  DEFAULT ((1)) FOR [status_id]
GO

