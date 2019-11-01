unit UnitMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, TLHelp32, psapi, StrUtils, Clipbrd,
  Vcl.Grids, Vcl.Buttons;

type
  TFormMain = class(TForm)
    btnSearchParentId: TButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    EditProcessPath: TEdit;
    Label3: TLabel;
    editFileName: TEdit;
    Label4: TLabel;
    editFullPath: TEdit;
    Label5: TLabel;
    editParentPath: TEdit;
    Label6: TLabel;
    editParentFileName: TEdit;
    Label7: TLabel;
    editParentFullPath: TEdit;
    Label8: TLabel;
    editParentProcessIdHex: TEdit;
    editParentProcessIdDec: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    rbHex: TRadioButton;
    rbDec: TRadioButton;
    editProcessId: TEdit;
    ComboBoxProcess: TComboBox;
    Label1: TLabel;
    editProcessIdHex: TEdit;
    Label11: TLabel;
    editProcessIdDec: TEdit;
    Label12: TLabel;
    GroupBox3: TGroupBox;
    BitBtnCopy: TBitBtn;
    listBoxSubProcess: TListBox;
    procedure btnSearchParentIdClick(Sender: TObject);
    procedure ComboBoxProcessChange(Sender: TObject);
    procedure BitBtnCopyClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcessItem = class
    ProcessId: DWORD;
    ProcessName: string;
    ModuleName: string;
end;
var
  FormMain: TFormMain;

  { 类外的函数声明}
  function HexToInt(hex: string): integer;
  function GetProcessFileName(ProcessID: DWORD): string;
  function GetParentProcessFileName(PID: DWORD): String;
  function GetParentProcessId(PID: DWORD): DWORD;
  function GetProcessIdByProcessName(processName: string): DWORD;
  function GetSubProcessId(PID: DWORD): TList;

implementation

{$R *.dfm}

procedure TFormMain.BitBtnCopyClick(Sender: TObject);
begin

  Clipboard.SetTextBuf(PChar(listBoxSubProcess.Items.Text));
end;

procedure TFormMain.btnSearchParentIdClick(Sender: TObject);
var
  ProcessID: DWORD;
  processList: TList;
  processItem: TProcessItem;
  i: Integer;
  s: string;
begin
  listBoxSubProcess.Clear;
  EditProcessPath.Text := '';
  editFileName.Text := '';
  editParentPath.Text := '';
  editParentFileName.Text := '';
  editParentFullPath.Text := '';
  editParentProcessIdHex.Text := '';
  editParentProcessIdDec.Text := '';
  editProcessIdHex.Text := '';
  editProcessIdDec.Text := '';
  
  if self.ComboBoxProcess.ItemIndex = 0 then
  begin
    ProcessID := GetProcessIdByProcessName(editProcessId.Text);
    
    if ProcessId = 0 then
    begin
      if (rightstr(editProcessId.Text, 4) = '.exe') then
      begin
        //ShowMessage('Invalid input.');
        exit;
      end
      else
      begin
        ProcessID := GetProcessIdByProcessName(self.editProcessId.Text + '.exe');
        if ProcessId = 0 then
        begin
          //ShowMessage('Invalid input.');
          exit;
        end;
      end;
    end;
  end
  else
  begin
    if rbHex.Checked then
      ProcessID := HexToInt(editProcessId.Text)
    else
      ProcessID := DWORD(StrToInt(editProcessId.Text));
  end;

  editProcessIdHex.Text := ProcessId.ToHexString;
  editProcessIdDec.Text := ProcessId.ToString;

  editFullPath.Text := GetProcessFileName(ProcessID);
  if editFullPath.Text = '' then
  begin
    EditProcessPath.Text := '';
    editFileName.Text := '';
    editParentPath.Text := '';
    editParentFileName.Text := '';
    editParentFullPath.Text := '';
    editParentProcessIdHex.Text := '';
    editParentProcessIdDec.Text := '';
    editProcessIdHex.Text := '';
    editProcessIdDec.Text := '';
  end else
  begin
    EditProcessPath.Text := ExtractFilePath(editFullPath.Text);
    editFileName.Text :=  ExtractFileName(editFullPath.Text);
    // 父进程
    editParentFullPath.Text := GetParentProcessFileName(ProcessID);
    if editParentFullPath.Text = '' then
    begin
      editParentPath.Text := '';
      editParentFileName.Text := '';
      editParentProcessIdHex.Text := '';
      editParentProcessIdDec.Text := '';
    end else
    begin
      editParentPath.Text := ExtractFilePath(editParentFullPath.Text);
      editParentFileName.Text := ExtractFileName(editParentFullPath.Text);
      editParentProcessIdHex.Text := GetParentProcessId(ProcessID).ToHexString;
      editParentProcessIdDec.Text := GetParentProcessId(ProcessID).ToString;
    end;

  end;

  {查询进程的所有子进程}
  processList := GetSubProcessId(ProcessID);
  listBoxSubProcess.Items.Clear;
  for i := 0 to processList.Count - 1 do
  begin
    processItem := TProcessItem(processList[i]);
    if processItem <> nil then
    begin
      s := Format('%s%8s%30s%4s%100s', [processItem.ProcessId.ToHexString, processItem.ProcessId.ToString, processItem.ProcessName, '', processItem.ModuleName]);
      listBoxSubProcess.Items.Add(s);
    end;
  end;

