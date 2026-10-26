-- ============================================================
-- Álbum Panini 2026 — que cada cuenta vea y toque solo su álbum.
--
-- La URL y la publishable key de Supabase están en index.html, y eso está
-- bien: son públicas por diseño. Lo que protege los datos es RLS. La app ya
-- filtra por user_id en cada consulta, pero ese filtro lo pone el navegador
-- y cualquiera puede sacarlo: si la tabla no tiene RLS, con la key pública
-- se pueden leer o borrar los álbumes de todos.
--
-- Primero, mirar cómo está (SQL Editor de Supabase):
--
--   select relname, relrowsecurity from pg_class where relname = 'user_stickers';
--   select policyname, roles, cmd, qual, with_check from pg_policies where tablename = 'user_stickers';
--
-- Si relrowsecurity da true y hay una política que compara user_id con
-- auth.uid(), ya está: no hace falta correr nada.
--
-- OJO con FiguMatch: si usa este mismo proyecto de Supabase y lee las
-- figuritas de otras cuentas desde esta tabla, estas políticas se lo cortan.
-- En ese caso FiguMatch necesita su propia política de lectura (o una vista
-- con solo lo que tiene que cruzar) antes de correr esto.
--
-- Es idempotente: se puede correr de nuevo sin romper nada.
-- ============================================================

alter table public.user_stickers enable row level security;

drop policy if exists user_stickers_propias on public.user_stickers;
create policy user_stickers_propias on public.user_stickers
  for all to authenticated
  using (user_id = auth.uid())
  with check (user_id = auth.uid());
