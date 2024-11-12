class Persona {
  var recursos = 20
  var edad

  method edad() = edad
  
  method recursos() = recursos

  method cumplirAnios() {
    edad += 1
  }

  method ganarMonedas(cantidad) {
    recursos += cantidad
  }

  method gastarMonedas(cantidad) {
    recursos -= cantidad
  }

  method esDestacada() = edad.between(18, 65) || recursos > 30

  method trabajar(nombrePlaneta, tiempo){}
}

class Productor inherits Persona {
  const property planeta 
  const property tecnicas = ["cultivo"]

  override method recursos() = recursos * self.cantTecnicasConocidas()

  method cantTecnicasConocidas() = tecnicas.size()

  method aprenderTecnica(unaTecnica) {
    tecnicas.add(unaTecnica)
  }

  override method esDestacada() = super() || self.conoceMasDe(5)

  method conoceMasDe(cantTecnicas) = self.cantTecnicasConocidas() > cantTecnicas

  method conoceTecnica(nombreTecnica) = tecnicas.contains(nombreTecnica)

  method realizar(nombreTecnica, cantTiempo) {
    if (self.conoceTecnica(nombreTecnica)){
      recursos += 3 * cantTiempo
    }
    else {
      recursos -= 1
    }
  }

  override method trabajar(nombrePlaneta, tiempo) {
    if (planeta == nombrePlaneta)
      self.realizar(tecnicas.last(), tiempo)
  }
}

class Constructor inherits Persona {
  var region

  const property contruccionesRealizadas

  method contruccionesRealizadas() = contruccionesRealizadas

  method cantConstrucciones() = contruccionesRealizadas.size()

  override method recursos() = recursos + (10 * self.cantConstrucciones())

  override method esDestacada() = self.cantConstrucciones() > 5


  override method trabajar(nombrePlaneta,tiempo) {
    if (region == "montaña"){
      nombrePlaneta.agregarConstrucciones(new Muralla(longitud = tiempo / 2))
    }
    else if (region == "costa"){
      nombrePlaneta.agregarConstrucciones(new Museo(superficieCubierta = tiempo, indiceImportancia = 1))
    }
    else {
      if (not self.esDestacada()) {
        nombrePlaneta.agregarConstrucciones(new Muralla(longitud = tiempo / 2))
      }
      else {
        nombrePlaneta.agregarConstrucciones(new Museo(superficieCubierta = tiempo, indiceImportancia = 3))
      }
    }
  }
}

class Muralla{
  const longitud
  method valor() = longitud * 10
}

class Museo {
  const superficieCubierta
  const indiceImportancia // de 1 a 5 solamente

  method valor() = superficieCubierta * indiceImportancia
}

class Planeta {
  const property habitantes = #{}
  const property construcciones = #{}

  method agregarHabitantes(unaPersona) {
    habitantes.add(unaPersona)
  }
  method agregarConstrucciones(unaConstruccion) {
    construcciones.add(unaConstruccion)
  }

  method delegacionDiplomatica() = self.habitantesDestacados() + #{self.personaConMasRecursos()}

  method habitantesDestacados() = habitantes.filter({ h => h.esDestacada() })

  method personaConMasRecursos() = habitantes.max({ p => p.recursos() })

  method esValioso() = self.valorTotalConstrucciones() > 100

  method valorTotalConstrucciones() = construcciones.sum({ c => c.valor() })

}
