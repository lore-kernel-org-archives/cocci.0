Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8522ECF34B0
	for <cocci@archiver.kernel.org>; Thu,  3 Oct 2024 16:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=F+1z7U/n6yl7iV1NAosWW0C7oJG63omhcZcSrRfRnkQ=;
  b=OpNsYxXS3SqM9lrGi6z6oWTbLuDNccjgpylojyJN7j1IJ4eOTRhK9RbE
   6qqUkUVlV043ivqRFDhq04TcriFTB786ePfMyWf9WmPrxrZjv48yvBnAD
   9gG6RLoNWcjei+CzAn5r8E6KG8O0xzopt+nDdaqgmEk7Z3cHcbRnzy1xH
   g=;
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
X-IronPort-AV: E=Sophos;i="6.11,175,1725314400"; 
   d="scan'208";a="186836461"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Oct 2024 18:38:28 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AB78CE0CD0; Thu,  3 Oct 2024 18:38:28 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3304EE0035
	for <cocci@sympa.inria.fr>; Thu,  3 Oct 2024 18:38:25 +0200 (CEST)
IronPort-SDR: 66fec880_QzKaIMssSJ75+W92sm3PUGY9Xz4uYZZ2vpOB3L875ZFqw89
 UUQxbUxJFLxdgGLN6dJ2CXq8cTCR9zr6NhVjRGQ==
X-IPAS-Result: =?us-ascii?q?A0EFAADHxv5mh07ASNlaGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgTsEAQEBAQELAYJDfQZUMwQLSIRWiB2HMIF1LQOEO?=
 =?us-ascii?q?48OhG+ECIFWFIEsPg8BAwENOwYBAgQBAQMEhQACihgCHgcBBDAJDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBOgcOO4V7DYJjARCBFIEmA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBFwINOkQBAQECASMdAQERGwsBDwsaAiYCAlYGA?=
 =?us-ascii?q?RICAQGCfQGCLwEDDiMHDbFegTKBAYIMAQEG2lsfLCJXgWMDBoEaLgGISgGFZ?=
 =?us-ascii?q?zuDQnonD4FVRIE8gwM+hAUJNYNbgmmMRYUyFoEkgwBXD1dvUEKEDCWBI4c5c?=
 =?us-ascii?q?JF7UnscA1khEwFVExcLCQWJOAqBeX0FISmBRSaBIIJ1CIErE4EGAoJXgWcJY?=
 =?us-ascii?q?YQ7gjxwYoENgT6BWQFFgReBXC8bJAtegUN/HAEWBhUEgSUFOAo/glFrTjkCD?=
 =?us-ascii?q?QI3gigkaoJagScEBYNrgVEdQAIBC209NQYDCxsGPaxfgVsBR4FnJYIHggIvx?=
 =?us-ascii?q?X80B4I3gWSBYwyKJ5UrBhMvhAWNAYY4DgaSdy6HY5BlIothgXiVKYV5gWc6b?=
 =?us-ascii?q?HAzGiRPgjMBATJPAxkPjiEMDQkWg3WEYYoqAbBvQTUCOQIHCwEBAwmFRgEBh?=
 =?us-ascii?q?k+BSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:D5mWS6/XXESvzvpN4Dhuk+AMI+orL9Y04lQ7vn2ZhyYlEPBw5P
 re+MjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3AnYG/3Whixprafpncn1UMH5VUoTJuaWLg4XDWHk2?=
 =?us-ascii?q?CBntmS5KVdwCdo6BDup87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AZZmmpw2S/8hdrCYxKX4t9kGHyzUj4qqvWWkuiZc?=
 =?us-ascii?q?6l5efFyZeNA3AtD+XTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,175,1725314400"; 
   d="scan'208";a="98160805"
X-MGA-submission: =?us-ascii?q?MDH1+RqwN3Veb45XpN3a3X8MqeYpwaFGY7YlVB?=
 =?us-ascii?q?td2awl8yt1ABc3ctAgP+eOAnW7bVm0t6K74eQ/PgWpAHU85Ki5K/L1Td?=
 =?us-ascii?q?1dgR9mj85DfAR1L+ekNnXwTc3TvZ8vxlZjpc0oTxST0TkbYFvEMRrePT?=
 =?us-ascii?q?v68falEKET5jthizgrgMX6/w=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 18:38:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727973496; x=1728578296; i=markus.elfring@web.de;
	bh=F+1z7U/n6yl7iV1NAosWW0C7oJG63omhcZcSrRfRnkQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PlYLC98AgZWVQVABWHy0FwIo+UGIBQwvDWsb+JfI7bk/h2YmOmobUScKXBBvDyNk
	 AZVtxYssUmOret2w4oRvUW+es+aLuDUkCJbx0J+WaONFn8YkO4lQIyYb+24yzst7Q
	 5MzMGqCR/+KpGvzVvk3yD6uUDuG+b1OxLgYFGmKJApkjjZxR41O8fL0/Wd3FudXvN
	 VWJg1i883VelK0XpdDQgEdWZBHDPhD6UjzOC0rdxQ+kZdUFvhVmBKnejstxBffAgG
	 6zIw5AN2ehQdIefD+33Vsf93wh4E+wLhFHwJahoFo6A1b/3NCpOKxQrMgpMLWXz6K
	 RSR2OkZJG0jnDbtt4w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M76XN-1soRPz0pDj-005cKX; Thu, 03
 Oct 2024 18:38:16 +0200
