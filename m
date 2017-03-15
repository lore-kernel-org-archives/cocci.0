From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 15 Mar 2017 12:01:24 +0100 (CET)
Subject: [Cocci] coccicheck run error
In-Reply-To: <20170315103555.GA27181@eros>
References: <20170315103555.GA27181@eros>
Message-ID: <alpine.DEB.2.20.1703151200540.6227@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 15 Mar 2017, Tobin C. Harding wrote:

> I am running coccinelle using
>
> $ make coccicheck MODE=report DEBUG_FILE=cocci-err.log M=drivers/staging/ks7010
> Please check for false positives in the output before submitting a patch.
> When using "patch" mode, carefully review the patch before submitting it.
>
> coccicheck failed
>
> $ cat cocci-err.log
> 3 files match
> Fatal error: exception Sys_error("alloc_cast: No such file or directory")
>
> Using V=1 gives no additional indication of the error.
>
> Any suggestions on how to proceed please?

What version of Coccinelle do you have?  If you are not using the github
version, perhaps you could try with that.

julia


>
> thanks,
> Tobin.
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
