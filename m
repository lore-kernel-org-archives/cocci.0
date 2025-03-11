Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B93C282EC
	for <cocci@archiver.kernel.org>; Tue, 11 Mar 2025 09:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=o/WMZvwN1OQqs1qhduhicZF879EzKyGGmbVJv8G0enA=;
  b=FO8phntj1u5sF/Mjx06L2mO84PRCUr5m5IGSCN/3pg68RgDxl5eDtgkV
   tpZHWyfZVKGaiCofHIsaWuCiz88txcKKe7XEMw6xz3x5ofjn1BNc49ou6
   1w9v+dONaId15bAt9nrve8Hyh1uBHJtNYen99We4btb/doskHpCMO4WMc
   4=;
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
X-IronPort-AV: E=Sophos;i="6.14,238,1736809200"; 
   d="scan'208";a="212248161"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2025 10:10:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 067D4E0D1D; Tue, 11 Mar 2025 10:10:42 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0EF0BE0260
	for <cocci@sympa.inria.fr>; Tue, 11 Mar 2025 10:10:37 +0100 (CET)
IronPort-SDR: 67cffe0d_zpZJhmhaquSeHN8jXcnx/q66SKhIE/xKb+H7adR6t8BB8UJ
 43VJj2XE1YD6o5Hk0S76qvLhjlBaAyhCH8sMjFQ==
X-IPAS-Result: =?us-ascii?q?A0F/EAA6/c9nfg4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VOCRGJ1MwQLSIRWj0+BdDCEO4c7h1OIdYNUDwEDAQ1BAQIEAQEDBIIMgnQCi?=
 =?us-ascii?q?xoCHgcBBEcBAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOC?=
 =?us-ascii?q?QExhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJgEECwsaA?=
 =?us-ascii?q?iYCAlYGARQBAYJ+gjABAw4jB7BDgTKBAYIMAQEG2lwfLCJXgWUJgRouhWyCY?=
 =?us-ascii?q?wGFWxA7g0J6Jw+BVUSBPIMDPogegmmCM4QbJWeKaYE0hDSETYReV4Jyi1RSe?=
 =?us-ascii?q?xwDWSwBVRMXCwcFgSlDAyo0MSMPgRQFNAo3OIILaUk6Ag0CNYIbJFiCK2oEB?=
 =?us-ascii?q?YEkgjaEPIQ/hU6CEYFdAwMiAYMfdxyDS3Y8hGEuMh1AAgELbT03CQsbBj2iQ?=
 =?us-ascii?q?oRCgRoRMm+UPJ4ylF40B4I4gWaBYwyfXgYTL4Nwk1YOBpJ9mH4iqRE1gUoig?=
 =?us-ascii?q?VwzGiSDNk8DGQ+OIYQtxk1CNTwCBwEKAQEDCQGBVYNwAQGKVIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 abZiIyErIyGpZbNLPtd
IronPort-HdrOrdr: A9a23:DE6+pauYIzh5fPF6QggqDjqj7skDotV00zEX/kB9WHVpmwKj5q
 KTdYcgpHvJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQo+WvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: 9a23:e9okr2/fiMTPC9uwMOeVv00sPPgic2bM9WqKBwyKMWE0SLuNV0DFrQ==
X-Talos-MUID: 9a23:sUMntwuvnNTdSUR+vc2n1QxIFOZp8amXN0kRmocB4eiGEB4oNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,238,1736809200"; 
   d="scan'208";a="212248120"
X-MGA-submission: =?us-ascii?q?MDGCnlgQTM+BAbjcyDeUqlw6nQZe3M1oYGSWir?=
 =?us-ascii?q?itKsSgPC6qMJeLJJKPGNRgQ6oPjEFy4xPwloGEy7I7KRGqPYtGdIgIaw?=
 =?us-ascii?q?uGDu+kZU7sx9pc+aZMgJuv355eL2HG3xzryDIDHU9tjREd+ofAqvrHcw?=
 =?us-ascii?q?Q6QGyPCwq6BvZXb1Sozo8dPg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 10:10:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741684235; x=1742289035; i=markus.elfring@web.de;
	bh=o/WMZvwN1OQqs1qhduhicZF879EzKyGGmbVJv8G0enA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tI+TA28b++RI+KJU6PvwMl3TUvtTGjWSL6cO6RbPZXDA5ClZWD4V3lMIUV2kmYtA
	 Kgn02PBWd58MYz1EkCyVVcsnFrCdO2bzfcUcl9c8Of7FAI5XxogwCcrckS/ZarX1i
	 fdjiT8PP5ppGt5zcXUm2VQTOSHL/jMzqt6CkK5D5bF/284MUPglPGdrl4XDmOKNG8
	 wNFcw0yrSauAXTqZQc/Odvd4czOYJMaJ6qjrN4FDRfoN/ThsWMFm2gBwM5Sd569on
	 Jnj/YUCVBByyJ39+H+1mKg2WBQHbXf1rxq8GWKxJKCtUUKwIIFS8DG5OvhuwKAR4u
	 yfHSmmwgV0Jpivkz0g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.40]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MP384-1tbKad2rN6-00Lpxe; Tue, 11
 Mar 2025 10:10:35 +0100
