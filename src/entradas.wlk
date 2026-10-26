import productora.*

class Entrada {
  const property banda
  const property fecha
  const precioBase = 1000

  method precioTotal() = precioBase + productora.impuesto()

  method esDelAñoPasado() = fecha.year() == new Date().year() - 1
}