Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD538CDE000
	for <cocci@archiver.kernel.org>; Wed, 24 Jun 2026 10:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=d1dnc+z7sYDh6WzLdAv6pbR84oMHSs0zP7eOQfrcf8M=;
  b=U28QM/Wuhe4fqWY36mh0iiqnHf+KPn4efIlQNiRHRlacOxcOWPa+ihwX
   fDoPDsUeEFLPnYuTqZxwWYDSSNrwVqfAf8XZ9XuKOXTrcg38AaFxJ1E/t
   /snFlJCL4hwLNCIPyrSxxhd+kG5kdq6sX18AZ8MyRJz7Vam9Mtpmijhfu
   A=;
X-CSE-ConnectionGUID: byffQqSPQa6qtlp2GFlWVA==
X-CSE-MsgGUID: VP4XY+88RqucKErZrvxt9w==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.24,222,1774306800"; 
   d="scan'208";a="283171899"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jun 2026 12:44:19 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 6888A81870; Wed, 24 Jun 2026 12:44:19 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id A52868069C
	for <cocci@sympa.inria.fr>; Wed, 24 Jun 2026 12:21:25 +0200 (CEST)
X-CSE-ConnectionGUID: ihvEk7+fSDOsSksKmsqe/w==
X-CSE-MsgGUID: aKZQgL56SAuHw140g2hTtQ==
IronPort-SDR: 6a3bafa2_ICPmV431x3p9rRBZNJ34ArunEfOVOQrgeB+gb/SF9j0d6ji
 YgQariQnEKRPLkswZ8IomRTH3YCRn1uI1ANlZmQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HFAgDsrjtqg07ASNlaglmCQYEKXjQEC0mEWI9Thl+PE?=
 =?us-ascii?q?Yh6g1ECDwEDAQ09EQECBAEBAQIEkkwCHgcBBDMGDgECBAMCAwEBAQEBAQEBA?=
 =?us-ascii?q?QEBCwEBAQQBAQECAQECBAMBAQEBAhABAQE6Bw47hk8NgluBLIEmAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBHQINOm0dAQERJzQCGA4CcwEBgn4BgiIBBhABAzYHDbYVgTKBAYIMA?=
 =?us-ascii?q?QEGgmrXfR8sIluBaQMGgR8uhXGCThwBBW6KJg+BVUSBPIhSgw6CaoImgQyRA?=
 =?us-ascii?q?oFKHANZLAFVExcLBwWBZgOBBm4yHYEjPhc0WBsHBYEdgW6BAQGFAiMfAzl/g?=
 =?us-ascii?q?UCBJGRmFTA1gQIRHgqBLgIBC209NwkLGwQ9jU8XD4N3gQCUeZE+oUY0B4I4g?=
 =?us-ascii?q?WgFgWEMiQmBJpU/BhMvg3EBk2EOkwsuh2aQdI4KlWCFWIF+JIFcMxokgzZQA?=
 =?us-ascii?q?xkPjjqDaTPOCUUyAgE6AgcCBw4DC4VEAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 T3TFrMc8/RxLlxUqT4v28GG
IronPort-HdrOrdr: A9a23:9D+dP6DOmehVF7jlHemO55DYdb4zR+YMi2TDpHoBKiC9Ffbo8P
 xG/c5rsSMc7Qx7ZJhOo7+90cW7MBHhHP1Oj7X5X43PYOCOggLBQb2KhrGSpgEIdRefysdg9e
 NHb7V0DsH2AGN3lMDg/WCDYq4dKZW8kZxBno3lvhFQpOxRGthdB4wVMGymLnE=
X-Talos-CUID: =?us-ascii?q?9a23=3AqFh5Fmi9UvUVg+Fj0EhD1W7WsjJuc33D4XSPYEG?=
 =?us-ascii?q?DJUFyc76OalqL4a4jjJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AbOGj4w4TKiJLxtFE9FeVz1MbxoxhwJaXB2RQz64?=
 =?us-ascii?q?vpumbbHAoNG2dsCiOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,222,1774306800"; 
   d="scan'208";a="283167574"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDEODX/0dPpq/N57dMtLJUvAdY0qJXSyoF5/Dg?=
 =?us-ascii?q?/mpyEIlRUUOt6ZhP8fwHodMkgbnJ92j4aPCAUhO/VxSt+RWrKnmqKw19?=
 =?us-ascii?q?cv/CpvoMVYRoz3TnjLm0VPJ+axtwgT1DeTLgMmjQHXUVC3OGheCKaBfo?=
 =?us-ascii?q?87QRIb4meLGfVoTVnLAtJ24g=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 12:21:22 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mkmzl-1x0cOM3xmx-00kd3g for
 <cocci@inria.fr>; Wed, 24 Jun 2026 12:21:21 +0200
Message-ID: <3455eaa7-297f-46c9-a8ab-91e5bfbe0105@web.de>
Date: Wed, 24 Jun 2026 12:21:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:X5XXL5d/Hs+WwqLX+G0AqcMlzobbp1P58BJQuaeLOLFEJDVxuQ/
 2192jZIVr00gVxqbJ/iy5cQpmChC2fhMCAzENS0o397ET5LxB8yj60ABIuCHZbWAr24160a
 UVYQnQ8o7KKLyThcD3T5tgYCiDFyL6Ngrk1seVgdTduglcEum7wLmslboqtfU1bAy9I45Db
 dC8xHMvsT8YgCXBngNLpg==
UI-OutboundReport: notjunk:1;M01:P0:+MDX56cQy34=;UhIfmd/+O25yMJFSlS/UHs5G189
 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
 qqGjmG54C8FbumdNVx50p60/iwR9NEBICbJs=
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] Using seq_buf_putc() calls more often?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3586
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/CasWtf8cd_XGDtBFZLPjNQ>

Hello,

I noticed another improvable implementation detail once more
also according to seq_buf_puts() calls.
https://elixir.bootlin.com/linux/v7.1.1/A/ident/seq_buf_puts

Another tiny SmPL script variant:
@replacement@
expression e;
@@
-seq_buf_puts
+seq_buf_putc
 (e,
(
-"\n"
+'\n'
|
-" "
+' '
)
 )


Would any more contributors become interested in such a source code
transformation pattern?

Regards,
Markus
