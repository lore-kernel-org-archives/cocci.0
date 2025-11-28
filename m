Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027E0D116EA
	for <cocci@archiver.kernel.org>; Fri, 28 Nov 2025 10:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=KWiaW+KQsFuof6czkO6AjzySACdite8MBPt7LTcYiws=;
  b=UdzbBVVvDtipDRRxXbQKgout7k+9apH4Aa+OBiCBgG0hyusAnpdJJIXM
   8MGxKJEP0EKOlEUS9+R7kWfFLAK/jLV7L7b3xH+nMUl197RujrgjmYVu/
   ccttr7pVbKoye8NUp6Tpwd8AL0uihGg8bpYCJ3iG9sphOrKA58unKkFSi
   c=;
X-CSE-ConnectionGUID: /sIi3H2oTEucrF9l8TlulA==
X-CSE-MsgGUID: wUdObV1cSwu/qYMxg2cvIQ==
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
X-IronPort-AV: E=Sophos;i="6.20,232,1758578400"; 
   d="scan'208";a="251732980"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Nov 2025 11:05:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C8235E0AF1; Fri, 28 Nov 2025 11:05:41 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CEC57E0157
	for <cocci@sympa.inria.fr>; Fri, 28 Nov 2025 11:05:39 +0100 (CET)
X-CSE-ConnectionGUID: tagiO8PWShWz4TD3CgZf1A==
X-CSE-MsgGUID: 1Snt+xHgQLKl3/vtftnwQA==
IronPort-SDR: 692973f3_ZEr9zvdEWrFJG4qCy/VmYC1bEW4Li/Zr6G5oNIgiyxaw6e2
 OXrC8xQhMWGzNGgrJ9U29y4aoqsKKuvueGYKG/A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FrBAB2cilpgAwR49RagQmBUIJAZR0GWDMEC0mEVY9Tg?=
 =?us-ascii?q?iSEO48Rik6BfQIPAQMBDUQKAQIEAQEDAwE4gVSCLkYCjGUCHgcBBDAJDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYZPDYJbg?=
 =?us-ascii?q?SyBJgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?g06RAEBAQIBIx0BAREnBAsLGgImAgJWGwEBgn4BgiIBBhABAw8nBw2wUYEyE?=
 =?us-ascii?q?26CDAEBBoJp13YfLCJZgWQDBoEcLoVugmUBimYnD4FVRIE8glIxPoJhAoFgT?=
 =?us-ascii?q?YMOgmmCJoEOhiSTNFJ4HANZLAFVExcLBwWBIEMDgQsjDzwFLR2BIyEdGBFgP?=
 =?us-ascii?q?RdAg0kdBmcPBoERGUkCAgIFAkA6gWYiBhwSAgMBAgI6VQyBdAICBIIZfoIKD?=
 =?us-ascii?q?4gOgQkFLoENAgELbT03CQsbBj2VEVCDaZU9sz00B4I4gWeBZAyKLpU+BhMvg?=
 =?us-ascii?q?3GTYQ4GkwUemGiOCJs5gWg6gVwzGiSDNk8DGQ+SITOBC8QYQjULMQIHAQoBA?=
 =?us-ascii?q?QMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 HUmVbJRElA4RKpy4qVNGdsfPNFoUzlinbPJ1KY1
