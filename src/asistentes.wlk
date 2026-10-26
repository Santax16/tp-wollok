import abonos.*
import entradas.*

class SaldoInsuficienteException inherits DomainException {}

class Asistente {
  var property tipoDeAbono
  const property historialDeEntradas = []
  var dineroDisponible

  method montoAPagar(entrada) = tipoDeAbono.precioFinal(entrada.precioTotal())

  method entradasDelAñoPasado() = historialDeEntradas.filter({ e => e.esDelAñoPasado() })

  method bono() = tipoDeAbono.bono()

  method bandasQueVio() = historialDeEntradas.map({ e => e.banda().nombre() }).asSet()

  method puedeComprar() {
    if (dineroDisponible <= 0) {
      throw new SaldoInsuficienteException(message = "El asistente debe tener saldo positivo para comprar una entrada.")
    }
  }

  method comprarEntrada(entrada) {
    self.puedeComprar()
    dineroDisponible -= self.montoAPagar(entrada)
    historialDeEntradas.add(entrada)
  }
}