end;

procedure TFormMain.ComboBoxProcessChange(Sender: TObject);
begin
  if self.ComboBoxProcess.ItemIndex = 0 then
  begin
    self.rbHex.Visible := false;
    self.rbDec.Visible := false;
  end
  else
  begin
    self.rbHex.Visible := true;
    self.rbDec.Visible := true;
  end;
end;

// -----------------------------------------------
// 16进制字符转整数,16进制字符与字符串转换中间函数
// -----------------------------------------------
function HexToInt(hex: string): integer;
var
  i: integer;
  function Ncf(num, f: integer): integer;
  var
    i: integer;
  begin
    Result := 1;
    if f = 0 then
      exit;
    for i := 1 to f do
      Result := Result * num;
  end;
  function HexCharToInt(HexToken: char): integer;
  begin
    if HexToken > #97 then
      HexToken := Chr(Ord(HexToken) - 32);
    Result := 0;
    if (HexToken > #47) and (HexToken < #58) then { chars 0....9 }
      Result := Ord(HexToken) - 48
    else if (HexToken > #64) and (HexToken < #71) then { chars A....F }
      Result := Ord(HexToken) - 65 + 10;
  end;

begin
  Result := 0;
  hex := ansiuppercase(trim(hex));
  if hex = '' then
    exit;
  for i := 1 to length(hex) do
    Result := Result + HexCharToInt(hex[i]) * Ncf(16, length(hex) - i);
end;

{ 根据ProcessID查找完整的文件路径}
function GetProcessFileName(ProcessID: DWORD): string;
var
  Hand: THandle;
  ModName: Array [0 .. Max_Path - 1] of char;
  hMod: HModule;
  n: DWORD;
begin
  Result := '';
  Hand := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, False,
    ProcessID);
  if Hand > 0 then
    try
      ENumProcessModules(Hand, @hMod, SizeOf(hMod), n);
      if GetModuleFileNameEx(Hand, hMod, ModName, SizeOf(ModName)) > 0 then
        Result := ModName;
    except
    end;
end;

{ 根据PID查找对于的父进程的完整路径 }
function GetParentProcessFileName(PID: DWORD): String;
var
  HandleSnapShot: THandle;
  EntryParentProc: TProcessEntry32;
  HandleParentProc: THandle;
  ParentPID: DWORD;
  ParentProcessFound: boolean;
  ParentProcPath: PChar;
begin
  ParentProcPath := nil;
  ParentProcessFound := False;
  HandleSnapShot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  GetMem(ParentProcPath, Max_Path);
  ZeroMemory(ParentProcPath, Max_Path);
  try
    if HandleSnapShot <> INVALID_HANDLE_VALUE then
    begin
      EntryParentProc.dwSize := SizeOf(EntryParentProc);
      if Process32First(HandleSnapShot, EntryParentProc) then
      begin
        repeat
          if EntryParentProc.th32ProcessID = PID then
          begin
            ParentPID := EntryParentProc.th32ParentProcessID;
            HandleParentProc := OpenProcess(PROCESS_QUERY_INFORMATION or
              PROCESS_VM_READ, False, ParentPID);
            ParentProcessFound := HandleParentProc <> 0;
            if ParentProcessFound then
            begin
              GetModuleFileNameEx(HandleParentProc, 0, PChar(ParentProcPath),
                Max_Path);
              ParentProcPath := PChar(ParentProcPath);
              CloseHandle(HandleParentProc);
            end;
            break;
          end;
        until not Process32Next(HandleSnapShot, EntryParentProc);
      end;
      CloseHandle(HandleSnapShot);
    end;

    if ParentProcessFound then
      Result := ParentProcPath
    else
      Result := '';
  finally
    FreeMem(ParentProcPath);
  end;
end;

{ 查找PID的父进程 }
function GetParentProcessId(PID: DWORD): DWORD;
var
  HandleSnapShot: THandle;
  EntryParentProc: TProcessEntry32;
  HandleParentProc: THandle;
  ParentProcessFound: boolean;
begin
  Result := 0;
  ParentProcessFound := False;
  HandleSnapShot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  try
    if HandleSnapShot <> INVALID_HANDLE_VALUE then
    begin
      EntryParentProc.dwSize := SizeOf(EntryParentProc);
      if Process32First(HandleSnapShot, EntryParentProc) then
      begin
        repeat
          if EntryParentProc.th32ProcessID = PID then
          begin
            Result := EntryParentProc.th32ParentProcessID;

            break;
          end;
        until not Process32Next(HandleSnapShot, EntryParentProc);
      end;
      CloseHandle(HandleSnapShot);
    end;

  finally

  end;
end;

{ 根据PID查找所有子进程 }
function GetSubProcessId(PID: DWORD): TList;
var
  HandleSnapShot: THandle;
  EntryParentProc: TProcessEntry32;
  HandleParentProc: THandle;
  ParentProcessFound: boolean;
  processList : TList;
  pProcessItem:TProcessItem;
  subProcessId: DWORD;
begin
  processList := TList.Create;
  ParentProcessFound := False;
  HandleSnapShot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  try
    if HandleSnapShot <> INVALID_HANDLE_VALUE then
    begin
      EntryParentProc.dwSize := SizeOf(EntryParentProc);
      if Process32First(HandleSnapShot, EntryParentProc) then
      begin
        repeat
          if EntryParentProc.th32ParentProcessID = PID then
          begin
            pProcessItem := TProcessItem.Create;
            pProcessItem.ProcessId := EntryParentProc.th32ProcessID;
            pProcessItem.ProcessName := EntryParentProc.szExeFile;
            subProcessId := GetProcessIdByProcessName( pProcessItem.ProcessName);
            pProcessItem.ModuleName := GetProcessFileName(subProcessId);
            processList.Add(pProcessItem);
          end;
        until not Process32Next(HandleSnapShot, EntryParentProc);
      end;
      CloseHandle(HandleSnapShot);
    end;

  finally
    Result := processList;
  end;
end;

{ 根据进程名查找进程ID }
function GetProcessIdByProcessName(processName: string): DWORD;
var
  HandleSnapShot: THandle;
  EntryParentProc: TProcessEntry32;
  HandleParentProc: THandle;
  ParentPID: DWORD;
  ParentProcessFound: boolean;
begin
  ParentProcessFound := False;
  Result := 0;
  HandleSnapShot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  try
    if HandleSnapShot <> INVALID_HANDLE_VALUE then
    begin
      EntryParentProc.dwSize := SizeOf(EntryParentProc);
      if Process32First(HandleSnapShot, EntryParentProc) then
      begin
        repeat
          if LowerCase(EntryParentProc.szExeFile) = LowerCase(processName) then
          begin
            Result := EntryParentProc.th32ProcessID;
            break;
          end;
        until not Process32Next(HandleSnapShot, EntryParentProc);
      end;
    end;
  finally

  end;
end;

end.
