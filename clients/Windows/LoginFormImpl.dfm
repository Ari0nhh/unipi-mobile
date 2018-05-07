object LoginForm: TLoginForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1042#1093#1086#1076' '#1074' '#1089#1080#1089#1090#1077#1084#1091
  ClientHeight = 146
  ClientWidth = 276
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object cxLoginData: TcxGroupBox
    Left = 5
    Top = 1
    Caption = #1059#1095#1077#1090#1085#1072#1103' '#1079#1072#1087#1080#1089#1100
    TabOrder = 0
    Height = 105
    Width = 263
    object cxUserName: TcxTextEdit
      Left = 6
      Top = 32
      TabOrder = 0
      Width = 249
    end
    object cxPassword: TcxTextEdit
      Left = 6
      Top = 73
      Properties.EchoMode = eemPassword
      Properties.PasswordChar = '*'
      TabOrder = 1
      Width = 249
    end
    object cxLabel1: TcxLabel
      Left = 6
      Top = 14
      Caption = #1048#1084#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103':'
    end
    object cxLabel2: TcxLabel
      Left = 6
      Top = 56
      Caption = #1055#1072#1088#1086#1083#1100':'
    end
  end
  object cxOK: TcxButton
    Left = 48
    Top = 112
    Width = 90
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object cxCancel: TcxButton
    Left = 144
    Top = 112
    Width = 90
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
