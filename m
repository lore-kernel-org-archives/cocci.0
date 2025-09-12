Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A93CAC582
	for <cocci@archiver.kernel.org>; Fri, 12 Sep 2025 12:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=2nEM+CPyetv/YOn0ORKQMuC04uu70MQPF9BWVnxKOBk=;
  b=AFu9mMORG9yz5cllAFdiE/7Vb+W87UTtsxNyfaLdgcMP7Zms8qJBnl9r
   rmk0Z/GpPc9K0Bzkgaen2+oXF/6Frz/06QRqNXNVVCo1FrzvTrwExuZJS
   8tvkHw1WIjTuZme1r9I0p2OOMkYDOjotGS2/ugVfQRO0ify6jcThETMoS
   s=;
X-CSE-ConnectionGUID: Z3agtd5bQtOHLUUYqHamFA==
X-CSE-MsgGUID: yYibUOFOSqif7L0Z8iiISw==
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
X-IronPort-AV: E=Sophos;i="6.18,259,1751234400"; 
   d="scan'208";a="238797642"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Sep 2025 14:31:03 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C0E7FE0172; Fri, 12 Sep 2025 14:31:03 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 39C6BE0171
	for <cocci@sympa.inria.fr>; Fri, 12 Sep 2025 14:31:00 +0200 (CEST)
X-CSE-ConnectionGUID: pBvd6afqTdWbTkTGWoBryw==
X-CSE-MsgGUID: IJmLQFW1Quu7ingFIbdr7w==
IronPort-SDR: 68c41283_FLgX0DiqmUZyETErF8/xE9zNJjrGKVgpgHznE4d9agi7yyv
 MtDqRSnY1T5cWH4hD3SWoAH15oiMNhAvU60Fr6A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FRAAAWEsRogAMP49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFTgkCBAgZUMwQLSYRVj1CCJIQ7jxGIeYNSAg8BAwENRAoBA?=
 =?us-ascii?q?gQBAQMDAYIMgnQCjDACHgcBBDQTAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBA?=
 =?us-ascii?q?QECAQECBAYBAhABATsHDgoxhk8NgmIBgSSBJgEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAg06RAEBAQIBIx0BAREnBAsLGgImA?=
 =?us-ascii?q?gJWBgESAgEBgn4BgiIBBhABAw8mBw0GsU6BMoEBggwBAQaBRgIMAkPYRh8sI?=
 =?us-ascii?q?lmBZAMGgRsuAYVrgmQBhieEPCcPgVVEgTyCUjE+gmEDgV+DW4JpgiaBFoNYm?=
 =?us-ascii?q?C9SeBwDWSwBVRMXCwcFgSBDAyo0MSNLBS0dgSd5gweBDYQeK0+CHHKBdD4ZQ?=
 =?us-ascii?q?YNTHgZrDwaBFRlJAgICBQJDPoFrIgYfEgIDAQICOlcQgXwCAgR/QAIBC209N?=
 =?us-ascii?q?wkLGwY9lgmBAYIwgTcCyHo0B4I4gWeBZAyKLpU+BhMvl1IOBpMFmQYii2yBe?=
 =?us-ascii?q?pVzhUaBfyOBXDMaJIM2TwMZD44hhDOBC4NVtDxBNQI6AgcLAQEDCYVGAQGMV?=
 =?us-ascii?q?oFLAQE?=
IronPort-PHdr: A9a23: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
 SRZ
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:hFe/OK0tSypRNdDcfnTHMgqjBGwkLtp133Aq2lEZdPUnSL38qy
 nIpoVj6faUskd2ZJhEo7u90ca7Lk80maQFhbX5eI3SOzUO21HHEGgB1+ffKlTbckWSygce79
 YDT0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaEZ2Ioz0ZNu6BeHcGPDWu6KBJb6
 Z1bad8zQadRQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AhC6O1GvPtoFDfDDUHrokJp9K6Is9WGPRkn7eOnO?=
 =?us-ascii?q?0NmxVS4G6dli64rJ7xp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AV9cMvg5Wtvt+dSymP8I+R7BCxoxJwaGKMW4yyKw?=
 =?us-ascii?q?bppaFMyNeGj2RlmuoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,259,1751234400"; 
   d="scan'208";a="125346906"
