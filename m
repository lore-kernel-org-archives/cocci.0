Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51709D116F1
	for <cocci@archiver.kernel.org>; Sat, 29 Nov 2025 13:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=G+u1MnJy3SlTlXfixOd91ZjQLlLyT4PItvJyMCC1KDY=;
  b=F7aS30G7fYfZrsPlrrVs1QDa7/nJsTSqd8oopE4J9ZLSwpwzj0dePntx
   JIkS9vPar/oLrJSYq5Haw2XjOy6y/+itVV6U+9hH4l3syF84uJ9aQBO2I
   yBqSrjW9eOyGTuRLPzFPow30NBC3hdjDpJvHYeflWBMZSNuYS86Rrv96T
   w=;
X-CSE-ConnectionGUID: R718lDt4TeiVJ4mExilZ2Q==
X-CSE-MsgGUID: FJUU0c3bTSKqAVlyQo/Kdw==
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
X-IronPort-AV: E=Sophos;i="6.20,236,1758578400"; 
   d="scan'208";a="251886809"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Nov 2025 14:11:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4C2C7E01A8; Sat, 29 Nov 2025 14:11:10 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CFC12E0157
	for <cocci@sympa.inria.fr>; Sat, 29 Nov 2025 14:11:04 +0100 (CET)
X-CSE-ConnectionGUID: byzgNg7qR+eD9lZO3bchrA==
X-CSE-MsgGUID: 6oE6sN10Ruak7OnoL21VIA==
IronPort-SDR: 692af0d9_+nuUSQBEaG8E1plJuJaTrE8G/h6I74tLuB0gMd2DOLfKZq4
 fdh9axwzkVNnOBJRadPUoX+vi5aMlf07Zy98x5w==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HODACE8Cppg07ASNlagQmBUoI+gQIGWDMEC0mEVY9Th?=
 =?us-ascii?q?l+PEYh5gxU9Ag8BAwENPREBAgQBAQMEgUxAgmuMcAIeBwEENBMBAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBAToHDjuGTw1JFgGBe4EsZ?=
 =?us-ascii?q?Qk4AQEBAQEBAQEBAQEBAQEBAQEBARYCPQptHQEBESc0AiYCcwEBgn4BgiIBB?=
 =?us-ascii?q?hABAzYHDbFHgTKBAYIMAQEGgmnXdh8sIlmBZAMGgRwuAYVtgkobAQVuihoPg?=
 =?us-ascii?q?VVEgTyCUjGDHwIDgiqDDoJpgiaBDplWgUocA1ksAVUTFwsHBYFjA4ELbjIdg?=
 =?us-ascii?q?SM+GHE9V4NJI2cPBoERg0+JFw+KVAIBC209NwkLGwY9lQ1QgkWBJJV5kTyhR?=
 =?us-ascii?q?TQHgjiBZ4FkDIkIgSaVPgYTL4NxAZNgDgaTBZkGjgiVYIVZgX8jgVwzGiSDN?=
 =?us-ascii?q?k8DGQ+OOoQahGDABkI1PAIHCwEBAwmFRgEBimGBdYFLAQE?=
IronPort-PHdr: A9a23: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
 HLrYqBWXho5G6FCYnk=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:lZFU5KPsGsNnG8BcTuOjsMiBIKoaSvp037BZ7TETdfUzSL3+qy
 nOpoV+6faQsl0ssR4b9uxoVJPwI080lqQa3WByB9uftWDd0QPEEGgI1/qG/9SPIU3D39J8kY
 F9bqN5FNr8NlRii93miTPIa+rIjOPnzEiy792uqUuFoDsaEp2JZGpCYDqmLg==
X-Talos-CUID: 9a23:xali+W91HCxSYTNTte6Vv0QFCM8DfSLE9jTdDx68O0EyQraVU3bFrQ==
X-Talos-MUID: 9a23:ALqO4wpYn9dBQzCXuVQez29lGZlzxf32Ml0Eksohvc6gb3VOGh7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,236,1758578400"; 
   d="scan'208";a="251886795"
X-MGA-submission: =?us-ascii?q?MDHCkigsU9k0ZNvDLr5Mr32Az9X2iGCDD6CrVx?=
 =?us-ascii?q?zjEMvWTqS+jau25hQcSVrWmXcgTZFzUpW2wdoHhd0f20eq7UN0AohCIN?=
 =?us-ascii?q?rF7lXstxDZi2jVD7YoEjDAlZI4BVqNo6HLU5ITcrAB8OKRqzk5lZRQIG?=
 =?us-ascii?q?0GDwrtu+hWDZNkRARhy7oWMQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 14:10:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764421848; x=1765026648; i=markus.elfring@web.de;
	bh=G+u1MnJy3SlTlXfixOd91ZjQLlLyT4PItvJyMCC1KDY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FbH/8l+aYbVwcBabEbXIthZkTsh5zifrNRsQo0IJ08FuKdWYfVCti8/C17cYpeBs
	 Uz0HoxYB7Hcipr8NLc1f/N+01z6IqsF7rTRG2ng37bMiu0BjLFmohVquPwpKJhwpP
	 EmPMjuwsNAZIa3xEifLgfKdIGG1cLtAB8+7yNESF0nWDPImMTPDJNpVxaDietsr9a
	 M/4yTgSN2W3yX46rsMmdIe1lc5Va7ktOcmVcliJv9xGdQQIRyWlinxB7wK7Cpvz+9
	 gTdY3WvjXdelDjCwZjIplFlXj4vHE15uxRbtyqbQWjM4JlNiDCO82dYHV1iYfjPij
	 YdB/wfMvHioKKck7kQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.187]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjxiM-1vnMsS1Yk4-00eoN7 for
 <cocci@inria.fr>; Sat, 29 Nov 2025 14:10:48 +0100
Message-ID: <b0db80a9-373a-469c-b95a-f053cb912090@web.de>
Date: Sat, 29 Nov 2025 14:10:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:5EyEBTRj9HjwFUoqq9WSyBBL6/sK2mBa8QyMFCFniYsY3FSSxO3
 zAzS7fG871+ClNbfq0jkPDSYFF89JvNkGxIl3HjtlIJMZRDRXmLzH5XZtN8FMU5MhdZkZy1
 4hgIhJ8b2TZFjwKHRYIoC2x6GlNcaQyq2jDGjjny8Qgxg/QcE+TI98ZlDXJxq2CnHlW9g6c
 odmqLOuoAJIWqiafi3iWA==
UI-OutboundReport: notjunk:1;M01:P0:fHOOUz/ZgC0=;gg3BqE3oBRsPqaY6AcnDBk4IoXY
 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
 +aaJqxjNvvL3kg==
Subject: [cocci] Testing Coccinelle software within Live systems?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3205
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/b0db80a9-373a-469c-b95a-f053cb912090%40web.de>

Hello,

Several Live systems are available.
https://en.wikipedia.org/wiki/List_of_live_CDs
https://en.wikipedia.org/wiki/Live_USB

Will any of them become complete and recent enough so that more developments
and tests can be tried out also for components of OCaml software (including Coccinelle)?

Regards,
Markus
