From: lists@eitanadler.com (Eitan Adler)
Date: Tue, 23 Oct 2012 15:32:47 -0400
Subject: [Cocci] licensing concerns with cocci patches
In-Reply-To: <alpine.DEB.2.02.1210232115200.1942@localhost6.localdomain6>
References: <CAF6rxgkr4aQ-b8HpxJ9w8FMOTL63w7GFJqF5FD5MOwaJ3Kni5w@mail.gmail.com>
 <alpine.DEB.2.02.1210221902220.3683@hadrien>
 <CAF6rxgmsuyxzTQOO1=WSBvqVixrj0T+k6x2wDNiFiObuRSi82g@mail.gmail.com>
 <alpine.DEB.2.02.1210232115200.1942@localhost6.localdomain6>
Message-ID: <CAF6rxgnMxA906SLzxrzDt6CcWxZQ8dJYLJkp3ByKwuR9ovHjFw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 23 October 2012 15:18, Julia Lawall <julia.lawall@lip6.fr> wrote:
> I wonder if for BSD you are actually interested in using the rules that do
> transformation?

Yes. This was the subject of mail. Ideally they could be 2-BSD
licensed (or dual-licensed) which solves the problem entirely. If not,
I'd be willing to accept assertions of the authors that they do not
intend for the output of the transformations to be
considered GPL.

> Most of the rules that are distributed with Linux can be
> used in several ways, to do transformation or to print a report.  For the
> ones that only print reports, I guess there is no problem at all, because no
> code is generated?

>  I'm not sure what would be the status of the rules that
> can do transformation if you only use them to generate reports.

As I understand it, there is no problem at all for reports as the code
is not being directly used (it is similar to a warning from gcc).

-- 
Eitan Adler
