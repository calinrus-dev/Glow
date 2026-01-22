# Contributing to Glow

Gracias por tu interés en contribuir a Glow.

Glow **no es un proyecto open source**, pero sí es un proyecto colaborativo que acepta contribuciones de personas comprometidas con crear una plataforma excepcional.

---

## Antes de contribuir

### Entiende la visión

Lee la documentación completa para comprender:
- Los conceptos fundamentales (Entornos, Canales, Lienzos)
- La filosofía del proyecto
- Los principios de diseño y desarrollo

Glow no es solo código. Es una plataforma con identidad y propósito claros.

### Acepta los términos

Al contribuir a Glow:
- Aceptas que tu código pasa a ser propiedad del proyecto
- Reconoces que Glow es software propietario
- Entiendes que no se trata de un proyecto open source tradicional
- Aceptas trabajar bajo los términos de la licencia propietaria

---

## Tipos de contribuciones aceptadas

### Código

- **Features:** Implementación de funcionalidades según roadmap
- **Bug fixes:** Corrección de errores existentes
- **Refactoring:** Mejoras en arquitectura y código
- **Tests:** Cobertura de tests unitarios e integración
- **Performance:** Optimizaciones de rendimiento

### Diseño y UX

- **UI/UX:** Diseño de interfaces y experiencias
- **Estética:** Propuestas visuales coherentes con la identidad
- **Animaciones:** Transiciones y efectos visuales
- **Iconografía:** Sistema de iconos y elementos visuales

### Documentación

- **Guías técnicas:** Documentación de arquitectura
- **Tutoriales:** Guías de uso y desarrollo
- **API docs:** Documentación de APIs internas
- **Comentarios:** Mejora de comentarios en código

---

## Proceso de contribución

### 1. Comunicación previa

**Antes de trabajar en algo, abre un issue para discutir:**

```markdown
Título: [FEATURE/BUG/REFACTOR] Descripción breve

Descripción:
- ¿Qué problema resuelve?
- ¿Cómo lo resuelve?
- ¿Hay alternativas consideradas?
```

Espera feedback antes de invertir tiempo en desarrollo.

### 2. Fork y desarrollo

```bash
# Fork del repositorio (si tienes acceso)
git clone https://github.com/calinrus-dev/Glow.git
cd glow

# Crear branch feature
git checkout -b feature/nombre-descriptivo

# Desarrollo
# ...

# Commit con conventional commits
git commit -m "feat(entornos): agregar selector de identidad contextual"
```

### 3. Pull Request

**Título:**
```
feat(scope): descripción breve
```

**Descripción:**
```markdown
## ¿Qué hace este PR?
Descripción clara del cambio.

## ¿Cómo se probó?
- [ ] Tests unitarios
- [ ] Tests de integración
- [ ] Pruebas manuales

## Checklist
- [ ] Código sigue las convenciones del proyecto
- [ ] Tests agregados/actualizados
- [ ] Documentación actualizada
- [ ] Sin warnings de análisis
- [ ] Build exitoso
```

---

## Estándares de código

### Dart/Flutter

- **Análisis estático:** `melos run analyze` sin warnings
- **Formato:** `melos run format` antes de commit
- **Lints:** Seguir `analysis_options.yaml` del proyecto
- **TODOs:** Evitar TODOs sin issue asociado

### Arquitectura

- **Clean Architecture:** Respetar separación de capas
- **Dependency Rule:** Dependencias apuntan hacia adentro
- **SOLID:** Aplicar principios SOLID
- **DRY:** No repetir lógica

### Convenciones

```dart
// ✅ Bueno
class EnvironmentRepository {
  Future<Either<Failure, Environment>> getEnvironment(String id);
}

// ❌ Malo
class EnvRepo {
  getEnv(id) {}
}
```

### Commits

Usar [Conventional Commits](https://www.conventionalcommits.org/):

```
feat(scope): agregar nueva funcionalidad
fix(scope): corregir bug
refactor(scope): refactorización
docs(scope): actualizar documentación
test(scope): agregar tests
perf(scope): mejora de performance
style(scope): cambios de estilo
chore(scope): tareas de mantenimiento
```

---

## Testing

### Requerido

- **Unit tests:** Para lógica de negocio
- **Widget tests:** Para widgets reutilizables
- **Integration tests:** Para flujos críticos

### Ejecutar tests

```bash
# Todos los tests
melos run test

# Tests de un paquete
cd packages/glow_domain
flutter test

# Tests con coverage
flutter test --coverage
```

---

## Code Review

Todo código pasa por code review antes de merge:

- **Legibilidad:** ¿Es fácil de entender?
- **Mantenibilidad:** ¿Es fácil de modificar?
- **Performance:** ¿Hay optimizaciones obvias?
- **Tests:** ¿Hay cobertura adecuada?
- **Arquitectura:** ¿Sigue los principios del proyecto?

---

## Comunicación

### Canales

- **Issues:** Bugs, features, discusiones técnicas
- **Pull Requests:** Revisión de código
- **Discussions:** Ideas, propuestas, arquitectura

### Tono

- Profesional y respetuoso
- Constructivo, no destructivo
- Enfocado en el código, no en personas
- Abierto a feedback

---

## Reconocimiento

Las contribuciones significativas serán:

- **Reconocidas públicamente** en el proyecto
- **Consideradas para participación futura** cuando el proyecto madure
- **Parte de acuerdos formales** bajo términos definidos

Glow se concibe como un proyecto serio con proyección real.

---

## Rechazo de contribuciones

Nos reservamos el derecho de rechazar contribuciones que:

- No se alineen con la visión del proyecto
- No cumplan los estándares de calidad
- No sigan el proceso establecido
- Introduzcan complejidad innecesaria
- No estén suficientemente testeadas

---

## Preguntas frecuentes

### ¿Puedo usar este código en mi propio proyecto?

No. Glow es software propietario. Ver [LICENSE](LICENSE).

### ¿Puedo hacer un fork?

Solo con permiso explícito. Los forks no autorizados violan la licencia.

### ¿Recibiré compensación por contribuciones?

Actualmente no hay compensación monetaria. Las contribuciones significativas pueden traducirse en participación futura cuando el proyecto madure.

### ¿Cómo sé si mi contribución será aceptada?

Abre un issue antes de trabajar. Discute la propuesta y espera feedback.

---

## Principios finales

Glow se construye con:

- **Claridad antes que complejidad**
- **Diseño consciente**
- **Arquitectura mantenible**
- **Experiencia coherente**
- **Decisiones pensadas a largo plazo**

Si compartes estos valores, tu contribución será bienvenida.

---

**Gracias por ayudar a construir el futuro de las comunidades digitales.**
