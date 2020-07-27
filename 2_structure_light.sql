USE [master]
GO
CREATE DATABASE [rpa_reporting]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'rpa_reporting', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.AACRSQLEXPRESS\MSSQL\DATA\rpa_reporting.mdf' , SIZE = 7168KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'rpa_reporting_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.AACRSQLEXPRESS\MSSQL\DATA\rpa_reporting_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [rpa_reporting] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [rpa_reporting].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [rpa_reporting] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [rpa_reporting] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [rpa_reporting] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [rpa_reporting] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [rpa_reporting] SET ARITHABORT OFF 
GO
ALTER DATABASE [rpa_reporting] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [rpa_reporting] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [rpa_reporting] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [rpa_reporting] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [rpa_reporting] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [rpa_reporting] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [rpa_reporting] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [rpa_reporting] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [rpa_reporting] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [rpa_reporting] SET  DISABLE_BROKER 
GO
ALTER DATABASE [rpa_reporting] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [rpa_reporting] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [rpa_reporting] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [rpa_reporting] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [rpa_reporting] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [rpa_reporting] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [rpa_reporting] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [rpa_reporting] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [rpa_reporting] SET  MULTI_USER 
GO
ALTER DATABASE [rpa_reporting] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [rpa_reporting] SET DB_CHAINING OFF 
GO
ALTER DATABASE [rpa_reporting] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [rpa_reporting] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [rpa_reporting] SET DELAYED_DURABILITY = DISABLED 
GO
USE [rpa_reporting]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rpa_bot_sla](
	[bot_name] [varchar](100) NOT NULL,
	[unit_cost_minutes] [int] NULL,
	[delay_minutes] [int] NULL
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rpa_main_log](
	[id_rp_main] [int] IDENTITY(1,1) NOT NULL,
	[start_time] [datetime] NULL,
	[end_time] [datetime] NULL,
	[bot_name] [varchar](100) NOT NULL,
	[num_iter] [int] NULL,
	[status] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_rp_main] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rpa_ticket_status](
	[id_ticket] [int] IDENTITY(1,1) NOT NULL,
	[num_ticket] [varchar](256) NOT NULL,
	[start_time] [datetime] NULL,
	[end_time] [datetime] NULL,
	[bot_name] [varchar](50) NULL,
	[code] [int] NULL,
	[id_rp_main] [int] NULL,
	[code_tech] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_ticket] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE dbo.rpa_ticket_status ADD CONSTRAINT
	FK_rpa_ticket_status_rpa_main_log1 FOREIGN KEY
	(
	id_rp_main
	) REFERENCES dbo.rpa_main_log
	(
	id_rp_main
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO