from pyswip import Prolog
import os

prolog = Prolog()
prolog.consult("prolog.pl")

for valor in prolog.query("emitir_nota([(iphone, 2), (macbook, 1), (apple_watch, 3)])."):
    print("TESTE")