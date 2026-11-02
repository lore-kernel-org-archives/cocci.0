Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF9C606A331
	for <cocci@archiver.kernel.org>; Sat,  7 Nov 2026 10:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=tvAdyP+Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:date:from:to:cc:in-reply-to:references:
   message-id:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Zo1UgpfExrdSaxdzBucFoa8Yd5E7v5UM/ya82JsqfeA=;
  b=tvAdyP+ZVj/duFenvwnpOoSssS22K5N0/wRvgpNmix+dbS691wHq2rNd
   abL8VJ1Ou/wLZsM3g5iiCqE+zsPcHJ91t91vt2s1rCq0cFMxh2M8N++jz
   xp5c9pNXF7JI7CTQTVLgoOPHiPjn78ry/1OB11ivG+xu2BgNunQEsWWf3
   8=;
X-CSE-ConnectionGUID: VB3Ob3oHS6K96uMHtHAHvw==
X-CSE-MsgGUID: vbTIHoJkS/KcWSa7mwMydQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,200,1787004000"; 
   d="scan'208";a="304323207"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2026 11:59:17 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 1DDAC81753; Sat,  7 Nov 2026 11:59:18 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 58D5F80F2E
	for <cocci@sympa.inria.fr>; Mon,  2 Nov 2026 02:06:04 +0100 (CET)
X-CSE-ConnectionGUID: zHw3I8hnRjq6aTASuX017Q==
X-CSE-MsgGUID: YuWbOGN3S9GCycgqgH8Ezg==
IronPort-SDR: 6ae7e1fb_HhL45MsiqOarVgHyuaA4ZJBHnMtDNlraknnlvdkx1plqccS
 VyJNcyE1SWkHFQF7snc07sr7qM5gmtBO0AQa0Eg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FqAQAQ4edqjxEsKNhaglmCQYFZEjQHCEmNUoh9khiGJ?=
 =?us-ascii?q?oVhgX4PAQMBDVEEAQEBhQQCjh4gBgEEMgcOAQIEAwIDAQEBAQEBAQEBAQELA?=
 =?us-ascii?q?QEBBAEBAQIBAQIEAwEBAQECEAEBAQEBATkFDjuGXIwaAYQAAQEBAzgCPxAEB?=
 =?us-ascii?q?xguVgYTCIJ6gnUDBbxjgTSBAd5JgXQVgTiFcoJtAYp2Qj+BToRAPosJBIIig?=
 =?us-ascii?q?QyBeJUTLCZ4HANZLAEPETUTFwsHBYElQwOBBiNLBS0dgSMhHQ8IER5YGwYFE?=
 =?us-ascii?q?iAqQUNbgRmBB12BKylgAQIfRi0VgXYCglGBI10CAUlBDgdFUwklQxJHJCIIE?=
 =?us-ascii?q?gkBExosC4EaNTwJJkEVDGQLGgUaSAgCCwIMdigREBMdICYwBR0mHQdmPTcVG?=
 =?us-ascii?q?QQCAYE1kXyDDz5RAYIoB6Uza6EPhCmBZ59+LheqcC6HZpB0o2UOhVEBgW4NJ?=
 =?us-ascii?q?oFcTSMVgyJQAxkPjjvSRCYyPQIHAgcOAwuSHIFMAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 QAIeIyPfK13pYMd3yqtl7651Sz1ZA/S8gg=
IronPort-HdrOrdr: A9a23:OnIHRamv9FGysOkOCKqCSjfAkfjpDfI33DAbv31ZSRFFG/Fw8P
 rOoB17726XtN91YhpLpTnuAsm9qB/nmKKdgrNhXotKPjOJhILAFugL0WKI+VLd8kPFmtJg6Q
 ==
X-Talos-CUID: =?us-ascii?q?9a23=3Asmqi/GiPiJbElrElNsuZUsSAjzJuYF3Cl1aAI0m?=
 =?us-ascii?q?CC383QYG8ckKgoPo7qp87?=
X-Talos-MUID: 9a23:IoYzfAlhlWEn5SE40eCkdnpTKfhixIuIU3tcvr4XsMadOgwgFiWS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,190,1787004000"; 
   d="scan'208";a="161433537"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGGWF6w7X23oua0FGVUj8qRWgfvxD6PRG9QXL?=
 =?us-ascii?q?KZKUTkDOCiNE3aFhwImp18Pt2Om+bWYYr4NJ3xVo3a1haX8DoNmNXGsm?=
 =?us-ascii?q?uO5ZZWUOqyI9l0asKhzsjj2FauQjM9l9uV0kL5n17XSke0e0Gf4Qn2GT?=
 =?us-ascii?q?DOfW7pm7kwyDNmEUCfnZfmNA=3D=3D?=
