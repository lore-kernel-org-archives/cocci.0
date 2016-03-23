From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 23 Mar 2016 23:47:24 +0100 (CET)
Subject: [Cocci] spatch temporary files issues
In-Reply-To: <02874ECE860811409154E81DA85FBB58579FCC13@ORSMSX115.amr.corp.intel.com>
References: <02874ECE860811409154E81DA85FBB58579FCC13@ORSMSX115.amr.corp.intel.com>
Message-ID: <alpine.DEB.2.02.1603232346280.2076@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 23 Mar 2016, Keller, Jacob E wrote:

> Hi,
> 
> I am using coccinelle for a project, and have run into an issue regarding the temporary director created by spatch when it runs on a given cocci file.
> 
> Fatal error: exception Failure("Directory memcpy-assign used for temporary files already exists and should be removed.")
> 
> This occurs because I run in parallel, the same cocci script in the same directory against different sets of files.
> 
> Does there exist an option to control where the temporary files are located?

No, currently it's just determined by the file name.  Could you invoke 
your semantic patch from different places?

In any case, this could be improved, but I can't do it immediately.

julia
