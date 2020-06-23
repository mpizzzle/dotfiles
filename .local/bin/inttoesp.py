import sys

first_thirty=[ "uno", "dos", "tres", "cuatro", "cinco", "seis", "siete", "ocho", "nueve", "diez", "once", "doce", "trece", "catorce", "quince", "dieciséis", "diecisiete", "dieciocho", "diecinueve", "veinte", "veintiuno", "veintidós", "veintitrés", "veinticuatro", "veinticinco", "veintiséis", "veintisiete", "veintiocho", "veintinueve" ]

decs=[ "treinta", "cuarenta", "cincuenta", "sesenta", "setenta", "ochenta", "noventa" ]

hundos=[ "ciento", "doscientos", "trescientos", "cuatrocientos", "quinientos", "seiscientos", "setecientos", "ochocientos", "novecientos" ]

special={ 0 : "cero", 100 : "cien", 100000 : "cien mil" }

i = int(sys.argv[1].replace(',', ''))

if i in special:
  print(special[i])
  exit()

s = ""
limit = 10000000
y = yy = False
m = True

while limit > 1:
  n = int((i % limit) / (limit / 10))

  if n > 0:
    if limit > 1000000 and n == 1:
      s += "un millón "
      m = False
    elif limit > 1000000:
      s += first_thirty[n - 1] + " millones "
      m = False
    elif limit > 100000:
      s += hundos[n - 1] + " "
      m = False
    elif limit > 10000 and n > 2:
      s += decs[n - 3] + " "
      yy = True
      m = False
    elif limit > 10000 and n <= 2:
      limit = limit / 10
      s += first_thirty[(n * 10) + int((i % limit) / (limit / 10)) - 1] + " mil "
      m = False
    elif limit > 1000 and n == 1 and m:
      s += "mil "
    elif limit > 1000:
      if yy:
        s += "y "
      if n == 1:
        s += "un mil "
      else:
        s += first_thirty[n - 1] + " mil "
    elif limit > 100:
      s += hundos[n - 1] + " "
    elif limit > 10 and n > 2:
      s += decs[n - 3] + " "
      y = True
    elif limit > 10 and n <= 2:
      limit = limit / 10
      s += first_thirty[(n * 10) + int((i % limit) / (limit / 10)) - 1]
    elif limit > 1:
      if y:
        s += "y "
      s += first_thirty[n - 1]
  #elif limit == 10000:
      #s += "mil "

  limit = limit / 10

print(s.strip())
