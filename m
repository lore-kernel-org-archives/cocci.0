From: jacob.e.keller@intel.com (Keller, Jacob E)
Date: Wed, 23 Mar 2016 22:40:38 +0000
Subject: [Cocci] spatch temporary files issues
Message-ID: <02874ECE860811409154E81DA85FBB58579FCC13@ORSMSX115.amr.corp.intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I am using coccinelle for a project, and have run into an issue regarding the temporary director created by spatch when it runs on a given cocci file.

Fatal error: exception Failure("Directory memcpy-assign used for temporary files already exists and should be removed.")

This occurs because I run in parallel, the same cocci script in the same directory against different sets of files.

Does there exist an option to control where the temporary files are located?

Thanks,
Jake
