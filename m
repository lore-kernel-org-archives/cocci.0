Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652D0C3DA6E
	for <cocci@archiver.kernel.org>; Thu, 28 Dec 2023 06:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=O7mrwpol3/MtUTqmEccZp0HgdNa08sVGdjyLCM3n6hs=;
  b=mO89ONpmbhgoTEHr3OzoPWB3M/b/0Sy3SnEogvMGif9m+5lp0i7fB5Qe
   EjL9YLiHoGBcIzHK8CHr+sXruRgz6FIf+uEvGgqMafkuMMbI9tkgoT/k+
   Cvmvc8DXmQt9yOALV+rkpaCyCcWe5epwfrgKuysXzcyyna49JjI4fzzsD
   Q=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,311,1695679200"; 
   d="scan'208";a="144182860"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Dec 2023 07:41:08 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AE4F3E0CCC; Thu, 28 Dec 2023 07:41:08 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3B41EE004E
	for <cocci@sympa.inria.fr>; Thu, 28 Dec 2023 07:41:03 +0100 (CET)
IronPort-SDR: 658d187e_jqRmuo905dwxCIdLYUbvx+81e6XBPb+/YVo8bwRqmhDOP95
 qPjkWhlgVLbqkAPgh2uzD/M63LbERPATmdvJIwg==
X-IPAS-Result: =?us-ascii?q?A0EdAQCsF41le07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYI4fANTMgQLSAgihCmPQYF1hGuPAYRrhASDFj4PAQMBDTsGAQIEA?=
 =?us-ascii?q?QEDAQOBSUKCdAJrhksCHgcBBDMGDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAQEkGAYOECeFbA2CXAEQdhZsMAIBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEXAg06QgMDIx0BAREmAQ8LGgImAgJWBgEUAQGCfAGCKgEDMQcNBq4egTKBA?=
 =?us-ascii?q?YIKAQEGgmasch8sIlaBYAMGgRouAYgaAYVng0F6Jw+BVUSBPIMDPoRDg1uCa?=
 =?us-ascii?q?INmhTYHMoVrkVZbIgVBcBsDBwN/DysHBDAbBwYJFBgVIwZQBCghCRMSQIFfg?=
 =?us-ascii?q?VIKgQE/Dw4Rgj4iAgc2NhlIglgVDDQERnUQKgQUF4EOBGobEh43ERAFEg0DC?=
 =?us-ascii?q?HQdAhEjPAMFAwQzChINCyEFVgNCBkkLAwIaBQMDBIEwBQ0aAhAaBgwnAwMSS?=
 =?us-ascii?q?QIQFAM7AwMGAwoxAzBVRAxPA2wfMgk8DwwaAhseDScjAixCAxEFEAIWAyQWB?=
 =?us-ascii?q?DQRCQsoAywGOwISDAYGCV0mBw8JBCUDCAQDKykDI3QRAwQKAxQHCwdSAxkrH?=
 =?us-ascii?q?UACAQttPTUGAwsbBj4CJ6I3gTYBgzMTLEakRaJANAeCNIFggWEMihiVEwYTL?=
 =?us-ascii?q?4NukzgOBpJULodQkE8gjUqafIF5JIFcMxokgzZPAxkPjiA4g0AzjwkBPUA1A?=
 =?us-ascii?q?gE4AgcBCgEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
 SILbEeeEUwinuP5Kg==
IronPort-Data: A9a23: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
 c42ohXNA/R6/n2lqSv/KBB2bSeLC842Hk41xH0=
IronPort-HdrOrdr: A9a23:Pg7Yn6O+nzOdSMBcThWjsMiBIKoaSvp037Dk7TEVdfUnSL3+qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQU3WBVB8bFYOCEggWVxeNZgbcKqgeIc0DDH6xmpM
 NdmsNFeb7N5DZB/KTHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:VEDZS21WHPa52+XvJNa5krxfP9AILFHv53PrKEboB0tmSPqxYEHN9/Yx
X-Talos-MUID: 9a23:MDSBHQiSgGrFG2dWHiZs0MMpBfwr7KacDVE3k4wGvu6dGghhJhSQpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,311,1695679200"; 
   d="scan'208";a="75435389"
X-MGA-submission: =?us-ascii?q?MDGSTsxCnGrWKSY4LOfUU85TaiTVswbpHl2267?=
 =?us-ascii?q?g9R38e/cpW5vNYI5KzPNIFUMgD2rL65Tbujr7oElE4ue9GE6Pg/6ho9e?=
 =?us-ascii?q?TmNmPAhcY8VnD63elbWcBFVxrFdMvHA7grmi9/Ib3BebCBei9NxaWzrI?=
 =?us-ascii?q?iBFeo4RpQdTLXZjL/+WySu2w=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 07:41:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703745568; x=1704350368; i=markus.elfring@web.de;
	bh=CQ9zUoeIIRPWlBOHSTjI21uVE111Q+XjbfT31zxGskg=;
	h=X-UI-Sender-Class:Date:From:Subject:To:Cc:References:
	 In-Reply-To;
	b=MhX+D4dQaTRR+Wp4MmEKg0TlR/voAK1KawY4y0Kmtt1iRjc96BYEgrsIyORIW42h
	 BGj8vESq1+qATcYA4GPesp5Ni6H8/vmpKUXqB9nBmeWedZRgER7MDdqeEaCEKkLjT
	 r+QAM4n8nVGpsUinTQQ7r2HyUbhd9/k/m1AwVuY4p4IU4FnB8KUdi181SvNjYrjBI
	 6lm00WQHe7CmxrvIbSJ9bUWnnk3SMpaXg7tB2Xcz4/fwqjNCxpWNl13AO+fl17/XD
	 Kr5TwPX/ZKlYa8QwUA44tKb3yEDveRC4nmiPmANceRQ2jqc3XaUwjRLX1545Ihkwm
	 Q++93rc6AyyrT/kZ+g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3V6G-1rJIHV3Y6U-0015Fq; Thu, 28
 Dec 2023 07:39:27 +0100
