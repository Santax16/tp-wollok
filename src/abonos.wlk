object fan {
  method precioFinal(valorEntrada) = valorEntrada 
  method bono() {}
}

class Vip {
  var descuento

  method precioFinal(valorEntrada) = valorEntrada * (1 - descuento / 100)

  method bono() {
    descuento += 1
  }
}