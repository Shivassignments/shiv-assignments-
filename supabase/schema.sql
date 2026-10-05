create extension if not exists pgcrypto;
create table if not exists public.products(id uuid primary key default gen_random_uuid(),programme text not null,code text not null unique,title text not null,price numeric(10,2) not null check(price>0),storage_path text not null,active boolean not null default true,created_at timestamptz not null default now());
create table if not exists public.orders(id uuid primary key default gen_random_uuid(),product_id uuid not null references public.products(id),razorpay_order_id text not null unique,razorpay_payment_id text,amount integer not null,status text not null default 'created',created_at timestamptz not null default now());
create table if not exists public.download_tokens(token text primary key,order_id uuid not null references public.orders(id) on delete cascade,expires_at timestamptz not null,created_at timestamptz not null default now());
alter table public.products enable row level security; alter table public.orders enable row level security; alter table public.download_tokens enable row level security;
revoke all on public.products,public.orders,public.download_tokens from anon,authenticated;
grant select on public.products to anon;
drop policy if exists public_active_products on public.products;
create policy public_active_products on public.products for select to anon using(active=true);
-- The server uses the Supabase service key for administrative writes and payment fulfillment. Never expose it in browser code.
insert into storage.buckets(id,name,public) values('assignment-pdfs','assignment-pdfs',false) on conflict(id) do nothing;
