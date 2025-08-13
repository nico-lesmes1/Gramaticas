import pathlib
import re

def validar(linea: str) -> None:
    linea = linea.strip()
    if not linea:
        return
    # ^a(ab)*b$  ==  a (ab)^n b
    if re.fullmatch(r'a(ab)*b', linea):
        print("Acepta")
    else:
        print("No acepta")

archivo = pathlib.Path(__file__).with_name("texto.txt")
with archivo.open() as f:
    for ln in f:
        validar(ln)