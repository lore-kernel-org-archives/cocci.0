From: Thierry.Martinez@inria.fr (Thierry Martinez)
Date: Sun, 12 Feb 2017 01:23:50 +0100
Subject: [Cocci] coccilib.report.print_report Broken For Redirected
	STDOUT
In-Reply-To: <alpine.DEB.2.20.1702112020360.1955@hadrien>
References: <b3ad7723-acf2-e642-8d9b-d448bb719f03@redhat.com>
 <alpine.DEB.2.20.1702112020360.1955@hadrien>
Message-ID: <ow4tw80p889.fsf@inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello!

Michael:
>> spatch cocciprint.cocci cocciprint.c  > /tmp/nothing
>> wc -c /tmp/nothing
>> 0 /tmp/nothing

Standard output gets buffered when redirected to a file and not flushed
as quickly as it is when there is no redirection: it is not specific to
coccilib.report.print_report and the same observation can be obtained
by just calling "print".

I just committed a simple fix on GitHub: standard outputs are now
flushed at the end of the processing of code transformation.

Thanks for the report. Best regards.
-- 
Thierry.

Julia Lawall (2017/02/11, 19:20 UTC)?:
> On Sat, 11 Feb 2017, Michael Stefaniuc wrote:
>
>> Hello!
>>
>> coccilib.report.print_report is not producing any output when STDOUT is
>> redirected to a file or a pipe. I have attached a simple test case.
>>
>> spatch cocciprint.cocci cocciprint.c
>> cocciprint.c:3:8-9: Printing Suceeded
>>
>> spatch cocciprint.cocci cocciprint.c  > /tmp/nothing
>> wc -c /tmp/nothing
>> 0 /tmp/nothing
>
> Thanks for the report.  Will have it looked into.
>
> julia
>
>>
>>
>> thanks
>> bye
>> 	michael
>>
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
