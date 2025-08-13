#!/usr/bin/env python3
# Ej4.py – validador de G₄ = {ab, abb}

import pathlib

def validar(linea: str) -> None:
    linea = linea.strip()
    if not linea:
        return
    if linea in {"ab", "abb"}:
        print("Acepta")
    else:
        print("No acepta")

archivo = pathlib.Path(__file__).with_name("texto.txt")
with archivo.open() as f:
    for ln in f:
        validar(ln)