X-MGA-submission: =?us-ascii?q?MDFPJ1Io54ddxRvC30f7VjSOJlRJdvj+5R9MEH?=
 =?us-ascii?q?y8FXea+golqsk/9VCbZLmtL9O4WtOYpJydI9SiRLVTh4F0JqroiqRAGo?=
 =?us-ascii?q?hq0NvbQp9/8So+qBIx9nbPxWZgn6BaD3xwk1lbD+NRSUuovoQ7wnB8ok?=
 =?us-ascii?q?3WitAz32QKEfxVxDsaEMl0LQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 14:30:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757680258; x=1758285058; i=markus.elfring@web.de;
	bh=2nEM+CPyetv/YOn0ORKQMuC04uu70MQPF9BWVnxKOBk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WEMXv/M5MszT2Hrq+4hnH9AboTV0OQoU6Y65C24bK83eH+B3kjyD2lHl+44UvFLr
	 xBlsMLHDQfPsLkMr+sk9QspheyRWO70kbWNaD7hahUzq710tcdTvHPHbxSo2dNmPB
	 tCJa/PyO22L1/KBJ+bMuVmvhLuw+r2qvfyNUeNXUnbdwfupSi7/jwvWSNRoYXBBlV
	 hcdvcK7zW+IkyBGmT+E96s+/qTUTIjU46I4eLs2slEZe52bj1vfBrs1lCH+XMeOlm
	 AaF2fcwZsYSUkpd+UCs6lUEbDO/r+iH1rLptmGp5huQ5BZWP0rlJZo83grtw3UmGM
	 MrpGpvqMXazJL4oWFw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.219]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N62ua-1uLsew0us4-00yBqc; Fri, 12
 Sep 2025 14:30:58 +0200
Message-ID: <4b034bf6-bbdb-460a-b460-69ae728143f3@web.de>
Date: Fri, 12 Sep 2025 14:30:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <6c2e0db1-033f-4f66-9cf7-dc0eae4bcde7@web.de>
 <1bfe79b9-f7a4-c20-f116-75d9fe1642b2@inria.fr>
 <504107f9-09eb-47fe-96ea-53e375b17eac@web.de>
 <85e2bcd-23aa-cabd-dee7-7ebf2448c83@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <85e2bcd-23aa-cabd-dee7-7ebf2448c83@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:05xzwXzBdX3HbxesHbwXX1Ed9Hx89a6fp4Cvs33nTpg9tOeYCjb
 7NNbPEl0oR2pjfo/afndZ/DetWiV37moTLKRDBYD/dbxZJBy3INb6HWjD8kNavkUuxiCO3p
 Er9k+wUQPBynM51H938snqYe1jy9eATz8k7XriMg66zV082GlpED8D6VfbKqXKqEPYO3W6X
 wz268KhF7bjQXcT1xRJkw==
UI-OutboundReport: notjunk:1;M01:P0:y4O3DO5dRsQ=;H+TMDn/eZkcImAmmMOW4AqQJsMx
 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
 H2e363dsvdvEGpJz71g
Subject: Re: [cocci] Searching for missing cleanup function calls (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3015
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/4b034bf6-bbdb-460a-b460-69ae728143f3%40web.de>

>> How does the shown test result fit to this expectation on the behaviour
>> of the Coccinelle software (when there are obviously places where the f=
ound variable
>> is used again after a null pointer check)?
>=20
> Your semantic patch isn't included and it is not cenvenient for me to hu=
nt
> it down.

I hope that you can take another look at the applied SmPL script
also according to known information systems.
https://lore.kernel.org/cocci/6c2e0db1-033f-4f66-9cf7-dc0eae4bcde7@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2025-09/msg00000.html


>           idn't you have ?dn =3D e; or something like at at the end?

To which data processing constraint do you try to refer here?

Regards,
Markus
