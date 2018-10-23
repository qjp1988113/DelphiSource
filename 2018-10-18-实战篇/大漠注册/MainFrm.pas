unit MainFrm;

interface

uses
  System.Generics.Collections, Dm_TLB, uUtils, Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.Menus;

type
  TForm1 = class(TForm)
    Button1: TButton;
    StringGrid1: TStringGrid;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }

  end;

var
  Form1: TForm1;

implementation

uses
  uMainThread;
{$R *.dfm}

var
  Threads: TList<TWorkThread>;

procedure TForm1.Button1Click(Sender: TObject);
var
  dmhdl: THandle;
  dm: Idmsoft;
  Hands, Hand: string;
  Ret: Integer;
  HandArray: TArray<string>;
  RowIndex: Integer;
  WorkThread: TWorkThread;
begin
  dmhdl := LoadLibrary('dm.dll');
  if dmhdl < 32 then begin
    ShowMessage('初始化失败'#13'请检测运行目录中是否含有dm.dll文件');
    Exit;
  end;

  dm := CreateComObjectFromDll(CLASS_dmsoft, dmhdl) as Idmsoft;

  if dm = nil then
    Exit;



  //枚举窗口，获取窗口句柄
  Hands := dm.EnumWindow(0, '《新天龙八部》', '', 1 + 4 + 8 + 16);
  //分割字符串
  HandArray := Hands.Split([',']);
  if (Length(HandArray) > 1) then
    StringGrid1.RowCount := StringGrid1.RowCount + High(HandArray);

  for RowIndex := Low(HandArray) to High(HandArray) do begin
//
    dm.SetWindowState(StrToInt(HandArray[RowIndex]), 12);
    TThread.Sleep(1000);
    //窗口绑定
    Ret := dm.BindWindow(StrToInt(HandArray[RowIndex]), 'normal', 'normal', 'normal', 0);
    if Ret = 0 then begin
      ShowMessage('绑定失败');
      Exit;
    end;

    WorkThread := TWorkThread.Create(StrToInt(HandArray[RowIndex]));
    Threads.Add(WorkThread);
    StringGrid1.Cells[0, RowIndex + 1] := (RowIndex + 1).ToString;
    StringGrid1.Cells[1, RowIndex + 1] := WorkThread.ThreadID.ToString;
    StringGrid1.Cells[2, RowIndex + 1] := HandArray[RowIndex];
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Threads := TList<TWorkThread>.Create();
  StringGrid1.Cols[0].Add('序号');
  StringGrid1.Cols[1].Add('线程ID');
  StringGrid1.Cols[2].Add('窗口句柄');
  StringGrid1.Cols[3].Add('角色名称');
  OLERegister('./dm.dll', 1);

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  OLERegister('./dm.dll', 0);
end;

procedure TForm1.N1Click(Sender: TObject);
var
  WorkThread: TWorkThread;
  ThreadId: Integer;
begin
  ThreadId := StrToInt(StringGrid1.Cells[1, StringGrid1.Row]);

  for WorkThread in Threads do begin
    if ThreadId = WorkThread.ThreadID then begin
      WorkThread.Suspended := True;
      Break;
    end;
  end;
end;

procedure TForm1.N2Click(Sender: TObject);
var
  WorkThread: TWorkThread;
  ThreadId: Integer;
begin
  ThreadId := StrToInt(StringGrid1.Cells[1, StringGrid1.Row]);

  for WorkThread in Threads do begin
    if ThreadId = WorkThread.ThreadID then begin
      WorkThread.Resume;
      Break;
    end;
  end;

end;

procedure TForm1.N3Click(Sender: TObject);
var
  WorkThread: TWorkThread;
  ThreadId: Integer;
begin
  ThreadId := StrToInt(StringGrid1.Cells[1, StringGrid1.Row]);

  for WorkThread in Threads do begin
    if ThreadId = WorkThread.ThreadID then begin
       //win32API
      TerminateThread(WorkThread.Handle, 0);
      Break;
    end;
  end;

end;

end.

