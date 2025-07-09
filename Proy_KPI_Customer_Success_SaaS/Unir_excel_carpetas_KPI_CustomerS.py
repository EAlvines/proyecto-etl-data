import pandas as pd
import os   #interactua con el sistema operativo

ruta = r"C:\Users\user\OneDrive\Desktop\Practica\PROYECTOS\Proy_Customer_Success_BUK"

meses = ["enero", "febrero", "marzo", "abril", "mayo", "junio"]

archivos = [
    "clientes.xlsx",
    "tickets_soporte.xlsx",
    "nps_respuestas.xlsx",
    "onboarding_estado.xlsx",
    "sesiones_sistema.xlsx",
    "cancelaciones.xlsx"
]

#carpeta de salida
salida = os.path.join(ruta, "Unificados")
os.makedirs(salida, exist_ok=True) #os.makedirs crea un nuevo directorio

#procesar cada archivo por tipo. 
for archivo in archivos:
    dfs = []
    for mes in meses:
        path = os.path.join(ruta, mes, archivo)
        if os.path.exists(path):   #os.path.exist verifica si un archivo existe
            df = pd.read_excel(path)
            df["mes"] = mes  #para agregar una columana del mes que viene el registro
            dfs.append(df)
        else:
            print(f"no se encontró: {path}")
    if dfs:
        df_total = pd.concat(dfs, ignore_index=True)
        if archivos == "clientes.xlsx":
            if "fecha_ingreso" in df_total.columns:
                df_total = df_total.sort_values("fecha_ingreso")
            df_total = df_total.drop_duplicates(subset="cliente_id", keep="first")
        
        #Guardar en excel
        nombre_salida = archivo.replace(".xlsx", "_total.xlsx")
        df_total.to_excel(os.path.join(salida, nombre_salida), index=False)
        print(f"archivo generado: {nombre_salida}")
    else:
        print(f"no se encontro ningun archivo: {archivo}")

