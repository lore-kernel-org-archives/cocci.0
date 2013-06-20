From: volanschi@metaware.fr (Nic Volanschi (R&D))
Date: Thu, 20 Jun 2013 14:14:13 +0200
Subject: [Cocci] metavariables for initialize/finalize
In-Reply-To: <mailman.1.1371722402.18703.cocci@systeme.lip6.fr>
References: <mailman.1.1371722402.18703.cocci@systeme.lip6.fr>
Message-ID: <1371730453.3207.16.camel@zamolxis.metaware.tm.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Personally, I think that adapting old patches to add the second @@ in
any initialization & finalization rule is very easy to do, even
automatically. So I see no problem for breaking the backward
compatibility on this matter, if it simplifies the implementation.

Nic.

On Thu, 2013-06-20 at 12:00 +0200, cocci-request at systeme.lip6.fr wrote:

> ----------------------------------------------------------------------
> 
> Message: 1
> Date: Wed, 19 Jun 2013 23:37:23 +0200 (CEST)
> From: Julia Lawall <julia.lawall@lip6.fr>
> To: cocci at systeme.lip6.fr
> Subject: [Cocci] metavariables for initialize/finalize
> Message-ID:
> 	<alpine.DEB.2.02.1306192330420.2023@localhost6.localdomain6>
> Content-Type: TEXT/PLAIN; charset=US-ASCII
> 
> SmPL allows defining initialize and finalize script rules that are rnu 
> before and after the treatment of any files, repectively.  They are useful 
> for managing counters, hash tables, etc. and for defining frequently used 
> script functions.
> 
> At the moment, they do not allow the declaration of any metavariables.  In 
> particular the syntax is, eg:
> 
> @initialize:python@
> 
> python code
> 
> without the second @@ as found in all other kinds of rules.
> 
> The problem is that this makes it impossible to refer to command line 
> arguments (ie virtual identifiers) in the initialize and finalize rules, 
> which can be useful.
> 
> One possibility would be to add metavariable declarations, as found 
> elsewhere.  This would mean adding @@ to any existing semantic patches 
> that contain initialize and finalize rules.
> 
> Another option would be to make the second @@ optional.  This preserves 
> backward compatability, but it makes the language more complex, and it is 
> not so easy to implement, because normally I don't parse the script code.
> 
> A third option would be to make it possible to refer to eg virtual.xyz 
> directly in the script code, regardless of the language.  These would then 
> get replaced by their values from the command line before passing the code 
> to the interpreter of the script language.
> 
> What do you think?  I prefer the fist option, because the language remains 
> (indeed, becomes more) uniform.  But the backward compatability is an 
> issue.  On the other hand, maybe most people don't use initialize and 
> finalize rules?
> 
> Thanks,
> julia


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20130620/ea85c568/attachment.html>
