From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 16 Oct 2018 18:39:32 +0200 (CEST)
Subject: [Cocci] Problem with improper multi-line string literals
In-Reply-To: <CAOZdJXXdbNO-S7iQgmV3nJ6q-1jjy0sJFGmJ7m2inZ3HLOOC3Q@mail.gmail.com>
References: <CAOZdJXWJLLZdttCJmZVbZU9EEjxxHGdvnRCmT+3=8O=Cv4yx-w@mail.gmail.com>
 <alpine.DEB.2.21.1810132318330.15695@hadrien>
 <CAOZdJXUJhwYkzJc6LLb_4Vm7nj_si8igx-fgs-q-PyRkOHr2Dw@mail.gmail.com>
 <20181016151052.GA26422@himanshu-Vostro-3559>
 <CAOZdJXXdbNO-S7iQgmV3nJ6q-1jjy0sJFGmJ7m2inZ3HLOOC3Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1810161838450.3512@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 16 Oct 2018, Timur Tabi wrote:

> On 10/16/18 10:10 AM, Himanshu Jha wrote:
> > FYI coccinelle works fine on Ubuntu 18.04.1 when built through
> > source code.
>
> I've attached my config.log, can you compare it with yours and post the diff?

I didn't find anything significant.  Maybe you can try disabling parmap,
like you disabled pcre.  There seems to be a config option for that.

julia
