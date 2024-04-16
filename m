Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D5EC4345F
	for <cocci@archiver.kernel.org>; Tue, 16 Apr 2024 12:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=sw6GZmEfJHOtxMwjc0tAhb+KXK5KwEfpIepkP/GZl2g=;
  b=WqS6Z+Jp+4owp+9fuQdw8zTWmjUv53oGle5b6KtQ4bPCRE9yTmPaaI9W
   tgQdu8VdW3j5ze55x2/iwCOC/sZn9EYY4FmpcsyGHgR36gboIxyI96Hgc
   ssB3f69647hcDvuUpMewh5lT6mIElasj86fzPbzhMWAOpoo8Jy7PdMR4W
   c=;
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
   d="scan'208";a="161848970"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2024 14:04:53 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4AD45E013D; Tue, 16 Apr 2024 14:04:53 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 531A7E0035
	for <cocci@sympa.inria.fr>; Tue, 16 Apr 2024 14:04:47 +0200 (CEST)
IronPort-SDR: 661e695e_lb//NaDR3nqII6lxuF+kbjnzFXEHrqxCqPBn/TYH/fP6R6q
 Dznl2Cxk1wWGWLDGOtvn1GHIkYke29Of6n0dpXw==
X-IPAS-Result: =?us-ascii?q?A0E7AQDMZx5mhwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYJDfANTMwQLSIRWkTstA4Q7jwaIcYMWPg8BAwENPQQBAgQBAQMEh?=
 =?us-ascii?q?DlGAogaAh4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AEBASMTBAcOECeFbQ2CZwEQgQ6BJgEBAQEBAQEBAQEBAQEBAQEBARcCDTpCA?=
 =?us-ascii?q?QEBAgEdBh0BAREZCgMBDwsODAImAgJWBgESAgEBgnwBgioBAw4jBw2zc4Eyg?=
 =?us-ascii?q?QGCCgEBBtpZHywiV4FhAwaBGi4BiC0BhXyDRnonD4FVRIEVJ4MDPoJKFwQYg?=
 =?us-ascii?q?UaDW4JokGqGcS+DcYYjVH0cA1kyAVUTIgsEDBoCGxQNJCMCKT4DCQoQAhYDH?=
 =?us-ascii?q?RQEMBEJCyYDKgY2AhIMBgYGWyAWCQQjAwgEA1ADIHARAwQaBAsHdYF8gT0EE?=
 =?us-ascii?q?0QDEIEyBooPDIF9gQwCBSEpgU4pgSmDCQhDcRWBCAKCfYFgA0QdQAIBC209N?=
 =?us-ascii?q?QYDCxsGIx2eCQGCFIFoP0aBB5NbHZMznwU0B4I2gWCBYQyKIZUkBhMvlzgOB?=
 =?us-ascii?q?pJomGIgi12Bd5sRgXokgVwzGiSDAgEBMk8DGQ+OIBmEFIRhkQpBNQIBATcCB?=
 =?us-ascii?q?wEKAQEDCYVGAQGDWoFIAQE?=
IronPort-PHdr: A9a23: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
 kFucjvJFeo5sg==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:9JGhaqom9V4lM0FQSYHeicwaV5r/eYIsimQD101hICG9vPbo9f
 xG785rsSMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaGSS5vyb3ODXKadC/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: =?us-ascii?q?9a23=3AawqXCmuR07+zyJVNPeeb6Quk6Is5eEWF7EncGnO?=
 =?us-ascii?q?YEF52Q5a6FmKL25Ndxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ALRXhpwyIXIzUyj7IW7DFzj8X2meaqI+fT1hTkrg?=
 =?us-ascii?q?Wh/WFLBJ/HAue0zGTXqZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,206,1708383600"; 
   d="scan'208";a="161848952"
X-MGA-submission: =?us-ascii?q?MDGHXSlmCz4ZVFuGaW8+yEglezeATv5iKO6NF0?=
 =?us-ascii?q?yKCqJqUByeF3j62apTcD52YAmvrLgsJteX2ac7gGAji5DdszlktWcJEX?=
 =?us-ascii?q?2+u4xz1vsGtqjSte9isfQdXu3ewGwnAIEUPuSZsCrfPTzMJkCmMv1TIH?=
 =?us-ascii?q?qfWCnv5PW75So0vvUPByWF1g=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:04:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713269081; x=1713873881; i=markus.elfring@web.de;
	bh=sw6GZmEfJHOtxMwjc0tAhb+KXK5KwEfpIepkP/GZl2g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=u3473ZzDDh+t+me2dt3F26eXQEJbXRMHgJIvA1x0hmPmrMaXX71ZZhD9cCNTr7Qv
	 SOws0lVeGYrFZMK69g+te0jPbWW7IyucPnCt1HHn3XAwR7CKbUcLj3nhaaBfwG8P1
	 fBaHtU/3CRJnGy8MFDNagvL7Eh9ut9NLLD0zvhyD9wlIJbcJmYb6id4an6a0fbHIZ
	 YMG0uA3goAupPaBlR+mpwC24ranx+557ADZWd/Tlbg8wtmReF+O0A/mF2G5THQbLR
	 OYFavdpt55nvuHgn+T9lvG/6m7GkdK5mFfNei4JhSRq2iiLfk252qggUgYH+3klZ9
	 Q5RkD631nk1w6rNkmQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFaui-1rxESE3P82-00H38p; Tue, 16
 Apr 2024 14:04:40 +0200
