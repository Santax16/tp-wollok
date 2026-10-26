import bandas.*
import asistentes.*
import entradas.*

object productora {
  var property impuesto = 0
  const property bandas = []
  const property asistentes = []

  method entradasVendidas() = asistentes.flatMap({ a => a.historialDeEntradas() })

  method cantidadDeEntradasVendidas() = self.entradasVendidas().size()

  method cantidadDeEntradasVendidasPorBanda(banda) = self.entradasVendidas().count({ e => e.banda() == banda })

  method bandaMasPopular() = bandas.max({ b => self.cantidadDeEntradasVendidasPorBanda(b) })

  method gananciaTotal() = self.entradasVendidas().sum({ e => e.precioTotal() }) - bandas.sum({ b => b.presupuesto() })

  method bonificarVips() {
    asistentes.forEach({ a => a.bono() })
  }
}