Message-ID: <28632df9-0ea6-4fda-a83a-5ff7c23f97c6@web.de>
Date: Thu, 3 Oct 2024 18:38:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Josh Boyer <jwboyer@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Stefan Roese <sr@denx.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <72a7bfe2-6051-01b0-6c51-a0f8cc0c93a5@web.de>
 <ecda8227-d89a-9c23-06b7-54f9d974af5e@web.de>
 <e68a714b-32f2-de9f-066e-99a3f51a264f@web.de>
 <8edc93c8-b146-4507-8336-0709b2596cb9@csgroup.eu>
 <66655a11-888b-4c50-8e57-06552b82f922@web.de>
 <e843b3f9-2214-4945-bc07-68fe935551a5@csgroup.eu>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <e843b3f9-2214-4945-bc07-68fe935551a5@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RPueEfq7odGfIrQtPnI4m0PJ39ogJF2r0KLnd9Jt8NBOXvCvNQD
 v9sYqSOgYyLAwLzY2q2dSHG8z80OZGDse0kNGxc1wzRMAUQ4wpdl//k5KQVKKu8leMVdWUs
 AmUA9QW8FfX5I1VBApoGncX4nDU7bY0ldHefJ9WnIH7cFLDmtpmQ/2LgKvUqjUaDKG414PD
 3tRzt6aoGOCZK8T9lKkTQ==
UI-OutboundReport: notjunk:1;M01:P0:JRKwEzXiVis=;rdSJHpinRPkxWnJHAGkZih/o0Do
 u/ArAjqkNbmv6kJMsjKj5drJblyzplTX04aRt4ebLVw50c0Oq3G6bfCAQ+3k1xb8AxPI/uLtl
 t8P9NbAOBeEew2jgo1YDAH1GjY4dF9n97YdNwi6/pVbmktpmHcIRM637lYzkt5/ydqdiQkIPB
 YlitfDzb64y3lptIErz2EHLx2Bs05Le89OTJrwn//+v9LFMq8Lx5Nv2PFUCWohHtoWeFIw+NW
 94dAsTkpRXA7ErHpX09COHjvxhWibtajQx3BviS/Cv5qoffz6MDd+r5PuzF83COcihSHfY72N
 ilc6Us1N0OIj0lIGWPvyTQXDTKnUI0ld1kt0U9T3MJ1ZJdW+PaWK0qQMKi85JlYOh7OfuBXJt
 RsaTL0aML/aX1lzkkAlrE++ybPSze97N9RJLG345Gk3gYUUQ++xnGIXikh9dtbkgSI/afQBVa
 Nq8cWzVD5TWCKa2+pSHp9pQQC5PKZlxZnxZIKxrRu2KUzVp3punbQw4xkfpvY8QEnzPbtygBg
 lzcb3rebeX0cWwn78YhShkA3/GqB1suWE1dGqQByVpPK2dHYDUyzPFttgY8SgL0ckUXu2A5Y8
 UpAF4ZBnxO8GwRMugza9FTMh/pq3brmTj49T+rd4kwquQr7w48YLOyOdUbz6jiufez527lDb6
 zWZfgYG1SAPSh61+b4Gevs7BddoC1VY74X1HMZxLPExmd7JDRasFBxJIfQxYTwtDxveuu2f2E
 D9RF2YJCX7faYhQmz4noX4Ycojok2G8hldUiNnOOMzvzLYc2hwZqX51hQrFZlJEus8nVhBq3p
 dowqb4xaL9WcqRhkKWRkey6Q==
Subject: Re: [cocci] [PATCH v2 1/4] powerpc/4xx: Fix exception handling in
 ppc4xx_pciex_port_setup_hose()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1906
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/28632df9-0ea6-4fda-a83a-5ff7c23f97c6%40web.de>

>>> Looks like you have messed up your patches,
>>
>> There were special communication settings involved which hindered desir=
able
>> data processing for known information systems.
>
> Don't know what you mean.

My email address was blocked in selected Linux mailing lists for a while.


>>> there is no much we can do it seems:
>>>
>>> $ b4 shazam e68a714b-32f2-de9f-066e-99a3f51a264f@web.de
>>
>> Please take another look also at published information according to fur=
ther
>> mailing list archive interfaces.
>
> Another look to what ?
>
> It seems like several patches were posted with the same Message-Id and/o=
r with an unrelated In-Reply-To:
>
> b4 is lost and cannot apply your series, it applies the patch at https:/=
/lore.kernel.org/all/82aebf6c-47ac-9d17-2d11-6245f582338e@web.de/
>
> You may consider fixing and resending the series as an independant serie=
s.
It seems that another information system did not get confused with publish=
ed data.

Example:
[v2,1/4] powerpc/4xx: Fix exception handling in ppc4xx_pciex_port_setup_ho=
se()
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/e68a714b-32f2-de9f=
-066e-99a3f51a264f@web.de/

Can we benefit any more from such information already?

Regards,
Markus
