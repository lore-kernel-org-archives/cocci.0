From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 24 Mar 2016 11:35:45 +0100
Subject: [Cocci] spatch temporary files issues
In-Reply-To: <02874ECE860811409154E81DA85FBB58579FCC13@ORSMSX115.amr.corp.intel.com>
References: <02874ECE860811409154E81DA85FBB58579FCC13@ORSMSX115.amr.corp.intel.com>
Message-ID: <56F3C301.8000000@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I am using coccinelle for a project, and have run into an issue regarding the temporary director created by spatch when it runs on a given cocci file.
> 
> Fatal error: exception Failure("Directory memcpy-assign used for temporary files already exists and should be removed.")
> 
> This occurs because I run in parallel, the same cocci script in the same directory against different sets of files.

How do you think about to circumvent this issue by creating another
temporary directory for your source code transformation tasks explicitly?
Do you need to fiddle also with symbolic links for your SmPL scripts?

Regards,
Markus
