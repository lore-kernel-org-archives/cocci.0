From: eliseomarmol@gmail.com (=?utf-8?Q?Eliseo_Mart=C3=ADnez?=)
Date: Sat, 20 Dec 2014 10:30:39 +0100
Subject: [Cocci] In depth docs & question about include
Message-ID: <63642497-E7BD-4E63-B934-523CFE111637@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi, 

I discovered coccinelle some time ago, and I think it?s an amazing tool that can make a real difference.
Unfortunately, up until now, I?ve had to restrict myself to simple use cases, because existing documentation only scratches the surface.
You can see there are much more advanced things you could do, but for those you don?t find an explanation anywhere. You?re left with trial & error.
So, my question is: Are there plans to produce a book-style, really in-depth explanation of all coccinelle functionality?
I think that would be really necessary if you want bigger adoption/usage.

Now, a concrete question:
Suppose I?m introducing changes that make use of a function declared in ?header.h?.
How would I automatically insert includes for the header, only when it?s not already present?

Thanks, and keep up the hard work.
Eliseo Mart?nez.
