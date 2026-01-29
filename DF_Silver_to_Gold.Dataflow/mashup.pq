[DefaultOutputDestinationSettings = [DestinationDefinition = [Kind = "Reference", QueryName = "DefaultDestination", IsNewTarget = true], UpdateMethod = [Kind = "Replace"], DestinationTypeSettings = [Kind = "Table"]], StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[BindToDefaultDestination = true]
shared #"Dimention Countries" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "dff63297-ff0e-4927-8e91-bc223e951376"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "40bd4a39-6798-4210-8e2f-e09024560926"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Countries", ItemKind = "Table"]}[Data]
in
  #"Navigation 2";
shared #"Food price inflation" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "dff63297-ff0e-4927-8e91-bc223e951376"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "40bd4a39-6798-4210-8e2f-e09024560926"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Food price inflation", ItemKind = "Table"]}[Data],
  #"Renamed columns" = Table.RenameColumns(#"Navigation 2", {{"Value", "Food price inflation"}}),
  #"Changed column type" = Table.TransformColumnTypes(#"Renamed columns", {{"Food price inflation", Percentage.Type}}),
  #"Inserted Merged Column" = Table.AddColumn(#"Changed column type", "Id", each Text.Combine({[country_code], ",", [Year]}), type text)
in
  #"Inserted Merged Column";
shared #"GDP Social Protection Spending" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "dff63297-ff0e-4927-8e91-bc223e951376"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "40bd4a39-6798-4210-8e2f-e09024560926"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "GDP Social Protection Spending", ItemKind = "Table"]}[Data],
  #"Renamed columns" = Table.RenameColumns(#"Navigation 2", {{"Value", "GDP Social Protection Spending"}, {"Ref_Area", "country_code"}}),
  #"Changed column type" = Table.TransformColumnTypes(#"Renamed columns", {{"GDP Social Protection Spending", Percentage.Type}, {"Year", type text}}),
  #"Inserted Merged Column" = Table.AddColumn(#"Changed column type", "Id", each Text.Combine({[country_code], ",", Text.From([Year], "en-US")}), type text)
in
  #"Inserted Merged Column";
shared #"GNI per capita" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "dff63297-ff0e-4927-8e91-bc223e951376"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "40bd4a39-6798-4210-8e2f-e09024560926"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "GNI per capita", ItemKind = "Table"]}[Data],
  #"Renamed columns" = Table.RenameColumns(#"Navigation 2", {{"Value", "GNI per capita"}, {"Ref_Area", "country_code"}}),
  #"Changed column type" = Table.TransformColumnTypes(#"Renamed columns", {{"GNI per capita", Currency.Type}, {"Year", type text}}),
  #"Inserted Merged Column" = Table.AddColumn(#"Changed column type", "Id", each Text.Combine({[country_code], ",", Text.From([Year], "en-US")}), type text)
in
  #"Inserted Merged Column";
shared #"Life Expectancy After Birth" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "dff63297-ff0e-4927-8e91-bc223e951376"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "40bd4a39-6798-4210-8e2f-e09024560926"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Life Expectancy After Birth", ItemKind = "Table"]}[Data],
  #"Renamed columns" = Table.RenameColumns(#"Navigation 2", {{"Value", "Life Expectancy After Birth"}, {"Ref_Area", "country_code"}}),
  #"Changed column type" = Table.TransformColumnTypes(#"Renamed columns", {{"Year", type text}}),
  #"Inserted Merged Column" = Table.AddColumn(#"Changed column type", "Id", each Text.Combine({[country_code], ",", Text.From([Year], "en-US")}), type text)
in
  #"Inserted Merged Column";
shared #"Population by Illiteracy" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "dff63297-ff0e-4927-8e91-bc223e951376"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "40bd4a39-6798-4210-8e2f-e09024560926"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Population by Illiteracy", ItemKind = "Table"]}[Data],
  #"Renamed columns" = Table.RenameColumns(#"Navigation 2", {{"Value", "Illiterate Population"}}),
  #"Changed column type" = Table.TransformColumnTypes(#"Renamed columns", {{"Illiterate Population", Percentage.Type}}),
  #"Inserted Merged Column" = Table.AddColumn(#"Changed column type", "Id", each Text.Combine({[country_code], ",", [Year]}), type text)
in
  #"Inserted Merged Column";
shared #"Population by School Attendance" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "dff63297-ff0e-4927-8e91-bc223e951376"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "40bd4a39-6798-4210-8e2f-e09024560926"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Population by School Attendance", ItemKind = "Table"]}[Data],
  #"Changed column type" = Table.TransformColumnTypes(#"Navigation 2", {{"Not attending school", Percentage.Type}}),
  #"Renamed columns" = Table.RenameColumns(#"Changed column type", {{"Not attending school", "Population Not attending school"}}),
  #"Inserted Merged Column" = Table.AddColumn(#"Renamed columns", "Id", each Text.Combine({[country_code], ",", [Year]}), type text)
in
  #"Inserted Merged Column";
shared #"Population by Type of Living Quarters" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "dff63297-ff0e-4927-8e91-bc223e951376"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "40bd4a39-6798-4210-8e2f-e09024560926"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Population by Type of Living Quarters", ItemKind = "Table"]}[Data],
  #"Renamed columns" = Table.RenameColumns(#"Navigation 2", {{"Housing units", "Population living in Housing units"}, {"Collective living quarters", "Population living in Collective living quarters"}, {"Roofless", "Population that are Roofless"}, {"Unknown", "Population with Unknown housing"}}),
  #"Changed column type" = Table.TransformColumnTypes(#"Renamed columns", {{"Population living in Housing units", Percentage.Type}, {"Population living in Collective living quarters", Percentage.Type}, {"Population that are Roofless", Percentage.Type}, {"Population with Unknown housing", Percentage.Type}}),
  #"Inserted Merged Column" = Table.AddColumn(#"Changed column type", "Id", each Text.Combine({[country_code], ",", [Year]}), type text)
in
  #"Inserted Merged Column";
shared #"Population in poverty" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "dff63297-ff0e-4927-8e91-bc223e951376"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "40bd4a39-6798-4210-8e2f-e09024560926"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Population in poverty", ItemKind = "Table"]}[Data],
  #"Changed column type" = Table.TransformColumnTypes(#"Navigation 2", {{"Value", Percentage.Type}}),
  #"Renamed columns" = Table.RenameColumns(#"Changed column type", {{"Value", "Population in poverty"}}),
  #"Inserted Merged Column" = Table.AddColumn(#"Renamed columns", "Id", each Text.Combine({[country_code], ",", [Year]}), type text)
in
  #"Inserted Merged Column";
shared #"Population living in slums" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "dff63297-ff0e-4927-8e91-bc223e951376"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "40bd4a39-6798-4210-8e2f-e09024560926"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Population living in slums", ItemKind = "Table"]}[Data],
  #"Renamed columns" = Table.RenameColumns(#"Navigation 2", {{"Value", "Population living in slums"}}),
  #"Changed column type" = Table.TransformColumnTypes(#"Renamed columns", {{"Population living in slums", Percentage.Type}}),
  #"Inserted Merged Column" = Table.AddColumn(#"Changed column type", "Id", each Text.Combine({[country_code], ",", [Year]}), type text)
in
  #"Inserted Merged Column";
shared #"Population using safely managed sanitation services" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "dff63297-ff0e-4927-8e91-bc223e951376"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "40bd4a39-6798-4210-8e2f-e09024560926"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Population using safely managed sanitation services", ItemKind = "Table"]}[Data],
  #"Changed column type" = Table.TransformColumnTypes(#"Navigation 2", {{"Value", Percentage.Type}}),
  #"Renamed columns" = Table.RenameColumns(#"Changed column type", {{"Value", "Population using safely managed sanitation services"}}),
  #"Inserted Merged Column" = Table.AddColumn(#"Renamed columns", "Id", each Text.Combine({[country_code], ",", [Year]}), type text)
in
  #"Inserted Merged Column";
shared #"Population with food insecurity" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "dff63297-ff0e-4927-8e91-bc223e951376"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "40bd4a39-6798-4210-8e2f-e09024560926"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Population with food insecurity", ItemKind = "Table"]}[Data],
  #"Renamed columns" = Table.RenameColumns(#"Navigation 2", {{"Value", "Population with food insecurity"}}),
  #"Changed column type" = Table.TransformColumnTypes(#"Renamed columns", {{"Population with food insecurity", Percentage.Type}}),
  #"Inserted Merged Column" = Table.AddColumn(#"Changed column type", "Id", each Text.Combine({[country_code], ",", [Year]}), type text)
in
  #"Inserted Merged Column";
shared #"Public Education Spending" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "dff63297-ff0e-4927-8e91-bc223e951376"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "40bd4a39-6798-4210-8e2f-e09024560926"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Public Education Spending", ItemKind = "Table"]}[Data],
  #"Renamed columns" = Table.RenameColumns(#"Navigation 2", {{"Value", "Public Education Spending"}, {"Ref_Area", "country_code"}}),
  #"Changed column type" = Table.TransformColumnTypes(#"Renamed columns", {{"Public Education Spending", Currency.Type}, {"Year", type text}}),
  #"Inserted Merged Column" = Table.AddColumn(#"Changed column type", "Id", each Text.Combine({[country_code], ",", Text.From([Year], "en-US")}), type text)
in
  #"Inserted Merged Column";
shared #"Public Health Spending" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "dff63297-ff0e-4927-8e91-bc223e951376"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "40bd4a39-6798-4210-8e2f-e09024560926"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Public Health Spending", ItemKind = "Table"]}[Data],
  #"Renamed columns" = Table.RenameColumns(#"Navigation 2", {{"Value", "Public Health Spending"}, {"Ref_Area", "country_code"}}),
  #"Changed column type" = Table.TransformColumnTypes(#"Renamed columns", {{"Public Health Spending", Currency.Type}, {"Year", type text}}),
  #"Inserted Merged Column" = Table.AddColumn(#"Changed column type", "Id", each Text.Combine({[country_code], ",", Text.From([Year], "en-US")}), type text)
in
  #"Inserted Merged Column";
shared #"Renewable Energy Score" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "dff63297-ff0e-4927-8e91-bc223e951376"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "40bd4a39-6798-4210-8e2f-e09024560926"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Renewable Energy Score", ItemKind = "Table"]}[Data],
  #"Renamed columns" = Table.RenameColumns(#"Navigation 2", {{"Value", "Renewable Energy Score"}, {"Ref_Area", "country_code"}}),
  #"Changed column type" = Table.TransformColumnTypes(#"Renamed columns", {{"Year", type text}}),
  #"Inserted Merged Column" = Table.AddColumn(#"Changed column type", "Id", each Text.Combine({[country_code], ",", Text.From([Year], "en-US")}), type text)
in
  #"Inserted Merged Column";
shared #"Research and Development Spending" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "dff63297-ff0e-4927-8e91-bc223e951376"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "40bd4a39-6798-4210-8e2f-e09024560926"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Research and Development Spending", ItemKind = "Table"]}[Data],
  #"Changed column type" = Table.TransformColumnTypes(#"Navigation 2", {{"Value", Currency.Type}, {"Year", type text}}),
  #"Renamed columns" = Table.RenameColumns(#"Changed column type", {{"Value", "Research and Development Spending"}, {"Ref_Area", "country_code"}}),
  #"Inserted Merged Column" = Table.AddColumn(#"Renamed columns", "Id", each Text.Combine({[country_code], ",", Text.From([Year], "en-US")}), type text)
in
  #"Inserted Merged Column";
[BindToDefaultDestination = true]
shared #"Fact Country Data" = let
  Source = Table.Combine({#"Food price inflation", #"GNI per capita"}),
  #"Removed columns" = Table.RemoveColumns(Source, {"Year", "Food price inflation", "country_code", "GNI per capita"}),
  #"Appended query 12" = Table.Combine({#"Removed columns", #"GDP Social Protection Spending"}),
  #"Removed columns 13" = Table.RemoveColumns(#"Appended query 12", {"country_code", "Year", "GDP Social Protection Spending"}),
  #"Appended query" = Table.Combine({#"Removed columns 13", #"Life Expectancy After Birth"}),
  #"Removed columns 1" = Table.RemoveColumns(#"Appended query", {"country_code", "Year", "Life Expectancy After Birth"}),
  #"Appended query 1" = Table.Combine({#"Removed columns 1", #"Population by Illiteracy"}),
  #"Removed columns 2" = Table.RemoveColumns(#"Appended query 1", {"Year", "Illiterate Population", "country_code"}),
  #"Appended query 2" = Table.Combine({#"Removed columns 2", #"Population by School Attendance"}),
  #"Removed columns 3" = Table.RemoveColumns(#"Appended query 2", {"Year", "Population Not attending school", "country_code"}),
  #"Appended query 3" = Table.Combine({#"Removed columns 3", #"Population by Type of Living Quarters"}),
  #"Removed columns 4" = Table.RemoveColumns(#"Appended query 3", {"Year", "Population living in Housing units", "Population living in Collective living quarters", "Population that are Roofless", "Population with Unknown housing", "country_code"}),
  #"Appended query 4" = Table.Combine({#"Removed columns 4", #"Population in poverty"}),
  #"Removed columns 5" = Table.RemoveColumns(#"Appended query 4", {"country_code", "Year", "Population in poverty"}),
  #"Appended query 5" = Table.Combine({#"Removed columns 5", #"Population living in slums"}),
  #"Removed columns 6" = Table.RemoveColumns(#"Appended query 5", {"country_code", "Year", "Population living in slums"}),
  #"Appended query 6" = Table.Combine({#"Removed columns 6", #"Population using safely managed sanitation services"}),
  #"Removed columns 7" = Table.RemoveColumns(#"Appended query 6", {"country_code", "Year", "Population using safely managed sanitation services"}),
  #"Appended query 7" = Table.Combine({#"Removed columns 7", #"Population with food insecurity"}),
  #"Removed columns 8" = Table.RemoveColumns(#"Appended query 7", {"country_code", "Year", "Population with food insecurity"}),
  #"Appended query 8" = Table.Combine({#"Removed columns 8", #"Public Education Spending"}),
  #"Removed columns 9" = Table.RemoveColumns(#"Appended query 8", {"Year", "country_code", "Public Education Spending"}),
  #"Appended query 9" = Table.Combine({#"Removed columns 9", #"Public Health Spending"}),
  #"Removed columns 10" = Table.RemoveColumns(#"Appended query 9", {"country_code", "Year", "Public Health Spending"}),
  #"Appended query 10" = Table.Combine({#"Removed columns 10", #"Renewable Energy Score"}),
  #"Removed columns 11" = Table.RemoveColumns(#"Appended query 10", {"country_code", "Year", "Renewable Energy Score"}),
  #"Appended query 11" = Table.Combine({#"Removed columns 11", #"Research and Development Spending"}),
  #"Removed columns 12" = Table.RemoveColumns(#"Appended query 11", {"country_code", "Year", "Research and Development Spending"}),
  #"Removed duplicates" = Table.Distinct(#"Removed columns 12", {"Id"}),
  #"Duplicated column" = Table.DuplicateColumn(#"Removed duplicates", "Id", "Id - Copy"),
  #"Split column by delimiter" = Table.SplitColumn(#"Duplicated column", "Id - Copy", Splitter.SplitTextByDelimiter(","), {"Country", "Year"}),
  #"Changed column type" = Table.TransformColumnTypes(#"Split column by delimiter", {{"Country", type text}, {"Year", Int64.Type}}),
  #"Merged queries" = Table.NestedJoin(#"Changed column type", {"Id"}, #"Food price inflation", {"Id"}, "Food price inflation", JoinKind.LeftOuter),
  #"Merged queries 1" = Table.NestedJoin(#"Merged queries", {"Id"}, #"GDP Social Protection Spending", {"Id"}, "GDP Social Protection Spending", JoinKind.LeftOuter),
  #"Merged queries 2" = Table.NestedJoin(#"Merged queries 1", {"Id"}, #"GNI per capita", {"Id"}, "GNI per capita", JoinKind.LeftOuter),
  #"Merged queries 3" = Table.NestedJoin(#"Merged queries 2", {"Id"}, #"Life Expectancy After Birth", {"Id"}, "Life Expectancy After Birth", JoinKind.LeftOuter),
  #"Merged queries 4" = Table.NestedJoin(#"Merged queries 3", {"Id"}, #"Population by Illiteracy", {"Id"}, "Population by Illiteracy", JoinKind.LeftOuter),
  #"Merged queries 5" = Table.NestedJoin(#"Merged queries 4", {"Id"}, #"Population by School Attendance", {"Id"}, "Population by School Attendance", JoinKind.LeftOuter),
  #"Merged queries 6" = Table.NestedJoin(#"Merged queries 5", {"Id"}, #"Population by Type of Living Quarters", {"Id"}, "Population by Type of Living Quarters", JoinKind.LeftOuter),
  #"Merged queries 7" = Table.NestedJoin(#"Merged queries 6", {"Id"}, #"Population in poverty", {"Id"}, "Population in poverty", JoinKind.LeftOuter),
  #"Merged queries 8" = Table.NestedJoin(#"Merged queries 7", {"Id"}, #"Population living in slums", {"Id"}, "Population living in slums", JoinKind.LeftOuter),
  #"Merged queries 9" = Table.NestedJoin(#"Merged queries 8", {"Id"}, #"Population using safely managed sanitation services", {"Id"}, "Population using safely managed sanitation services", JoinKind.LeftOuter),
  #"Merged queries 10" = Table.NestedJoin(#"Merged queries 9", {"Id"}, #"Population with food insecurity", {"Id"}, "Population with food insecurity", JoinKind.LeftOuter),
  #"Merged queries 11" = Table.NestedJoin(#"Merged queries 10", {"Id"}, #"Public Education Spending", {"Id"}, "Public Education Spending", JoinKind.LeftOuter),
  #"Merged queries 12" = Table.NestedJoin(#"Merged queries 11", {"Id"}, #"Public Health Spending", {"Id"}, "Public Health Spending", JoinKind.LeftOuter),
  #"Merged queries 13" = Table.NestedJoin(#"Merged queries 12", {"Id"}, #"Renewable Energy Score", {"Id"}, "Renewable Energy Score", JoinKind.LeftOuter),
  #"Merged queries 14" = Table.NestedJoin(#"Merged queries 13", {"Id"}, #"Research and Development Spending", {"Id"}, "Research and Development Spending", JoinKind.LeftOuter),
  #"Expanded Food price inflation" = Table.ExpandTableColumn(#"Merged queries 14", "Food price inflation", {"Food price inflation"}, {"Food price inflation"}),
  #"Expanded GDP Social Protection Spending" = Table.ExpandTableColumn(#"Expanded Food price inflation", "GDP Social Protection Spending", {"GDP Social Protection Spending"}, {"GDP Social Protection Spending"}),
  #"Expanded GNI per capita" = Table.ExpandTableColumn(#"Expanded GDP Social Protection Spending", "GNI per capita", {"GNI per capita"}, {"GNI per capita"}),
  #"Expanded Life Expectancy After Birth" = Table.ExpandTableColumn(#"Expanded GNI per capita", "Life Expectancy After Birth", {"Life Expectancy After Birth"}, {"Life Expectancy After Birth"}),
  #"Expanded Population by Illiteracy" = Table.ExpandTableColumn(#"Expanded Life Expectancy After Birth", "Population by Illiteracy", {"Illiterate Population"}, {"Illiterate Population"}),
  #"Expanded Population by School Attendance" = Table.ExpandTableColumn(#"Expanded Population by Illiteracy", "Population by School Attendance", {"Population Not attending school"}, {"Population Not attending school"}),
  #"Expanded Population by Type of Living Quarters" = Table.ExpandTableColumn(#"Expanded Population by School Attendance", "Population by Type of Living Quarters", {"Population living in Housing units", "Population living in Collective living quarters", "Population that are Roofless", "Population with Unknown housing"}, {"Population living in Housing units", "Population living in Collective living quarters", "Population that are Roofless", "Population with Unknown housing"}),
  #"Expanded Population in poverty" = Table.ExpandTableColumn(#"Expanded Population by Type of Living Quarters", "Population in poverty", {"Population in poverty"}, {"Population in poverty"}),
  #"Expanded Population living in slums" = Table.ExpandTableColumn(#"Expanded Population in poverty", "Population living in slums", {"Population living in slums"}, {"Population living in slums"}),
  #"Expanded Population using safely managed sanitation services" = Table.ExpandTableColumn(#"Expanded Population living in slums", "Population using safely managed sanitation services", {"Population using safely managed sanitation services"}, {"Population using safely managed sanitation services"}),
  #"Expanded Population with food insecurity" = Table.ExpandTableColumn(#"Expanded Population using safely managed sanitation services", "Population with food insecurity", {"Population with food insecurity"}, {"Population with food insecurity"}),
  #"Expanded Public Education Spending" = Table.ExpandTableColumn(#"Expanded Population with food insecurity", "Public Education Spending", {"Public Education Spending"}, {"Public Education Spending"}),
  #"Expanded Public Health Spending" = Table.ExpandTableColumn(#"Expanded Public Education Spending", "Public Health Spending", {"Public Health Spending"}, {"Public Health Spending"}),
  #"Expanded Renewable Energy Score" = Table.ExpandTableColumn(#"Expanded Public Health Spending", "Renewable Energy Score", {"Renewable Energy Score"}, {"Renewable Energy Score"}),
  #"Expanded Research and Development Spending" = Table.ExpandTableColumn(#"Expanded Renewable Energy Score", "Research and Development Spending", {"Research and Development Spending"}, {"Research and Development Spending"}),
  #"Removed columns 14" = Table.RemoveColumns(#"Expanded Research and Development Spending", {"Id"})
in
  #"Removed columns 14";
shared DefaultDestination = Lakehouse.Contents([EnableFolding = false]){[workspaceId = "dff63297-ff0e-4927-8e91-bc223e951376"]}[Data]{[lakehouseId = "c94bf87a-9471-4610-9706-026accea4424"]}[Data];
