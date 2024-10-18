DECLARE @NombreVista NVARCHAR(255);
DECLARE @Consulta NVARCHAR(MAX);

-- Cursor para recorrer todas las vistas en la base de datos actual
DECLARE VistaCursor CURSOR FOR
SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.VIEWS
WHERE TABLE_SCHEMA = 'dbo'; -- Cambia el esquema si es necesario

OPEN VistaCursor;

FETCH NEXT FROM VistaCursor INTO @NombreVista;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @Consulta = 'SELECT * FROM [' + @NombreVista + '];';
    
    PRINT 'Resultados de la vista: ' + @NombreVista;
    EXEC sp_executesql @Consulta; -- Ejecuta la consulta dinámica
    
    FETCH NEXT FROM VistaCursor INTO @NombreVista;
END;

CLOSE VistaCursor;
DEALLOCATE VistaCursor;

