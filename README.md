# Álbum Panini 2026

> **Estado: Activo** — en uso, con sincronización entre dispositivos por Supabase (v1.1).

Para llevar el álbum de figuritas del Mundial 2026 sin planilla ni papelito: qué tenés, qué te
falta y cuáles te sobran, con selección múltiple para cargar de a muchas.

Es **un solo `index.html`** sin dependencias ni build: se abre directo desde el celular.

## Sincronización

Con login por *magic link* de Supabase, el álbum se sincroniza entre dispositivos. Sin login
funciona igual, guardando todo en el navegador.

La key de Supabase que está en `index.html` es pública por diseño: lo que separa el álbum
de cada cuenta es RLS en la tabla `user_stickers`. `supabase-rls.sql` trae cómo verificarlo
y la política para dejarlo así.

La versión multiusuario de la idea —cruzar repetidas con faltantes de otra gente— está aparte,
en FiguMatch.
