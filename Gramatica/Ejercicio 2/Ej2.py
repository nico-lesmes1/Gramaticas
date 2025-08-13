import sys
import os

def acepta(cadena: str) -> bool:
    """
    L(G) = { a^n b^{n+1} | n >= 0 }
    """
    cadena = cadena.rstrip("\n\r")
    i = 0
    while i < len(cadena) and cadena[i] == 'a':
        i += 1
    j = i
    while j < len(cadena) and cadena[j] == 'b':
        j += 1
    if j != len(cadena):
        return False
    n, m = i, j - i
    return m == n + 1

def main():
    archivo = "texto.txt" if len(sys.argv) < 2 else sys.argv[1]
    if not os.path.isfile(archivo):
        print("No acepta")
        return
    with open(archivo, "r", encoding="utf-8") as f:
        for linea in f:
            linea = linea.rstrip("\n\r")
            if acepta(linea):
                print("Acepta")
            else:
                print("No acepta")

if __name__ == "__main__":
    main()