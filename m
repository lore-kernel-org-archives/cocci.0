Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CD5C433EF
	for <cocci@archiver.kernel.org>; Thu,  9 Dec 2021 06:17:23 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,191,1635199200"; 
   d="scan'208";a="9581446"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Dec 2021 07:17:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4B5C7E034E; Thu,  9 Dec 2021 07:17:21 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C09D8E00D0
	for <cocci@sympa.inria.fr>; Tue,  7 Dec 2021 07:25:20 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=nixiaoming@huawei.com; spf=Pass smtp.mailfrom=nixiaoming@huawei.com; spf=None smtp.helo=postmaster@szxga02-in.huawei.com
IronPort-PHdr: =?us-ascii?q?A9a23=3Ai4wF4RT4ruxrmh/zA/97ncAH7dpsopCYAWYlg6H?=
 =?us-ascii?q?Pa5pwe6iut67vIFbYra00ygOTBMOEt7kV06L/iOPJYSQ4+5GPsXQPItRndiQur?=
 =?us-ascii?q?oEopTEmG9OPEkbhLfTnPGQQFcVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZ?=
 =?us-ascii?q?vJuTyB4Xek9m72/q99pHNfglEnjiwbLx9IBiysQnaq9Ubj5ZlJqst0BXCv2FGe?=
 =?us-ascii?q?/5RxWNmJFKTmwjz68Kt95N98Cpepuws+ddYXar1Y6o3Q7pYDC87M28u/83kqQP?=
 =?us-ascii?q?DTQqU6XQCVGgdjwdFDBLE7BH+WZfxrzf6u+9g0ySUIcH6UbY5Uim54qx1VBHnl?=
 =?us-ascii?q?jsINz8h8GHWlMNwir5boAm8rBB72oLYfZ2ZOOZ7cq7bYNgUR3dOXtxJWiJcHI2?=
 =?us-ascii?q?8YYsBAekPM+lWoIbypUcBoxS/BQS3GOPiyCVFimPq0aA0z+osFxzN0gw6H9IJt?=
 =?us-ascii?q?XTZtNT6NKYIXuCyyanIzDPDb/xL0jnl6YjDbxcsofeNXbN/cMre004vFwbEjlW?=
 =?us-ascii?q?WpozoJDOV1vkXvGmV8eVgVPijhHIgqwF0uzWiwNonhYbViIwP0F/E6Tl5z5gvJ?=
 =?us-ascii?q?d2+UEN3fdGqHYZNuyyYNIZ7X8cvTmBntSs0xLMIuZG1cSYWxZkoxxPSafOKfoi?=
 =?us-ascii?q?G7B7/UOucPDV1iXJ5dL6hgxu88Uytx+vhXce3yFZHtiVIn9nWunwT2BHe7tKLR?=
 =?us-ascii?q?uVg8ku/wzqDygPe5+JcLUwpiabXMZ8sz7wqmpYOrUjPADX6lFjygaKUcEgv5/K?=
 =?us-ascii?q?m5P79Yrr8o5+RL490hR/6MqQpgsG/GuU5MwcBX2eB5eiwyqTv/Uz/QLlQjv02j?=
 =?us-ascii?q?7PWsZ7EKsQavKK2HwhV0oM75xa+CTepzsgYkGEIIV9FYh6LkYfkNlXULPzmEPu?=
 =?us-ascii?q?znU6gnCpoyv3FJrHhB4/CLnnHkLfvZ7Z97EtcxRI1zdBe6JNUC6sOIPX2Wk/ws?=
 =?us-ascii?q?tzYAQQ0Mwypw+n9BtRyyIIeVXiTDa+eNaPeqUWI6f43I+mQeI8Vvy7wK/w/6P/?=
 =?us-ascii?q?gl3A5nVsdcLKo3JsWbXC3Be5mLF+DbXrthNcBC2YKsRAkQOzkkl2ISSRTaGqqX?=
 =?us-ascii?q?6Ig+jE7D5qrApvERo+xnLOB3Ty2HoZWZ2BDElCDC23kd4SCW/cWaSKdONVtkjI?=
 =?us-ascii?q?eVevpd4h09xaj/Df30bFnI/Gcri8fuLr72cJ+5+DI0xo18GowR+2b33uAUClRm?=
 =?us-ascii?q?XkUQDl+iKl8uUlVzlaFzLg9jftFE9Ba+/JOVEE9L5GKi6RYFtTzU0rld8iATFL?=
 =?us-ascii?q?uFve7BTA4CPY43NYKZ258Hc+jh1bNxXzuS+sekLeABbQ19Ljd1j7/PZAu5WzB0?=
 =?us-ascii?q?fwRjlAhR8pJOiWAh+Yr8QnDBofOlkSfmI6qaK0D0S+L/2CGmznd9HpEWRJ9BP2?=
 =?us-ascii?q?WFUsUYVHb+JGgvhuqp1CGCakuLQZAj8WFL/kTAjUIpU5UVPjqYI6bYmT3m3q5G?=
 =?us-ascii?q?huJgLiLadiyE4349CXAAVcJkkYY+nPUbWAD?=
