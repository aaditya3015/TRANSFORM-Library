within TRANSFORM.Math.Interpolation.Models.Examples.MSL;
model check_readTableData
  parameter Boolean tableOnFile=true
    "= true, if table is defined on file or in function usertab"
    annotation (Dialog(group="Table data definition"));
  parameter Real table[:,:]=fill(
      0.0,
      0,
      2)
    "Table matrix (grid u1 = first column, grid u2 = first row; e.g., table=[0,0;0,1])"
    annotation (Dialog(group="Table data definition", enable=not tableOnFile));
  parameter String tableName="table2D_1"
    "Table name on file or in function usertab (see docu)"
    annotation (Dialog(group="Table data definition", enable=tableOnFile));
  parameter String fileName=Modelica.Utilities.Files.fullPathName("C:\\Users\\vmg\\Documents\Modelica\\TRANSFORM-Library\\TRANSFORM\\Resources\\data\\lookupTables\\ParaHydrogen\\pT\\test.txt")
    "File where matrix is stored" annotation (Dialog(
      group="Table data definition",
      enable=tableOnFile,
      loadSelector(filter="Text files (*.txt);;MATLAB MAT-files (*.mat)",
          caption="Open file in which table is present")));
  parameter Boolean verboseRead=true
    "= true, if info message that file is loading is to be printed"
    annotation (Dialog(group="Table data definition", enable=tableOnFile));
  parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
    "Smoothness of table interpolation"
    annotation (Dialog(group="Table data interpretation"));
protected
  Modelica.Blocks.Types.ExternalCombiTable2D tableID=
      Modelica.Blocks.Types.ExternalCombiTable2D(
      if tableOnFile then tableName else "NoName",
      if tableOnFile and fileName <> "NoName" and not
        Modelica.Utilities.Strings.isEmpty(fileName) then fileName else "NoName",
      table,
      smoothness) "External table object";
  parameter Real tableOnFileRead(fixed=false)
    "= 1, if table was successfully read from file";
initial algorithm
  if tableOnFile then
    tableOnFileRead := TRANSFORM.Math.Interpolation.MSL.readTableData(
      tableID,
      false,
      verboseRead);
  else
    tableOnFileRead := 1.;
  end if;
end check_readTableData;
