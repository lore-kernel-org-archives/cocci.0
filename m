From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 5 Aug 2014 14:01:47 +0200 (CEST)
Subject: [Cocci] unreadable files
In-Reply-To: <CAJwHcF62DVbQq9DUWzqwh8p6m8DuHK1x=Rtn3SBs2YAo1pFauQ@mail.gmail.com>
References: <CAJwHcF62DVbQq9DUWzqwh8p6m8DuHK1x=Rtn3SBs2YAo1pFauQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1408051401280.2333@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hmm, that patch ay not be enough...

julia

On Tue, 5 Aug 2014, Akos PASZTORY wrote:

> Currently if coccinelle meets a file that it cannot open (e.g. it's an
> dangling symlink), it exits with:
> Fatal error: exception Sys_error("/tmp/aa/what.c: No such file or directory")
> even if run in recursive mode (i.e. passing a directory as argument).
>
> Could you please add a command line option to just skip those files
> and keep running?  (like make -k)
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
