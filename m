From: peter.senna@gmail.com (Peter Senna Tschudin)
Date: Fri, 9 Nov 2012 12:12:52 +0100
Subject: [Cocci] [Review needed] Ensure that calls to d_find_alias() are
 followed by dput().
In-Reply-To: <509C118D.3010109@gmail.com>
References: <509B0B81.50304@gmail.com>
 <alpine.DEB.2.02.1211080820540.1945@localhost6.localdomain6>
 <509C118D.3010109@gmail.com>
Message-ID: <CA+MoWDqOY+7eiVHiAYHYa+BDiF=1JXLLvqSySQFaOi-s9YCMKA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Cyril,

I found the same 2 matches using your V1 script, but the second looks
as a false positive. It tries to fix the code fixed by the patch:

http://permalink.gmane.org/gmane.linux.kernel.commits.head/348204

See:

[peter at ace linux-next]$ make coccicheck MODE=org

Please check for false positives in the output before submitting a patch.
When using "patch" mode, carefully review the patch before submitting it.

Processing d_find_alias.cocci
with option(s) ""

Message example to submit a patch:
 The semantic patch that makes this Org report is available
 in scripts/coccinelle/d_find_alias.cocci.

 More information about semantic patching is available at
 http://coccinelle.lip6.fr/

warning: rule starting on line 106: inherited metavariable dent not
used in the -, +, or context code
* TODO [[view:/home/peter/devel/git/ksfc/kernels/linux-next/drivers/iommu/tegra-smmu.c::face=ovl-face1::linb=1039::colb=1::cole=5][Missing
call to dput() at line 1056.]]
* TODO [[view:/home/peter/devel/git/ksfc/kernels/linux-next/fs/ceph/export.c::face=ovl-face1::linb=59::colb=16::cole=22][Missing
call to dput() at line 64.]]

[]'s

Peter

On Thu, Nov 8, 2012 at 9:09 PM, Cyril Roelandt <tipecaml@gmail.com> wrote:
> On 11/08/2012 08:21 AM, Julia Lawall wrote:
>>
>> How many cases do you find?
>>
>
> Well, only 2 cases (in drivers/iommu/tegra-smmu.c and fs/ceph/export.c).
> It's worth noticing that the d_find_alias() function is only called 20 times
> though, so this seems to be quite a common mistake.
>
> I attached an updated semantic patch, to deal with cases where the dentry is
> assigned a new value and dput() has not been called.
>
>
> WBR,
> Cyril Roelandt.
>
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>



--
Peter
