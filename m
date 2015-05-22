From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 22 May 2015 07:47:44 +0200
Subject: [Cocci] array index range checking
In-Reply-To: <CABBGRWtnRi0UmDeaemtx-=S8bznO2K-_8jjB_v9sEgHnQUN9QQ@mail.gmail.com>
References: <CABBGRWtAHM7naeENzeVQu_n0QC9EhCpUEvv_0MyZ+VH8zfxgxg@mail.gmail.com>	<555E4A91.2010300@users.sourceforge.net>
 <CABBGRWtnRi0UmDeaemtx-=S8bznO2K-_8jjB_v9sEgHnQUN9QQ@mail.gmail.com>
Message-ID: <555EC300.50503@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> i tried this script
>
> @r@
> position p1;
> identifier  arr;
> constant i , var;
> type T;
> @@
>  T arr[var];

Does this SmPL approach work a bit as you expect?
Which details did not satisfy you so far?


> ... when != (i < var/ )

How do you think about to omit parentheses here?


> ...
> * arr[i]@p1

Would you like to reuse the data from the position variable anywhere?

How do you want to handle scopes for the involved array indexes?
http://en.cppreference.com/w/c/language/scope

Regards,
Markus
