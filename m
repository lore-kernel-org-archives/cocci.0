From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 27 Jul 2018 19:09:35 +0200
Subject: [Cocci] Search/replace inside string constants?
In-Reply-To: <CAOZdJXV4rb-Snt95ZcLJG1v-qV_O+RKjC=X0ACZghmDK=WXGnA@mail.gmail.com>
References: <CAOZdJXV4rb-Snt95ZcLJG1v-qV_O+RKjC=X0ACZghmDK=WXGnA@mail.gmail.com>
Message-ID: <8c83d9bf-bf11-567a-62f8-0ab713c6a310@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> @script:python s@
> c << r.c;
> c2;
> @@
> if c.startswith('"NVRM: '):
>     coccinelle.c2 = '"' + c[7:];
> else:
>    coccinelle.c2 = c;

I suggest to reconsider the action if no modification should be performed finally.
How do you think about to use the statement ?cocci.include_match(False)?
in the else branch instead?


> But this didn't:

I wonder also about the shown source code situation that an unwanted prefix
could be still preserved in the error message from such a transformation example.

Would you like to show your final SmPL replacement rule here?

Regards,
Markus
