import pathlib

def es_capicua(s: str) -> bool:
    return s == s[::-1]

def validar(linea: str) -> None:
    linea = linea.strip()
    if not linea:
        return
    if set(linea) - {'0', '1'}:
        print("No acepta")
    else:
        print("Acepta" if es_capicua(linea) else "No acepta")

archivo = pathlib.Path(__file__).with_name("texto.txt")
with archivo.open() as f:
    for ln in f:
        validar(ln)