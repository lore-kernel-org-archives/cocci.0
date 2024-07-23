Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CCDC3DA49
	for <cocci@archiver.kernel.org>; Tue, 23 Jul 2024 10:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=bFV1ApnZr6l41hbLy78ecKlgGLcfy1MgJ0JGOpKuthU=;
  b=OX37WvodGQ/L6XYAdwgTs+Wn6IEeEwupBIB1c7cF8Y7V2Y70liqN9SGI
   kiYGfYS8tU1+XNve4qrvNVIFkdttm9X2L0CeJiZkiDH7+ydzwS2zjipqO
   P4XlFMIKFF2cYYgld/y4iwNSYk7mfzxayHxAzj9GMjP/q2LWEcglaMBw3
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.09,230,1716242400"; 
   d="scan'208";a="176641992"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Jul 2024 12:50:43 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 679E9E0CCA; Tue, 23 Jul 2024 12:50:43 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D8494E0131
	for <cocci@sympa.inria.fr>; Tue, 23 Jul 2024 12:50:39 +0200 (CEST)
IronPort-SDR: 669f8aff_KgnS+Olh+bq33NztQ0MMTccIzK+AkV6ZUdyz1wbIcQHMuAd
 Ixd+LkYy/+zOsBugPA7PVtRundwUQ1VSLEb3unQ==
X-IPAS-Result: =?us-ascii?q?A0EiAAB1ip9mhwwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYJDYnQzBAtIhFaIHYctgXUwhDuHOYdRiHOBVoFAPg8BAwENQQECB?=
 =?us-ascii?q?AEBAwSCC4J0Aok2Ah4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAEBAToHDjuFdQ2CZwEQgRKBJgEBAQEBAQEBAQEBAQEBAQEBARcCR?=
 =?us-ascii?q?0QBAQECASMdAQERJgEPCw4MAiYCAlYGARQBAYJ8gjABAw4jB64pgTKBAYIMA?=
 =?us-ascii?q?QEG2lkfLCJXgWMJgRouAYg6AYYJg0p6Jw+BVUSBPAuCeD6EQ4NbgmmWPoMQg?=
 =?us-ascii?q?iCJXSYLjV1UexwDWSETAVUTFws+HQIWAxsUBDAPCQsmKQY5AhIMBgYGWTIJB?=
 =?us-ascii?q?CMDCAQDQgMgcREDBBoECwd3gXGBNAQTRAOBNwaJVwqCfwIFIQQlgUkmgSSCd?=
 =?us-ascii?q?wiBLRWBCAKCXIFrDGGERIMyYoEPgT6BYAFJgRiBZjAbJAuCNIEFOhWBGR1AA?=
 =?us-ascii?q?gELbT01BgMLGwY9r3iCHcVYNAeCNoFhgWMMn0sGEy+DcgGTSA4Gkm0umD4gq?=
 =?us-ascii?q?G2BZzqBXDMaJIM2TwMZD44hGYQUy1NBNTsCBwsBAQMJhUYBAYNagUoBAQ?=
IronPort-PHdr: A9a23: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
 9KJmK+hcF+qFvrL8MFaC8WGcKq6
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:rMiLm61twwpckD7qGSyfDgqjBGYkLtp133Aq2lEZdPWaSL37qy
 ncpoV+6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyUMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: 9a23:HhoaKWBNgCWSOFv6EwBpqVBISs54SHCe1CfMAH+SDUEuEKLAHA==
X-Talos-MUID: 9a23:qsd52AV+EVeBo1zq/HzyvSFCJYBU35izGHIPgKxWssS/GDMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,230,1716242400"; 
   d="scan'208";a="92767384"
X-MGA-submission: =?us-ascii?q?MDE8jCETirFH3FmfqY8nN7Os6GTR6OKpetjP3G?=
 =?us-ascii?q?Al5MIgAO/o1t8Tv2siy4WTry9f19ZefuWF1xMuyHHpfRu2PR2RS1jJry?=
 =?us-ascii?q?vGpHVO2vHH0kQ4abEPkaaWYRz3gjlXZLGD1+IYM1LX2C3oFMvIxL9Rgp?=
 =?us-ascii?q?B2p0FoEbcgv4W2TtIWietZEg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 12:50:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721731823; x=1722336623; i=markus.elfring@web.de;
	bh=bFV1ApnZr6l41hbLy78ecKlgGLcfy1MgJ0JGOpKuthU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=edt6oRj+1Z/TF3SRe8VhID6W/uslTRY96qmg51fHfnDW25ZTK07M/O2CDf4ctyci
	 jxdqhsI8yrX1KciwXoCZTBnk6GTWcwhjBubutSUuGMyWojcHz7eJr2EEXN5gP/ik/
	 bv4jjtxF6W1GvCN1iAWL2x1s47xehV3AXrq3EM5Z1cJNuyKzQcSaPMgNq7rbJiqPC
	 EUxwTXNs2NBIGDwEAjHb5gRStUMH84SuSoOkj1s0FCie/jPRGyIlYq0axFOpmN7t7
	 1C3H1dxHzThmyeL2xXGbwClJD19TsQFDC9Rp0WiLp7eIfkQOZsX5XzAYi8Y1YX9UQ
	 ZhUakhYFGhU/LTWjWQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDvDi-1sdwr52AbM-00BgE6; Tue, 23
 Jul 2024 12:50:23 +0200
