
import pathlib
import re

def forma_correcta(as_seq: str, bs_seq: str) -> bool:
    return len(as_seq) + 1 == len(bs_seq)

def validar(linea: str) -> None:
    linea = linea.strip()
    if not linea:
        return
    m = re.fullmatch(r'(a+)(b+)', linea)
    if not m:
        print("No acepta")
    else:
        as_seq, bs_seq = m.groups()
        print("Acepta" if forma_correcta(as_seq, bs_seq) else "No acepta")

archivo = pathlib.Path(__file__).with_name("texto.txt")
with archivo.open() as f:
    for ln in f:
        validar(ln)