IronPort-Data: =?us-ascii?q?A9a23=3A7EbvOqhXX0C5xItWX2p9k+0RX161EhEKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkVWzzNMXGCEM6uLYGTzeoh1adm+8xkHucCBx4VrSldl+VhgHilAw?=
 =?us-ascii?q?SbnLYTAfx2oZ0t+DeWaERk5t51GAjX4wXFdokb0/n9BCZC86ykjvU20buCkUre?=
 =?us-ascii?q?dYHguHVYMpBoJ0HqPpcZp2uaEvvDiW2thifuqyyHuEAfNNwxcagr42IrfwP9bh?=
 =?us-ascii?q?8kejRtD1rAIiV+ni3eF/5UdJMp3yahctBIUSKEMdgKxb76rIL1UYgrkExkR5tO?=
 =?us-ascii?q?Nyt4Xc2URUK7dNFDUz3tQHai/iwdPp2o51aNT2Pg0NRoR0WnY2YookpMU5czYp?=
 =?us-ascii?q?QQBZsUgnMwbUglZGiZ7PKtJ0L/aKGeysIqYyEiun37Ek6Q3UhpmZeX0/c4tXD0?=
 =?us-ascii?q?Sq6VJQNwXVTiHjv2/xLaTWOhpjN4qasjtJoIW/H96pRnSCv0tQLjYUqDS7JlZ2?=
 =?us-ascii?q?i0xj4ZAB57ji2AxfWI6N1Kdd0QaYhFPHMhrxKHy2yehZ2YN8BTIsfViynb35wl?=
 =?us-ascii?q?X/LjJEdPzRsasUZwNyx/c/HauE3/RGQMKO9XHk3+E9DSsm+bQkCK9U4UXfIBUP?=
 =?us-ascii?q?8VC2DW7rlH/wjVPPbd6nRW4tqJ6c8lNO0MdonBrrK509FGiUdT8GRa/pRZoezZ?=
 =?us-ascii?q?0t8V4S4UHBMOlk8I4IDp1wkAEUzdeZd1gv8gzLdDv/kHchMvnXFSDr5XMIU9wN?=
 =?us-ascii?q?d6oQfeaOTUcMmIDIyQDSGPpJvGLTJ4b1nryczqoLEJ5YhAZ1909L/BmYRXSX4k?=
 =?us-ascii?q?usPM=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AT2+c1KBpK9hvZIPlHely55DYdb4zR+YMi2TD?=
 =?us-ascii?q?sHoBMCC9E/bo7/xG+c5w6faaskd3ZJhNo6HjBECrexLhHOdOj7X5Xo3SPzUOxl?=
 =?us-ascii?q?HEEGgK1+KLqAEIfReOktK1vp0QFZSWZueAaGRSvILU7AW0GN4rwp2m/cmT5dv2?=
 =?us-ascii?q?/jNXbkVAY7xr7m5CZTqzIwlMZ01tAYNRLvah2vY=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BLAAA0/a5hh7zU+S1aHAEBAQEBAQcBA?=
 =?us-ascii?q?RIBAQQEAQGCBQcBAQsBgyNWAQEBODELhDyII4hwA5xBgXwLAQMBDAEtFAQBAYF?=
 =?us-ascii?q?vgxYCgxYCHQcBBDAJDgECBBUBAQUBAQECAQMDBAETAQEBAQsNDgg0IoVoDYI1K?=
 =?us-ascii?q?QGDZAECAycRKBkQCxgEKAJXBgEMAQUCAQGCbQGDF5NTnAUJfTKBAYRqhQ+BDC4?=
 =?us-ascii?q?BiimECCccgg2BFSeCUzA+h1mCaQSRdoJKMgpSkhuDKItWXp1aFYM1g3+GXpQmB?=
 =?us-ascii?q?g8FLYU5kFCROJYnH5gCjXcCBAIEBQIWgWGCFHCDOQlIFwIPjjkeiH2FKTQBAQE?=
 =?us-ascii?q?wOAIGCwEBAwmNCYEQAQE?=
