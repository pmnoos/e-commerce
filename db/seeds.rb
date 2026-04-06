# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Spree::Core::Engine.load_seed
Spree::Auth::Engine.load_seed

store_name = ENV.fetch("STORE_NAME", "Digital Apps Store")
if (default_store = Spree::Store.default || Spree::Store.first)
  default_store.update!(name: store_name)
end

digital_category = Spree::ShippingCategory.find_or_create_by!(name: "Digital")
download_url_property = Spree::Property.find_or_create_by!(name: "Download URL", presentation: "Download URL")

[
  {
    slug: "my-diary-app",
    name: "My Diary App",
    description: <<~DESC,
      <h2>Your Private Space to Think, Reflect and Grow</h2>

      <p>Diary App is a calm, thoughtfully designed journalling tool for people who want more than a notes app. It gives you one private place to capture thoughts, moods, goals, gratitude, and everyday memories without clutter, ads, or distractions. If you want a writing habit that actually lasts, this app is built to make daily reflection feel easy to return to.</p>

      <h3>Key Features</h3>
      <ul>
        <li><strong>Daily Entry Prompts</strong> — Start writing in seconds with optional prompts that reduce blank-page friction and help you stay consistent.</li>
        <li><strong>Mood Tracker</strong> — Tag each entry with a mood so you can notice emotional patterns, triggers, and positive routines over time.</li>
        <li><strong>Date &amp; Timeline View</strong> — Revisit your life through a clean archive that makes old entries easy to browse by day, week, or month.</li>
        <li><strong>Tags &amp; Categories</strong> — Organise thoughts around themes like work, family, gratitude, travel, ideas, or personal growth.</li>
        <li><strong>Rich Text &amp; Photos</strong> — Add formatting and image memories so important moments feel complete, not reduced to plain text.</li>
        <li><strong>Streak &amp; Habit Tracking</strong> — Build momentum with gentle consistency tools that encourage reflection without turning it into pressure.</li>
        <li><strong>Private by Design</strong> — Keep your personal writing in a space that feels owned by you rather than another social platform.</li>
        <li><strong>Export &amp; Backup</strong> — Download your journal whenever you want so your memories stay portable and under your control.</li>
      </ul>

      <h3>Who Is It For?</h3>
      <p>Diary App is for anyone who wants to slow down and reflect with more intention: students navigating change, professionals clearing their heads after busy days, parents preserving family moments, or anyone building a mindfulness, gratitude, or self-awareness practice.</p>

      <h3>Why Diary App?</h3>
      <p>For a modest one-time price, Diary App gives you a focused personal writing space you can keep using for years. No social feed. No likes. No noise. Just a clean place to think clearly, remember more, and build a personal archive that becomes more valuable the longer you use it.</p>

      <p><em>Start your first entry today — the best time to begin is always now.</em></p>
    DESC
    price: 19.0,
    download_url: "https://pmnoos.github.io/diary_app-landing/",
    meta_title: "Diary App | Private Journal, Mood Tracking and Daily Reflection",
    meta_keywords: "diary app, private journal, mood tracker, gratitude journal, encrypted diary, daily writing",
    meta_description: "A private diary app for daily reflection, mood tracking, prompts, photos, and reminders. One-time purchase with no subscription."
  },
  {
    slug: "autobiography-app",
    name: "Autobiography App",
    description: <<~DESC,
      <h2>Tell Your Life Story — On Your Terms</h2>

      <p>Autobiography App helps you turn decades of memories into a clear, structured life story without the overwhelm of starting from a blank page. Whether you want to write a memoir for family, preserve your experiences for future generations, or finally organize the story you have been meaning to tell, this app gives you a guided framework that keeps you moving.</p>

      <h3>Key Features</h3>
      <ul>
        <li><strong>Life Stage Timeline</strong> — Organise memories across childhood, education, work, relationships, milestones, and legacy in a structure that makes sense.</li>
        <li><strong>Guided Writing Prompts</strong> — Use carefully designed prompts to unlock details and stories you might otherwise leave out.</li>
        <li><strong>Chapter Builder</strong> — Build, reorder, and refine chapters so your life story reads like a narrative rather than a pile of notes.</li>
        <li><strong>Photo Integration</strong> — Add images to chapters and events so important memories carry visual context as well as words.</li>
        <li><strong>Privacy Controls</strong> — Keep sections private, share selected chapters with family, or prepare material for publication on your terms.</li>
        <li><strong>Export & Publish</strong> — Produce a polished PDF, EPUB, or print-ready document you can keep, share, or publish.</li>
        <li><strong>Auto-Save &amp; Backup</strong> — Write with confidence knowing your progress is preserved as you go.</li>
        <li><strong>Collaboration Mode</strong> — Bring in a relative, editor, or writing coach when another voice can help fill gaps or sharpen the story.</li>
      </ul>

      <h3>Who Is It For?</h3>
      <p>Autobiography App is ideal for retirees documenting a lifetime of experience, parents leaving a legacy for their children, professionals shaping a career memoir, or writers who want support turning lived experience into a finished manuscript.</p>

      <h3>Why Choose Autobiography App?</h3>
      <p>At $29, this is positioned as a premium writing tool because it solves a bigger problem than simple note-taking: it helps you organize a life story into something meaningful and shareable. Instead of staring at a blank document, you get structure, momentum, and a clearer path to finishing what matters.</p>

      <p><em>Start your first chapter today. Your story deserves to be told.</em></p>
    DESC
    price: 29.0,
    download_url: "https://www.autobiography.live",
    meta_title: "Autobiography App | Guided Memoir Writing and Life Story Builder",
    meta_keywords: "autobiography app, memoir writing, life story, guided prompts, chapter builder, family history",
    meta_description: "Write your memoir with guided prompts, chapter planning, photo support, and export tools. A premium one-time purchase for preserving your life story."
  },
  {
    slug: "term-deposit-tracker",
    name: "Term Deposit Tracker",
    description: <<~DESC,
      <h2>Take Control of Your Term Deposits — All in One Place</h2>

      <p>Term Deposit Tracker is a practical finance tool for people who want real visibility over their cash savings. Instead of juggling spreadsheets, paper notes, and maturity reminders in your head, you get one place to track balances, rates, maturity dates, and reinvestment decisions with clarity.</p>

      <h3>Key Features</h3>
      <ul>
        <li><strong>Centralised Dashboard</strong> — See every deposit, institution, rate, term, and projected return in one view.</li>
        <li><strong>Maturity Alerts</strong> — Get ahead of rollover deadlines before money sits at the wrong rate by default.</li>
        <li><strong>Interest Calculator</strong> — Compare scenarios quickly so you can make decisions with numbers instead of guesswork.</li>
        <li><strong>Rate Comparison Tool</strong> — Spot underperforming deposits and identify where better returns may be available.</li>
        <li><strong>Reinvestment Planner</strong> — Model rollover, withdrawal, top-up, or split strategies before committing funds.</li>
        <li><strong>Portfolio Summary</strong> — Understand your total savings position, weighted return, and expected cash flow at a glance.</li>
        <li><strong>Transaction History</strong> — Maintain a clean record of openings, closures, rollovers, and adjustments.</li>
        <li><strong>Secure &amp; Private</strong> — Track savings without handing over bank logins or relying on disconnected spreadsheets.</li>
      </ul>

      <h3>Who Is It For?</h3>
      <p>Term Deposit Tracker is built for self-directed savers, retirees managing income streams, investors laddering deposits across banks, and business owners who want tighter control over reserve cash.</p>

      <h3>Why Term Deposit Tracker?</h3>
      <p>At $24, this app earns its place by helping prevent costly inattention. One missed maturity date or poor rollover choice can cost more than the price of the app. Term Deposit Tracker gives you a clearer process, better visibility, and more confidence in how your savings are managed.</p>

      <p><em>Start tracking smarter today — your savings will thank you.</em></p>
    DESC
    price: 24.0,
    download_url: "https://pmnoos.github.io/term-tracker/",
    meta_title: "Term Deposit Tracker | Maturity Alerts, Rates and Reinvestment Planning",
    meta_keywords: "term deposit tracker, maturity alerts, rate comparison, savings tracker, reinvestment planner, fixed deposit",
    meta_description: "Track term deposits, compare rates, monitor maturity dates, and plan reinvestment decisions with a one-time purchase savings tool."
  },
  {
    slug: "grocery-expense-tracker",
    name: "Grocery Expense Tracker",
    description: <<~DESC,
      <h2>Keep Grocery Costs Under Control Without Guesswork</h2>

      <p>Grocery Expense Tracker helps households understand where grocery money actually goes. Instead of relying on rough guesses, receipts stuffed in drawers, or a spreadsheet you stop updating after two weeks, you get a simple system for tracking trips, comparing stores, and seeing how food costs change over time.</p>

      <h3>Key Features</h3>
      <ul>
        <li><strong>Trip-by-Trip Logging</strong> — Save every shop with the store, date, total, and notes so spending stays easy to review.</li>
        <li><strong>Category Breakdown</strong> — See what goes to produce, pantry items, snacks, household supplies, frozen foods, and more.</li>
        <li><strong>Budget Targets</strong> — Compare weekly or monthly spending against a target you can actually track.</li>
        <li><strong>Repeat Item Tracking</strong> — Notice price creep on the staple items you buy most often.</li>
        <li><strong>Shopping List Support</strong> — Keep common purchases organized so routine trips stay focused.</li>
        <li><strong>Store Comparison</strong> — Identify which stores genuinely fit your budget instead of relying on assumptions.</li>
        <li><strong>Simple Reports</strong> — Review trends quickly and make better buying decisions without spreadsheet overhead.</li>
        <li><strong>Private by Design</strong> — Keep your household spending information in a straightforward personal tool.</li>
      </ul>

      <h3>Who Is It For?</h3>
      <p>Grocery Expense Tracker is built for families, couples, roommates, and solo shoppers who want more control over rising food costs without turning budgeting into a chore.</p>

      <h3>Why Grocery Expense Tracker?</h3>
      <p>At $21, this is an easy-value household tool: a small one-time cost for better spending visibility on something you deal with every week. Grocery Expense Tracker turns everyday purchases into useful information so you can spend more intentionally, reduce waste, and stay closer to budget.</p>

      <p><em>Track the next shop with more confidence and less guesswork.</em></p>
    DESC
    price: 21.0,
    meta_title: "Grocery Expense Tracker | Grocery Budget, Prices and Spending History",
    meta_keywords: "grocery expense tracker, food budget app, grocery spending tracker, shopping budget, household expense tracker",
    meta_description: "Track grocery trips, compare store totals, monitor prices, and stay on budget with a practical one-time purchase household budgeting tool."
  }
].each do |attrs|
  product = Spree::Product.find_or_initialize_by(slug: attrs[:slug])
  product.name = attrs[:name]
  product.description = attrs[:description]
  product.available_on ||= Time.current
  product.shipping_category ||= digital_category
  product.price = attrs[:price]
  product.meta_title       = attrs[:meta_title]       if attrs[:meta_title]
  product.meta_keywords    = attrs[:meta_keywords]    if attrs[:meta_keywords]
  product.meta_description = attrs[:meta_description] if attrs[:meta_description]
  product.save!

  if attrs[:download_url].present?
    product_property = product.product_properties.find_or_initialize_by(property: download_url_property)
    product_property.value = attrs[:download_url]
    product_property.save!
  end
end

# Backward-compatible rename for existing environments seeded with my_diary_app.
Spree::Product.where(name: "my_diary_app").update_all(name: "diary_app")