IronPort-Data: A9a23:4iqHPKjLmmXBcECFHhlLUdFAX161NBQKZh0ujC45NGQN5FlHY01je
 htvD2CFO6mJamWnedhzYNm28RhSu8SGzNQwQQJkrCwzFipjpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+e6VaidfHgsGGeIcQ954Tp7gek1n4V0ttawBgKJq
 LvartbWULOf82cc3lk8teTZ8HuDgNyo4GlF5wVkOqgU1LPjvyB94Kw3dfnZw0TQGdE88t6SH
 47r0Ly/92XFyBYhYvvNuqr7aEADXonJNgGIjHdMM4D66vSVjnFaPg4TbZLwWG8P49m7t4gZJ
 OZl6fRcfTwU0pjkw4zxZfX3/xZWZsWq8JefSZS2XFf6I0fuKxMAyN02ZK060BFxFk+azgii+
 NRBQA3hYCxviMqqyb26bblUuf8jE9u3AK9EkX5Sw2jwWKNOrZDrG80m5Pdd2yoswN9DF7DSa
 qL1axI1NU6GOUcQfA5ITstk9AurriGXnzlwjVuPprcspUXXwhZw1rfFL9ffPNCHLSlQth/D/
 DuXpD+gWXn2MvTG8jyZsWKMidbrviegH5wOGqG+6cdD1Qj7Kms7U0FGDQDr/pFVkHWWUNVUI
 E084TsrtaF09UqxT9C7UQfQnZKflhsbRsYWDOAwrg2AokbJ3+qHLnQNQT9mOOQZj88JV2AW+
 gSikOHnXBU65dV5VkmhGqGoQSSaFQV9EIPvTSoDUBdD/NTp5o0+5v4ucjqBOP/u5jEWMWiuq
 9xvkMTYr+hD5SLs//jqlW0rexr2+vD0ovcdv207pF5JET+VlKb+O9zwsgiEhRqxBIeeSF6a9
 GMJ8/WjABQ1JcjVzkSlGb1TdJnwvqrtGGOG3TZHQcN/nxzzoCTLVd4Lv1lDyLJBaJZslcnBO
 h+L4Vs5CV46FCfCUJKblKroUZ16kfW/S4q+Ph0WB/IXCqVMmMa81HkGTSatM6rFyyDASIluZ
 8nJQtXmFnsAF6VswRy/QupXg/dhxTkzySmXDdr3xgium+jWLnOEa6Y3AH3XZMAA7YSAvFr09
 fRbPJC00BlxarD1TRTW1o8xFmo0C0YHK6r4kfEKSd7bEDFaQDkgL9Tz3YIef5dUmvUJt+XQo
 VC4dExq6Hv+onzlcje1S21RR47ueb1drnsLGzMmEnj1+nokYKeptLw+cblud5YZ1eVT99xGZ
 NhbRNelHdJ0VSXhxzQRSbLfvb5SXk2nqizWNhX0fQVlWYBrQjL43+PNfyztxXEoNTW2v85vm
 I+Q/FrXbrRbTjszEfuMTuykym6wmn0vmOhSeU/sCfsLcWXO9LlaEQDAvsUVEeotdyqaniC70
 jyICyg2vePO+o850OfYjJC+8ruGLbFMIVp4LUL6s5CNKijozkiyy9RhUcGJXwznekHaxaGAX
 dhRntbAaKApvVASqIdtMadZ/YRn7fvVmrJq5ABFHnLKUleVNo1dMkS2hclii6kc6YJa6C2XW
 12O8OZ0Ib+mGt3oO39PKRsHbtas7+A1mD7T4a4LIWH/3itW/aWGY2pWLRKjmCxQF5orEYIHk
 MMKmt8a1By7sTUuau25tyFz83+eC1A9SIAli80qO5DqgQ8V1V1yW5zQJSvo6pWpad8XEE0VD
 hKLpajF3ZJw+1HjdictKH3zwuZtv5QClxRUxlskJV7SuN7khOcy7SJB4wYMUQVZ4RVW4d1dY
 lExGRVOGpyP2DN0iOxofWOmQVhBDSLE3H3B8QICkWmBQnS4UmDIEnYGBt+M20Ik6ENZQClQ+
 eCJ6WTiUAuyRvrL4AkJZRdHpcDgHPtLzS+TvOC8Hs+AIYs2Xiq9vI+qelgzikXGBeEfuRT5g
 NdErcdKVL3DFC8PoqcEJZGQ+pYORTulemFTY/FT05kYPGPbeTuNiGGCAB3qSPxsOs7lzE6cI
 O5tL/JpSB6R+nuvrDcaJKhUOJ5yvqcjy+Qjc4PRB1wtkuWgvB92lpPP5A3SuXQOQegyof0iK
 4jUSS2OIlaQiVRQhWXJistOYUi8XvUpeyz+27qT3NgSNpdertxpT14+4oG0s1qRLgFj2RCe5
 yHHRq3Oyt1d2ZZepJTtHopDFjeLB4vKDsrQyz+KsvNKcd/rGuXNvVlMqlDYYiJnDYFIUNFzz
 bmwoNr72X3eh4kPUkfbpoKgEpdY7sDjTctVNcPKdENhpxWgY/O1wRU/+DGfE6drweNtvpztA
 0PybcarbtcaVutM3HAfOWAUDx8ZDL+xdav64z+0q/OXEBUGzAjbN5Wd+GT0aX1APDo9U3Ek5
 tQYZ971jjyZkGhNOPPAL/RhHoM+P1LpH6crHzE0Wf90EUHw6m5ueJO7/fbj1d0PImaJGoD27
 PopgzDgIQ+qtvigIM5x6uRPU95+MJq5qfY9dAQR9raaTtx84HEudYwgDHnNNn2YfuEeGn01i
 PEhoVbO0RnAYAk=