X-IPAS-Result: =?us-ascii?q?A0BLAAA0/a5hh7zU+S1aHAEBAQEBAQcBARIBAQQEAQGCBQc?=
 =?us-ascii?q?BAQsBgyNWAQEBODELhDyII4hwA5xBgXwLAQMBDAEtFAQBAYFvgxYCgxYCHQcBB?=
 =?us-ascii?q?DAJDgECBBUBAQUBAQECAQMDBAETAQEBAQsNDgg0IoVoDYI1KQGDZAECAycRKBk?=
 =?us-ascii?q?QCxgEKAJXBgEMAQUCAQGCbQGDF5NTnAUJfTKBAYRqhQ+BDC4BiimECCccgg2BF?=
 =?us-ascii?q?SeCUzA+h1mCaQSRdoJKMgpSkhuDKItWXp1aFYM1g3+GXpQmBg8FLYU5kFCROJY?=
 =?us-ascii?q?nH5gCjXcCBAIEBQIWgWGCFHCDOQlIFwIPjjkeiH2FKTQBAQEwOAIGCwEBAwmNC?=
 =?us-ascii?q?YEQAQE?=
X-IronPort-AV: E=Sophos;i="5.87,293,1631570400"; 
   d="scan'208";a="8916380"
X-MGA-submission: =?us-ascii?q?MDFu7EJtv+KBZ/aRm0RdgbXLHRgsi6vUXyDYyR?=
 =?us-ascii?q?uN8Vz0w+T+StLE57p6hklVgGmpfl01GocMQ9n/7AMJA1zl/8Jtxa9R4r?=
 =?us-ascii?q?4Sj5A2x77at7MPpjQqvvgxo5Ihu2s1BSty9QKEFi5Nb8GrrjoXlJZv56?=
 =?us-ascii?q?h49TMT+NGOts/wrZHNH8qkTQ=3D=3D?=
Received: from szxga02-in.huawei.com ([45.249.212.188])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 07:25:19 +0100
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J7Vdq4QmGzQjD0;
	Tue,  7 Dec 2021 14:25:03 +0800 (CST)
Received: from [10.67.102.197] (10.67.102.197) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 14:25:15 +0800
To: Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>,
	Julia Lawall <Julia.Lawall@inria.fr>, <cocci@inria.fr>
CC: <linux-kernel@vger.kernel.org>, <mcgrof@kernel.org>,
	<viro@zeniv.linux.org.uk>, <ebiederm@xmission.com>, <keescook@chromium.org>,
	<jlayton@kernel.org>, <bfields@fieldses.org>, <yzaikin@google.com>,
	<wangle6@huawei.com>
