class   Entrada{
  const property nombreBanda
  const property fecha  
  var impuesto   
  const precioBase = 1000
  method precioTotal() = precioBase + impuesto
  method esDelAñoPasado() {
    return fecha.year() == new Date().year() - 1
  }


   }

class Asistente{
    var property tipoDeAbono
    var property historialDeEntradas = []
    var dineroDisponible 
    method agregarEntradaHistorial(entrada) = historialDeEntradas.add(entrada)
    method montoAPagar(valorEntrada) = tipoDeAbono.precioFinal(valorEntrada)
    method entradasDelAñoPasado() = historialDeEntradas.filter({e => e.esDelAñoPasado()})
     
    method bandasQueVio() {
        return historialDeEntradas.map({e => e.nombreBanda()})
    }

   method puedeComprarEntrada(entrada,valorEntrada) {
    if(dineroDisponible > 0)
    {
        dineroDisponible =-  self.montoAPagar(valorEntrada) 
        self.agregarEntradaHistorial(entrada)
    }
   }else{
 // aca va el error (manejo de errores)
}


}  

object fan{
    var descuento = 0
  method precioFinal(valorEntrada) = valorEntrada 

  method bono(){}
 
}
class vip{
 var descuento
 method precioFinal(valorEntrada) = valorEntrada * (1 - descuento / 100 )
 

 method bono(){
    descuento += 1
 }

}

class Banda{
   const nombre 
   method canon() = 1000000
   method gastoExtra()
   method popularidad()
   method presupuesto() = self.canon() + self.gastoExtra()

}

class Rock inherits Banda{
    const solosDeGuitarra
    override method gastoExtra() =  10000
    override method popularidad() = solosDeGuitarra * 100
    

} 

class Trap inherits Banda{
   const tieneHielo
   override method gastoExtra() = 0
   override method popularidad(){
    if(tieneHielo){
    return 1000
   }else
   return 0 
   }
   override method canon() = self.popularidad() * super()
   
}

class Indie inherits Banda{
    const instrumentos
    override method popularidad() = 3.14 * nombre.length()   
    override method gastoExtra() = 500 * instrumentos
}

object productora{
    var bandas = []
    var asistentes = []
    method entradasVendidas() = asistentes.flatMap({a => a.historialDeEntradas()})
    method cantidadDeEntradasVendidas() = self.cantidadDeEntradasVendidas().size()
    method cantidadDeEntradasVendidasPorBanda(banda) = self.entradasVendidas().count({e=> e.banda() == banda})
    method bandaMasPopular() = bandas.max({b => self.cantidadDeEntradasVendidasPorBanda(b)})
    method gananciaTotal() = self.entradasVendidas().sum({e => e.precioTotal() }) - bandas.sum({b => b.presupuesto() })
    method bonificarVips() = asistentes.forEach({a => a.bonificar()})
}



Las decisiones importantes que considero son las siguientes



 


