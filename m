From: chrubis@suse.cz (Cyril Hrubis)
Date: Thu, 2 Oct 2014 15:07:16 +0200
Subject: [Cocci] string parameter concatenation
In-Reply-To: <542D4AA2.6060407@users.sourceforge.net>
References: <20141001130215.GB4701@rei.suse.cz>
 <542D4AA2.6060407@users.sourceforge.net>
Message-ID: <20141002130716.GA3635@rei.suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi!
> Would it make sense and work to write a semantic patch rule like the following?
> 
> @replacement@
> @@
> -f
> +g
> (L);
> 
> 
> Can the passed parameters be omitted from the desired adjustment by "the plus line"?

The whole rule that I'm working with is:

@@
expression list L;
expression C != {TINFO, TPASS};
@@
- tst_resm(C, L);
- tst_exit();
+ tst_brkm(C, NULL, L);

Which is used to replace two functions with one and shuffles the
arguments a bit.

-- 
Cyril Hrubis
chrubis at suse.cz