Received: from smtprelay0017.hostedemail.com (HELO relay.hostedemail.com) ([216.40.44.17])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:06:02 +0100
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 4831B80A80;
	Mon,  2 Nov 2026 01:06:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 9932C20027;
	Mon,  2 Nov 2026 01:05:58 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Sun, 01 Nov 2026 17:05:58 -0800
From: Joe Perches <joe@perches.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook <kees@kernel.org>,
 driver-core@lists.linux.dev, Nicolas Palix <nicolas.palix@imag.fr>,
 cocci@inria.fr
In-Reply-To: <1a6026c4-3e19-a1a9-e637-f1842172482b@inria.fr>
References: <9b55b3e3269ef43ede64fff34f42121f7aa47979.camel@perches.com>
 <1a6026c4-3e19-a1a9-e637-f1842172482b@inria.fr>
Message-ID: <2556411d9bf65125cf5c1dfa37eb4454@perches.com>
X-Sender: joe@perches.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 7ihqq8zu4wt8d6sc9oe61qzyiepq3q84
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 9932C20027
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+tSEqHxwg/Cl4Yi9FtrWtASKGJGfOSlM4=
X-HE-Tag: 1793581558-879429
X-HE-Meta: U2FsdGVkX1+hucxXj/E8FjYYuXOJBvbHv6o/KN2yNbo/Y3VW4ETf8+sBjAhSVgjcoGsIuO/mon1vo7oVd2Jq2FSoH475Wdou2uvoSsDfVVS1C86tQ1nJ6Rgq2YV3XelvlEkqjqQjT175PdsfEvZwd0iFuw1o6Q313ni2sgG91rX6RFUMtFvy/zi9pFZVbM5Z/QfUmPX10+sb7d5AayvPi6ENto98Sm9I0ebHQUN4x6JpX7yBH6MWKzU/PHltLT91Q+rT2s6hOfXDsgs6llyRs1zAqztN18GlF0gWLSRXPEtapS8zZuNKk2ZBdSGNITVvQf8F6xVKS6dyMP6wmLhfMQ==
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [resend PATCH] coccinelle: Add devm_kmalloc_objs
 conversion script
Reply-To: Joe Perches <joe@perches.com>
X-Loop: cocci@inria.fr
X-Sequence: 3770
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/bREqHNXOS2-uGhPFf-kl6w>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-01 15:51, Julia Lawall wrote:
> On Sun, 1 Nov 2026, Joe Perches wrote:
> 
>> Like commit bdc5071d7f7b ("coccinelle: Add kmalloc_objs conversion 
>> script")
>> with commit 1c7bbaeed110 ("coccinelle: kmalloc_obj: Remove default 
>> GFP_KERNEL arg")
>> 
>> Finds and converts sized devm_kmalloc-family of allocations into the 
>> typed
>> devm_kmalloc_obj-family of allocations.
> 
> Applied
> 
>> 
>> Signed-off-by: Joe Perches <joe@perches.com>
>> ---
>> 
>> Maybe this might be useful to run and apply just prior to some -rc1
>> 
>> This script would change more than 8000 instances in more than
>> 5000 files in Linus' current master.
>> 
>> $ spatch -D patch --very-quiet --cocci-file 
>> ./scripts/coccinelle/api/devm_kmalloc_objs.cocci \
>>     --include-headers-for-types --all-includes --include-headers 
>> --keep-comments \
>>     -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include 
>> \
>>     -I ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi -I 
>> ./include/uapi \
>>     -I ./include/generated/uapi --include 
>> ./include/linux/compiler-version.h \
>>     --include ./include/linux/kconfig.h .
> 
> I'm not sure that --include-headers-for-types is useful.  That is 
> useful
> when there is an expression metavariable that is required to have a
> particular type.  I don't see that here.  I also got around 5000 
> changes
> in Linus's current master without using that argument.  I didn't try 
> it,
> but I think --no-includes would thus be fine.  --include-headers will 
> get
> the changes in the header files.
> 
> If the --keep comments argument is useful, it could be added to the
> semantic patch, by putting #spatch --keep-comments at the top of the 
> file.

Ok. Whatever is appropriate.

I just copied the command line from the one that applied the commits 
above.
