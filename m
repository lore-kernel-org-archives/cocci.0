Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90DBFC0218D
	for <cocci@archiver.kernel.org>; Fri, 31 Jan 2025 10:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=v/2tW1mr3a7X6+KuJtaKbQN6WobPyIwVcZDc9rIfc4k=;
  b=MjByRGBaJFOeqd8Yrj1O7ZKuQXb+Wyy/bn2JO8770WhOtWUjLkVLfLW+
   Z/Mcd8Xq2j1D1qNZvl5rD6juBFWHqGWQyZDOIJwTdE01K8sEw00YnCeRR
   RU2fuyftn1L7GeiZpozCjD/ygYNpB6jxKzVPxBa0DhGNEOqPVXgu3oKEv
   U=;
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
X-IronPort-AV: E=Sophos;i="6.13,248,1732575600"; 
   d="scan'208";a="205927044"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 31 Jan 2025 11:05:52 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BDF9DE0D1D; Fri, 31 Jan 2025 11:05:51 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2AACCE0260
	for <cocci@sympa.inria.fr>; Fri, 31 Jan 2025 11:05:47 +0100 (CET)
IronPort-SDR: 679ca07a_vyPAD8g/CkaRys4lfmdBJ0dhLiTjL1OCv924BGzBAzouES5
 up0meqgnnMXPhW/Atgm4+fgFV3Eo2Ex57D2A2QQ==
X-IPAS-Result: =?us-ascii?q?A0EmAAAjn5xngAwR49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFBAwEBAQELAQGCQmIbWjMEC0iEVo9PgXQwhDuPEIh2gVaBf?=
 =?us-ascii?q?g8BAwENOwYBAgQBAQMDATiEPgoCinsCHgcBBDIHDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEQAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYV7DUkBEAGCBwGBJIEmAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECDTpEAQEBAgEjH?=
 =?us-ascii?q?QEBESYBBAsLDgwCJgICVgYBEgIBAYJ+AYIvAQMOIwcNBrQPeoEygQGCDAEBB?=
 =?us-ascii?q?oFGAgwCQ9hCHywiV4FlAwaBGi4BhWqCYwGGJoNCeicPgVVEgTwLgng+aYFhF?=
 =?us-ascii?q?wOFOoJpgjOETGehYVJ7HANZLAFVExcLBwWBKRA4AyAKNjECFA0QDwYQBG0FN?=
 =?us-ascii?q?UE6gg1pSToCDQI1gh4kWIIrawQFgS2CO4RFhFGCRlSCRIIUeGsDAxYQAYMne?=
 =?us-ascii?q?ByCbB1AAgELbT03BgMLGwY9ngU9hUACXX1jpF+hOzQHgjiBZoFjDIoplTMGE?=
 =?us-ascii?q?y+DcQGTUg4Gknsuh2SQaiKLaYF5lUeFY4FuCCuBXDMaJIM2HzADGQ+OIYQtg?=
 =?us-ascii?q?QuDVYoqAbkbQjUCOgIHCwEBAwmFRgEBiGGBf4FLAQE?=
IronPort-PHdr: A9a23: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
 eRjsz5EZXRKSPcg5P5npBtVBg==
IronPort-Data: A9a23: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
 avLelaw
IronPort-HdrOrdr: A9a23:/2WJHa5uU4SoAVtXpAPXwCXXdLJyesId70hD6qkRc20uTiX8ra
 qTdZsgpHvJYVoqKRQdcLO7WJVoI0msjKKdiLN5VdyftSbdyQiVxepZnPPfKlPbalbD398Y+6
 MlXKR3FcHqAUISt7ed3CCIV/glhPeImZrGuQ4c9RtQpMNRBp1I3kNWDACUF0EzfgVACJYjUL
 KB+8svnUvGRV0nKuq8AHcBU6z4q9rHmImjTBICCxAu9QmJilqTmdzH+tSjsCv2mgkv/Ysf
