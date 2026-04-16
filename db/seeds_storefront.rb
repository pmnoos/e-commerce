store_name = ENV.fetch("STORE_NAME", "Digital Apps Store")
if (default_store = Spree::Store.default || Spree::Store.first)
  default_store.update!(name: store_name)
end

digital_category = Spree::ShippingCategory.find_or_create_by!(name: "Digital")
download_url_property = Spree::Property.find_or_create_by!(name: "Download URL", presentation: "Download URL")

[
  {
    slug: "my-diary-app",
    name: "Diary App",
    description: <<~DESC,
      <h2>Your Private Space to Write and Reflect (Django Edition)</h2>

      <p>Diary App is now delivered as a Django application focused on daily writing, reminders, and simple personal organization. It gives you one private place to capture thoughts, moods, goals, gratitude, and everyday memories with a clean interface designed for consistency.</p>

      <h3>Key Features</h3>
      <ul>
        <li><strong>Entry Management</strong> - Create, edit, archive, and organize diary entries with a focused writing flow.</li>
        <li><strong>Image Uploads</strong> - Attach photos to entries so key memories keep their full context.</li>
        <li><strong>User Accounts</strong> - Sign up, sign in, and manage your personal diary space securely.</li>
        <li><strong>Reminders</strong> - Use built-in reminder support to stay consistent with your writing routine.</li>
        <li><strong>Subscription Features</strong> - Includes subscription components and Stripe-ready settings.</li>
        <li><strong>PWA Support</strong> - Manifest and service worker assets are included for installable app behavior.</li>
        <li><strong>Portable Setup</strong> - Run with SQLite locally or PostgreSQL in production via environment configuration.</li>
        <li><strong>Open Source Delivery</strong> - Receive direct access to the Django codebase for your own deployment.</li>
      </ul>

      <h3>Who Is It For?</h3>
      <p>Diary App is for people who want a practical journalling system they can own and run themselves: students, professionals, creators, and families who value private writing and structured reflection.</p>

      <h3>Why Diary App?</h3>
      <p>For a modest one-time price, you get the Django-based diary app source and can host it on your own infrastructure. No noisy feed and no lock-in, just a focused writing experience you control.</p>

      <p><em>Start your first entry today - the best time to begin is always now.</em></p>
    DESC
    price: 19.0,
    download_url: "https://github.com/pmnoos/diary_app",
    meta_title: "Diary App (Django) | Private Journal, Reminders and Image Entries",
    meta_keywords: "django diary app, private journal, reminders, image diary, pwa diary, daily writing",
    meta_description: "A Django diary app with entries, reminders, image uploads, authentication, and PWA support. One-time purchase with source access."
  },
  {
    slug: "autobiography-app",
    name: "Autobiography App",
    description: <<~DESC,
      <h2>Tell Your Life Story - On Your Terms</h2>

      <p>Autobiography App helps you turn decades of memories into a clear, structured life story without the overwhelm of starting from a blank page. Whether you want to write a memoir for family, preserve your experiences for future generations, or finally organize the story you have been meaning to tell, this app gives you a guided framework that keeps you moving.</p>

      <h3>Key Features</h3>
      <ul>
        <li><strong>Life Stage Timeline</strong> - Organise memories across childhood, education, work, relationships, milestones, and legacy in a structure that makes sense.</li>
        <li><strong>Guided Writing Prompts</strong> - Use carefully designed prompts to unlock details and stories you might otherwise leave out.</li>
        <li><strong>Chapter Builder</strong> - Build, reorder, and refine chapters so your life story reads like a narrative rather than a pile of notes.</li>
        <li><strong>Photo Integration</strong> - Add images to chapters and events so important memories carry visual context as well as words.</li>
        <li><strong>Privacy Controls</strong> - Keep sections private, share selected chapters with family, or prepare material for publication on your terms.</li>
        <li><strong>Export &amp; Publish</strong> - Produce a polished PDF, EPUB, or print-ready document you can keep, share, or publish.</li>
        <li><strong>Auto-Save &amp; Backup</strong> - Write with confidence knowing your progress is preserved as you go.</li>
        <li><strong>Collaboration Mode</strong> - Bring in a relative, editor, or writing coach when another voice can help fill gaps or sharpen the story.</li>
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
      <h2>Stop Losing Track of Maturity Dates, Rates, and Rollover Decisions</h2>

      <p>Term Deposit Tracker gives you one practical place to manage your term deposits before small oversights turn into expensive mistakes. Instead of relying on memory, scattered spreadsheets, or bank emails you might miss, you can see every deposit, rate, maturity date, and reinvestment decision in one focused dashboard.</p>

      <p>If you manage multiple deposits across different institutions, this app helps you stay ahead of maturity dates, compare returns properly, and make rollover decisions with more confidence and less guesswork.</p>

      <h3>What You Can Do</h3>
      <ul>
        <li><strong>Track Every Deposit Clearly</strong> - Keep balances, institutions, rates, terms, and maturity dates together in one view.</li>
        <li><strong>Stay Ahead of Maturity Dates</strong> - Reduce the risk of deposits rolling over at the wrong rate because you noticed too late.</li>
        <li><strong>Compare Rates Properly</strong> - See which deposits are performing well and where your money may be underperforming.</li>
        <li><strong>Model Reinvestment Choices</strong> - Review rollover, withdrawal, top-up, or split scenarios before you commit.</li>
        <li><strong>See Portfolio-Level Impact</strong> - Understand total savings position, expected returns, and upcoming cash-flow events.</li>
        <li><strong>Keep a Clean Savings Record</strong> - Maintain a usable history of openings, closures, changes, and reinvestment decisions.</li>
        <li><strong>Avoid Spreadsheet Drift</strong> - Replace scattered notes and aging spreadsheets with a more deliberate tracking workflow.</li>
        <li><strong>Keep It Private</strong> - Manage savings without sharing bank logins or depending on generic budgeting software.</li>
      </ul>

      <h3>Who Is It For?</h3>
      <p>Term Deposit Tracker is built for self-directed savers, retirees managing income-producing cash, investors laddering deposits across institutions, and business owners who want tighter control over reserve funds.</p>

      <h3>Why Term Deposit Tracker?</h3>
      <p>At $24, the value proposition is simple: one missed maturity date, one weak rollover decision, or one forgotten deposit can cost more than the app itself. Term Deposit Tracker helps you replace passive savings management with a clearer process and better timing.</p>

      <p>This is not about adding complexity. It is about reducing avoidable mistakes, improving visibility, and giving yourself a better basis for each savings decision.</p>

      <p><em>Know when your deposits mature, compare your options, and make the next move with confidence.</em></p>
    DESC
    price: 24.0,
    download_url: "https://pmnoos.github.io/term-tracker/",
    meta_title: "Term Deposit Tracker | Track Maturity Dates, Rates and Rollover Decisions",
    meta_keywords: "term deposit tracker, maturity date tracker, rollover planning, rate comparison, fixed deposit tracker, savings maturity alerts",
    meta_description: "Track term deposits, stay ahead of maturity dates, compare rates, and make better rollover decisions with a practical one-time purchase savings tool."
  },
  {
    slug: "grocery-expense-tracker",
    name: "Grocery Expense Tracker",
    description: <<~DESC,
      <h2>Keep Grocery Costs Under Control Without Guesswork</h2>

      <p>Grocery Expense Tracker helps households understand where grocery money actually goes. Instead of relying on rough guesses, receipts stuffed in drawers, or a spreadsheet you stop updating after two weeks, you get a simple system for tracking trips, comparing stores, and seeing how food costs change over time.</p>

      <h3>Key Features</h3>
      <ul>
        <li><strong>Trip-by-Trip Logging</strong> - Save every shop with the store, date, total, and notes so spending stays easy to review.</li>
        <li><strong>Category Breakdown</strong> - See what goes to produce, pantry items, snacks, household supplies, frozen foods, and more.</li>
        <li><strong>Budget Targets</strong> - Compare weekly or monthly spending against a target you can actually track.</li>
        <li><strong>Repeat Item Tracking</strong> - Notice price creep on the staple items you buy most often.</li>
        <li><strong>Shopping List Support</strong> - Keep common purchases organized so routine trips stay focused.</li>
        <li><strong>Store Comparison</strong> - Identify which stores genuinely fit your budget instead of relying on assumptions.</li>
        <li><strong>Simple Reports</strong> - Review trends quickly and make better buying decisions without spreadsheet overhead.</li>
        <li><strong>Private by Design</strong> - Keep your household spending information in a straightforward personal tool.</li>
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
  product = Spree::Product.with_discarded.find_or_initialize_by(slug: attrs[:slug])
  product.undiscard if product.discarded?

  master = product.find_or_build_master
  master.undiscard if master.respond_to?(:discarded?) && master.discarded?
  master.product ||= product
  product.name = attrs[:name]
  product.description = attrs[:description]
  product.available_on ||= Time.current
  product.shipping_category ||= digital_category
  product.price = attrs[:price]
  master.price = attrs[:price]
  master.shipping_category ||= digital_category
  master.track_inventory = false
  product.meta_title = attrs[:meta_title] if attrs[:meta_title]
  product.meta_keywords = attrs[:meta_keywords] if attrs[:meta_keywords]
  product.meta_description = attrs[:meta_description] if attrs[:meta_description]

  unless product.valid?
    raise "Product seed failed for #{attrs[:slug]}: #{product.errors.full_messages.join(', ')}"
  end

  begin
    product.save!
  rescue ActiveRecord::RecordInvalid => e
    master_errors = master.errors.full_messages
    price_errors = master.prices.flat_map { |price| price.errors.full_messages }
    raise "Product save failed for #{attrs[:slug]}: #{e.record.class.name} #{e.record.errors.full_messages.join(', ')} | product=#{product.errors.full_messages.join(', ')} | master=#{master_errors.join(', ')} | prices=#{price_errors.join(', ')}"
  end

  if default_store && product.respond_to?(:stores) && !product.stores.exists?(default_store.id)
    product.stores << default_store
  end

  if attrs[:download_url].present?
    product_property = product.product_properties.find_or_initialize_by(property: download_url_property)
    product_property.value = attrs[:download_url]
    product_property.save!
  end
end

Spree::Product.where(name: "my_diary_app").update_all(name: "diary_app")
