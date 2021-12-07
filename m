Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB965C433F5
	for <cocci@archiver.kernel.org>; Tue,  7 Dec 2021 06:23:27 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.87,293,1631570400"; 
   d="scan'208";a="8916181"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Dec 2021 07:23:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A0A09E0285; Tue,  7 Dec 2021 07:23:25 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4386DE00D0
	for <cocci@sympa.inria.fr>; Tue,  7 Dec 2021 02:50:25 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=joe@perches.com; spf=None smtp.mailfrom=joe@perches.com; spf=None smtp.helo=postmaster@smtprelay.hostedemail.com
IronPort-PHdr: =?us-ascii?q?A9a23=3AoS37sR2ANxC1rKCRsmDO/AMyDhhOgF0UFjAc5pd?=
 =?us-ascii?q?vsb9SaKPrp82kYBaGo6oxxwSUFazgqNt8w9LMtK7hXWFSqb2gi1slNKJ2ahkel?=
 =?us-ascii?q?M8NlBYhCsPWQWfyLfrtcjBoVJ8aDAwt8H60K1VaF9jjbFPOvHKy8SQSGhLiPgZ?=
 =?us-ascii?q?pO+j5AIHfg9qq2+yo+ZDebApEiTS9bLhvMBi4sALdu9UMj4B/MKgx0BzJonVJe?=
 =?us-ascii?q?+RS22xlIE+Ykgj/6Mmt4pNt6jxctP09+cFOV6X6ZLk4QqdDDDs6KWA15dbkugf?=
 =?us-ascii?q?FQACS+3YTSGQWkh5PAwjY8BH3W4r6vyXmuuZh3iSRINb7Rq4oVzu886hrSQfoi?=
 =?us-ascii?q?CYZOD4/7GHXkdF7gKZCrB68uxBz34vYbYeIP/R8Y6zdZ8sXS2lcUMhRSSJPDIG?=
 =?us-ascii?q?zb4UTAOUPMulWoJLwp0cMoBakGQWgGPnixiJOi3Tr3aM6yeMhEQTe0QIkGNIBr?=
 =?us-ascii?q?mnfos/rO6cITe+1zLfHzS7eZP5R2zf975bHfws5of6SR7J/bcrRxlc0Fw/fklq?=
 =?us-ascii?q?QronlMiqT2+8QvGeV8/BuWvizi247tQ5xuD6vy98oh4TGmo4Yyl/J+CtkzIg1O?=
 =?us-ascii?q?NC1SlJ3bNy4HZdNqyyXN4l7Tt4tTWxmtys0xL4Lt5G5cSUEzJkr2R7RZfObf4W?=
 =?us-ascii?q?W5B/oSeWfIS9giX57Zb6yhgy+/Ee8xuHmWcS530xGojdFn9XUqHwByh3e5tKIR?=
 =?us-ascii?q?/dh5Eus1zWC2xrS5+1YJ00/iLDVJIQ7wrEqk5oeqUTDETHymEXxlKKWbUAk+vS?=
 =?us-ascii?q?w6+T9fLrmooWTNo9uhgH+NaQugdC/DvolPQcQWmiU4+W81Ln58ULlR7VKi+U6k?=
 =?us-ascii?q?qjfsJ/EOcQWvrC1DxJU34o55BuzEy2q3dsXkHUdMV5IeAqLj43zNFHPJPD4A+2?=
 =?us-ascii?q?/g1OpkDpzxfDGOaPuD47VLnfdirfuYbZ95FBHyAYp0d9f4JdUBqkbIP3vQk/xq?=
 =?us-ascii?q?MDYDhghPgyw2enmBs9y1ocaWW+UA66ZMabSvkSS5u01OeWMZYkVuCz8K/c//fL?=
 =?us-ascii?q?ug2U5k0cHfaa1xZsXdGy4HvN+LkqFZnrjnssOEWYRswolTO3qjUWCXiRJa3azW?=
 =?us-ascii?q?aI8/DA7B5i8AYfNXID+yICGiQ69EodbeShjDUqQFnGgI4yHQ/IkbCOUP98knDs?=
 =?us-ascii?q?ZU7SoV44m01eprgCsj/JXL+PT/yweutrF1ZAh4ezDlBg18D1yAOydzmiSQmAyl?=
 =?us-ascii?q?WQNEXt+/r17oEU17l6c2Kx8y6h6CNhS7rVtWxgzMZr0zupgCtm0VBiXOp+CT12?=
 =?us-ascii?q?tQ/2nByswR5Q/2YwgeUF4Tvelg1j70jChA7IO3+iJA5Ec6q/G1Hj8PIB2zHOQh?=
 =?us-ascii?q?/pptEUvXsYabT7uvaV47QWGQteRyy1xeI6yeL4X3CPWsmyEyDjW1Km9eBZ9S67?=
 =?us-ascii?q?FUGtZbUzT/4yRDqLqVLqyEa4qNgJQj86FMbdHZtDshFRCAvzkPYaGC18=3D?=