IronPort-HdrOrdr: A9a23:dtFcPqFaLYXZLqxPpLqENseALOsnbusQ8zAXPjNKOHhom6uj5r
 mTdZUgpHnJYVMqM03I9uruBEDtewK+yXcx2/h3AV7AZmfbUQmTQL2KhLGKq1Dd8m/Fh4tgPM
 xbE5SWZueAb2RSsea/xhWkGNA9x9S9/Lmvnvq29QYWcegnUcBdBxwSMHfiLqSafng8OXKzea
 D32vZ6
X-Talos-CUID: =?us-ascii?q?9a23=3AM+ydgWo5X3rSKqK0E0DCbxzmUdwsfXz6nE/vGE+?=
 =?us-ascii?q?HGzpVZOa+Rm2eoYoxxg=3D=3D?=
X-Talos-MUID: 9a23:26PfpgoRHF6hqAyLSG4ez2hZMtsr84ShMWQulc5BpdWKKSpvAh7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,232,1758578400"; 
   d="scan'208";a="132193313"
X-MGA-submission: =?us-ascii?q?MDFSnjNgixcf42uA3ZLF9auZsnsdpeBPLELDKb?=
 =?us-ascii?q?Plbkh7WVW5T0q5aAvXzMFbFVZEQ5KedtwUeh0o9nbdrvVwjVWzIznaCR?=
 =?us-ascii?q?mdyFnnP2pIYNFblFQkXVXcrOZM9LYBbhYnQdEsSyXJmIODM+JwUI6bFq?=
 =?us-ascii?q?33VbHX/G4u8m672MMD2vY2kw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 11:05:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764324336; x=1764929136; i=markus.elfring@web.de;
	bh=KWiaW+KQsFuof6czkO6AjzySACdite8MBPt7LTcYiws=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bn6JK/4pZUgC5fz1B6PjomI/j80gZcKqIaV3WjDMZ9M7TQm4ZlbvcEGk/iAtG734
	 VIsIM3dbJ/YIHsZ0UJYDLxldgDTK0yNHjkxNWigtFxyAgsQhqQoyROSM0yjiAiPc/
	 kXR8d/A7YmG4XznQzPIYw4pvKvzk88hzFhqX+BFQgGpmKV4kl845LRHfaRcAxfRjc
	 arVEhZZTphOBEjuR9Xja+TGAaK++X/TFPTE4Fbb7Y/0soPWUMZ787YTq4Z0DP50GM
	 DbP4xDO8v+th9Dd5X8PNs/gH6vxeWxtJOAqbpMEYp1cF1YZ1eqOS27McSI9KH1Dsj
	 e2ggR1r21B1PDW/vYA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.222]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MT7aP-1vWnxX1QCd-00O497 for
 <cocci@inria.fr>; Fri, 28 Nov 2025 11:05:36 +0100
Message-ID: <aa45d63e-bce0-47a7-b34f-434311ecd9ed@web.de>
Date: Fri, 28 Nov 2025 11:05:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <d08dc115-5c88-4545-8a77-b588382db1e7@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <d08dc115-5c88-4545-8a77-b588382db1e7@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0U3wMRDWvKpQwZYXyutZXQn8JUAzaGERlvZ8X1l8qzbDq90VfuD
 2vcNPDU7Ij+du6lI5r46lGSujIh1oTAKykWtnud1mH3K2qG5DSWFsK3NyOro16loSjtrZxE
 uxVBQJU+ckT8ik9Ped8EiFVoYFCS5OUgqS9xt8UZb+qs6Fn7+L5dO6qn35G2Nnay/+KzOQA
 uoLKKfYixeZrsKmrbZ+lw==
UI-OutboundReport: notjunk:1;M01:P0:3gb+4WTE5Fg=;+9CY9Q+opBnjLjC8EyIuxW3j8oK
 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
Subject: Re: [cocci] Data processing challenges with usage of not operators
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3198
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/aa45d63e-bce0-47a7-b34f-434311ecd9ed%40web.de>

> How reasonable do you find the conversion of such a simple test expressi=
on
> into an SmPL disjunction with 15 branches by isomorphism rules?

How does the generated SmPL disjunction look after the software adjustment
=E2=80=9Cavoid duplicates in disjunctions=E2=80=9D (from 2025-11-23)?
https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/5bf4aac3af217126380=
05c0f4e225fb37c2fd70f
https://github.com/coccinelle/coccinelle/commit/5bf4aac3af21712638005c0f4e=
225fb37c2fd70f

How long will I wait until I can see a corresponding data processing resul=
t myself?

Regards,
Markus
