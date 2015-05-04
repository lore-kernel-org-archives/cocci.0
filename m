From: mstefani@redhat.com (Michael Stefaniuc)
Date: Mon, 04 May 2015 10:10:43 +0200
Subject: [Cocci] smpl-spacing Whitespace Issue on Assignments
	(regression)
In-Reply-To: <alpine.DEB.2.02.1505032357060.2221@localhost6.localdomain6>
References: <55468FCA.5000402@redhat.com>
 <alpine.DEB.2.02.1505032357060.2221@localhost6.localdomain6>
Message-ID: <55472983.2000209@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 05/03/2015 11:58 PM, Julia Lawall wrote:
> On Sun, 3 May 2015, Michael Stefaniuc wrote:
> 
>> Hello Julia,
>> 
>> sorry for the delay, here is the whitespace regression though it
>> affects only --smpl-spacing
>> 
>> foo.cocci: @@ expression e1, e2; @@ - e1 = e2 + c = d
>> 
>> foo.c: void foo(void) { int a, b; b = a; }
>> 
>> spatch --smpl-spacing foo.cocci foo.c gives: -    b = a; +
>> c=d;
> 
> Just out of curiosity, did it work recently?  I don't think I have
> changed
Yes, the last rc worked. Or maybe it was the penultimate rc as I had
massive HW related problems with that machine and I might have missed
an update.

I'm am doing a "validation" run when updating coccinelle with my
monster cocci file that generates cocci file that get run on the Wine
source code.
https://people.redhat.com/mstefani/wine/coccinelle/COM-gen.cocci
The interdiff between the old and new run showed that whitespace issue
as only difference.

> anything recently related to assignments.  I will look into it.
Not urgent, I really learned coccinelle while writing that script back
in the days. The line that triggered was not optimal anyway and fixing
that avoids the issue: as the right hand side of the assignment is
invariant I could move it out of the - + code.

thanks
bye
	michael
