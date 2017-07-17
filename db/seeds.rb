# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

the_line = Lesson.create([
    {
      title: "The Line",
      slug: "the-line",
      description: "Explore a timeless God",
      video_id: "184720737",
      image: "Screen_Shot_2016-10-11_at_8.29.37_AM.png"
    }]).first

the_line.questions.create([
    {
      position: 1,
      body: "What physical scenes have you witnessed that caused you to have a sense of awe?"
    },
    {
      position: 2,
      body: "Why, do you think, did God choose to reveal himself through creation?"
    },
    {
      position: 3,
      body: "What does it mean to be timeless?"
    },
    {
      position: 4,
      body: "When the elders worshipped God, John says they “cast down their crowns before the throne.” What statement are they making by casting their crowns before the throne?"
    },
    {
      position: 5,
      body: "What statements do the elders make about God?"
    },
    {
      position: 6,
      body: "According to the elders, why is God worthy?"
    },
    {
      position: 7,
      body: "What does this heavenly scene tell us about worship?"
    }])

the_line.exercizes.create([
  {
    body: "Acknowledge God as your creator. Tell God, then tell your study group.",
    difficulty: 1
  },
  {
    body: "Write down a list of the most beautiful places you’ve been or seen. Find a place to be alone. Thank God for creating those places.",
    difficulty: 2
  },
  {
    body: "Find a beautiful creation scene (stars, moon, ocean, lake, mountains, sky, etc.) Take some photos and share them on Facebook, Twitter, or Instagram. In the description, thank the Creator for his creation.",
    difficulty: 3
  },
  {
    body: "Write a letter to God. Tell him what you think of his timeless nature. Tell him what you think of yourself in view of his greatness. Tell him that he is worthy. For the next three days, re-read your letter before you start your day.",
    difficulty: 4
  },
  {
    body: "If you have talent with music, write a song about the reasons God is worthy. If you can design (draw, paint, digital graphics, etc.) make a picture of the throne room scene described in Revelation 4. Or, write a story putting yourself in John’s shoes during that throne room scene. What do you see? How do you react? How do you feel?",
    difficulty: 5
  }
])

the_least = Lesson.create([
    {
      title: "The Least",
      slug: "the-least",
      description: "Become great by serving others",
      video_id: "173713492",
      image: "photo-1457171907497-235711313923.jpeg"
    }]).first

the_least.questions.create([{
      position: 1,
      body: "Jesus says that the only way to become great is to become a servant. Do you agree? Where have you witnessed this principle at work in your life?"
    },
    {
      position: 2,
      body: "Why do you think God created the world to work in this way? Why did God desire that greatness be connected to service?"
    },
    {
      position: 3,
      body: "Why did Jesus wash the disciples’ feet?",
      notes: "“The evening meal was in progress, and the devil had already prompted Judas, the son of Simon Iscariot, to betray Jesus. Jesus knew that the Father had put all things under his power, and that he had come from God and was returning to God; so he got up from the meal, took off his outer clothing, and wrapped a towel around his waist. After that, he poured water into a basin and began to wash his disciples’ feet, drying them with the towel that was wrapped around him.
He came to Simon Peter, who said to him, “Lord, are you going to wash my feet?”
Jesus replied, “You do not realize now what I am doing, but later you will understand.”
“No,” said Peter, “you shall never wash my feet.”
Jesus answered, “Unless I wash you, you have no part with me.”
“Then, Lord,” Simon Peter replied, “not just my feet but my hands and my head as well!”
- John 13:2-9"
    },
    {
      position: 4,
      body: "Knowing Judas had already betrayed Him, Jesus still served him. Why do people find it challenging to serve someone who has done them wrong? What does it say about Jesus that He would serve Judas?"
    },
    {
      position: 5,
      body: "Why did Peter first question and reject Jesus’ service?"
    },
    {
      position: 6,
      body: "If we are bold, we will look at Jesus’ example as a standard for our own lives. When you compare Jesus’ service to your own practice of service, what differences stand out? Where can you stand to improve?"
    },
    {
      position: 7,
      body: "What is the relationship between faith and works?",
      notes: "“What good is it, my brothers, if someone says he has faith but does not have works? Can that faith save him? If a brother or sister is poorly clothed and lacking in daily food, and one of you says to them, “Go in peace, be warmed and filled,” without giving them the things needed for the body, what good is that? So also faith by itself, if it does not have works, is dead.” James 2:14-17"
    },
    {
      position: 8,
      body: "What are some areas in your life where you have faith without works?"
    },
    {
      position: 9,
      body: "How could works and service improve our faith?"
    }])