References: <20211207011320.100102-1-nixiaoming@huawei.com>
 <20211206173842.72c76379adbf8005bfa66e26@linux-foundation.org>
 <80e800b505adf8a26b2ed9898d03516263a830a7.camel@perches.com>
From: Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <ce96717e-3f18-bf9e-90e2-a482be33a488@huawei.com>
Date: Tue, 7 Dec 2021 14:25:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <80e800b505adf8a26b2ed9898d03516263a830a7.camel@perches.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] sysctl: Add a group of macro functions to
 initcall the sysctl table of each feature
Reply-To: Xiaoming Ni <nixiaoming@huawei.com>
X-Loop: cocci@inria.fr
X-Sequence: 111
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-12/ce96717e-3f18-bf9e-90e2-a482be33a488%40huawei.com>

On 2021/12/7 9:50, Joe Perches wrote:
> On Mon, 2021-12-06 at 17:38 -0800, Andrew Morton wrote:
>> On Tue, 7 Dec 2021 09:13:20 +0800 Xiaoming Ni <nixiaoming@huawei.com> wrote:
>>
>>> To avoid duplicated code, add a set of macro functions to initialize the
>>> sysctl table for each feature.
>>>
>>> The system initialization process is as follows:
>>>
>>> 	start_kernel () {
>>> 		...
>>> 		/* init proc and sysctl base,
>>> 		 * proc_root_init()-->proc_sys_init()-->sysctl_init_bases()
>>> 		 */
>>> 		proc_root_init(); /* init proc and sysctl base */
>>> 		...
>>> 		arch_call_rest_init();
>>> 	}
>>>
>>> 	arch_call_rest_init()-->rest_init()-->kernel_init()
>>> 	kernel_init() {
>>> 		...
>>> 		kernel_init_freeable(); /* do all initcalls */
>>> 		...
>>> 		do_sysctl_args(); /* Process the sysctl parameter: sysctl.*= */
>>> 	}
>>>
>>> 	kernel_init_freeable()--->do_basic_setup()-->do_initcalls()
>>> 	do_initcalls() {
>>> 		for (level = 0; level < ARRAY_SIZE(initcall_levels) - 1; level++) {
>>> 			do_initcall_level
>>> 	}
>>>
>>> The sysctl interface of each subfeature should be registered after
>>> sysctl_init_bases() and before do_sysctl_args(). It seems that the sysctl
>>> interface does not depend on initcall_levels. To prevent the sysctl
>>> interface from being initialized before the feature itself. The
>>> lowest-level late_initcall() is used as the common sysctl interface
>>> registration level.
>>
>> I'm not normally a fan of wrapping commonly-used code sequences into
>> magical macros, but this one does seem to make sense.
>>
>> I wonder if it is possible to cook up a checkpatch rule to tell people
>> to henceforth use the magic macros rather than to open-code things in
>> the old way.  Sounds hard.
> 
> Almost impossible for checkpatch.
> Likely easier in coccinelle.
>

Maybe we can add a rudimentary check to the checkpatch.

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b01c36a15d9d..26e953ae4cc5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7212,6 +7212,12 @@ sub process {
                              "Deprecated use of '$deprecated_api', 
prefer '$new_api' instead\n" . $herecurr);
                 }

+# check register_sysctl_init
+               if ($prevline =~ /{/ && $rawline =~ 
/\sregister_sysctl_init\(\"(kernel|fs|vm|debug|dev)\",\s+(.*)\)\;/) {
+                       WARN("DEPRECATED_API",
+                            "Deprecated use of 
'register_sysctl_init(\"$1\", $2);', prefer '$1_sysctl_initcall($2);' 
instead\n".$herecurr);
+               }
+
  # check for various structs that are normally const (ops, kgdb, 
device_tree)
  # and avoid what seem like struct definitions 'struct foo {'
                 if (defined($const_structs) &&



Thanks
Xiaoming Ni
