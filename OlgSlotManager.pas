unit OlgSlotManager;

interface

uses
  SysUtils, Classes, Generics.Collections, Generics.Defaults, Types,

  OlgLogger, OlgSlot, OlgSlotNode;

type
  TOlgSlotManager = class
    private
      FSlots: TOlgSlots;
      FWidth: Integer;
      FHeight: Integer;
      FFilledArea: Integer;
      function GetTotalArea: Integer;
    public
      constructor Create;
      destructor Destroy; override;

      procedure Add(AWidth, AHeight: Integer; AName: String);
      procedure Clear;

      property Slots: TOlgSlots read FSlots;

      procedure Place;

      procedure SortByWidthASC;
      procedure SortByHeightASC;

      procedure SortByWidthDESC;
      procedure SortByHeightDESC;

      procedure SortByAreaASC;
      procedure SortByAreaDESC;

      property FilledArea: Integer read FFilledArea;
      property TotalArea: Integer read GetTotalArea;

      property Width: Integer read FWidth;
      property Height: Integer read FHeight;

  end;

implementation

{=========================================================================================================================================}
{ TOlgSlotManager }
{=========================================================================================================================================}
constructor TOlgSlotManager.Create;
begin
  FSlots := TOlgSlots.Create;

  FWidth := 700;
  FHeight := 500;
  FFilledArea := 0;
end;

{=========================================================================================================================================}
destructor TOlgSlotManager.Destroy;
begin
  FreeAndNil(FSlots);
  inherited;
end;

{=========================================================================================================================================}
procedure TOlgSlotManager.Clear;
begin
  FSlots.Clear;
end;

{=========================================================================================================================================}
function TOlgSlotManager.GetTotalArea: Integer;
begin
  Result := FWidth * FHeight;
end;

{=========================================================================================================================================}
procedure TOlgSlotManager.SortByHeightASC;
begin
  FSlots.Sort(
    TComparer<TOlgSlot>.Construct(
      function (const A, B: TOlgSlot): Integer
      begin
        Result := A.Height - B.Height;
      end
    )
  );
end;

{=========================================================================================================================================}
procedure TOlgSlotManager.SortByHeightDESC;
begin
  FSlots.Sort(
    TComparer<TOlgSlot>.Construct(
      function (const A, B: TOlgSlot): Integer
      begin
        Result := B.Height - A.Height;
      end
    )
  );
end;

{=========================================================================================================================================}
procedure TOlgSlotManager.SortByWidthASC;
begin
  FSlots.Sort(
    TComparer<TOlgSlot>.Construct(
      function (const A, B: TOlgSlot): Integer
      begin
        Result := A.Width - B.Width;
      end
    )
  );
end;


{=========================================================================================================================================}
procedure TOlgSlotManager.SortByWidthDESC;
begin
  FSlots.Sort(
    TComparer<TOlgSlot>.Construct(
      function (const A, B: TOlgSlot): Integer
      begin
        Result := B.Width - A.Width;
      end
    )
  );
end;

{=========================================================================================================================================}
procedure TOlgSlotManager.SortByAreaASC;
begin
  FSlots.Sort(
    TComparer<TOlgSlot>.Construct(
      function (const A, B: TOlgSlot): Integer
      begin
        Result := A.Width * A.Height - B.Width * B.Height;
      end
    )
  );
end;

{=========================================================================================================================================}
procedure TOlgSlotManager.SortByAreaDESC;
begin
  FSlots.Sort(
    TComparer<TOlgSlot>.Construct(
      function (const A, B: TOlgSlot): Integer
      begin
        Result := B.Width * B.Height - A.Width * A.Height;
      end
    )
  );
end;

{=========================================================================================================================================}
procedure TOlgSlotManager.Place;
var S: TOlgSlot;
    X, Y: Integer;

    StartNode: TOlgSlotNode;
    Q: TOlgSlotNode;
    //R: TOlgRect;
begin

  X := 10;
  Y := 10;

//  R := TOlgRect.ToRect(X, Y, FWidth - X, FHeight - Y);
  FFilledArea := 0;

  StartNode := TOlgSlotNode.Create();
  StartNode.SetRect(X, Y, FWidth - X, FHeight - Y);

  for S in FSlots do
    begin
      //R := TOlgRect.ToRect(0, 0, S.BoundsRect.Width, S.BoundsRect.Height);

      Q := StartNode.Insert(S);
      if Q <> nil then
        begin
//          S.BoundsRect := Rect(Q.FRect.X, Q.FRect.Y, Q.FRect.X + Q.FRect.W, Q.FRect.Y + Q.FRect.H);
          S.Move(Q.FSlot.Left, Q.FSlot.Top);

          FFilledArea := FFilledArea + Q.FSlot.Width * Q.FSlot.Height;

//          OlgLog(Q.FRect.X);
//          OlgLog(Q.FRect.Y);
//          OlgLog(Q.FRect.W);
//          OlgLog(Q.FRect.H);
//          OlgLog('');
        end;

//      X := X + S.Width;
    end;

  FreeAndNil(StartNode);

end;

{=========================================================================================================================================}
procedure TOlgSlotManager.Add(AWidth, AHeight: Integer; AName: String);
var Q: TOlgSlot;
begin
  Q := TOlgSlot.Create(0, 0, AWidth, AHeight);
  Q.Name := AName;
  Q.Color := Random($00FFFF00);

  FSlots.Add(Q);

end;

{=========================================================================================================================================}
end.
