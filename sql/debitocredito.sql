USE [master]
GO

/****** Object:  Database [DebitoCredito]    Script Date: 18/06/2019 11:35:06 ******/
CREATE DATABASE [DebitoCredito]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DebitoCredito', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\DebitoCredito.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DebitoCredito_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\DebitoCredito_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [DebitoCredito] SET COMPATIBILITY_LEVEL = 110
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DebitoCredito].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [DebitoCredito] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [DebitoCredito] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [DebitoCredito] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [DebitoCredito] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [DebitoCredito] SET ARITHABORT OFF 
GO

ALTER DATABASE [DebitoCredito] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [DebitoCredito] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [DebitoCredito] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [DebitoCredito] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [DebitoCredito] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [DebitoCredito] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [DebitoCredito] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [DebitoCredito] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [DebitoCredito] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [DebitoCredito] SET  DISABLE_BROKER 
GO

ALTER DATABASE [DebitoCredito] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [DebitoCredito] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [DebitoCredito] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [DebitoCredito] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [DebitoCredito] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [DebitoCredito] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [DebitoCredito] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [DebitoCredito] SET RECOVERY FULL 
GO

ALTER DATABASE [DebitoCredito] SET  MULTI_USER 
GO

ALTER DATABASE [DebitoCredito] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [DebitoCredito] SET DB_CHAINING OFF 
GO

ALTER DATABASE [DebitoCredito] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [DebitoCredito] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO

ALTER DATABASE [DebitoCredito] SET  READ_WRITE 
GO

USE [DebitoCredito]
GO
/****** Object:  Table [dbo].[ContasCorrentes]    Script Date: 18/06/2019 11:34:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContasCorrentes](
	[Id] [uniqueidentifier] NOT NULL,
	[Numero] [nvarchar](10) NOT NULL,
	[SaldoAtual] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_ContaCorrente] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lancamentos]    Script Date: 18/06/2019 11:34:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lancamentos](
	[Id] [uniqueidentifier] NOT NULL,
	[IdTransacao] [nvarchar](50) NOT NULL,
	[Acao] [nvarchar](10) NOT NULL,
	[NumeroContaCorrente] [nvarchar](10) NOT NULL,
	[Valor] [decimal](18, 2) NOT NULL,
	[DataLancamento] [datetime] NOT NULL,
 CONSTRAINT [PK_Transacoes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[ContasCorrentes] ([Id], [Numero], [SaldoAtual]) VALUES (N'8f9ae367-613b-4d3a-82e2-6b36aee96954', N'3210', CAST(800.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ContasCorrentes] ([Id], [Numero], [SaldoAtual]) VALUES (N'57ff3302-b839-433a-a984-ed810807d3dc', N'0123', CAST(1000.00 AS Decimal(18, 2)))
GO