X-Talos-CUID: 9a23:ZE/FHW4R8symtuY8jtssxFM7Wcp6aybmwHaNBVKcG2BAd7bLVgrF
X-Talos-MUID: 9a23:jun1QQs/fvWLLr8V2c2nuBtbbNxmwI6UJh4Hk5Fc5cmcHnQ3JGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,248,1732575600"; 
   d="scan'208";a="107843849"
X-MGA-submission: =?us-ascii?q?MDGftxa6Vh4bQxL7Fq2fxh0ed2+sd8IMONB7TL?=
 =?us-ascii?q?j/vmWL1NPaEx70d33PQ0DYGV6qGxHEgBYWjuYCMfsUgbmYZYB+N3ZHbC?=
 =?us-ascii?q?Z9gjrGaPFMPV5R9CG2dZkUrCDlcUsR5K/b8712ni9LmQ3kUT4r1Wh6OF?=
 =?us-ascii?q?BX0smFKWTpGDyTYfYah9sr5w=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 11:05:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738317934; x=1738922734; i=markus.elfring@web.de;
	bh=v/2tW1mr3a7X6+KuJtaKbQN6WobPyIwVcZDc9rIfc4k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bU3a09iwEa5ICO93iHuImDsr5ElGZaC23E3XiyU5nIZCo8PZD2couY8h7zyA0rFV
	 TMOr8MiFR0s2QwzR79j508FqowaxmNKp6vKy3gwo8S3i9MiqiIq31BRQbNnKn+Wu+
	 /GWTqwaI2YfXHddmGqvVoBQ3aC12zzWtK9MyNQWHLn4aaBjndBzGDvySlVCDz7qZI
	 aDTezq8C7neC9ue0PmrTsHxv/ep6aDdE3U6OliFl2Rl9ObJuCsT7EFcMQXg8pFMQL
	 Onq/S8YmPS2MuN/ohdWT+UTP37gBT0MK9My3u01r4m3uBS/0D0IoKx6Z/VQSlfXgW
	 od61ia3vmnzZ+t26oA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.48]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDMzM-1tm1d228L0-00Gy5G; Fri, 31
 Jan 2025 11:05:34 +0100
Message-ID: <e0c6e1d8-a04b-4405-8e40-22ec9a7f8b21@web.de>
Date: Fri, 31 Jan 2025 11:05:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrew Morton <akpm@linux-foundation.org>,
 Julia Lawall <Julia.Lawall@inria.fr>,
 Easwar Hariharan <eahariha@linux.microsoft.com>,
 Ricardo Ribalda <ribalda@chromium.org>,
 Victor Gambier <victor.gambier@inria.fr>, cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Nicolas Palix <nicolas.palix@imag.fr>
References: <20250129-secs_to_jiffles-v1-1-35a5e16b9f03@chromium.org>
 <fe13604a-2626-4641-908e-87eeaca53288@web.de>
 <CANiDSCvufe0nK_NLykSRLb9RmttNOhw3-mm6aiC=gj41Hxtgiw@mail.gmail.com>
 <fce88885-8c10-4f22-a19c-3b04430aec3d@web.de>
 <35764b92-edf0-490f-beea-c36207de4cc2@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <35764b92-edf0-490f-beea-c36207de4cc2@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:HM/PaLfpWy3mNJ1btQkbUC48XTQLmL2z+E8xWqOsjYv/xDWnSFh
 JVAYb9qX48HQHg98Bd5p+J02oq0AgaSunuvzaS5C8RdSnoq+aa7c+K06ASoDTFJa4PSVQSc
 wolP4nbA1fRgUNu7Cskk5yrxJDlVcQZVJz6NhmvRZJ8SmpLnyyGL3u6fShABh2SBnmjaYmG
 F9/umCKyiJp7fA7wuJMCg==
