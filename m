From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 28 Jun 2014 23:28:42 +0200 (CEST)
Subject: [Cocci] [PATCH V3] scripts/coccinelle/free: Delete NULL test
 before freeing functions?
In-Reply-To: <53AF2CE6.5020300@users.sourceforge.net>
References: <1403945247-21549-1-git-send-email-fabf@skynet.be>
 <53AE8613.8080600@users.sourceforge.net>
 <20140628120052.0b8670723928a967808dd544@skynet.be>
 <53AEA927.3010100@users.sourceforge.net>
 <20140628140157.98304218ad0919b1567cfee4@skynet.be>
 <53AF2CE6.5020300@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1406282326010.2022@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 28 Jun 2014, SF Markus Elfring wrote:

> > Sorry but I'm not working on coccinelle ; just did a small script for kernel tree.
> 
> I would appreciate a more constructive feedback for my update suggestions around
> the topic "Deletion of unnecessary checks before specific function calls".
> - Did you look at the concrete patches?
> - How do you think about the general approach?
> 
> Examples:
> https://systeme.lip6.fr/pipermail/cocci/2014-March/000676.html
> http://marc.info/?l=kernel-janitors&m=139405971927100&w=2

Regular expressions do not allow taking advantage of the optimizations 
provided by Coccinelle and are not easy for a reader to understand.

> https://systeme.lip6.fr/pipermail/cocci/2014-March/000677.html
> http://marc.info/?l=kernel-janitors&m=139405983727148&w=2

This is not safe due to the use of when any.  You have no guarantee that 
there is not a dereference of input in the matched region, or that the 
value of input is still the argument value at the point of the test.

julia