Message-ID: <57cc9da4-93ad-4279-a175-2e291ccc8a47@web.de>
Date: Tue, 23 Jul 2024 12:50:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, kernel-janitors@vger.kernel.org, cocci@inria.fr
Cc: Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, LKML <linux-kernel@vger.kernel.org>
References: <8ff2d1aa-4c48-4cb1-b5d5-675adb90ae81@web.de>
 <mbv6jl67qw43ruzf55yzgdo7zrusvuod2c3b7cfgliypyh7pgf@mqneyza5cffr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <mbv6jl67qw43ruzf55yzgdo7zrusvuod2c3b7cfgliypyh7pgf@mqneyza5cffr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XPtjKtOmu+o1KiPudxOTGi3zEakWysdnmkb4xMg3GL/Xjgum9h7
 rvU7oC2MlNYESZIUF5C8rdKOgBA7eQmpxRoG56BsXWmor0fzdhqxObsRahUxGlc/hRCG3AH
 dFFrmh+6yJo2G12Zmn5oCrFsOAfghrTclwc1WArIp3R3hSoeuYRM0cmnqAeZt+NUnQYpNSL
 z8V+plr+Bmf/rrUWpVlxg==
UI-OutboundReport: notjunk:1;M01:P0:u53tujkg5OE=;QR1UYRuThn7/hO8mc7T4sdzZ4vJ
 lAFwAKSsLPp6NmXwrC5pyQrgLE+i2iSVtFfuc3AY6fS7otaojj6325sTP6DFR5EZ4rdo/R6sv
 UKBpUKUc9YttrbEv2bu1t3+ZRURZ956g+zgCqMkTyeS0pFoM+P1JwuOm1C+LSobZbR2hG1+Kp
 xTbpwgsRKA5Kxdiw/5UFGAoevXKDuMq9V3rGBQlDb7x0zDf3jXLnVDLX7S/3E3Uw/LtHtogW/
 hw/xzzH0C/s9BDSDIZFEtIVIdc5gfeEkYEFb+nZ7NP7Q5byN9YOzT888qt65fLlTeixKo7oQ7
 Uwlj4mDL4pDsR7ZUtwrNxgBOM/+NBaE3nPgyEiN6ft4Nx9wZDyiDPUwOMnPM1JNET0/kd7Dmb
 7PA2fXfBDFrz+ExaUjIn33ySCQJ5gnQ78Qa4ELyHKS8cliNxEHWRq9nRrsN1lnZjRbA65AFxY
 Gko8k6PC/Ucayk9di8OvpZmYYITwERahqZFpp3buEuqWs9bkgEa8YClgesQA3VTJ+FtE6Cr/z
 RMXYPv0qdpcEiupZcKXsrbmLXOtyWNdBRoahRTotfaU1922NU3fJXU+cj6G9E6w/uGQ9OgZuH
 sz3p6gjVw2aCsfuYyeef4HCEVekPDGIl0yPQzWdptRVHwt15GvgGSVZnZ65rM2kjiDrY91/jb
 Gh/sRoqeyDiPr2U0nPGp66Cswp9UMTdjp9vbX9aDbwfgh5sCtzcG0Ztb03CjCMSGoJPfyzdMA
 Jm43tjRUw3Su41g7EQ0OCOErniOWwa86vDgi8Nb1RfQdcRVWVfTJuLUFOzlzdoMAaDYiGaSOR
 jPiDqs3WKB4XOSGV8dGRygng==
Subject: Re: [cocci] cgroup: Use seq_putc() in three functions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1813
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-07/57cc9da4-93ad-4279-a175-2e291ccc8a47%40web.de>

>> This issue was transformed by using the Coccinelle software.
>
> Maybe that would better fit under scripts/coccinelle/misc for optional c=
hecking.

Would you like to support any corresponding developments also according to
the coccicheck tool?

Regards,
Markus
