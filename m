From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 14 Sep 2015 11:38:00 +0200
Subject: [Cocci] Checking lock usage
In-Reply-To: <20150914082905.GA11348@kaficko.joja.cz>
References: <20150914082905.GA11348@kaficko.joja.cz>
Message-ID: <55F69578.7050100@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I want to check whether all accesses to any part of some struct are locked.

I imagine that you will need to perform data-flow analysis for such a task.
I guess that there are some software development challenges to achieve
it with the semantic patch language.


> struct B *b;
> ...
> b->bar->foo;

Are you eventually concerned about the handling of such pointer access
chains?


> If B, I wanted to implement it but got totally lost in the code.

Would you like to increase your efforts for the software development
with the programming language "OCaml"?

Regards,
Markus