IronPort-Data: =?us-ascii?q?A9a23=3AxLIjVavhc87FO4D+/Ymus9fE3OfnVC5fMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3zjcYXjrQO/iDZTbyfNp2bouw9k5VvpLTyYU3GgNtpSlEQiMRo?=
 =?us-ascii?q?6IpJ/zJdxaqZ3v6wu7rFR88sZ1GMrEsFC2FJ5Pljk/F3oPJ8D8sislkepKmULS?=
 =?us-ascii?q?dY3opGlc9IMscoUsLd9AR0tYAbeeRWFvlVePa+6UzCXf9s9JGGjp8B5Gr9HuDi?=
 =?us-ascii?q?M/PVAYw5TTSUxzkUGj2zBH5BLpHTU24wuCRroN8RoZWTM6bpF21E/+wwvsjNj+?=
 =?us-ascii?q?luu6TnkwiWbvOJRKDjnNHHailmQRPqiE326c/cvEbbC+7iR3Txo43lI0L6cD2E?=
 =?us-ascii?q?FpB0q7kwIzxVzFaFCxWJaBc87/KOj60tsn7I0juIyu9nqg/VCnaOqVEobgtXzA?=
 =?us-ascii?q?mGeYjADQEcRmHg8qkwbexUOAqh8I5LcCtMpl3knpnxjrYJe03RIjKBaTM/95Rm?=
 =?us-ascii?q?jkq7v2it97KP59CL2d7NUGYJUVbYAJPTshjwrm83SynNWBM9we8u4wc5k7/zCh?=
 =?us-ascii?q?Q2Z7WK9bpYPqeHJ0AxgLAsgoq5EziBw0CLtGbwCvdqivxwO/Ihj/2VI8XHby8s?=
 =?us-ascii?q?PVthTWuKqUoIEV+fTOGTTOR0yZSmu6zKnD4PgI1qLQq7kGvR8i7XxqjvHOIsxs?=
 =?us-ascii?q?VWt4WGOo/gO1I4sI4/C7BblXojBYYADDliCPybSQnzFSJksivDjtq2FFQYRpx6?=
 =?us-ascii?q?Z/MxQ5f+kEpwasqfSIeRgsI+J/op4RbYtfnJjp8OPbds+AZ0g0cD9xHQObSSln?=
 =?us-ascii?q?TYQM2O32HwG36?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ApKXCTqCJ3rOeTRDlHekh55DYdb4zR+YMi2TD?=
 =?us-ascii?q?GXoRdfUzSL3/qynOpoV/6faaslYssR0b9uxofZPwIk80lqQFhrX5X43OYOCOgg?=
 =?us-ascii?q?LBR+tfBMnZsl/d8kbFmtK1u50PT0EzMqyVMXFKyefXpDSxHb8bsaa62ZHtvv3G?=
 =?us-ascii?q?x3NhCTl3Z71tqyd1YzzraXFedU18H4MwEJfZ3MZduDa6EE5nFviTNz0+U/LYp9?=
 =?us-ascii?q?vN0LLKCCR2eyIP2U21gSmz6Lj8VzyRxRUTSFp0sMofGHb+4nXEz5Tmieyy11vn?=
 =?us-ascii?q?12HV54lLg9eJ8Ko4OPCx?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BIAAB8vK5hhw8sKNhaHAEBAQEBAQcBA?=
 =?us-ascii?q?RIBAQQEAQFAgUgEAQELAYN6KBIxjUqHKGuBQJx9CwEDAQ1BBAEBhQUCgxceBgY?=
 =?us-ascii?q?zBg4BAgQVAQEFAQEBAgEDAwQBEwEBAQENCw4IKQEKIoV1gjUpAYNkAQIDJ1IQC?=
 =?us-ascii?q?w4KHBJXBgESgnGDGAWwAYEBMoEBiBaBY4E6AYophAhDP4FOhA8wPopCBJRBMgp?=
 =?us-ascii?q?SkhuOfQFgnViDSoE6nhCnQZYnH6YiAYF2gX5NIxWDJFEZD445Ho46IDM4AgYLA?=
 =?us-ascii?q?QEDCY4ZAQE?=
X-IPAS-Result: =?us-ascii?q?A0BIAAB8vK5hhw8sKNhaHAEBAQEBAQcBARIBAQQEAQFAgUg?=
 =?us-ascii?q?EAQELAYN6KBIxjUqHKGuBQJx9CwEDAQ1BBAEBhQUCgxceBgYzBg4BAgQVAQEFA?=
 =?us-ascii?q?QEBAgEDAwQBEwEBAQENCw4IKQEKIoV1gjUpAYNkAQIDJ1IQCw4KHBJXBgESgnG?=
 =?us-ascii?q?DGAWwAYEBMoEBiBaBY4E6AYophAhDP4FOhA8wPopCBJRBMgpSkhuOfQFgnViDS?=
 =?us-ascii?q?oE6nhCnQZYnH6YiAYF2gX5NIxWDJFEZD445Ho46IDM4AgYLAQEDCY4ZAQE?=
