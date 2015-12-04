From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 4 Dec 2015 17:18:36 +0100
Subject: [Cocci] Using Coccinelle to add #include lines
In-Reply-To: <CAFEAcA-PnYAapj3tc5CiD4r5UROcbrO0x2=7xGTv+XqCjXWFKg@mail.gmail.com>
References: <CAFEAcA-HKiMsz36SbfaGN3Oaz3Jn_h+f8McaHo48zmsngJtyRg@mail.gmail.com>
 <alpine.DEB.2.10.1512041701250.2768@hadrien>
 <CAFEAcA-PnYAapj3tc5CiD4r5UROcbrO0x2=7xGTv+XqCjXWFKg@mail.gmail.com>
Message-ID: <5661BCDC.10707@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> The solution would be to take the position of each one, and then save only
>> the position of the earliest one.  This would require using scripts and
>> hash tables, and is kind of clunky.
> 
> Maybe I'm better off just using sed or perl for this job?

Would you dare to try the semantic patch language out a bit more together
with capabilities from programming languages like "Python" or "OCaml"?


> #include lines are really pretty much line-based after all.

How safe and robust should the desired adjustment of include statements
become for your source files?

Regards,
Markus
