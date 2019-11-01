object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'Process Tool'
  ClientHeight = 454
  ClientWidth = 510
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    510
    454)
  PixelsPerInch = 96
  TextHeight = 13
  object btnSearchParentId: TButton
    Left = 251
    Top = 8
    Width = 72
    Height = 25
    Caption = 'Search'
    Default = True
    TabOrder = 1
    OnClick = btnSearchParentIdClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 58
    Width = 490
    Height = 130
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Process Information'
    TabOrder = 2
    DesignSize = (
      490
      130)
    object Label2: TLabel
      Left = 20
      Top = 44
      Width = 22
      Height = 13
      Caption = 'Path'
    end
    object Label3: TLabel
      Left = 20
      Top = 16
      Width = 67
      Height = 13
      Caption = 'Process Name'
    end
    object Label4: TLabel
      Left = 20
      Top = 71
      Width = 41
      Height = 13
      Caption = 'Full Path'
    end
    object Label1: TLabel
      Left = 20
      Top = 98
      Width = 50
      Height = 13
      Caption = 'Process Id'
    end
    object Label11: TLabel
      Left = 155
      Top = 100
      Width = 27
      Height = 13
      Caption = '(Hex)'
    end
    object Label12: TLabel
      Left = 255
      Top = 100
      Width = 26
      Height = 13
      Caption = '(Dec)'
    end
    object EditProcessPath: TEdit
      Left = 95
      Top = 44
      Width = 380
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      ReadOnly = True
      TabOrder = 1
    end
    object editFileName: TEdit
      Left = 95
      Top = 16
      Width = 380
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      ReadOnly = True
      TabOrder = 0
    end
    object editFullPath: TEdit
      Left = 95
      Top = 71
      Width = 380
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      ReadOnly = True
      TabOrder = 2
    end
    object editProcessIdHex: TEdit
      Left = 95
      Top = 98
      Width = 54
      Height = 21
      ReadOnly = True
      TabOrder = 3
    end
    object editProcessIdDec: TEdit
      Left = 195
      Top = 98
      Width = 54
      Height = 21
      ReadOnly = True
      TabOrder = 4
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 194
    Width = 490
    Height = 134
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Parent Process Information'
    TabOrder = 3
    DesignSize = (
      490
      134)
    object Label5: TLabel
      Left = 15
      Top = 46
      Width = 22
      Height = 13
      Caption = 'Path'
    end
    object Label6: TLabel
      Left = 15
      Top = 19
      Width = 67
      Height = 13
      Caption = 'Process Name'
    end
    object Label7: TLabel
      Left = 15
      Top = 73
      Width = 41
      Height = 13
      Caption = 'Full Path'
    end
    object Label8: TLabel
      Left = 15
      Top = 100
      Width = 50
      Height = 13
      Caption = 'Process Id'
    end
    object Label9: TLabel
      Left = 155
      Top = 100
      Width = 27
      Height = 13
      Caption = '(Hex)'
    end
    object Label10: TLabel
      Left = 255
      Top = 100
      Width = 26
      Height = 13
      Caption = '(Dec)'
    end
    object editParentPath: TEdit
      Left = 95
      Top = 46
      Width = 380
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      ReadOnly = True
      TabOrder = 1
    end
    object editParentFileName: TEdit
      Left = 95
      Top = 19
      Width = 380
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      ReadOnly = True
      TabOrder = 0
    end
    object editParentFullPath: TEdit
      Left = 95
      Top = 73
      Width = 380
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      ReadOnly = True
      TabOrder = 2
    end
    object editParentProcessIdHex: TEdit
      Left = 95
      Top = 100
      Width = 54
      Height = 21
      ReadOnly = True
      TabOrder = 3
    end
    object editParentProcessIdDec: TEdit
      Left = 195
      Top = 100
      Width = 54
      Height = 21
      ReadOnly = True
      TabOrder = 4
    end
  end
  object rbHex: TRadioButton
    Left = 103
    Top = 35
    Width = 41
    Height = 17
    Caption = 'Hex'
    Checked = True
    TabOrder = 4
    TabStop = True
    Visible = False
  end
  object rbDec: TRadioButton
    Left = 150
    Top = 35
    Width = 42
    Height = 17
    Caption = 'Dec'
    TabOrder = 5
    Visible = False
  end
  object editProcessId: TEdit
    Left = 103
    Top = 8
    Width = 142
    Height = 21
    TabOrder = 0
  end
  object ComboBoxProcess: TComboBox
    Left = 8
    Top = 8
    Width = 91
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 6
    Text = 'Process Name'
    OnChange = ComboBoxProcessChange
    Items.Strings = (
      'Process Name'
      'Process Id')
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 334
    Width = 490
    Height = 112
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Sub Process Information'
    TabOrder = 7
    ExplicitHeight = 341
    DesignSize = (
      490
      112)
    object listBoxSubProcess: TListBox
      Left = 15
      Top = 24
      Width = 460
      Height = 71
      Anchors = [akLeft, akTop, akRight, akBottom]
      ItemHeight = 13
      TabOrder = 0
      ExplicitHeight = 153
    end
  end
  object BitBtnCopy: TBitBtn
    Left = 474
    Top = 332
    Width = 25
    Height = 26
    Anchors = [akTop, akRight]
    Glyph.Data = {
      36050000424D3605000000000000360400002800000010000000100000000100
      08000000000000010000120B0000120B0000000100001C00000000000000E1E1
      E1008989890033333300FCFCFC007B7B7B00C7C7C7001F1F1F00E5E5E5001E1E
      1E001A1A1A00F9F9F900999999003636360030303000868686000D0D0D00E3E3
      E300FFFFFF00C9C9C900080808008C8C8C00383838001C1C1C0022222200E7E7
      E700FFFFFF008B8B8B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000121212121211
      070A070707070707170012121212120103061101010101110617121212121211
      161112121212121211071101010111060301121212121212010707031616160E
      181112121212121201070A061101110603011212121212120107071112121211
      1611121212121212010707011212120103061108041212120107070112121208
      1818031608121212010707011212120B020D0C03111212121107071112121212
      0B1B0D1806110111060A0A0611080412120B0F100E1616160307141803160812
      12120103061101010111050D0C031112121211161112121212120B150D180611
      01110603011212121212120B05140A0707070A07111212121212}
    TabOrder = 8
    OnClick = BitBtnCopyClick
  end
end
