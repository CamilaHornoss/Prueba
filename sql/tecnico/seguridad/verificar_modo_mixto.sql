/*
Verificación del modo de autenticación de la instancia SQL Server.
SERVERPROPERTY('IsIntegratedSecurityOnly') devuelve:
- 1: solo autenticación de Windows.
- 0: modo mixto (Windows + SQL Server).
*/

SELECT
    SERVERPROPERTY('ServerName') AS servidor,
    SERVERPROPERTY('Edition') AS edicion,
    SERVERPROPERTY('ProductVersion') AS version,
    SERVERPROPERTY('IsIntegratedSecurityOnly') AS solo_seguridad_integrada,
    CASE SERVERPROPERTY('IsIntegratedSecurityOnly')
        WHEN 0 THEN 'MODO MIXTO ACTIVO: Windows + SQL Server'
        WHEN 1 THEN 'SOLO WINDOWS: habilitar modo mixto en propiedades del servidor y reiniciar el servicio'
        ELSE 'No se pudo determinar el modo de autenticacion'
    END AS diagnostico;
GO

/*
Si el resultado indica SOLO WINDOWS:
1. En SSMS: clic derecho sobre el servidor > Properties.
2. Security > Server authentication.
3. Seleccionar SQL Server and Windows Authentication mode.
4. Aceptar y reiniciar el servicio de SQL Server.
5. Volver a ejecutar este script y conservar el resultado como evidencia.
*/
