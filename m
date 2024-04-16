Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1393EC4345F
	for <cocci@archiver.kernel.org>; Tue, 16 Apr 2024 12:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Lv4Wq6qu9p1ZBlPnYwsPtJ9DrW7B8a2DGJ+zDiVy+Vo=;
  b=ts8x5kdb4wn9wIYPKi4o3V0qUKq2fegO4GSjfINkIabcb/BgvlOw2jFt
   jkEOllmav+7q8W31nuq/LSljQ5vOOT9V2Xvdtd5yYqLdBsWnDFMH5aJ5c
   sxtgqsW+VM+HauiheqqXpjQDwQjEHCrpOQ900+m4GP5+BPByOcTb70ulf
   w=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.07,206,1708383600"; 
   d="scan'208";a="161851171"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2024 14:14:40 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4DDDCE013D; Tue, 16 Apr 2024 14:14:40 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 32A32E0D64
	for <cocci@sympa.inria.fr>; Tue, 16 Apr 2024 14:14:36 +0200 (CEST)
IronPort-SDR: 661e6bab_a5JsBcrep1CMEGojeEa7FQGax/iq/CNIQHPxORZUnzq9+2w
 JmZa8a1WrQULHbHdyNVuB9E7joKkeP7OYXeDhsg==
X-IPAS-Result: =?us-ascii?q?A0E5AAC9ah5mh07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYJDf1MzBAtIhFaROzCEO4c4h06KR4FAPg8BAwENQQECBAEBAwSEf?=
 =?us-ascii?q?wKIGgIeBwEEMQgOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABA?=
 =?us-ascii?q?QEjFwcOECeFbQ2CZwEQgQ6BJgEBAQEBAQEBAQEBAQEBAQEBARcCR0IBAQECA?=
 =?us-ascii?q?SMdAQERJgEECwsaAiYCAlYGARQBAYJ8gisBAw4jB7N+gTKBAYIKAQEG2lkfL?=
 =?us-ascii?q?CJXgWEJgRouAYgtAYYFgz16Jw+BVUSBFSeDAz6IHoJokGqGcYQghiNUfRwDW?=
 =?us-ascii?q?TIBVRMiCwQMGgIbFA0kIwIpPgMJChACFgMdFAQwEQkLJgMqBjYCEgwGBgZbI?=
 =?us-ascii?q?BYJBCMDCAQDUAMgcBEDBBoECwd1gXyBPQQTRAMQgTIGig8MgX2BDAIFIQQlg?=
 =?us-ascii?q?U4pgSmDCQhDcRWBCAKCfYFgA0QdQAIBC209NQYDCxsGIx2iBifIFTQHgjaBY?=
 =?us-ascii?q?IFhDJ9FBhMvg3KTRg4GkmiYYiCoZYFmATeBXDMaJIM2TwMZD44gGYQUjwkBh?=
 =?us-ascii?q?mpBNTsCBwsBAQMJhUYBAYNagUgBAQ?=
IronPort-PHdr: A9a23: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
 FAiKzrOAb5c3eMISA==
IronPort-Data: A9a23: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
 Yl2x0Ac9SRdDn2kqSj/KxB7bSpaKivm+081
IronPort-HdrOrdr: A9a23:rirY/681tmJ+pAJSjpFuk+AMI+orL9Y04lQ7vn2ZhyYlEPBw5P
 re+MjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: 9a23:HzKov2E7B7S7QHUoqmJq2kBPM80rf0fG73OXGGK1JER2baK8HAo=
X-Talos-MUID: 9a23:TevimAgGTMTEG3hxz0IFhsMpMutU2fWiVU8xqK5FkvuON3RSHAeng2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,206,1708383600"; 
   d="scan'208";a="161851065"
X-MGA-submission: =?us-ascii?q?MDFU01Tc+fmwzbz3w9hj3ihL5wXRgq1NxiXE9V?=
 =?us-ascii?q?hZw9ya4+8andDzriu/Y7Tw4Vn0qctgQ/S4faVLQdVksjHqwyu2NNwURw?=
 =?us-ascii?q?W62Vg6bqJt3jPfFpkT1tpvocy1XeGb5sYRHDDsyt4W7eaKmq0yenq5gh?=
 =?us-ascii?q?i4Cw00oNUQmZcV6CAtslI9Zw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:14:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713269670; x=1713874470; i=markus.elfring@web.de;
	bh=Lv4Wq6qu9p1ZBlPnYwsPtJ9DrW7B8a2DGJ+zDiVy+Vo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DzzFlkEUke+DhEGxPHdIS8e4/ngQIMUtZ8HEZd1HZgFq6/3lNsQorRZX1khJ9Xwt
	 0SGBJYOr+f/Dd3q8G4gJWCI+OR+6jFNWWoWBY1ra4Nv/dN6urer/7z/Tl7epWgF2B
	 uydQzFiYsdAg+egdNjjkO8pYx6Dp55rvzfdB7q91aevhS8/NZnjWfzqjTeBb/I3ba
	 hYVB6vNVLFlruAKhELns3sYA/a4DeEH/JolGvjt4w70i5L2ZvvrA+lqOmxcr/ib3v
	 ii4b9cFFFqJs7GTx1jJ/4eevBEsJUqyL5AVkAxXOaDgakG1uSPihBBHFZSEhQSZYC
	 zC62WaDdQp7G0L76IA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M28WJ-1rullX0mPx-002YIA; Tue, 16
 Apr 2024 14:14:30 +0200
