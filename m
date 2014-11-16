From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Sun, 16 Nov 2014 14:24:57 +0300
Subject: [Cocci] [PATCH 1/1] kernel-audit: Deletion of an unnecessary
 check before the function call "audit_log_end"
In-Reply-To: <54687F1A.1010809@users.sourceforge.net>
References: <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <54687F1A.1010809@users.sourceforge.net>
Message-ID: <20141116112457.GB4905@mwanda>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, Nov 16, 2014 at 11:40:26AM +0100, SF Markus Elfring wrote:
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 21eae3c..1fed61c 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1470,8 +1470,7 @@ static void audit_log_exit(struct audit_context *context, struct task_struct *ts
>  
>  	/* Send end of event record to help user space know we are finished */
>  	ab = audit_log_start(context, GFP_KERNEL, AUDIT_EOE);
> -	if (ab)
> -		audit_log_end(ab);
> +	audit_log_end(ab);
>  	if (call_panic)
>  		audit_panic("error converting sid to string");
>  }

I should have tried to explain this in my earlier message...

The original code is very clear, the new code works exactly the same but
it's not clear if the author forgot about handling errors from
audit_log_start().  So now someone will come along later and add:

	if (!ab)
		return;

We get a lot of mindless "add error handling" patches like that.  Even
if no one adds that patch who ever is reading the code will think that
the error handling is missing by mistake and have to read the git log
to determine the original intention.

Instead of hiding the readable code in the git log, let's just leave it
in the source file.

regards,
dan carpenter
