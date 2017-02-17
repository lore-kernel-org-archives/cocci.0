From: mstefani@redhat.com (Michael Stefaniuc)
Date: Fri, 17 Feb 2017 19:15:14 +0100
Subject: [Cocci] Python Output Not Flushed With -j > 1
In-Reply-To: <ow4wpco975t.fsf@inria.fr>
References: <9bb393fd-22cf-8b1e-33e8-755e0ba02ed3@redhat.com>
 <ow4wpco975t.fsf@inria.fr>
Message-ID: <b650a0e5-4165-b61a-9950-7a001e7e983b@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 02/17/2017 04:19 PM, Thierry Martinez wrote:
> Michael:
>> With a slightly modified .cocci file from last time:
>> sibiu:/tmp$ spatch -j 1 cocciprint.cocci cocciprint.c > out 2> /dev/null
>> && cat out
>> cocciprint.c:3:8-9: coccilib.report.print_report Suceeded
>> print() Succeded
>> sibiu:/tmp$ spatch -j 2 cocciprint.cocci cocciprint.c > out 2> /dev/null
>> && cat out
>> sibiu:/tmp$ spatch -j 3 cocciprint.cocci cocciprint.c > out 2> /dev/null
>> && cat out
>> sibiu:/tmp$
> 
> It should be fixed now (commit 8996213b).
> Thank you for the report.
Thanks, that fixed it, for my real cocci script too.

bye
	michael
