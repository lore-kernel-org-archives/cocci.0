Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3D5C54ED1
	for <cocci@archiver.kernel.org>; Sat, 28 Jun 2025 14:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=a5zC3dXHIII5J9Dy48gjdLkTpzaXUzRypfjbOLjAZZs=;
  b=ZNRqBIYIB+8aAn4uNWU/tKqAMFeHN8HZOk3LjvHCTyGNqLKesA6+Ftff
   Uu6yHW+emBSL8284M0PcqoFtyHGfz/UrEez7rPPpCcK1Npza+1BNSeeFu
   +9zBGufmCeT0zLSnaz913dH+bhA4/1mkCINS9xf4EhMHZ5wTkNKeVtFoa
   k=;
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
X-IronPort-AV: E=Sophos;i="6.16,273,1744063200"; 
   d="scan'208";a="229423129"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jun 2025 16:11:27 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F3CEEE0AF1; Sat, 28 Jun 2025 16:11:26 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1FA12E0157
	for <cocci@sympa.inria.fr>; Sat, 28 Jun 2025 16:11:23 +0200 (CEST)
IronPort-SDR: 685ff80a_tsGngDK15foneLK63gplM2yUw/cIGqaYTyaODslYuIcuqto
 DqqQzLXTECIBbjrY5xnvh1yZbfm7L0ne0K6JHxg==
X-IPAS-Result: =?us-ascii?q?A0FYDgAV919oe07ASNlagQmBU4JEgQAGVDMEC0kIhE2PU?=
 =?us-ascii?q?IF0hGuPD4h3gVWBfQIPAQMBDUQKAQIEAQEDBIR2AYt9Ah4HAQQxCA4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBQg47hXsNgluBLIEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBHQINOm0EGQEBESc0AiYCcwEBgn4BgiEBBhABAzIHDQayGn8zg?=
 =?us-ascii?q?QGCDAEBBoJp13UfLCJYgWUDBoEbLoVtgkoaAQVtihgPgVVEgTyCUoNQBIIrg?=
 =?us-ascii?q?w6CaYImgRaFTYRQjy2BShwDWSwBVRMXCwcFgWMDgQ8yPDIdgSd/hQiBG4RFK?=
 =?us-ascii?q?0+FHkFag10kbQ8GgSFNQAIBC209NwkLGwY9kwCDIYFBlXeRNqFCNAeCOIFmB?=
 =?us-ascii?q?YFfDIkHgSaVPAYTL4NxAZNaDgaTApkFjgeVXIVZgWoBN4FcMxokgzZPAxkPk?=
 =?us-ascii?q?iEzvC9BNQIBOQIHCwEBAwmFRgEBil2BSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:6rRPB6PtV6lB4MBcTuOjsMiBIKoaSvp037BZ7TETdfUzSL3+qy
 nOpoV+6faQsl0ssR4b9uxoVJPwI080lqQa3WByB9uftWDd0QPEEGgI1/qG/9SPIU3D39J8kY
 F9bqN5FNr8NlRii93miTPIa+rIjOPnzEiy792uqUuFoDsaEp2JZGpCYDqmLg==
X-Talos-CUID: 9a23:eZEmQmFrNBVjpQTBqmI7638SRs4FdESF4y2XEVCIKGIwYaGsHAo=
X-Talos-MUID: 9a23:Xr+i7gSOhQa4Vy6nRXTjuBZcGttOzZiqI1gXzrFflO2bLTd/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,273,1744063200"; 
   d="scan'208";a="120196983"
X-MGA-submission: =?us-ascii?q?MDF6ZbT2m5pXbc6y6+B5Irfz7S21xSxp7qent4?=
 =?us-ascii?q?xzTtNPqO2OyQJudZRH9fF6zwPqiaNbdqCXLTkzcdZhWLUt8zLVuY+WEp?=
 =?us-ascii?q?fwQpcxT4fqoe5e2HSiCTDl381FY4+ZlSU1WduCRaZfd37RhtdCs46B/j?=
 =?us-ascii?q?JvamZWCjxX3QZMtPKTETsQKw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2025 16:11:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751119881; x=1751724681; i=markus.elfring@web.de;
	bh=a5zC3dXHIII5J9Dy48gjdLkTpzaXUzRypfjbOLjAZZs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LPBZub0OXLvQ6ioE3z4OcFaZHqrV9/J57Zjwors7Rkj8KdmrcQ3DwAMT/zgEISZB
	 U1Habv8R2DyaJjxrp+wWbnDii+74pFHgFEP7s5m4Y8ZA3BIjsiFXz2/NQH4lbVM33
	 BVVcvlstmdzGLNEExKQ7NeKtrv9mcPPpYURyaypoulILaXQw64E/TBleAvNByeOIe
	 sv8qlnJH5kYR/58BdxYKzajg6rVfKenKfiKvDfOFtuoM1lRKi01pq/7a48sheYsoA
	 6JnxrY8OZ7IcT2tuWNc4jcz6ShjGCOlIRcO6Rv8qfxA5FAO/DorK1GDOEmXWp/LXf
	 ZxiemnHGgeJMEv3o1A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.176]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHmm4-1uYDyp0RBW-004Xee for
 <cocci@inria.fr>; Sat, 28 Jun 2025 16:11:21 +0200
Message-ID: <2038c080-a429-44bb-a572-c1f9e733320d@web.de>
Date: Sat, 28 Jun 2025 16:11:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:XjIK39/gtmeund+CYBblS5arSVZMTAr1QrvwdVQhi1duNZL4abT
 PFIrmsAkVWwJZY5puyt/6CyI9kNtKddlqR6GttdY3T0PMGEWZYMLlWW6RAfmxuN1/hYNVQr
 mHZfu9C3djagP176Qkq1DRTOXBT+pB9riAV/lzPGVu8IBJDNImgGJAKQe844KvZHlalcEup
 bTUoh4SQooolKhHmfqvuw==
UI-OutboundReport: notjunk:1;M01:P0:mMz1hwtAVDs=;J3KAJgGS0oMd1B/3kOTK/Rrcmi9
 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
Subject: [cocci] Avoiding metavariable confusion for duplicate identifiers?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2797
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/2038c080-a429-44bb-a572-c1f9e733320d%40web.de>

Hello,

I imagine that a known function definition can be converted into a source code
transformation like the following.
https://elixir.bootlin.com/linux/v6.16-rc3/source/include/uapi/linux/cec.h#L84-L90

Another SmPL script example:
@replacement@
@@
-msg -> msg [ 0 ] & 0xf
+cec_msg_destination(msg)


Now I wonder which metavariable selections would be appropriate for such
an use case.

Regards,
Markus
