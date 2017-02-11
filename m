From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 11 Feb 2017 20:20:59 +0100 (CET)
Subject: [Cocci] coccilib.report.print_report Broken For Redirected
 STDOUT
In-Reply-To: <b3ad7723-acf2-e642-8d9b-d448bb719f03@redhat.com>
References: <b3ad7723-acf2-e642-8d9b-d448bb719f03@redhat.com>
Message-ID: <alpine.DEB.2.20.1702112020360.1955@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 11 Feb 2017, Michael Stefaniuc wrote:

> Hello!
>
> coccilib.report.print_report is not producing any output when STDOUT is
> redirected to a file or a pipe. I have attached a simple test case.
>
> spatch cocciprint.cocci cocciprint.c
> cocciprint.c:3:8-9: Printing Suceeded
>
> spatch cocciprint.cocci cocciprint.c  > /tmp/nothing
> wc -c /tmp/nothing
> 0 /tmp/nothing

Thanks for the report.  Will have it looked into.

julia

>
>
> thanks
> bye
> 	michael
>
