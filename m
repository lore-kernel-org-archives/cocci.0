From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 21 Jan 2015 19:03:09 +0100
Subject: [Cocci] Matching functions with attributes
In-Reply-To: <F6392E9E-0D22-4398-8173-DD84FFEBAB98@gmail.com>
References: <D59A6A6F-9D60-44DE-9B6C-8B615B776EA8@gmail.com>
 <54BFD099.8030002@users.sourceforge.net>
 <F6392E9E-0D22-4398-8173-DD84FFEBAB98@gmail.com>
Message-ID: <54BFE9DD.7000708@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Regarding meaning, well, I?m looking for places where var is checked for nullness/non-nullnes.
> That?s the most obvious way I?ve found to express that?

By the way:
Do you need to extend your source code search pattern with else clauses
for the shown if statements?


>> Would you like to store involved function names into specific
>> data structures (like databases)?
> 
> The purpose of my question is to see if there?s a way to do this within coccinelle.

It can become possible.

Would you like to help in improving the corresponding OCaml source files?


> If there?s no such a way, then, well, I?ll definitely consider constructing
> that regexp through some external script.

How do you think about to reuse any ideas from my approach for an other
semantic filter?

https://lkml.org/lkml/2014/3/5/356
http://article.gmane.org/gmane.comp.version-control.coccinelle/3513/
https://systeme.lip6.fr/pipermail/cocci/2014-March/000676.html

Regards,
Markus
