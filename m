From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 14 Nov 2017 10:08:18 +0100
Subject: [Cocci] Coccinelle: fix parallel build with
	CHECK=scripts/coccicheck
In-Reply-To: <alpine.DEB.2.20.1711140735020.2332@hadrien>
References: <alpine.DEB.2.20.1711140735020.2332@hadrien>
Message-ID: <e1d8885a-4e3f-a980-00d8-76515d02da17@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> The problem on the Coccinelle side is that it uses a subdirectory with the
> name of the semantic patch to store standard output and standard error for
> the different threads.

It is occasionally good to know such background information.


> I didn't want to use a name with the pid, so that one could easily find
> this information while Coccinelle is running.

Do you mark these data as ?hidden? in the file system?


> Normally the subdirectory is cleaned up when Coccinelle completes,
> so there is only one of them at a time.

I find that this can be insufficient occasionally.


> Maybe it is best to just add the pid.

I imagine that the storage algorithm could become better configurable
besides the parameters ?--temp-files? and ?--tmp-dir?.


> There is the risk that these subdirectories will accumulate if
> Coccinelle crashes in a way such that they don't get cleaned up,

I noticed such a situation a few times.


> but Coccinelle could print a warning if it detects this case,
> rather than failing.

I would appreciate such a software adjustment.


> Still I think it is useful to do something on the make coccicheck side,
> because there is no need for the double layer of parallelism.

Would you like to improve the corresponding documentation in any ways?

Regards,
Markus
