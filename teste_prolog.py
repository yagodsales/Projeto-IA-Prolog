from pyswip import Prolog
from pyswip import Functor, Variable, Query, call

prolog = Prolog()
prolog.consult("prolog.pl")

lista = []

q = Query("emitir_nota([(iphone, 2), (macbook, 1), (apple_watch, 3)]).")
    
print(q.nextSolution())