Message-ID: <a206cd2a-03ef-4c8b-8f8d-635e8a02e72a@web.de>
Date: Thu, 28 Dec 2023 07:39:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel test robot <lkp@intel.com>, linux-omap@vger.kernel.org,
 linux-clk@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Tero Kristo <kristo@kernel.org>,
 Tony Lindgren <tony@atomide.com>
Cc: oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
 cocci@inria.fr
References: <b11039e4-69c6-4247-b4ba-c442b9427231@web.de>
 <202312281350.5H2Rhh67-lkp@intel.com>
Content-Language: en-GB
In-Reply-To: <202312281350.5H2Rhh67-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DvP9z21vMsNBbQJt43X0o5GZcDwyooJWWYTx1miGfTsjAJDm9kX
 RMebBTOHOA/Y3UiZsegNNb4nbDoTDKwVi0QdLSK6XEeeyN1oRCi9kvtfm6R64pnj8aIVPU5
 D2HKwNGODLa8Vy4H7ZZ19kK9AxkOtD1xF5e7cTM+zzDiBUND+dbS0qoh71szBUmd5kZB96I
 hw0NGGO6aEgwgeIMt86sw==
UI-OutboundReport: notjunk:1;M01:P0:irS8BLfZwbs=;nqFf8TNcswZcxiA74aGtBUelV4W
 wPLFUNj9Y5LCKpgjRB5FcfIW56ElQ2n8No3Mz0qJmsKp7CJTLkGYPA+OKoCoDg99e67nykupF
 KpSV+r9k/fgCBat89n4CP8H+7w79DCBYKDURZWt5zBtFidlVEjK0KKUmx4F/fxnfcEw+wAuAg
 +J/KhYxaeUUlpbKvfA8pl1fDhWNUXnpD5x8x5PyQJVJwrWmFQJQWgB6gHF5e5tJpeVyEZDse0
 R2RMejLFBPLRr9XhrjsoRoEvWUsyLHcC+qRUe7EiFbQg42T+leSxKxNL0gHU+eJYOW5n2w+DJ
 gmDXRrqW99b7KkJh7WghhGBTJfbLiAo6shHSYtBhI6aWJtdvMXHTPoSistUCaP4Jjr8JwB+Hq
 A5qwohRaRlRXjCYWTxeh5A3+NeLkfYh0hJQIUEZ5YnkgxaZn9498LoIzj+ofmKEmbAkGVgN4W
 T37J+49AylfFtk3Bcui839UNbY3dJUAloHJ+yNQoRn7q5Ru4GNQGwX1Pw/NybnUTV6lNX2bf1
 G9koHh6MOi2mqgnJabHLBw7dlIJC0rV8cx2GNt++KewuO5BJLC6aniPGq3DLzyneGvNXJPtSR
 lzaS3OeGTLBbxt01C3K5ZQdtTrj5ZIvR1cCuzcbajtnrfrG87LozgIsgdcP6pRanPGt8GM1Zn
 k/L9rJ3zWGA5Uagli3s5EDjwL9NMBXaGiJzf6KqRtsQd5np3mppA4fdlnWS66/MdHNEJpMna7
 uNKF4L1v58q+hMMzPASNSRAXz0REqmImEIA7jUQe9uoVhgB7C3DuEp3AECTy2epta5GY38U2N
 yTyWJ0nqdzueADSiiqlxcbki9v+267z4ZSnfUyxWl1VpK3tQP/wovmKSXbfhmmcCGhKJxtGE0
 PJLzpWLAJiI+aZf5MNJf2THiWO78vioh01VmY/O2xpT3RC3sEo/ZErIXn4t1c1t5zmKqBVqjG
 F4f5jg==
Subject: Re: [cocci] [09/10] clk: ti: Less function calls in
 _ti_clkctrl_clk_register() after error detection
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1424
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/a206cd2a-03ef-4c8b-8f8d-635e8a02e72a%40web.de>

=E2=80=A6
>    drivers/clk/ti/clkctrl.c: In function '_ti_clkctrl_clk_register':
>>> drivers/clk/ti/clkctrl.c:330:1: error: 'free_init_name' undeclared (fi=
rst use in this function)
=E2=80=A6
>    328	cleanup:
>    329		kfree(clkctrl_clk);
>  > 330	free_init_name;
>    331		kfree(init.name);
>    332		return ret;
=E2=80=A6

Will it become helpful to fix a typo for the delimiter of the shown label?

   Or:

Are you looking for further adjustments according to software design optio=
ns
which would be supported by the file =E2=80=9Ccleanup.h=E2=80=9D?
https://elixir.bootlin.com/linux/v6.7-rc7/source/include/linux/cleanup.h

Regards,
Markus
