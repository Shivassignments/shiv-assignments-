# Shiv Assignments — production starter

This is a real full-stack digital-download store starter. It is designed for deployment with Node.js + Supabase + Razorpay.

## What is functional
- Public course catalogue and search
- Server-side course catalogue
- Admin PDF upload, price/course editing foundation and delete
- Private PDF storage
- Razorpay order creation
- Server-side Razorpay signature verification
- Webhook endpoint for captured payments
- One-time-ish, expiring download tokens (15-minute token; signed file URL 5 minutes)
- No public PDF URLs

Supabase private buckets and signed URLs are used so the PDF is not publicly accessible. Supabase documents private buckets and time-limited signed URLs here: https://supabase.com/docs/guides/storage/serving/downloads

## Setup
1. Create a Supabase project.
2. Run `supabase/schema.sql` in Supabase SQL Editor.
3. Create `.env` from `.env.example` and fill secrets.
4. Add `ADMIN_SECRET` to `.env` (a long random secret). For a production deployment, replace this prototype admin header with Supabase Auth + MFA.
5. `npm install`
6. `npm start`
7. Configure Razorpay webhook URL: `https://YOUR-DOMAIN/api/webhook/razorpay` and use the same webhook secret in `RAZORPAY_WEBHOOK_SECRET`.

## Admin
The included admin UI calls `/api/admin/*` and expects `x-admin-secret`. This is intentionally server-side and not stored in the browser. Before public launch, add proper admin authentication (Supabase Auth) rather than sharing the secret.

## Important security
- Never put `SUPABASE_SERVICE_ROLE_KEY`, Razorpay secret, or webhook secret in frontend code.
- Keep the storage bucket private.
- Use HTTPS.
- Add rate limiting, logs, backups, and monitoring before launch.
- Razorpay payment status should be trusted from server-side verification/webhooks, not a browser success message.

## Legal/content
Upload only assignment solutions/PDFs you created or are authorized to distribute. Keep the site clearly independent from IGNOU unless you have formal authorization.
