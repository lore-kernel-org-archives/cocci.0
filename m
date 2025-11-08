Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB11CCFA18
	for <cocci@archiver.kernel.org>; Sat,  8 Nov 2025 17:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=7KrGKJHPaZ8o4j6iu/ZxAqNPqdsrN4pgdB5+UQLWQtU=;
  b=eu9fxR873xFvMNlfZeBYeGbvX/HbbylDkmijhH5XcJ8NmcQYE2A2+2Pd
   WGpIHO+n02GNjmaRYnioRM12aaXxxc9s0yiUUx0Kc4F6YBc0kHB/LdoEZ
   KBmF7snoTQAoSHXXbly8G00vSDfjtZYiEkA+AjgaaG7VBSOEPOxRqA6cX
   M=;
X-CSE-ConnectionGUID: j9y4EwTNTe+yDRXFUAHmvQ==
X-CSE-MsgGUID: bLcajputRLqUL0ONmXSV1A==
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
X-IronPort-AV: E=Sophos;i="6.19,290,1754949600"; 
   d="scan'208";a="248317560"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Nov 2025 18:58:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3A010E0172; Sat,  8 Nov 2025 18:58:26 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id AD299E0171
	for <cocci@sympa.inria.fr>; Sat,  8 Nov 2025 18:58:23 +0100 (CET)
X-CSE-ConnectionGUID: d2Q7MtmdTwyYwW39nopmyA==
X-CSE-MsgGUID: 6DghTzlDSP+V/7COwPbzeg==
IronPort-SDR: 690f84b3_WcWtHk7AuBs+Gr5pQ9dL27wrSykAQ4lpTjt1b8xPk/+fatR
 D4HG800EA6qqnbu51QCsHWlMcmHyviWMiW8JyoA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HOBgAUhA9pgAMP49RaHgEBCxIMQIFFC4JAZSNYMwQLS?=
 =?us-ascii?q?YRVj1OCJIQ7hzyHUgOKToF9Ag8BAwENTgECBAEBAwSCDIJ0AoxaAh4HAQQwC?=
 =?us-ascii?q?Q4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBOwcOCjGGT?=
 =?us-ascii?q?w2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREmAQQLCQIaAiYCA?=
 =?us-ascii?q?lYGFQEBgn6CIwEGEAEDDycHkl+cRoEygQGCDAEBBtpfHywiWYFkCYEcLoVug?=
 =?us-ascii?q?mUBimYnD4FVRIE8glIxPoRDg1uCaYImgQ6GJ4JukEFSeBwDWSwBVRMXCwcFg?=
 =?us-ascii?q?SBDA4ELI0sFLR2BJCIfGBFgPRdAg0kcBmgPBoESGUkCAgIFAkA6gWgGHAYcE?=
 =?us-ascii?q?gIDAQICOlcNgXcCAgSCGX6CCg+EEoEFhG9AAgELbT03CQsbBj2VBoJ1gg4uS?=
 =?us-ascii?q?pQcsxk0B4I4gWeBZAyfbAYTL4NxAZNgDgaTBZkGqUGBaDqBXDMaJIM2TwMZD?=
 =?us-ascii?q?44hDBaEEbwNQjU8AgcBCgEBAwmFRgEBjCIsCIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 FnwUYfpNckxsfmov/kxDBQPkzpz3tAzB+o=
IronPort-HdrOrdr: A9a23:9Z9c9qPOlnhEIMBcThWjsMiBIKoaSvp037Dk7TEUdfUnSL38qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YDT0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:RKIcgmwhLIQHneMzBZoyBgUYQPl6V2HYwEvPMn6nNj04TrqNTE65rfY=
X-Talos-MUID: 9a23:CYcD+wrLVzx4HfHwLdgez29OO8dU8aCCM3hOr9JZkO6bDSZiNjjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,290,1754949600"; 
   d="scan'208";a="248317555"
X-MGA-submission: =?us-ascii?q?MDGZY/2hCbmzc6S50rOB3bl0VaBOCtsuMjYrUb?=
 =?us-ascii?q?coKw0ybpsVNt9WCcK6Lhad63+GT06PZEEP63gJC2iroFjh4gz3yFyWia?=
 =?us-ascii?q?TNS1DK83YOKSodsjQ+OKyffNY5GIWXvpme7fx55TsjsfxbrzuRJZ1AwC?=
 =?us-ascii?q?7I3NeDYOlhh19Tdp8m6NMvLA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 18:58:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762624690; x=1763229490; i=markus.elfring@web.de;
	bh=7KrGKJHPaZ8o4j6iu/ZxAqNPqdsrN4pgdB5+UQLWQtU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Gy6V35ttDH7qKT0pqZaap8z5aSDcq32QgVQdPJMr6KjDFN8tshKyfvkAWfultUsD
	 QmW7q8SpB/UgA0gF85ukXIn3yUk6pXUCOb1rW0gW8NzFmc5Ur/X1sWL3zR09DxsX1
	 Nu+VeKIBn0qtuQ1ki7B7oJwBLjmHizouZIBR/GBjI+KPaKl3NDZyGYgkXR0W6lN0r
	 BDJQ3XQIFwLSD526KzTpJMjTArsXazoeRm5YC5ojKgcz+wNreqahTK7qxY74dp3B3
	 r/eqKnZefqMBnse+t/o2gJ/a7Rj8IsFh9TpxTGlIeDZAiR4eEdOe/H0YooswBxbyz
	 P8IskqUDVQnHRfJ3/w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.239]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MV2KQ-1vgds434MQ-00ILnV; Sat, 08
 Nov 2025 18:58:10 +0100
Message-ID: <570a5419-64c2-440c-b492-d52778b154bb@web.de>
Date: Sat, 8 Nov 2025 18:58:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <Julia.Lawall@inria.fr>
References: <fef2eb18-8ec4-40ff-9ba2-217a68a7bd5b@web.de>
 <8E60777A-0749-49FB-90CE-EF0016700A1A@inria.fr>
Content-Language: en-GB, de-DE
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <8E60777A-0749-49FB-90CE-EF0016700A1A@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I11lLn95Z/o81BpkwPWS5uLRkMRVeWJxkYDe/gywjx4KpeLx/UL
 W6ZzXRvfBLMfBz73drdeNRewad+X9cg70gGFO89CL3Alnh/dT3BAFVhkc6fScCmD0TisziB
 CBBZz+0ORR+8PGWfq1IE+qXQQCOw4KpqpCd81WbjIlCwsk0c4neyfqORlj2bqPpLms+WZVR
 mfcgW2FsjaZHoXPLHoHRg==
UI-OutboundReport: notjunk:1;M01:P0:ED2YI0+Rt3U=;z+TdPhw4qEidHXq6UR64nG6GP63
 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
 dXjRA==
Subject: Re: [cocci] Searching for switch statements with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3149
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/570a5419-64c2-440c-b492-d52778b154bb%40web.de>

> There is no meta variable for case lines.

Did I stumble on another (temporary) software limitation then?


> The <+=E2=80=A6 =E2=80=A6+> caused the parsing problem as far as I know.

I would expect that such an SmPL dot variant can usually handle multiple i=
tems.

Regards,
Markus
