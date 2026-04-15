# E-Commerce (Solidus + Rails)

This project is a Rails 8 + Solidus storefront used to sell digital apps.

## Featured Product Details: Food Track App

The Food Track app details used in this storefront are based on:

- [Food Costs App Details](https://pmnoos.github.io/food-costs/)

Core Food Track capabilities:

- Store management (name, address, logo, spend totals)
- Product tracking (quantity, unit, price, date)
- Spending reports (week/month/year totals, filters, CSV/print)
- Price history (trend indicators, highest/lowest/average by period)
- Recipe manager (ingredients, instructions, nutrition tracking)
- Menu planner (course planning by occasion/date)

## Tech Stack

- Ruby on Rails 8
- Solidus storefront/admin
- PostgreSQL (recommended in this repository)
- Hotwire/Turbo
- Importmap

## Local Setup

1. Install dependencies:
   - `bundle install`
2. Configure database (PostgreSQL) in `config/database.yml`.
3. Create and migrate DB:
   - `ruby .\\bin\\rails db:create db:migrate`
4. Seed data if needed:
   - `ruby .\\bin\\rails db:seed`
5. Start app:
   - `ruby .\\bin\\dev`

Windows server helper (recommended to avoid stale process/port issues):

- Start server with cleanup: `bin\\server.cmd start`
- Stop server and clean PID/port: `bin\\server.cmd stop`
- Check status: `bin\\server.cmd status`

Open the app at [http://localhost:3000](http://localhost:3000).

## Useful Commands

- Run test suite: `ruby .\\bin\\rails spec`
- Run lints (if configured): `ruby .\\bin\\rubocop`
- Open Rails console: `ruby .\\bin\\rails console`

## Deployment

Deployment configuration files are present in:

- `render.yaml`
- `config/deploy.yml`

Adjust environment variables and credentials before deploying.

### Render note

On Render, production now defaults to a simpler single-service setup:

- cache uses `:memory_store`
- jobs use the Rails `:async` adapter
- Action Cable uses the `async` adapter

If you later want to switch production back to the Solid Cache / Solid Queue / Solid Cable stack, set `USE_SOLID_BACKENDS=true` and ensure the extra database schemas are available before boot.

## PayPal Setup

This project already includes `solidus_paypal_commerce_platform`.

To wire your PayPal account:

1. Create a PayPal app in your PayPal developer account.
2. Copy the app credentials.
3. Set environment variables:
   - `PAYPAL_CLIENT_ID`
   - `PAYPAL_CLIENT_SECRET`
   - `PAYPAL_SANDBOX` (`true` for sandbox, `false` for live)
4. Run setup task:
   - `ruby .\\bin\\rails paypal:setup`

The task is idempotent and will create or update the PayPal payment method.

On Render, this task is run automatically in predeploy after migrations.
