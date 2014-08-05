From: peter.senna@gmail.com (Peter Senna Tschudin)
Date: Tue, 5 Aug 2014 13:16:50 +0200
Subject: [Cocci] unreadable files
In-Reply-To: <alpine.DEB.2.10.1408051247410.2333@hadrien>
References: <CAJwHcF62DVbQq9DUWzqwh8p6m8DuHK1x=Rtn3SBs2YAo1pFauQ@mail.gmail.com>
 <alpine.DEB.2.10.1408051247410.2333@hadrien>
Message-ID: <CA+MoWDow_QBv1af=PrzQ=+M9N0+yep6_QNbrN_Ay+Q5wucGD4g@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I think ignoring files it can't open can be default behavior. Maybe
print a warning?

On Tue, Aug 5, 2014 at 12:49 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> On Tue, 5 Aug 2014, Akos PASZTORY wrote:
>
>> Currently if coccinelle meets a file that it cannot open (e.g. it's an
>> dangling symlink), it exits with:
>> Fatal error: exception Sys_error("/tmp/aa/what.c: No such file or directory")
>> even if run in recursive mode (i.e. passing a directory as argument).
>>
>> Could you please add a command line option to just skip those files
>> and keep running?  (like make -k)
>
> Do you really want a command line argument for that?  I think it could
> just be the default behavior?  Already, Coccinelle doesn't process code
> that it can't parse, so in general there is no guarantee that all code in
> a file or directory is processed.  It could give a warning on standard
> error if it encounters this problem.
>
> julia
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci



-- 
Peter
