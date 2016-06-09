From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 9 Jun 2016 18:10:11 +0200
Subject: [Cocci] [PATCH] docs/demos: add ++ transformation documentation
 and demos
In-Reply-To: <1465419046-24096-1-git-send-email-mcgrof@kernel.org>
References: <1465419046-24096-1-git-send-email-mcgrof@kernel.org>
Message-ID: <18cc6dea-37f0-4073-dfe7-fd1be5603645@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> This perhaps is not the best demo for use of ++ but it
> should suffice.

Since which release of the Coccinelle software is this notation (double
plus) supported?


> This adds some basic documentation for it and a demo.

Thanks for your approach.


> @@ -0,0 +1,28 @@
> +/*
> + * This can move unused variables declaration and assignment

Will it be better to refer to "variable declaration"?


> + * which is only used in the branch into the branch. Its

Can this wording be confusing?


> + * resticted however to only apply to code where this happens

Is the word "restricted" appropriate here?


> + * doe snot matter.

Would you like to move a space character here?


> + * If you don't use "++" you'll get "already tagged token" error since

Would the addition of a comma (before "you'll") make sense here?


> +You may run into the situation where grammar you specificy for

Is such a wording confusing?
Will the word "specify" be more appropriate in this context?


> +additions. If you are sure that order does not matter you can use the

Would the addition of a comma (before "you") help in reading?


> +If however you have two consecutive tokens that Coccinelle
> +can transform order cannot be guaranteed for how Coccinelle

How do you think about "? transform, order ?"?

Regards,
Markus
