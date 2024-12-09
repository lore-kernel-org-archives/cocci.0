Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C98E77173
	for <cocci@archiver.kernel.org>; Mon,  9 Dec 2024 10:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=W3ZMflSXHIPmR5UeF/oKlFBpOppezWSLB8lydNMljmY=;
  b=D2AYAvfIWFu+Glx0smfB66zPC3DCb4U6sD5jtlQ2mVH28W/08DcVl97c
   yJtYVXhNWeVRRHuldeHZGra97ZhNLquaHT1UC+SqvFivbeOdYaCtFlrXZ
   A9Ke9aJXQ884lhIC9zjGbCieFPAdrx+lKoRG1hIaFwlQjouzLGqVWAAJY
   I=;
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.12,219,1728943200"; 
   d="scan'208";a="198136628"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Dec 2024 11:17:38 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A2A20E0D1C; Mon,  9 Dec 2024 11:17:37 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 52789E00B6
	for <cocci@sympa.inria.fr>; Mon,  9 Dec 2024 11:17:34 +0100 (CET)
IronPort-SDR: 6756c3bd_Nl7mGfPhJq26Duyv6EId+lsbhuBAC8JwyRZyTI4uryF83B9
 uw0o+DbcORArhd7Kh7QK14ys6ywTzYG3WKp+TBw==
X-IPAS-Result: =?us-ascii?q?A0GBAAB/wlZngAMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAYJDYiFUMwQLSIRWj02BdDCEO4c7h1aIdoFWgX4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEhQACimkCHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAQE7Bw4KMYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBE?=
 =?us-ascii?q?SYBDwsaAiYCAlYGARQBAYJ9gjABAw4jB69JgTKBAYIMAQEGUtoJHywiV4FkC?=
 =?us-ascii?q?YEaLgGFaoJjAYYmg0J6Jw+BVUSBPAuCeD6IHoJpgkGFemecDFJ7HANZMgFVE?=
 =?us-ascii?q?xcLBwWBKiEsAy45MYIFgVsFN0eCSWlLNwINAjaCJCRYgk2BJQQFg2mBC4Neh?=
 =?us-ascii?q?FqGJoIZFR1AAgELbT03CQsbBj2cIKpzom00B4I4gWWBYwyfWgYQAy+DcQGTU?=
 =?us-ascii?q?Q4GknqYeyKpCIFuBS6BXDMaJIM2TwMZD44hhC2+JEI1PAIHCwEBAwmFRgEBi?=
 =?us-ascii?q?nyBSwEB?=
IronPort-PHdr: A9a23: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
 jnnkaXuNHFd/tiS8cZOX6Dp
IronPort-Data: A9a23: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
 VUIqat4rI1XhKI//QuMu5KYJf3BgA7S8g==
IronPort-HdrOrdr: A9a23:J5gn46p/ZLwn2liD1eeTwAsaV5r/eYIsimQD101hICG9vPbo9f
 xG785rsSMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaGSS5vyb3ODXKadC/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: =?us-ascii?q?9a23=3ANXIXwGiCYZDj0yQbB96s7MJAmjJuSHOAyVn0IEG?=
 =?us-ascii?q?BDjhRC7enR1SRu4I+qp87?=
X-Talos-MUID: 9a23:1w2ePAQGo+JqmePlRXTSvTdBKd1L7Z/3J3tWoadXnum6NSJZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,219,1728943200"; 
   d="scan'208";a="103807048"
X-MGA-submission: =?us-ascii?q?MDELKN4udXeOCTWYe3nEA2rhG4Q1SuLTfuqOYq?=
 =?us-ascii?q?vgv8sezaFU4hC51HI5Mn3G+Pf5PvV4O61dMVDLdFStOz+mWeQ6Qqg+oq?=
 =?us-ascii?q?l6gPXFb5h50W7+FXuzwaOIRBbw3jUu+Z20IRPjkfEU7ZeFRu0/iBRao9?=
 =?us-ascii?q?VTtU7ztUWy02ywLI1ncs188Q=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 11:17:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1733739453; x=1734344253; i=markus.elfring@web.de;
	bh=W3ZMflSXHIPmR5UeF/oKlFBpOppezWSLB8lydNMljmY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=G52SjXj2S8ZZLGPfbM0jwi6tl1ql6hKgyo2oAAhU6YCazOAyD96h7S5/aEowqVfY
	 ry980RqO5kJD14AUPfxOXwv/ck1WWyIIczcm2xvSsQKKBTeET/8csTRGIUBhJ/7OI
	 NgRe1F2qjfTOTMznmg/FfcSiozB7YTOCWsfrpvp4aVJp7sc+Tdb1oD7XwWkfWXDvg
	 7hSfA0JubMmmZqo+kHsJ1bnE06a8Cc2AjmKRBzZEKJj8HqI4K55Va4OArRntu9d33
	 rTmlOnxbXdZquUbW3PyOm59cleB4Abrkl/xB8+S+7X2jmA9j6SXwpYxaZDsnuPdue
	 NqRDJ+IRuKR8ZSLfqA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDMzC-1tRmME3x5S-00FpM1; Mon, 09
 Dec 2024 11:17:32 +0100
