program BinPacker;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {Form1},
  OlgSlot in 'OlgSlot.pas',
  OlgSlotManager in 'OlgSlotManager.pas',
  OlgSlotNode in 'OlgSlotNode.pas',
  OlgLogger in '..\..\UI\OlgLogger.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
