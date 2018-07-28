From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 28 Jul 2018 08:42:59 +0200
Subject: [Cocci] Search/replace inside string constants?
In-Reply-To: <CAOZdJXV4rb-Snt95ZcLJG1v-qV_O+RKjC=X0ACZghmDK=WXGnA@mail.gmail.com>
References: <CAOZdJXV4rb-Snt95ZcLJG1v-qV_O+RKjC=X0ACZghmDK=WXGnA@mail.gmail.com>
Message-ID: <a87fbecd-88fa-e638-7bab-e662030850dd@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> @script:python s@
> c << r.c;
> c2;
> @@
> if c.startswith('"NVRM: '):
>     coccinelle.c2 = '"' + c[7:];
> else:
>     coccinelle.c2 = c;

I have got another software development idea for this transformation approach.
The detection of unwanted prefixes could be moved into a regular expression
like ?^"NVRM: ? for the constraint of the metavariable for which SmPL inheritance
is used here, couldn't it?
The shown SmPL rule ?s? needs to work only with matching data then so that
the Python code could be reduced to the statement ?coccinelle.c2 = '"' + c[7:]?.

How do you think about to try such a script variant out besides adjustments
for comma positions?
https://systeme.lip6.fr/pipermail/cocci/2018-July/005212.html

Regards,
Markus
