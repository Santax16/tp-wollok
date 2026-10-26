class SaldoInsuficienteException inherits DomainException {}

class   Entrada{
  const property banda
  const property fecha    
  const precioBase = 1000
  method precioTotal() = precioBase + productora.impuesto()
  method esDelAñoPasado() {
    return fecha.year() == new Date().year() - 1
  }


   }

class Asistente{
    var property tipoDeAbono
    var property historialDeEntradas = []
    var dineroDisponible 
    method montoAPagar(entrada) = tipoDeAbono.precioFinal(entrada.precioTotal())
    method entradasDelAñoPasado() = historialDeEntradas.filter({e => e.esDelAñoPasado()})
    method bono() = tipoDeAbono.bono()
     
    method bandasQueVio() {
        return historialDeEntradas.map({e => e.banda().nombre() }).asSet()
    }
   
  
  method puedeComprar() {
        if (dineroDisponible <= 0) {
            throw new SaldoInsuficienteException(message = "El asistente debe tener saldo positivo para comprar una entrada.")
        }
    }
method comprarEntrada(entrada){
self.puedeComprar()
dineroDisponible -= self.montoAPagar(entrada)
historialDeEntradas.add(entrada)
}


}  

object fan{
  method precioFinal(valorEntrada) = valorEntrada 

  method bono(){}
 
}
class Vip{
 var descuento
 method precioFinal(valorEntrada) = valorEntrada * (1 - descuento / 100 )
 

 method bono(){
    descuento += 1
 }

}

class Banda{
   const nombre
   method nombre() = nombre
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
    var property impuesto = 0
    var bandas = []
    var asistentes = []
    method entradasVendidas() = asistentes.flatMap({a => a.historialDeEntradas()})
    method cantidadDeEntradasVendidas() = self.entradasVendidas().size()
    method cantidadDeEntradasVendidasPorBanda(banda) = self.entradasVendidas().count({e=> e.banda() == banda})
    method bandaMasPopular() = bandas.max({b => self.cantidadDeEntradasVendidasPorBanda(b)})
    method gananciaTotal() = self.entradasVendidas().sum({e => e.precioTotal() }) - bandas.sum({b => b.presupuesto() })
    method bonificarVips() = asistentes.forEach({a => a.bono()})
}



Las decisiones importantes que considero son las siguientes
1. El hecho de usar composicion en vez de herencia para los tipos de abono:
me parecio una mejor deicision debido a que en vez de dejarlo como 2 subclases estaticas con var tipoDeAbono podia manejar facilmente las bonificaciones
2. El uso de fan como un objeto y de vip como una clase:
como el primero no posee estado y es igual para cualquier asistente preferi utilizar un objeto, como vip si tenia un estado propio que era el descuento me decante por la clase
3. el manejo de errores con excepciones de dominio
al principio quise meterlo en un else despues de si se cumplia el caso pero despues me di cuenta que era mejor manejarlo primero antes de que si se cumpliera el caso use 
SaldoInsuficienteException por si la condicion no se cumplia y corto la ejecucion 
4. impuesto en productora 
en vez de ponerlo en la entrada lo pase a la productora y use productora.impuesto() para evitar duplicados y que la entrada le pregunta a la productora por el impuesto

Justificacion de 5 conceptos vistos en la materia
1. Polimorfismo:
Donde se uso: En el calculo de precio y bonificacion de fan y vip, calculo de presupuesto y popularidad en las bandas rock trap y indie
Justificacion: dos o mas objetos son polimorficos con un 3ro cuando entienden el mismo conjunto de mensajes y no le importa la clase o objeto que tiene enfrente le importa el mensaje 
2. Encapsulamiento y delegacion:
Donde se uso: en Asistente.montoAPagar(entrada) delegando en tipoDeAbono, y en Asistente.entradasDelAñoPasado() delegando en Entrada.esDelAñoPasado()
Justificacion: Los objetos ocultan su estado interno y exponen sus metodos. El asistente en vez de calcular por si mismo la antiguedad se lo pregunta a la entrada misma que tan antigua es.

3. Herencia y Reutilizacion de Codigo:
Donde se uso: En la jerarquia de Banda (Rock, Trap y Indie) y en SaldoInsuficienteException inherits Domain Exception 
Justificacion: Permite abstraer comportamiento y atributos comunes en una superclase abstracta( ej presupuesto()) evitando que se duplique el codigo y haciendo que metodos como gastoExtra() y popularidad() tengan que usar override

4. Redefinicion de metodos(override) y super():
Donde se uso: en Trap.canon() al hacer self.popularidad() * super()
Justificacion : Permite que una subclase cambie el comportamiento normal que se definio en la superclase pero reutilizando el calculo de esta por medio de super()
5. Manejo de Colecciones y Funciones de Orden Superior(Bloques):
Donde se uso: en los reportes de productora (flatMap, count, max, sum) y en las consultas de (filter, map , asSet)
Justificacion: en lugar de usar bucles imperativos manuales con variables acumuladoras aprovecho el pasaje de comportamiento por  bloque a mensajes declarativos de alto nivel.





 


