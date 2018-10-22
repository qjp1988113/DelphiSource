unit uMainThread;

interface

uses
  uUtils, Dm_TLB, System.Classes, Winapi.Windows;

type
  TWorkThread = class(TThread)
  private
    Hand: Integer;
    Dm: Idmsoft;
  protected
    procedure Execute; override;
  public
    constructor Create; overload;
    constructor Create(Hand: Integer); overload;
  end;

implementation

uses
  MainFrm;


{ TWorkThread }

constructor TWorkThread.Create(Hand: Integer);
begin
  inherited Create(False);
  Self.Hand := Hand;

end;

constructor TWorkThread.Create;
begin
  inherited Create(False);
end;

procedure TWorkThread.Execute;
begin
  FreeOnTerminate := False;
  Dm := CreateComObjectFromDll(CLASS_dmsoft, LoadLibrary('dm.dll')) as Idmsoft;

  self.Hand := Dm.FindWindowEx(Self.Hand, '', '');

  if dm.BindWindow(Self.Hand, 'gdi', 'windows', 'windows', 0) = 0 then begin
    Exit;
  end;

  //操作向窗口中发送字符串
  while True do begin

    dm.SendString(Self.Hand, PWideChar('我是来测试的'));
    TThread.Sleep(1000);
  end;

end;

initialization


end.

