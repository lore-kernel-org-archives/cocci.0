From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 22 May 2015 12:40:42 +0200
Subject: [Cocci] array index range checking
In-Reply-To: <CABBGRWtoj4=eyKeeW5x1yK2x2msUQDts-i9TjukxTX-HosfDOg@mail.gmail.com>
References: <CABBGRWtAHM7naeENzeVQu_n0QC9EhCpUEvv_0MyZ+VH8zfxgxg@mail.gmail.com>	<555E4A91.2010300@users.sourceforge.net>	<CABBGRWtnRi0UmDeaemtx-=S8bznO2K-_8jjB_v9sEgHnQUN9QQ@mail.gmail.com>	<555EC300.50503@users.sourceforge.net>	<CABBGRWsyH6LZe-4wxZOyG7zcc0yp=t4MPE07ETBC+jnMne45bw@mail.gmail.com>	<555EFF6F.2030603@users.sourceforge.net>
 <CABBGRWtoj4=eyKeeW5x1yK2x2msUQDts-i9TjukxTX-HosfDOg@mail.gmail.com>
Message-ID: <555F07AA.7030504@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> i want that the script compare the index to the size of the array.

How do you think about to try this comparison by Python or OCaml scripts
(within SmPL)?


> i don't know if coccinelle can do this.

I have got the impression that this software can also find some update
candidates for your search pattern in principle. But I imagine that the
software development efforts will increase significantly to make its
application safer to some degree.

How would you like to handle scopes around array variables generally?

Regards,
Markus