UI-OutboundReport: notjunk:1;M01:P0:rrMajmTh5+Q=;k0WsUkaGp1LRfrGr2AC67cFc5ut
 L5Iz/qsOc8P+peCEPfHF6XQWZXFValPm5M8/REtzJWdL/qheLoK8rdCN9xP0NiwtG7mssFztW
 95aLirtstMvOsLi+AGdVoA9hSUZrIEF4AEoarZGeCNX/xjeafbMXGSbBbBkiStL7c3emxwOiN
 NAbsQOyaZ0uafAds4zvdAv3i8Vout3OPx9Kr2Kfaf1Q4uJBnLIdlYbJYRTCQQcmrrBFGhRAZ/
 ok/gNrxWndkNYUbwxqOBzz8WFJcmZ+aiSx2Q40zik/RQdE97FbicT0ukQWKU1X6xJWXOBzN7Q
 uvH150uF1rzEZV77Xvz9SvmlnZo6RKQQM3RnVSJqtLUPnuNt7fOepd/oChG1NkUHY+5HMp3Mb
 jHlm05dmI9zke7lkf3dx0xdlH8AKrvdvDlNjMIGy/haX0TBgXgPY8SFxRk3ZSj8FurR84bd2/
 ZqqhSprJ9Ud+hzJsvk1Oll3QAdLm3hwU1TOk5KeC//t4dhN9Ry5iSqpgZNV5rHoXH8Z1vpO5z
 HBZivPn9W1tneyPEaoKerZTBUheXMJE7GQuUOZ8flnzm5ifDAHFkrjfrDYMLyBYyPg3XLg92w
 7I+eZKFcdLU2OR2Px8Fh61ZUGux0sF3+bDQI+RhCXgLcBVvP1gawfawrMrkE6Cbnk+uqydmIr
 yZ/Xrn+3CfxhVVjCMh/+b6YKeUXiQSB7w7jAToD17wWCe7Tvnta9AOPe6DEpmbkXjwNoKkIAP
 1O1N6B8SoXtiRYYGOAYJV2lPXOGfrTXmZIsVtHrt2TT0NoLNyfhC8FyAZFmUgjD1lASdZeYpc
 B0Az87IKjzeR1XnLzQ2TwVx/wBpKfKj4AjvmtSmDZw8HyRVyPYLqdMT4Rgmr+OcbDeIy8m1Zw
 kJRTL65jq3fXeD/a8q3vZKjw6opBB56NFg3osd7fBrM8dd+LPyVn/tV37soHSKBg26j9ML2O5
 u7EtMALW8TldF/PkRRqyzaKfMxJs3BBx0H0VQBVTcFBLMNudLVhnAt+EwcgxyLCav6SRh7xOw
 FmtfV8K0eOTHJ9lkCt37zVARk6OLzP/KfCJ8eYN2P3aoklWWGBWJIKGAkj5Q9278+xW63G32/
 LecQ+tUgXGpTKfd08S+LHDuS7Q0DtuS8e5OyrXWO2uN4nll4JPprP5znj8q84vIx9dYkJOEoJ
 4MaCdbSn5ezuKkh5gCIaOCNNEZrHWEdHXzWqfx/ShfzfQVgCmf9MJ6sQ3mV8iZofEnMci4H/T
 s8MTgZdbua4pLjJWehJj8OPW9LaxQqmNh35fUAMGrGwC3JEwePzCCJeQdLJ+aZQ5Yk3+oA4YH
 tjB1s2rFhRbz5HkHkwnuGAakBEveTsM6rasqYn9UET1osIY4JFPmEHRk0L2m5Y2z0CX
Subject: Re: [cocci] coccinelle: misc: secs_to_jiffies script: Create dummy
 report
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2325
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/e0c6e1d8-a04b-4405-8e40-22ec9a7f8b21%40web.de>

> Either provide a fully working example or stop nitpicking useful patches for projects you don't maintain.

Would you like to support any of my contributions a bit more?
[PATCH 01/16] coccinelle: misc: secs_to_jiffies: Patch expressions too
https://lore.kernel.org/cocci/e06cb7f5-7aa3-464c-a8a1-2c7b9b6a29eb@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2025-01/msg00122.html
https://lkml.org/lkml/2025/1/30/307

Regards,
Markus