Message-ID: <33a38d7e-26da-46e0-90d4-7137f9ec0c90@web.de>
Date: Tue, 16 Apr 2024 14:14:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <7be66990-de9e-488b-ad6d-fafd1c7bb34c@web.de>
 <ee6022b8-3aeb-4e6e-99f5-2668dd344e0a@web.de> <87plupbm0c.fsf@mail.lhotse>
 <795ca003-4231-45c0-8bb6-178597950fa5@csgroup.eu>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <795ca003-4231-45c0-8bb6-178597950fa5@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hsxChQyFzhPEKKvYCyvy7NgsHW1pjrvs8WruIhj+JKDV7dHWRe0
 I4b/QJ8s8AXfyqEPsqrF3pGy3hn/sZ+YDLWr95BvPAPEz1iabte7Xs9qjteD3zPuY3bU47F
 XW9ujYjwb5Ccas8EWQ2MHwVzl/UnDEYgne3L/Wx1VhSNyLAeOQUpOI803P39hx1YTXPc2OO
 IuN9VbCGqj8aIop4FE3tg==
UI-OutboundReport: notjunk:1;M01:P0:cgnuqKGvJbs=;A9nNALScgBDWwff956u51qJ3ddr
 IwHS8JlxBuV4T5W7RhoUOEBY/k5hzh1H36Nvz681MqMc/Bt7X4y7ROd7hwnkWwz1GlenSxin8
 rETv+oYf/jAVXATFkGSiM92DXMC5jKaPJDdnc0QAL2QhOyJ4YyiWehUfXE5guZ/cgkGjgX62U
 k2ythW+58+lwecDDVYYL5+PxUsPJiLU8Zs5Zh2aJQB+jzsF8gFdbRgVrCh1hWfuEtEbQTTTXe
 JdDTK7oPYgUHPa6WhdQRG8Mjdqft1ZSR+gQRdIU7wBLI7uSaS/R1fXVPh27xpU5B6PwusfQlL
 GPjqUv0xkIuEfnYb3RJJTOqrc8WMxp4DuEAICG+MWlz5U5EwjDl2B050SoMaa0BOZkPybV62K
 VUW1aGirQj9Bh7Tak4lhDw4vZwwG6swjpetwTsa29/9P0vBZTjJ7EWQPtS8GYg06RjMX6SJIi
 3H1arPp0IZvpSMBLt47D6xzFpq6/aJoa3ZZ2vk2BYTkrdnaFJOvU5tN7WUhAJiBbEh0RF7lou
 V4ABevcKcEDkD60OQyW2eLpJL/TuyJ9SFhi4vI7Ftw0gFCjuEmysuw2F/Mfol0zQFpxj4MhOV
 Sbo17qHtgKSZLewLIVsCDPO6VoWmmiLmtQBBKYNZ9/D0RnhX1FKcow29VoZYkecg592P92F3K
 Z6JJ6m/oZ7MGneIspDw8jSKSET8DNH2aJ1fwn/wHTewvizMNI/t3QfTLaIzZgJkds+wyBERZp
 0AuiMSAbgoWWuxOhLSIzt0mvHFE5rX4rCBoBA/rrFgZH6pk+/OJBcSySbwGc3zk4nSkmL1IbS
 vEVhAV0RbpMZDjzbF3ZDBuM5HgpXM1v0IzO0IG189sfSc=
Subject: Re: [cocci] [0/2] powerpc/powernv/vas: Adjustments for two function
 implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1663
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
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/33a38d7e-26da-46e0-90d4-7137f9ec0c90%40web.de>

> This is explicit in Kernel documentation:
>
> /**
>   * kfree - free previously allocated memory
>   * @object: pointer returned by kmalloc() or kmem_cache_alloc()
>   *
>   * If @object is NULL, no operation is performed.
>   */
>
> That's exactly the same behaviour as free() in libc.
>
> So Coccinelle should be fixed if it reports an error for that.

Redundant function calls can occasionally be avoided accordingly,
can't they?

Regards,
Markus