the_least.exercizes.create([
  {
    body: "Pay attention to the needs of your family. Find a need you can satisfy and do it. Some ideas: Do some cleaning or maintenance on your parent’s home. Make a meal for a sibling. Spend some time caring for your grandchildren, nieces, nephews, or other children of a relative to give the parents some rest.",
    notes: "But if anyone has the world's goods and sees his brother in need, yet closes his heart against him, how does God's love abide in him? Little children, let us not love in word or talk but in deed and in truth. - 1 John 3:17-18",
    difficulty: 1
  },
  {
    body: "Who is “the least of these”? Find someone in your community who is “the least of these”. Find a way to serve that person and do it.",
    notes: "When the Son of Man comes in his glory, and all the angels with him, he will sit on his glorious throne. All the nations will be gathered before him, and he will separate the people one from another as a shepherd separates the sheep from the goats. He will put the sheep on his right and the goats on his left.
Then the King will say to those on his right, ‘Come, you who are blessed by my Father; take your inheritance, the kingdom prepared for you since the creation of the world. For I was hungry and you gave me something to eat, I was thirsty and you gave me something to drink, I was a stranger and you invited me in, I needed clothes and you clothed me, I was sick and you looked after me, I was in prison and you came to visit me.’
“Then the righteous will answer him, ‘Lord, when did we see you hungry and feed you, or thirsty and give you something to drink? When did we see you a stranger and invite you in, or needing clothes and clothe you? When did we see you sick or in prison and go to visit you?’
“The King will reply, ‘Truly I tell you, whatever you did for one of the least of these brothers and sisters of mine, you did for me.’
Matthew 25:31-40",
difficulty: 2
  },
  {
    body: "Find something you can give up in order to serve someone else. Some ideas: Give up time watching a sporting event to spend with someone who is lonely. Give up money you planned on using on yourself to buy clothes, food, or a gift for someone.",
    notes: "Do nothing out of selfish ambition or vain conceit. Rather, in humility value others above yourselves, not looking to your own interests but each of you to the interests of the others. - Philippians 2:3-4",
    difficulty: 3
  },
  {
    body: "For one week, focus on improving your attitude at work. Realize that your work is for the Lord and use that to work with more diligence, honesty, and humility.",
    notes: "Whatever you do, work at it with all your heart, as working for the Lord, not for human masters, since you know that you will receive an inheritance from the Lord as a reward. It is the Lord Christ you are serving. - Colossian 3:23-24",
    difficulty: 4
  },
  {
    body: "Jesus served the one who had betrayed him, Judas Iscariot. Has someone betrayed you? Do you have an enemy? Is there someone who does not show you respect? Find a way to humbly serve that person and do it this week.",
    difficulty: 5
  }
])

the_feast = Lesson.create([
    {
      title: "The Feast",
      slug: "the-feast",
      description: "Fill up on the good stuff.",
      video_id: "171419925",
      image: "photo-1464219222984-216ebffaaf85.jpeg"
    }
  ]).first

the_feast.questions.create([
    {
      position: 1,
      body: "What questions do you have about the three-step approach to meditation?"
    },
    {
      position: 2,
      body: "What does it mean to meditate on God’s word?"
    },
    {
      position: 3,
      body: "Why does scripture compare meditation to a roar, or moan?"
    },
    {
      position: 4,
      body: "What benefits come to the one who meditates on the Bible?"
    },
    {
      position: 5,
      body: "What truths did you learn after meditating on the story of Jesus and the ten lepers (Luke 17:11-19)? What commitments did you make?"
    },
    {
      position: 6,
      body: "Does anything make you uncomfortable about the three-step approach?"
    }])

the_feast.exercizes.create([
  {
    body: "Use the three-step approach to meditate on Psalm 23. Next week, share your findings with your group. What did the Lord teach you through this scripture? What has the Lord asked you to do through this scripture?",
    difficulty: 1
  },
  {
    body: "Use the three-step approach to meditate on Matthew 6:5-15. Next week, share your findings with your group. What did the Lord teach you through this scripture? What has the Lord asked you to do through this scripture?",
    difficulty: 2
  },
  {
    body: "Use the three-step approach to meditate on Luke 15:11-32. Next week, share your findings with your group. What did the Lord teach you through this scripture? What has the Lord asked you to do through this scripture?",
    difficulty: 3
  },
  {
    body: "Use the three-step approach to meditate on Romans 6. Next week, share your findings with your group. What did the Lord teach you through this scripture? What has the Lord asked you to do through this scripture?",
    difficulty: 4
  },
  {
    body: "Use the three-step approach to meditate on Matthew 5-7. Next week, share your findings with your group. What did the Lord teach you through this scripture? What has the Lord asked you to do through this scripture?",
    difficulty: 5
  }
])