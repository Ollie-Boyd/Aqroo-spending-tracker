### Brief
>
>Build an app that allows a user to track their spending. No JavaScript or other libraries. Pure Ruby, CSS, and HTML.
>
>#### MVP
>
>* The app should allow the user to create and edit merchants, e.g. Tesco, Amazon, ScotRail
>* The app should allow the user to create and edit tags for their spending, e.g. groceries, entertainment, transport
>* The user should be able to assign tags and merchants to a transaction, as well as an amount spent on each transaction.
>* The app should display all the transactions a user has made in a single view, with each transaction's amount, merchant and tag, and a total for all transactions.
>
>##### Inspired by:
>
>Monzo, MoneyDashboard, lots of mobile/online banking apps
>
>##### Possible Extensions
>
>* The user should be able to mark Merchants and Tags as deactivated. Users will not be able to choose deactivated merchants/tags when creating a transaction. 
>* Transactions should have a timestamp, and the user should be able to view transactions sorted by the time they took place.
>* The user should be able to supply a budget, and the app should alert the user somehow when when they are nearing this budget or have gone over it.
>* The user should be able to filter their view of transactions, for example, to view all transactions in a given month, or view all spending on groceries.
### Why I chose this brief
* There were a few briefs but this one really spoke to me. I love keeping up with the latest consumer and SMB fintech developments and I was really excited to plan a similar style of app. My parents were really bad at managing their money growing up and I am the complete opposite so I had in mind some features that could be nice to try and implement.
* I have a sad love of graphs and I was excited for the challenge of getting some dynamic graphing going without any JavaScript or libraries. 

### My initial thoughts, hopes, and aims
* I wanted the webapp to be fully responsive from phone to desktop. I have been involved in fixing a poorly implemented 'responsive' website and it's a lot easier to get things right first time than digging back through CSS.  
* I wanted the tracker to be as frictionless as possible to use. I knew any friction at all will put a consumer off using it especially if they have to enter every purchase. This was kept in mind through the planning.
* Accessibility - This was new to me and I tried to keep it in mind all the time although I have more to learn. 

### Planning
* Planning took a solid day and a half of the project and it was so worth it as it made the rest of the process a lot easier and I hope made the result look better than I could have imagined at the start. I have used these steps to help me in subsequent projects and I hope I can keep refining them!
* **Proto Personas** - I spent time putting my mind into the shoes of 5 potential users of the app. Keeping the characters real, detailed, and diverse helps me not get too fixated on what **I** would want.
* **User Stories** - This was really helpful to flesh out the functionality of Aqroo from the perspective of my proto-personas. I also brainstormed functionallity with my girlfriend and flatmates. There were a lot of really cool ideas that I didn't have time to build into the app (one they really liked was having a way of seeing the recurring birthday/anniversary presents you needed to buy in a certain month and being able to tick them off. They struggled to budget for those larger spends which crop up in the year). 
* **User Journeys** Getting the flow throught the app was key. For example I wanted to make entering a new transaction as simple as possible, eg the user would begin typing a merchant and their matching merchants would show. There would be no seperate screen to 'add a merchant'! If there was no match for a merchant the user had typed, the merchant would just be added as a new merchant on their account. 
* **Wire Frames** - I went through many pages of notepaper wireframing the app. I wanted it to be aimed at a younger audience, maybe more teens and millenials which is why I ended up with a pretty 'young' feel to the colours and iconography. 
* **Paper prototyping** - I had never tried this before and it was so, **so** useful. I used my flatmates as subjects and gave them various tasks to achieve in the app ( eg remove a merchant, add a transaction, view transactions from a certain month etc). For the most part they confirmed that the design language of the wireframes was pretty conventional but there were a couple of points where they were a bit uncertain or had to try a couple of times to get to the right place so I had to revise a couple of elements in the wireframes. My girlfriend is a full-on pop-up card engineer in her spare time so she helped with my prototyping.
* **Database relationship diagram** - I have an A1 notepad for my diagrams as personally I am a big fan of doing them by hand. Once I was happy with these I mapped out the classes, their peoperties, and methods.

### What I learned along the way
* **Graphing with no JS** - as I mentioned before, I was excited about trying my hand at the challenge of rendering some graphs with the help of Ruby. I knew I would have so use dynamically rendered SVG or CSS but which?

My tactic with anything like this is to read a whole lot of recent blogs/StackOverflow, bookmark the blogs that have some promising looking code examples, take those code examples into CodePen or JS Fiddle, strip them down to their most basic form, then play about/break them until I get my head around what's going on. Then comment the hell out of it. 

The best resources I found in camp CSS were:[This 2015 blog on CSS graphs was useful](https://css-tricks.com/making-charts-with-css/), as was [this 2019 blog on using CSS conic-gradient for pie charts](https://keithclark.co.uk/articles/single-element-pure-css-pie-charts/, finally [this 2015 afticle on using CSS transform to make piecharts](https://www.smashingmagazine.com/2015/07/designing-simple-pie-charts-with-css/)
### What I know could be better and could be fixed in the next version








