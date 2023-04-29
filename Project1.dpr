program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  OlgSlot in 'OlgSlot.pas',
  OlgSlotManager in 'OlgSlotManager.pas',
  OlgNode in 'OlgNode.pas',
  OlgLogger in '..\..\UI\OlgLogger.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