Message-ID: <d3818747-cb02-409f-99a0-7e8c1338b859@web.de>
Date: Tue, 16 Apr 2024 14:04:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <7be66990-de9e-488b-ad6d-fafd1c7bb34c@web.de>
 <ee6022b8-3aeb-4e6e-99f5-2668dd344e0a@web.de> <87plupbm0c.fsf@mail.lhotse>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <87plupbm0c.fsf@mail.lhotse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zKTayE+y3pYrRCZmB87Ixt/657oQ3H2YB0/2sGYhXb1MTtV8tUe
 /Ie+mZa7KKHvaoOkIUKwfc6FAzADz0rFlB5qsj3hUrVYvoigUOWDTZoWRRVyYoMTf8Z8Xed
 dOdN4nUMvdSGDJpS1cuy9DRYnuL237JWBZD1/wbwZoPnfILPLxJQ1hDa9dB3tLMeuG7A4Aq
 bOyXnIhDAh4k3xNmJdezw==
UI-OutboundReport: notjunk:1;M01:P0:IYZhPlxcEOk=;o0SPT7r47DuqadD0lHVbClQmafX
 syjPCHer6jwHsnHQD8mIuxQ1xu4M0n3AI3EEXltIPvH5L2gC8P9V3eEXB/WCilC/+xchxGEOO
 8d8ITp7Keo/un3qIEvnhvSSN9TutGH5wm1jgR197fDLbWKVbQTSKXIuWrMSeJYt4YmAuQrAjI
 Gbb+wnL9kdKylA7XDdzCeJyWUnCWl9XxFAktDKdvK4cIvOG8x7uyekdf8SENCC09ALY7EDHNH
 edPJathkI1o11h2ZC2uDx5mXYtCFMkgSfmGjJXSasH9GU44Ks9ttbZy3ZC/T1f17tH4Drqnvq
 GDAj5TenV2O+YbU8zLNMzQwhRZOg26/Bgf52+89jBNa5+qHmlKhYSGaZ15m9LYM3UVQwyahHo
 rqm+sioDTGuJZlZ45T4adETk36opLhzWnRBwpkT/3iR4jpcmouEl3DQ0QoE6frf/Yw1A6us33
 PmHMJr11BkbM/SSxQtyFd84DIq1DILkvF7NG241PXqb/+FyoI8x9Ych7pKwUjuxwrkk/K1N+8
 e0ebv01F4oZaf6bQEl9rgW2cNZ3qLhxkO27ArjOKUZ1+IyRMlsTlWovAQpvf3Sj0ARaHHpZpt
 1km6aoZU1pfegEGP2BHbUqS5x8T52KBDc1CL8wE0WrT8PIvAoe3nmrbUil03CoHzBJFIEA/l+
 en4L+ooMpScTSesV3tQXR5HRXa6+N/KedT6li+lRpgqJpO9/8Jvc5B8auv6YJOvytteQ38MAM
 pKPMyO1roLTNmq5zVzKVgyw3riae8jfi9vCH7J/MkBCUaCGWNX/FOxXnlg+S/DOSDd9/OshPO
 VsPdQI9aM3+AsqCipnHonD6TyhL/16e5yMLJnfz0JlY9A=
Subject: Re: [cocci] [0/2] powerpc/powernv/vas: Adjustments for two function
 implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1656
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/d3818747-cb02-409f-99a0-7e8c1338b859%40web.de>

>>>   One function call less in vas_window_alloc() after error detection
>>
>> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/1f1c21cf-c34c-4=
18c-b00c-8e6474f12612@web.de/
>
> It introduced a new goto and label to avoid a kfree(NULL) call, but
> kfree() explicitly accepts NULL and handles it. So it complicates the
> source code for no gain.

I proposed to avoid such a redundant function call for the affected
exception handling.


>>>   Return directly after a failed kasprintf() in map_paste_region()
>>
>> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/f46f04bc-613c-4=
e98-b602-4c5120556b09@web.de/
>
> Basically the same reasoning. And it also changes the function from
> having two return paths (success and error), to three.

See also a corresponding advice once more from the section =E2=80=9C7) Cen=
tralized exiting of functions=E2=80=9D:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.9-rc4#n532

Regards,
Markus
