Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12C3D1CDC6
	for <cocci@archiver.kernel.org>; Sun,  7 Dec 2025 13:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=oQyBXhZssFW7/7HECS8te6zJSMGLd9EBxUoBsRrhgE0=;
  b=irMeKMUCpjDjK66Up62ieSI96yJBbwILNzBX/+0ZAKhhAxYuKZAZHzYA
   b1xZVbPrEmeJrcYjT3QoA3uQQzKkbE8MGjUugRnFOy/a2eBLiJi47mcrs
   dnRPO8Ob86cH80rBzUjrgW2KXlOtWAiJpLBm55eKMKyQlOKZsZ9l0ju1Z
   M=;
X-CSE-ConnectionGUID: 1f7V75GhRYu2IuZsdxBpRw==
X-CSE-MsgGUID: +uivw9fdSq++ENT/7igZ/A==
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
X-IronPort-AV: E=Sophos;i="6.20,256,1758578400"; 
   d="scan'208";a="253175813"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Dec 2025 14:41:02 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A9694E00B7; Sun,  7 Dec 2025 14:41:02 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 20CFCE00A5
	for <cocci@sympa.inria.fr>; Sun,  7 Dec 2025 14:41:01 +0100 (CET)
X-CSE-ConnectionGUID: Bxr6z6e4RNiUHgWE2juVdQ==
X-CSE-MsgGUID: e4WhzGRfTY2Pvw1MP3yekQ==
IronPort-SDR: 693583d9_jUxTK/1cD5MrqrHi3/zxZ0oeVmONzvamnsZ2tx26xILGluB
 aRNq5vHkvQSckSZXSbByg2wX/+fOQD8dXDN6X6g==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0F4AwCbgzVpgwsR49RagQmEEGcfBlkzBAtJhFWPU4Ikh?=
 =?us-ascii?q?DuPEYh5g1ICDwEDAQ09EQECBAEBAwSBTIJuPQkCjGcCHgcBBDQTAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQE6Bw47hk8NgmIBgSSBJ?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAQEBAQEBARcCDTpEAQEBAgEjHQEBEScECwsaAiYCAlYGA?=
 =?us-ascii?q?RQBAYJ+AYIiAQYQAQMPJwcNsWSBMoEBggwBAQbaYR8sIlmBZAMGgR0uhW6CZ?=
 =?us-ascii?q?QGGKYQ9Jw+BVUSBPIJSMT6CYQKBYINbgmmCJoEOhh+JeQaJKFJ4HANZLAFVE?=
 =?us-ascii?q?xcLBwWBIEMDKjQtIw88BS0dgSMhHRcTYD0XQINJGAYdSw8GgREZSQICAgUCQ?=
 =?us-ascii?q?DqBZiIGHBICAwECAjpVDIF3AgIEghV+ggoPh0KBCAUuezECAQttPTcJCxsGP?=
 =?us-ascii?q?ZR+ToNcECKCGzrGAzQHgjiBZ4FkDIoulT4GEy+DcQGTYA4GkwUemGgijWabO?=
 =?us-ascii?q?IF/I4FcMxokgzZPAxkPjjqDZzPCRUI1PAIHAQoBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 Pwhoofv5eURkAmoqSnB3ek=
IronPort-HdrOrdr: A9a23:CaDHW63paG4JSHpdmiQkeQqjBGwkLtp133Aq2lEZdPUnSL38qy
 nIpoVj6faUskd2ZJhEo7u90ca7Lk80maQFhbX5eI3SOzUO21HHEGgB1+ffKlTbckWSygce79
 YDT0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaEZ2Ioz0ZNu6BeHcGPDWu6KBJb6
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:I9JmZWDPqvAGRJ76EwN37hAGRM15SFvc8VffHGLiC3tXRITAHA==
X-Talos-MUID: 9a23:JJ7zTAUjDzSjcVPq/DKwuzFwG/1m35X0MF4SyLA+4NiJNhUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,256,1758578400"; 
   d="scan'208";a="133014205"
X-MGA-submission: =?us-ascii?q?MDF0sEM9UYLNQix73nUysaqU5ZKtpN1vutKnXd?=
 =?us-ascii?q?rgqbLloG2mGZkD6bMDz1yP/yw3XksdSYo8OV4rO45kmqa2YNPikDWPgq?=
 =?us-ascii?q?L3SlNDDTtEt8r3ONYbIV4sHCrgcCWNS/y7kXTHgd3Li1ZM+aX3PnTl8F?=
 =?us-ascii?q?EqSKWPmU1vgEpTNebSuBvYkg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 14:40:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765114839; x=1765719639; i=markus.elfring@web.de;
	bh=oQyBXhZssFW7/7HECS8te6zJSMGLd9EBxUoBsRrhgE0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bfjJm3yyMlXYKH9Rw+5TeOvl8+xYpSgAL14nosPyzlgNH8H/9ZfqQn8w997+GEdd
	 0dcwkkfCrZZc1AxQRPERekNC4VSb241xXLM9Lkb9y5yZU2hpo9yZ7BrZMFFt6aqoV
	 rLBJv5gCNh8lyXDIUoiNa6rUUKOkycrpALz7nVvdqfN2G1spT5FLg/hQm920lmnws
	 Yd49Z0I6a6zIq8cn4fUGOWvC8MhSvbZhJBWD+f9xK6SLl+hjPhpAkFf57boQ1UV46
	 QcLfr2qLL1O4DXgThIxTBtPm4h4pizLEeoDv5HGhc5JcmogNPgUspZDRpzkw8mCTO
	 NbMaMgwIV4fW918M4Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.183]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mvsq5-1wI8zx2uKV-00vKw1; Sun, 07
 Dec 2025 14:40:38 +0100
Message-ID: <10f80fe1-f999-44a3-a35a-c9e23b4665ce@web.de>
Date: Sun, 7 Dec 2025 14:40:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tobias Deiminger <tobias.deiminger@posteo.de>, cocci@inria.fr
References: <1b8dad8151ef1409adc8cb24c728907a@posteo.de>
 <9ab63cb6ee4a0354c053f22fb0934317@posteo.de>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9ab63cb6ee4a0354c053f22fb0934317@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wSiNO9lagtCoY+qF6boAwTz8YNovt3vUnf6JwZRqCPxzbvAqljb
 WCc3HvPe9hcS0VkOF9M03KWpIaFoPs/Hz8ijuqidP2Fqq/JryxRtDyL+rwNeF96BasztDAX
 YDl+cBsUz+m8naYUYXIfqnEmBVVLvlcQygwiaaqCq99J5UeT6sLv7K5dIG2bJMj91wFlpe2
 GRcYZ052g+RLm6FYiQ6MQ==
UI-OutboundReport: notjunk:1;M01:P0:/Y8xLL4PPbI=;Lnuju8xnxE3mTOYaoMfFBoHvwNs
 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
 dg/Z52EIxevUPtOg7Z0qeg03twWqfK0C3mYQVW
Subject: Re: [cocci] Constraints for processing with data collections
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3247
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/10f80fe1-f999-44a3-a35a-c9e23b4665ce%40web.de>

> Seems=C2=A0to=C2=A0work=C2=A0good=C2=A0enough.=C2=A0If=C2=A0there=C2=A0a=
re=C2=A0cleaner=C2=A0ways,=C2=A0let=C2=A0me=C2=A0know.

There are further development ideas to consider which are also waiting on =
growing interests.

Example:
Improve support for processing with data collections
2023-12-01
https://github.com/coccinelle/coccinelle/issues/335

Regards,
Markus
