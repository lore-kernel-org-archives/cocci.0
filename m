From: mstefani@redhat.com (Michael Stefaniuc)
Date: Mon, 13 Feb 2017 10:47:24 +0100
Subject: [Cocci] coccilib.report.print_report Broken For Redirected
	STDOUT
In-Reply-To: <ow4tw80p889.fsf@inria.fr>
References: <b3ad7723-acf2-e642-8d9b-d448bb719f03@redhat.com>
 <alpine.DEB.2.20.1702112020360.1955@hadrien> <ow4tw80p889.fsf@inria.fr>
Message-ID: <2e1cffc0-710c-a66e-03d7-85986fd96e6b@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 02/12/2017 01:23 AM, Thierry Martinez wrote:
> Hello!
> 
> Michael:
>>> spatch cocciprint.cocci cocciprint.c  > /tmp/nothing
>>> wc -c /tmp/nothing
>>> 0 /tmp/nothing
> 
> Standard output gets buffered when redirected to a file and not flushed
> as quickly as it is when there is no redirection: it is not specific to
> coccilib.report.print_report and the same observation can be obtained
> by just calling "print".
> 
> I just committed a simple fix on GitHub: standard outputs are now
> flushed at the end of the processing of code transformation.
Thanks Thierry, that fixes the issue.

bye
	michael
