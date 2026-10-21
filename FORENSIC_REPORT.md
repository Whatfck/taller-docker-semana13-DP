# FORENSIC_REPORT

## Tabla de Identidad

| Evidencia | Comando | Salida |
|---|---|---|
| Hash de la imagen | `docker inspect --format='{{.Id}}' eco-air-backend:1.0.0` | `sha256:0a8aa86097491ef640eeb4dc9cc2c83c838fb768d99c634b1b35a35a50f73bdc` |
| Variable de entorno inyectada | `docker exec eco_air_active env \| grep OPERATOR_ID` | `OPERATOR_ID=1234567890` |

### Información de consumo

Comando: `docker stats --no-stream eco_air_active`

```
CONTAINER ID   NAME             CPU %     MEM USAGE / LIMIT     MEM %     NET I/O         BLOCK I/O         PIDS
88c2398aac55   eco_air_active   0.20%     224.7MiB / 7.748GiB   2.83%     1.32kB / 264B   95.6MB / 73.7kB   43
```
