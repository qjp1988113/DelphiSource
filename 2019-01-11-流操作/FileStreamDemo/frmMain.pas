unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Memo1: TMemo;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

const
  SOURCE_FILE_PATH: string = 'E:\Demo\a.txt';

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  WriteFileStream, ReadFileStream: TFileStream;

begin
  try
    // 创建对象
    ReadFileStream := TFileStream.Create('D:\常用软件下载.txt', fmOpenRead);

    WriteFileStream := TFileStream.Create('E:\Demo\a.txt', fmCreate);

    // 设置读取的位置
    ReadFileStream.Position := 0;

    WriteFileStream.CopyFrom(ReadFileStream, ReadFileStream.Size);
  finally
    FreeAndNil(ReadFileStream);
    FreeAndNil(WriteFileStream);
  end;

end;

procedure TForm1.Button2Click(Sender: TObject);
var
  FileStream: TFileStream;
var
  Str: string;
var
  StrByte: TBytes;
begin

  // 字符串的长度、字符编码   Unicode、utf-8、gbk
  Str := '期待B站粉丝破万';

  try
    FileStream := TFileStream.Create(SOURCE_FILE_PATH, fmCreate);

    // 将string转换为指定编码的字节数组
    StrByte := TEncoding.UTF8.GetBytes(Str);

    FileStream.WriteBuffer(StrByte, Length(StrByte));

  finally
    FreeAndNil(FileStream);
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  FileStream: TFileStream;
var
  Str: UTF8String;
begin
  try
    // 以只读的方式打开一个文件
    FileStream := TFileStream.Create(SOURCE_FILE_PATH, fmOpenRead);
    FileStream.Position := 0;
    // 设置字符串的长度
    SetLength(Str, FileStream.Size);
    // 读取数据：解除指针引用，获取变量中的值
    FileStream.Read(PChar(Str)^, FileStream.Size);
    ShowMessage(Str);

  finally
    FreeAndNil(FileStream);
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  x: PInteger; // 整数类型的指针，    指针就是一个存放内存地址的变量
  y: Integer;

begin
  y := 20;

  x := @y;
  ShowMessage(x^.ToString); // ^在变量名的右边时表示解除指针引用
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  FileStream: TFileStream;
var
  Str: UTF8String;
begin
  FileStream := TFileStream.Create(SOURCE_FILE_PATH, fmOpenRead);
  FileStream.Position := 0;
  SetLength(Str, FileStream.Size);
  // 读取数据：解除指针引用，获取变量中的值
  FileStream.Read(PChar(Str)^, FileStream.Size);
  Self.Memo1.Lines.Add(Str);

  FreeAndNil(FileStream);
end;

end.
