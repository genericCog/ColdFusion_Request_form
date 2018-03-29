USE [vaintradb]
GO

/****** Object:  Table [dbo].[itnss_requirement]    Script Date: 03/28/2018 10:26:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[itnss_requirement](
	[itnss_requirement_id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](150) NOT NULL,
	[date_created] [datetime2](7) NOT NULL,
	[date_needed] [datetime2](7) NULL,
	[poc] [varchar](50) NULL,
	[is_funded] [bit] NULL,
	[lab_name] [varchar](150) NULL,
	[request_type] [varchar](10) NULL,
	[fk_network_type_id] [int] NOT NULL,
	[itnss_description] [varchar](500) NULL,
	[itnss_description_staff_cacedipi] [int] NULL,
	[itnss_justification] [varchar](500) NULL,
	[itnss_justification_staff_cacedipi] [int] NULL,
	[itnss_solution] [varchar](500) NULL,
	[itnss_solution_staff_cacedipi] [int] NULL,
	[notes_cso_cto_iao] [varchar](500) NULL,
	[acq_purchase_vehicle] [varchar](150) NULL,
	[acq_gpc_log_cross_reference] [varchar](150) NULL,
	[acq_funding_source] [varchar](50) NULL,
	[acq_fund_cite] [varchar](150) NULL,
	[acq_afway_waiver_number] [varchar](50) NULL,
	[acq_afway_rfq_number] [varchar](50) NULL,
	[acq_afway_tracking_number] [varchar](50) NULL,
	[acq_afway_order_number] [varchar](50) NULL,
	[acq_vendor_awarded] [varchar](150) NULL,
	[acq_date_ordered] [datetime2](7) NULL,
	[acq_comments] [varchar](500) NULL,
	[attachments] [varchar](500) NULL,
	[itnss_status] [varchar](50) NULL,
	[tracking_number] [varchar](50) NULL,
	[request_number] [int] NULL,
	[classification] [varchar](100) NULL,
	[created_by] [varchar](50) NULL,
	[created_date] [datetime2](7) NULL,
	[last_modified_by] [varchar](50) NULL,
	[last_modified_date] [datetime2](7) NULL,
	[is_funded_authority] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[itnss_requirement_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[itnss_requirement] ADD  CONSTRAINT [DF_itnss_requirement_date_created]  DEFAULT (getdate()) FOR [date_created]
GO

ALTER TABLE [dbo].[itnss_requirement] ADD  CONSTRAINT [DF_itnss_requirement_created_date]  DEFAULT (getdate()) FOR [created_date]
GO

