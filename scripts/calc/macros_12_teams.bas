REM  *****  BASIC  *****

sub Punkte_Sortieren
    dim document   as object
    dim dispatcher as object

    document = ThisComponent.CurrentController.Frame
    dispatcher = createUnoService("com.sun.star.frame.DispatchHelper")

    dim args1(0) as new com.sun.star.beans.PropertyValue
    args1(0).Name = "ToPoint"
    args1(0).Value = "$C$2:$AE$13"
    dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args1())

    dim args2(11) as new com.sun.star.beans.PropertyValue
    args2(0).Name = "ByRows"
    args2(0).Value = true
    args2(1).Name = "HasHeader"
    args2(1).Value = false
    args2(2).Name = "CaseSensitive"
    args2(2).Value = false
    args2(3).Name = "NaturalSort"
    args2(3).Value = false
    args2(4).Name = "IncludeAttribs"
    args2(4).Value = true
    args2(5).Name = "UserDefIndex"
    args2(5).Value = 0
    args2(6).Name = "Col1"
    args2(6).Value = 16
    args2(7).Name = "Ascending1"
    args2(7).Value = false
    args2(8).Name = "Col2"
    args2(8).Value = 17
    args2(9).Name = "Ascending2"
    args2(9).Value = true
    args2(10).Name = "IncludeComments"
    args2(10).Value = false
    args2(11).Name = "IncludeImages"
    args2(11).Value = true
    dispatcher.executeDispatch(document, ".uno:DataSort", "", 0, args2())
end sub

sub Copy_To_Block(BlockNr As String)
    Dim Doc As Object
    Dim PunkteSheet, BlockSheet As Object
    Dim Source, Target As Object
    Dim BlockPunkteCellRange As Object
    Dim PunkteCount As Integer

    Doc = ThisComponent
    PunkteSheet = Doc.Sheets.getByName("Punkte")
    BlockSheet = Doc.Sheets.getByName("Block" + BlockNr)

    REM Check for Points
    BlockPunkteCellRange = BlockSheet.getCellRangeByName("G5:G16")
    PunkteCount = BlockPunkteCellRange.computeFunction(com.sun.star.sheet.GeneralFunction.COUNTNUMS)

    If (PunkteCount > 0) Then
        MsgBox "Der ausgewählte Block enthält Punkte!"
    Else
        REM copy Name
        Source = PunkteSheet.getCellRangeByName("C2:C13")
        Target = BlockSheet.getCellRangeByName("D5:D16")
        Target.setDataArray(Source.getDataArray())
        REM copy Startnummer
        Source = PunkteSheet.getCellRangeByName("S2:S13")
        Target = BlockSheet.getCellRangeByName("B5:B16")
        Target.setDataArray(Source.getDataArray())
        REM copy Punkte
        Source = PunkteSheet.getCellRangeByName("N2:N13")
        Target = BlockSheet.getCellRangeByName("C5:C16")
        Target.setDataArray(Source.getDataArray())
        REM Target = BlockSheet.getCellRangeByName("B5")
        REM PunkteSheet.copyRange(Target.CellAddress, Source.RangeAddress)
    End If
    REM Source

end sub

sub Copy_To_Block1
    Copy_To_Block("1")
end sub
sub Copy_To_Block2
    Copy_To_Block("2")
end sub
sub Copy_To_Block3
    Copy_To_Block("3")
end sub
sub Copy_To_Block4
    Copy_To_Block("4")
end sub
sub Copy_To_Block5
    Copy_To_Block("5")
end sub


sub Punkte_Execute_Script(FileName As String)
    Dim Url, Path, Skript As String

    Url = ThisComponent.getURL()
    Path = replace(Url, "file://", "")
    Path = replace(Path, "punkte.ods", "")
    Skript = "bash -c 'cd " + Path + " && ./" + FileName + "'"
    Shell(Skript, 1)
end sub

sub Punkte_Backup_And_Check
    ThisComponent.store()
    Punkte_Execute_Script("backup_and_check.sh")

end sub
sub Punkte_Export_To_Web
    Punkte_Execute_Script("export_to_web.sh")
end sub
