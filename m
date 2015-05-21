From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 21 May 2015 23:13:53 +0200
Subject: [Cocci] array index range checking
In-Reply-To: <CABBGRWtAHM7naeENzeVQu_n0QC9EhCpUEvv_0MyZ+VH8zfxgxg@mail.gmail.com>
References: <CABBGRWtAHM7naeENzeVQu_n0QC9EhCpUEvv_0MyZ+VH8zfxgxg@mail.gmail.com>
Message-ID: <555E4A91.2010300@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> the script must detect an error on ( T[20] = 5 ;)
> because there is an overflow of the array size.

Did you experiment with any SmPL script already?


> any suggestions please to implement this script ?

Would you like to analyse affected source code
only with constant array indexes?

Do you need to check for inappropriate numbers with
a bit of additional Python or OCaml programming?

Regards,
Markus