X-IronPort-AV: E=Sophos;i="5.87,293,1631570400"; 
   d="scan'208";a="8895590"
X-MGA-submission: =?us-ascii?q?MDEYrYqorbzlzgqHbsJ+iFBUwrQCvrl7D1w6yP?=
 =?us-ascii?q?hIewFNxHCVfsFtrRrZuuf97cjw+olSPIDSWM/+mfsURem/u4ZAvUY6A0?=
 =?us-ascii?q?zXZ1tV/WVOFM172oKGWCzyolSTgS3uuigZpTv9BbwtvRLb1A7oaE/CMP?=
 =?us-ascii?q?/j82TdgHH3McIHKNbN2SxLgQ=3D=3D?=
Received: from smtprelay0015.hostedemail.com (HELO smtprelay.hostedemail.com) ([216.40.44.15])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 02:50:25 +0100
Received: from omf19.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
	by smtprelay05.hostedemail.com (Postfix) with ESMTP id 38CD118132D08;
	Tue,  7 Dec 2021 01:50:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 0073F20033;
	Tue,  7 Dec 2021 01:50:19 +0000 (UTC)
Message-ID: <80e800b505adf8a26b2ed9898d03516263a830a7.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Andrew Morton <akpm@linux-foundation.org>, Xiaoming Ni
 <nixiaoming@huawei.com>, Julia Lawall <Julia.Lawall@inria.fr>,
 cocci@inria.fr
Cc: linux-kernel@vger.kernel.org, mcgrof@kernel.org,
 viro@zeniv.linux.org.uk,  ebiederm@xmission.com, keescook@chromium.org,
 jlayton@kernel.org,  bfields@fieldses.org, yzaikin@google.com,
 wangle6@huawei.com
Date: Mon, 06 Dec 2021 17:50:19 -0800
In-Reply-To: <20211206173842.72c76379adbf8005bfa66e26@linux-foundation.org>
References: <20211207011320.100102-1-nixiaoming@huawei.com>
	 <20211206173842.72c76379adbf8005bfa66e26@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 0073F20033
X-Stat-Signature: eugaf6p34atyjwnhapyor8dt4d1wdy83
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/vZ1xREZaK8aQe4h87FYXZfPC75uLdtD4=
X-HE-Tag: 1638841819-30
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] sysctl: Add a group of macro functions to
 initcall the sysctl table of each feature
Reply-To: Joe Perches <joe@perches.com>
X-Loop: cocci@inria.fr
X-Sequence: 109
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-12/80e800b505adf8a26b2ed9898d03516263a830a7.camel%40perches.com>

On Mon, 2021-12-06 at 17:38 -0800, Andrew Morton wrote:
> On Tue, 7 Dec 2021 09:13:20 +0800 Xiaoming Ni <nixiaoming@huawei.com> wrote:
> 
> > To avoid duplicated code, add a set of macro functions to initialize the
> > sysctl table for each feature.
> > 
> > The system initialization process is as follows:
> > 
> > 	start_kernel () {
> > 		...
> > 		/* init proc and sysctl base,
> > 		 * proc_root_init()-->proc_sys_init()-->sysctl_init_bases()
> > 		 */
> > 		proc_root_init(); /* init proc and sysctl base */
> > 		...
> > 		arch_call_rest_init();
> > 	}
> > 
> > 	arch_call_rest_init()-->rest_init()-->kernel_init()
> > 	kernel_init() {
> > 		...
> > 		kernel_init_freeable(); /* do all initcalls */
> > 		...
> > 		do_sysctl_args(); /* Process the sysctl parameter: sysctl.*= */
> > 	}
> > 
> > 	kernel_init_freeable()--->do_basic_setup()-->do_initcalls()
> > 	do_initcalls() {
> > 		for (level = 0; level < ARRAY_SIZE(initcall_levels) - 1; level++) {
> > 			do_initcall_level
> > 	}
> > 
> > The sysctl interface of each subfeature should be registered after
> > sysctl_init_bases() and before do_sysctl_args(). It seems that the sysctl
> > interface does not depend on initcall_levels. To prevent the sysctl
> > interface from being initialized before the feature itself. The
> > lowest-level late_initcall() is used as the common sysctl interface
> > registration level.
> 
> I'm not normally a fan of wrapping commonly-used code sequences into
> magical macros, but this one does seem to make sense.
> 
> I wonder if it is possible to cook up a checkpatch rule to tell people
> to henceforth use the magic macros rather than to open-code things in
> the old way.  Sounds hard.

Almost impossible for checkpatch.
Likely easier in coccinelle.


