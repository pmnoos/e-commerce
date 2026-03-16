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

      <p>Diary App is a beautifully simple journalling tool built for people who want a calm, distraction-free place to record their daily thoughts, feelings, goals, and gratitude. Whether you write every day or only when inspiration strikes, Diary App adapts to your rhythm and keeps every entry safe, private, and easy to find again.</p>

      <h3>Key Features</h3>
      <ul>
        <li><strong>Daily Entry Prompts</strong> — Start writing in seconds with optional prompts like "What went well today?", "What are you grateful for?", and "What do you want to remember about this moment?"</li>
        <li><strong>Mood Tracker</strong> — Tag each entry with a mood so you can spot patterns over time and understand what lifts you or weighs you down.</li>
        <li><strong>Date &amp; Timeline View</strong> — Browse past entries on a clean calendar or scrolling timeline. Every memory is exactly where you left it.</li>
        <li><strong>Tags &amp; Categories</strong> — Organise entries with custom tags: travel, health, work, relationships, dreams, ideas — whatever matters to you.</li>
        <li><strong>Rich Text &amp; Photos</strong> — Write in plain text or use formatting. Attach photos to entries to capture the full picture of a moment.</li>
        <li><strong>Streak &amp; Habit Tracking</strong> — Build a daily writing habit with streak counters and gentle reminders that keep you coming back without pressure.</li>
        <li><strong>End-to-End Encryption</strong> — Your entries are encrypted and completely private. Not even we can read them.</li>
        <li><strong>Export &amp; Backup</strong> — Download your entire diary as a PDF or plain text file at any time. Your memories belong to you.</li>
      </ul>

      <h3>Who Is It For?</h3>
      <p>Diary App is for anyone who wants to slow down and reflect — students processing big life changes, professionals clearing their heads after a busy day, parents recording family moments, or anyone building a mindfulness or gratitude practice.</p>

      <h3>Why Diary App?</h3>
      <p>No social feed. No likes. No distractions. Just you and your thoughts in a clean, focused space designed to make writing feel effortless. Thousands of users say a daily five minutes with Diary App has changed how they see their own lives.</p>

      <p><em>Start your first entry today — the best time to begin is always now.</em></p>
    DESC
    price: 19.0,
    download_url: "https://pmnoos.github.io/diary_app-landing/",
    meta_title: "My Diary App | Private Journal with Mood Tracker",
    meta_keywords: "diary app, private journal, mood tracker, gratitude journal, encrypted diary, daily writing",
    meta_description: "Private digital journal with daily prompts, mood tracking, encrypted entries, and streaks. Capture thoughts, gratitude, and goals in minutes."
  },
  {
    slug: "autobiography-app",
    name: "Autobiography App",
    description: <<~DESC,
      <h2>Tell Your Life Story — On Your Terms</h2>

      <p>Autobiography App is a thoughtfully designed writing tool that helps you transform your life experiences into a compelling, well-structured personal narrative. Whether you are capturing memories for family, writing a memoir for publication, or simply preserving your story for yourself, this app gives you everything you need to write with clarity and confidence.</p>

      <h3>Key Features</h3>
      <ul>
        <li><strong>Life Stage Timeline</strong> — Organise your story chronologically or thematically across chapters: childhood, education, career, relationships, milestones, and legacy.</li>
        <li><strong>Guided Writing Prompts</strong> — Over 200 carefully crafted prompts spark memories you might otherwise forget. From "What was the street you grew up on?" to "Describe a moment that changed everything."</li>
        <li><strong>Chapter Builder</strong> — Drag-and-drop chapters, reorder events, and build a narrative arc that flows naturally from beginning to end.</li>
        <li><strong>Photo Integration</strong> — Attach photos to any chapter or event to bring your story to life with visual context.</li>
        <li><strong>Privacy Controls</strong> — Mark chapters as private, family-only, or public. Share selectively with people you trust.</li>
        <li><strong>Export & Publish</strong> — Export your finished autobiography as a beautifully formatted PDF, eBook (EPUB), or print-ready document. Share it with family or submit it to a publisher.</li>
        <li><strong>Auto-Save &amp; Cloud Backup</strong> — Your writing is saved automatically and backed up securely so you never lose a word.</li>
        <li><strong>Collaboration Mode</strong> — Invite a family member or writing coach to contribute, suggest edits, or add their own memories to shared chapters.</li>
      </ul>

      <h3>Who Is It For?</h3>
      <p>Autobiography App is ideal for anyone who wants to preserve their personal history — retirees documenting a lifetime of experience, professionals writing a career memoir, parents leaving a legacy for their children, or writers crafting a personal narrative for publication.</p>

      <h3>Why Choose Autobiography App?</h3>
      <p>Unlike a blank word processor, Autobiography App gives you structure without constraint. The guided framework keeps you moving forward, while the flexible chapter system lets your unique voice shape the final story. Thousands of users have completed memoirs they never thought possible — one prompt at a time.</p>

      <p><em>Start your first chapter today. Your story deserves to be told.</em></p>
    DESC
    price: 29.0,
    download_url: "https://www.autobiography.live",
    meta_title: "Autobiography App | Write and Preserve Your Life Story",
    meta_keywords: "autobiography app, memoir writing, life story, guided prompts, chapter builder, family history",
    meta_description: "Write your memoir with guided prompts, chapter planning, photo support, and exports to PDF or EPUB. Preserve your life story with structure and confidence."
  },
  {
    slug: "term-deposit-tracker",
    name: "Term Deposit Tracker",
    description: <<~DESC,
      <h2>Take Control of Your Term Deposits — All in One Place</h2>

      <p>Term Deposit Tracker is a smart financial tool that helps you monitor, compare, and optimise all your term deposits from a single clear dashboard. Whether you hold deposits across multiple banks or are just starting to build your savings strategy, this app makes it effortless to stay on top of maturity dates, interest rates, and reinvestment decisions.</p>

      <h3>Key Features</h3>
      <ul>
        <li><strong>Centralised Dashboard</strong> — See every term deposit you hold at a glance: institution, balance, interest rate, start date, maturity date, and projected return — all in one screen.</li>
        <li><strong>Maturity Alerts</strong> — Never miss a rollover deadline. Get notifications days or weeks before a deposit matures so you have time to compare rates and make the right decision.</li>
        <li><strong>Interest Calculator</strong> — Instantly calculate projected interest for any principal, rate, term, and compounding frequency. Compare simple vs compound interest side by side.</li>
        <li><strong>Rate Comparison Tool</strong> — Compare your current rates against current market rates to identify gaps and opportunities to earn more.</li>
        <li><strong>Reinvestment Planner</strong> — Model different reinvestment scenarios — roll over the full amount, withdraw interest, top up the principal, or split across multiple accounts.</li>
        <li><strong>Portfolio Summary</strong> — View your total savings portfolio value, weighted average interest rate, total interest earned to date, and upcoming cash flow from maturing deposits.</li>
        <li><strong>Transaction History</strong> — Keep a full audit trail of every deposit opened, rolled over, topped up, or closed.</li>
        <li><strong>Secure &amp; Private</strong> — All data is stored locally on your device. No bank credentials are ever requested or stored.</li>
      </ul>

      <h3>Who Is It For?</h3>
      <p>Term Deposit Tracker is built for self-directed savers, retirees managing income streams, investors laddering deposits across institutions, small business owners managing cash reserves, and anyone who wants to be more intentional about how their money grows.</p>

      <h3>Why Term Deposit Tracker?</h3>
      <p>Banks make it easy to open a deposit and easy to forget about it. Term Deposit Tracker puts you back in control. With clear visibility over every deposit and smart alerts before every maturity date, you will never leave money sitting at a suboptimal rate again.</p>

      <p><em>Start tracking smarter today — your savings will thank you.</em></p>
    DESC
    price: 24.0,
    download_url: "https://pmnoos.github.io/term-tracker/",
    meta_title: "Term Deposit Tracker | Rates, Maturity Alerts, Returns",
    meta_keywords: "term deposit tracker, maturity alerts, rate comparison, savings tracker, reinvestment planner, fixed deposit",
    meta_description: "Track term deposits, compare rates, monitor maturity dates, and model reinvestment options. Keep your savings portfolio organized and optimize interest returns."
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