Message-ID: <84940079-6768-446a-a6c2-2cef4f9b24ce@web.de>
Date: Mon, 9 Dec 2024 11:17:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Zack Rusin <zack.rusin@broadcom.com>
References: <CABQX2QM+cBpVhcBYRae+W4n5a6bVJ=sC+zu9GGj0veiqvU2_4w@mail.gmail.com>
 <6b81d431-36e9-7a7a-687b-2d7fc7aa6c31@inria.fr>
 <CABQX2QP0Vk5UZPDFDXThvzuw-gkam-4wU_xq3rbSmwi9x7cBHw@mail.gmail.com>
 <dff4cbd9-00c1-47a9-b2f7-fb2e98d04433@web.de>
 <CABQX2QPZB9uHMxKKoZA6f=+4f0ifHfft-rHcqd-Ck9rjo7-ShQ@mail.gmail.com>
 <1995b696-6825-a144-fcb-c5f9f3b1094@inria.fr>
 <CABQX2QOb9C4G3Kejo_ght3Dgo0qxHW5A6it4GB6TdgoU0Bo7sQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2412081042370.3332@hadrien>
 <CABQX2QMwBGJHnehxy4j0gHgmUWBBuFqncLWbDZWEdENtGOrZ3w@mail.gmail.com>
 <alpine.DEB.2.22.394.2412082014130.3332@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2412082014130.3332@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mDOFTGuIox1A4/GOcL8oORa61c5xLeD+wlX7XctTn/rVJMURVG/
 46zeuvd1ipyAKRPIbDJVdhZW5NKlbINwV2aWI71fTJ+UWWxDELrt8u6wthl8ghtQ/kOhm1W
 LVgxfm+sBfTNdeosJo7shGwQKMwTXSRzrEFu7Hxg5aLjiTUwI6Mpijrh6ZVezZCHHdtC6wI
 uvKxU/qbkYQRn3v79G5Xw==
UI-OutboundReport: notjunk:1;M01:P0:eFq2RzLb0rw=;AhnJkziZ1IeuSP+L6UiLTH53/Pn
 3MhRmATy7vmAyKGO0pRR98bDJccbHdrWuzBhw7g1xUvRKBHwdW/Bnqr9NZxp3XQ8kXdyE5Wpv
 QOG2syBET4ECLbjeOOieOt+yHpdAQX8v5JUVrYli3ND3SkIeJMtKV3HZwQzc3pfRWcLIZhCHT
 jJUmkX94YlMIToLvmJVvW88FaCbsh4Z28sMAFYc50QtWYKa5VtxgXWO8Goh7V57liCFGczpok
 FH+lnXx23Tl27Mi9QARwrZtaK5tMHjSIR8n+t99c3btTIWV942LwWl0NvHxBMTBrQzPnQFxd9
 mJ2CivFt+PA8NXYdcgBh/vLenDBq1ZSruQmXXso0lS8+iC5ny7B3EWZRtcqPUW3FzXmg8MJn2
 3LHAdQTtfnEP2mgv07XJQu1BdBJXgiahrl9ljVWLw4ljP/bK8Bf182GAznig6Q8c7uJEngGMH
 PaikYndzkAiMBM/DV/Bxd8dOVuX7yR0X65N+FbTWhI5UeTpb/PL0tkJm1tWxGlQbZSLSCFuKB
 s3aMtXdUCB1KQ1H3ldi4WhwhVdJYZZy4ap/1aYNFHnDg2ZRj+U7w4dXzNrkAg2/jW+pc7LtqZ
 5kW/EN6flmDXYKq13f48qQGuT1AkgZ736LI41KzgWFgP2A4EJQcgIv5qN0OQb6Qxch5gDCjkj
 ufk4Cp9JLkLQrdU0ro6EQQCPMcl6dsdF2zdx4olNCTWw5fsCqDqCOEy8YK6A+2B5Lrv/gvUES
 7e0avjjCXaBI1Eqo9hzD05zQ28GpTguEKUxTLHD60c3Q6KDYc7xm7CCcHAsnSX5aMXCLtzMJ6
 djOH1y3v+TUFo9geP43aF9dypnRNnfHxlxPByFBRci5t0mashrdjfG+tt15Sspg1p/MFYfPVi
 yNVri+cg2cTZKiHVHh0b/J9KHe5y0tDON7/rhvZOaitLyS5SNXAJroHBhOxlydn3WRKIIoHHX
 3LUiMTWw/sNBE2rZrgZGlh7as/HNTrbFSrz72Hdx27TZB1Neiwcw6ekzl5H3cfFwtKOu1Ggql
 9d8Pe4QQzi1G1I9kjuu7MAOF9iw0P5wsGBmiuCufj170cQ5oDnU7RGufzUKfmuB/UMd/9pLmy
 I0kaKX8hA=
Subject: Re: [cocci] Replacing type names
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2172
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/84940079-6768-446a-a6c2-2cef4f9b24ce%40web.de>

>>> Function name:
>>>
>>> @r1@
>>> identifier i : script:python(t) { needs_rename(i) };
>
> Oops, this should be
>
> identifier i : script:python() { needs_rename(i) };
Would you ever like to show how the desired renaming can be performed
with less SmPL rules?

Regards,
Markus