Message-ID: <91895cd3-dd1b-4f2b-99b5-54612f671b84@web.de>
Date: Tue, 11 Mar 2025 10:10:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jacob Keller <jacob.e.keller@intel.com>, cocci@inria.fr
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <67642477-5f3e-4b2a-914d-579a54f48cbd@intel.com>
 <c3991582-ecb1-4b7a-b2d9-057a6be1d7fd@web.de>
 <90c4769b-0247-492f-a137-fec1c970eaf5@intel.com>
 <8bc6d266-cc33-4f77-93d8-b12f2086449e@intel.com>
 <fdf1c4b6-9f0d-4c27-a668-65cc5926ab3d@web.de>
 <f85188bf-8f0d-4531-b5e7-b7bf30bedb58@intel.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <f85188bf-8f0d-4531-b5e7-b7bf30bedb58@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:42BPMhpjXsUuU/eJPiPUsHKCR1hSIf22mIlZ4NotHEkbEv2aclD
 E3pM4Anq66rwQwCL4NL8Ghec+aEBBVyaXDXTbQwgRCDnSgMarEL/4pBRdrb66kAjEubwD64
 +lh5RThjBji/SY0WCBlQvhQH8LqYYo9/17i0bcEG/If3uvpc2zHm9ZFp2AclHdMOYPqip+5
 65IuOG9bJF+pCjXnEgfQA==
UI-OutboundReport: notjunk:1;M01:P0:XSqtCZlTjKc=;+oOdLWTx0ES8osWTM+JpoIilo+Q
 mlKoEmkt7tXHkUkESvWfdnE7ozRCGlHHLYogzFmPvapgGs2EI5cHlNKW0TUEkGyU5meQsyV3W
 zORS3m/0weJ6CsVQyrvGlXMUwTMqT86BnBtydzUgbtOVAkSqdSfVD6aeVnJP7Vl/6J/NfU5xk
 XaYW2dsN+vOl+RoAatvqtSv+rjNI/OcMCTbwkUzZhc0PTgeadYJZCnRkvlbwB/Dcj+RWITanU
 WCFM7ghsZN7DT7XFcd7kL5fP3KthG9M8eZaOMqbTHEIo84Resp1N0jIeuGztWDPUfeAA6cU1K
 tJTqG+i1WnuK/TkfYrO0ye9rvhVl8YJkd5JNBg5yEKB/kZtPHmYN8cI4KGD+weB0ryi401NXL
 lirIG2d7TrYX2R/3tAQPGFcHHRxlV3sftZ1YiPUkkfDZdUiMe/1RyA4gW93oIjoa+Tesmje3t
 l6mmPHj1v9lYOrN2PLw1Pe8I/CO88ECGGdHqNwGAqEOz3hFAavBA3ld4D+ffc0yxdHMRYz4U4
 BfQDnk5JREHlKN5JUmclC2CkunVhKShBIxCCalKQ3p/lF2J8B6aGStQczLt9jIBhv2cmNiS6Z
 WmIubRVvJjLnniZ6dtzpnIlNaMGwhGByYs2brJXFx6yaQDESNKphb3AT9jpXHHRc+RJqNfVM6
 GRC2aOCDdrPhzYGciyDuTcWBg2CbBV2qqBrCsSGYfNeEv5VNrVOtn5TEMGGT8+5BLeEJl4VuU
 A5yUL9AH9f+aEHp/76xeDUh5IdIZa/SksTmKFc0yM6k3V1+qk+AunlqhEPKM6CwLGvl5ynk8e
 O4o/uLdkWiZS2BlZfeurVcTGshIqE3oC1lxiR57H+pS8llaDRw7kKVm9qf9TlLIYzZP8gG3dg
 ykiY6Z36jNmMt7DJBv3qLnkuYrNgPuyBY6uetW6kPzTMTo8J/YoU9jl47ihLfJXuAKoyjI4JB
 OVbdeCwkgamNX64URaPgEKUEWLMlar3siFS16jWPaa5FnUy8e+ImEB1bAXVJqAq8MqZiryipQ
 XhBO1qzwN1EpKfajoE/AZeQPagbJSYBaFVmPqeuoemdJeKeeqKMBj1JUZ3Up8vO3uVX51o8td
 VrLxDl1HKIo7mvTheFUWOJABXqGOWsHTjniFlSTiIur64Sp4YJfMwXO7o9Eytu+9zD6c1ZiLZ
 to6ZHgIzVteJXpYb3riISNghKqd9gD/bWjv2jWrTisWWnrYmo83Fc73C6rCY6p+6GXgO5bDsY
 zM1IbioKMHwoSS4+D/Z0/cvL/l/7ZiiQ6X9B5SNjA2mNyZCxK9k/mBZ1/Nx7m1hVH8bdHzzN4
 Gc5O43vS5m+nU5bENz7EIQdq0CU4GZnXOIUhvuqRz5HF/+p1MSlPzZkFbZ0ZE05BEV86q5Cz2
 5NaDOKm6cIEOpNbkvXvcnrJciH0QcdJDtJaCqw4pV/GiOd24EBz6FrkPhU6QH/sxwYpBf61vs
 Ib/bEtg==
Subject: Re: [cocci] behavior change in semantic patches since c36b51ffc889
 =?UTF-8?Q?=E2=80=A6?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2583
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/91895cd3-dd1b-4f2b-99b5-54612f671b84%40web.de>

=E2=80=A6
> I found that both styles can be helpful depending on what you're doing.

This is good to know.

Do the mentioned technical details point any remaining open issues out
also for the software documentation?


Would you get into the mood to influence affected source code
(including OCaml or TeX from Coccinelle) any more?


> There were exactly 2 places in the code base where this produced
> different results, with the form:
Will such places become more interesting for the clarification
of code layout concerns?

Regards,
Markus
