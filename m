Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0883410F3DE6
	for <cocci@archiver.kernel.org>; Sat, 28 Mar 2026 12:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=tbfhEhm+15X7Inh0QXV7OUoCHwUK9eyZrxPt4/qYzp0=;
  b=CsIGXDyttozGb28QDAGOOML9Br8pIGZCiv+9pPiDDEZGsx1HY//GDx+9
   Xj0de+/iZOw9QE/VVfgYrxNfKjB02YMUxy44MhIdH7le0yZ/g+b1WSMHa
   Q0LP35dlVLhNgiuqc8rADLSoI8+v4P6S6geF1KVHnRCHVswS+InJpJM7c
   M=;
X-CSE-ConnectionGUID: MVq+Km3RTh+ngQaNVizczQ==
X-CSE-MsgGUID: 9NgHPVFMSZ6Mg6JxxlHD7Q==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,146,1770591600"; 
   d="scan'208";a="269924211"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Mar 2026 13:56:37 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id E8EFA8062D; Sat, 28 Mar 2026 13:56:36 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id A122080506
	for <cocci@sympa.inria.fr>; Sat, 28 Mar 2026 13:56:29 +0100 (CET)
X-CSE-ConnectionGUID: TUFeeUPrRyqH7G6dGlNd6w==
X-CSE-MsgGUID: RFkyx4DqRdqH4F2MLzc+bQ==
IronPort-SDR: 69c7cffd_Yq0w2QU4F7jCrsd/4LePb9kxJV2J9zHUFj/HCN21w2UqL3k
 Qtd+rFe++oERGeDVx8BSf4hZs7KahDCuR6zzKgQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EdBQBDzsdpgAQP49RahRqBB140BAtJCIRQj1OGX48Ri?=
 =?us-ascii?q?HmDUgIPAQMBDUoEAQIEAQEDAwGSKAIeBwEENBMBAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?QEBAQELAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYZPDYJbgSyBJgEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAkdtHQEBESc0AhgOA?=
 =?us-ascii?q?nMBAYJ+AYIiAQYQAQM2Bw0GtFuBMoEBggwBAQaBWEFQ13sfLCJZgWcDBoEfL?=
 =?us-ascii?q?oVvgkocAXOKIw+BVUSBPIJSg1ABA4Irgw6CaYImgQ6JZod2gUocA1ksAVUTF?=
 =?us-ascii?q?wsHBYFmA4EGMjwyHYEjPhc0WBsHBYFgD4hxgWGBEAGEBDUCAQttPTcJCxsEP?=
 =?us-ascii?q?Y1AMYMVWYEFlHSRPIxilGM0B4I4gWcFgV8MiQiBJpU/BhMvl1IOkwsemGiOC?=
 =?us-ascii?q?ZVghViBfyOBXDMaJIM2TwMZD5JUgQvEC0UyAgkyAgcCBw0DC4VEAQGMVoFLA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 R3yN5E+0tVdAn2keArL2sGGvA==
IronPort-HdrOrdr: A9a23:xmITRqhrBZitzOLxznS3mAAZLXBQXvgji2hC6mlwRA09TyXqrb
 HKoB19726StN9xYgBFpTnkAsK9qBznmqKdjbNwAV7AZmfbUQmTQL2KhLGKq1Dd8kbFh41gPM
 lbAspDIeHRSX5nkM39/A60KNo4xsKbmZrY/ds2g00NcelwAZsQiTuR5zzra3Gfz2R9b6YEKA
 ==
X-Talos-CUID: 9a23:aimF6mGMFoqmpAu1qmJbyWAZF/0daEfM1VePDBG0JmJPROOKHAo=
X-Talos-MUID: 9a23:kQDrmgo9McpeKs3SaiEezwtMN9Z4v4i3MkwUscko4eygJyczMQ7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,146,1770591600"; 
   d="scan'208";a="269924201"
X-MGA-submission: =?us-ascii?q?MDHKHZfftKI4GrJCZ/FZYLePKBVsVHMx+ogBjZ?=
 =?us-ascii?q?ut4zVo293OHv37KW/10PUu9HCJ8NXilVeIQiIXx0r31DZJhBnCgEipcz?=
 =?us-ascii?q?wflVVgKaGqzW19N8j+fGK284DrWsK3kvLhb3FO9/RhAnBdBLzpff3zfd?=
 =?us-ascii?q?jZpi+1nJyQRYoatrq8gCiEHQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2026 13:56:29 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mvspv-1vDXB51DVP-014Mej for
 <cocci@inria.fr>; Sat, 28 Mar 2026 13:56:28 +0100
Message-ID: <815c88e4-44bd-4a9e-b25c-324e953decae@web.de>
Date: Sat, 28 Mar 2026 13:56:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
Content-Language: en-GB, de-DE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:zd8K+HD0QufCTqU4Y6lIyVu54wtsRbZ+m2EE83QT05TJykCWEdb
 JNFTLTZsjgcCePRqYRdYVsVMn/fdguSZR7iM/mqQfDBzEsVJyQfJO2ppT5q8xpwipYsE6B5
 c+e6m3dW0B/h4tqaQW/tvt3LFLk4JN2Z8JEdaxv8kRW1Li3+rjuWXjPCXnrFSfSei+nxwoQ
 4eUvRvN/HINMl4v5Swguw==
UI-OutboundReport: notjunk:1;M01:P0:cvGxg6vJcEQ=;YVUY2BhIyTCQDzMBZ6oYpQ3KgL2
 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
 IRsvUJ+v6Pdv9x7JdrKkf7orb3PHR/nvA==
Subject: [cocci] Evolution for data reuse with generic SmPL metavariable
 types?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3465
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/UGZrQtjxYAaLBBCyzSCFrA>

Hello!

Metavariables are supported to some degree.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/03a1af0a3316ddfc2b54d827b8b9627a841c85c9/docs/manual/cocci_syntax.tex#L209-288

I find that their types can be distinguished by corresponding properties.

1. generic

2. number of items (which can be matched)


Examples:
* statement
* declaration


A declaration can contain the following elements.

+ variable type
+ identifier
+ attributes
+ comments


Thus it would occasionally be helpful if such contents can be reused directly.
But there are corresponding data processing constraints involved.
These data would only become usable after detection according to a (compound)
metavariable type.

How will development interests evolve to improve programming interfaces accordingly?

Regards,
Markus
