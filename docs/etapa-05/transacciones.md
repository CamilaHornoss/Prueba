# Manejo de transacciones

La prueba registra una venta, agrega su detalle y actualiza el stock dentro de una única transacción con `TRY/CATCH`. Si cualquier paso falla, se ejecuta `ROLLBACK` y no queda información parcial.

Se incluyen dos escenarios: uno exitoso y otro con error intencional por producto inexistente. El segundo permite demostrar atomicidad y consistencia.
