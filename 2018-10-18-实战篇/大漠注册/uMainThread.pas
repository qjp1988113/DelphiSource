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
    //�һ����
    procedure HangUp();
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
var
  OcrStr: string;
begin
  FreeOnTerminate := False;
  Dm := CreateComObjectFromDll(CLASS_dmsoft, LoadLibrary('dm.dll')) as Idmsoft;
   //����ȫ��·��
  dm.SetPath('\');
  dm.SetDict(0, 'ziku.txt');
 
  if dm.BindWindow(Self.Hand, 'normal', 'normal', 'normal', 0) = 0 then begin
    Exit;
  end;
  Self.Sleep(1000);
  //�һ�
//  Self.HangUp();
  OcrStr := dm.Ocr(65,11,216,52, 'ded784-000000', 0.9);
  Form1.Caption := OcrStr;
end;

procedure TWorkThread.HangUp;
begin
  while True do begin
     // ѡ��
    Self.Dm.KeyDown(17); //Ctrl
    Self.Sleep(500);
    Self.Dm.KeyPress(9); //Tab
    Self.Sleep(100);
    Self.Dm.KeyUp(17); //Ctrl
    Self.Sleep(1000);
    //�жϹ���Ѫ��������Ƿ�����Ѫ
    if Self.Dm.CmpColor(494, 34, 'ff4e40-000000', 0.9) = 1 then begin
      Continue;
    end;

    while True do begin
      //�ͷż���,��ȴʱ���ж�
      if Self.Dm.CmpColor(273, 542, '796549-000000', 0.9) = 0 then begin
        Self.Sleep(500);
        Self.Dm.KeyPress(113); //Tab
      end;
      //�жϹ����ͷ�����
      if (Self.Dm.CmpColor(320, 32, 'dd4536-000000', 0.9) = 1) then begin
        Break;
      end;

      Self.Sleep(1000);
    end;

  end;

end;

initialization


end.

