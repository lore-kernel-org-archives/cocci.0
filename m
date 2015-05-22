From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 22 May 2015 13:53:26 +0200
Subject: [Cocci] array index range checking
In-Reply-To: <alpine.DEB.2.11.1505221311210.1551@cocci>
References: <CABBGRWtAHM7naeENzeVQu_n0QC9EhCpUEvv_0MyZ+VH8zfxgxg@mail.gmail.com>
 <555E4A91.2010300@users.sourceforge.net>
 <CABBGRWtnRi0UmDeaemtx-=S8bznO2K-_8jjB_v9sEgHnQUN9QQ@mail.gmail.com>
 <555EC300.50503@users.sourceforge.net>
 <CABBGRWsyH6LZe-4wxZOyG7zcc0yp=t4MPE07ETBC+jnMne45bw@mail.gmail.com>
 <555EFF6F.2030603@users.sourceforge.net>
 <CABBGRWtoj4=eyKeeW5x1yK2x2msUQDts-i9TjukxTX-HosfDOg@mail.gmail.com>
 <alpine.DEB.2.11.1505221311210.1551@cocci>
Message-ID: <555F18B6.5090806@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> But it will not detect the case where you check but on the wrong value.
> Coccinelle doesn't know anything about eg the values of particular
> variables.

Will any more software developers dare to fiddle with data flow analysis
by the help of your tool?

Regards,
Markus
