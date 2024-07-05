Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2486DC3271E
	for <cocci@archiver.kernel.org>; Fri,  5 Jul 2024 13:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=lW41I8cEVh+yKSMWNRdeyYxQb9Fyiq7QuZJXsxH1ji4=;
  b=bB2epH3MtSDQ7183eE0JDFeh2bnvKG6bl4obSZj2MlO7dcajm481Ac9W
   yM/piGT0VndEIgv3WSGa6cGeHbXqrB2m/ODc9i7kofmfIrh3haXCVSq85
   HQapDQp8tOil+Jku8Yaj7sEb8mrr2Ys4UkAdcCfqOEr6JGC//KBnUimK5
   E=;
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
X-IronPort-AV: E=Sophos;i="6.09,184,1716242400"; 
   d="scan'208";a="174157902"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Jul 2024 15:28:23 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E1E94E0CCE; Fri,  5 Jul 2024 15:28:22 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 303B2E004E
	for <cocci@sympa.inria.fr>; Fri,  5 Jul 2024 15:28:17 +0200 (CEST)
IronPort-SDR: 6687f4f0_560QJis7NNVMMwzSOnPLwFnxe+yyREaRRdK1BtNM7HqPUip
 uq2vr67oicKE7lWFy4QN3AutYJMIE4Rm9AW2qFA==
X-IPAS-Result: =?us-ascii?q?A0ERFADl84dmh07ASNlaHgEBCxIMQIFEC4JEYhoGVDMEC?=
 =?us-ascii?q?0gEhFKPSIZgjwqIc4MWPg8BAwENOwYBAgQBAQMEgguCdAKJEgIeBwEEMwYOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEjFwcOECeFdA2CZ?=
 =?us-ascii?q?wEQgRJkCTkBAQEBAQEBAQEBAQEBAQEBAQEXAg06RAIBAyMdAQERJw8LGgImA?=
 =?us-ascii?q?gJWBgESAgEBgnwBgi8BAzEHDa5sgTKBAYIMAQEGgmfXch8sIleBYwMGgRoui?=
 =?us-ascii?q?DEBhXyDIYEfJw+BVUSBPIJSMT6CSoFAOYNbgmmZVowSJguMelR7HANZIRMBV?=
 =?us-ascii?q?RMXCz4dAhYDGxQEMA8JCyYpBjkCEgwGBgZZNAkEIwMIBANCAyBxEQMEGgQLB?=
 =?us-ascii?q?3eBcYE0BBNEA4E3iW8Mgy2BcieEGQhDbBWDboFrDGGDRYRAYoEPgT6BYgFLg?=
 =?us-ascii?q?nxLhE8dQAIBC209NQkLGwY9qXyFBSuVULI5NAeCNoFhgWIMiiGVJwYTL5c6D?=
 =?us-ascii?q?gaSbJhpIItfgXebFYF9JDyBIDMaJIM2HzADGQ+OIRmEFIRhxmRBNQIBAQE2A?=
 =?us-ascii?q?gcBCgEBAwmFRgEBgyY0gUoBAQ?=
IronPort-PHdr: A9a23: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
 fDQmai1JDoQqro8HOMZANXIbt2KOjwtPEixcAM=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:/Zs/m6rqFjNhSZhZb6ZOfcgaV5tnL9V00zEX/kB9WHVpm6yj+/
 xGys5rqiMc7wxhPE3I+OrwXZVoLkm8yXcY2/h2AV7AZniFhILLFvAE0WKK+VSJcEeSmNK1s5
 0QCpSWY+eAbmSS4/yb3CCIV/gh3Z2h/L6yifi29QYQcShaL49h8kNeDwuBHlIefng6ObMJUL
 Sd+459qzWmcXAaB/7LfUUtbqzsp8COr57ofA4eC3ccmXOzpALtxr7mVyOVxxF2aUI2/Z4StU
 77kkjS46WutOya03bnuFP73tBxh9qk98BKDsCWzugZQw+c9DqAVcBfYPm5hRgQismS0npCqq
 i+nz4Qe/tJr0npVkWOiz3X92DboUYTwk6n9mTdu0LKhfbFbA8XYvAx9L5kTg==
X-Talos-CUID: =?us-ascii?q?9a23=3ApRsNHGrgoplUNoy235fIUnXmUZk/e0LbwVX2GWu?=
 =?us-ascii?q?hTl80FJzIbXuApIoxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A5dQWcw4nwedeCxChANttiMONxoxUwbmOF2Yttql?=
 =?us-ascii?q?Bos3cEzZaOmicvWm4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,184,1716242400"; 
   d="scan'208";a="91469940"
X-MGA-submission: =?us-ascii?q?MDGkB0fzNg82rCjAY8+Zb3q1UMbYIbcIB2T+Qg?=
 =?us-ascii?q?y9WmiWFq9BLHoNEFe9Y8vO0FC0kxSJVQohgdthemPVc+cgOmIGmRG5dG?=
 =?us-ascii?q?Xm5wFTNDeiaRJfwRDGlFDwfKiQON5Ll4m5elL8mciLaomIEK1mGn0OJF?=
 =?us-ascii?q?WWZO00DJB+xli1DlQMt2b3vg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 15:28:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720186094; x=1720790894; i=markus.elfring@web.de;
	bh=lW41I8cEVh+yKSMWNRdeyYxQb9Fyiq7QuZJXsxH1ji4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=t+7f1/WbsPWIh0SuRfjvMVwCzKHUafqOH58aZg3QGp1Q1fhdLLJDhvh2mtf82uQi
	 9Uf5tML4vWpuRIDeiF3eXdKQ5W26wQadcb97fNz6+ACdiyhVRSK+pD7Js1nqzRSv9
	 tb/i85tnoPsRmFDoRWYv/lXvbUhEcDV4bFP3v3O/GC/uJ+mwCGOEuiFJYG5E4rkER
	 6p8vcB9qB1Wr+b64By+oS9PTolqORNZExUYIv1EDsuTioBB6/PQyZLp8gdAlyZ0Qt
	 m7yvfjJm5dIL6EXssuvdcBFcJL3wHxXjKGIZTKh30CsmzqqJUt5BCGwnrYS7R5cKk
	 SY8/Vyx39cnm5xSeqg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZSBQ-1sskYK0FPi-00Lhav; Fri, 05
 Jul 2024 15:28:14 +0200
Message-ID: <067bc622-e73a-45b7-b7d5-425ce7cdab5f@web.de>
Date: Fri, 5 Jul 2024 15:28:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr, Dan Carpenter <dan.carpenter@linaro.org>
References: <bcd3e669-9158-45a4-a539-14bfeca06deb@web.de>
Content-Language: en-GB
In-Reply-To: <bcd3e669-9158-45a4-a539-14bfeca06deb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FKADmZ51LJJKdafi09SLydx2sGrhhKQwd3fGLu58KYYEB3+JP2+
 XHxyGqhJbUMt1AT3ipxuJwF1wzkfVRO2byRU0PVxirkFoHb53F1tP0bVdWQBhaiulC2MV/X
 PmtM6hOQZKEneIypmCTir2yAX8ydNNuHbzhVCmkn1xSceMubPPpcwGNOii25q3K4EQ+VxUd
 /977aABxsxQ4wQyknoakg==
UI-OutboundReport: notjunk:1;M01:P0:utnZucFAohg=;a6iMMKAcqUzCS25vOXmlQzOhUF/
 h91bDnd0lAOolAQV2pqEQ3G8XCKUQHXuUaLLlIUlpcwJhWvofDyYiUb3sLro2VgismXBrrORy
 v8IWbvaGAGsXvl8lY9v9tV1Xw2SkGGmqcrSPf8TygYjc5msMEk99JQL6rfUltMMM0+0z50Ntf
 4Fd8Y4Y7kZIi2EV17xEh1/AY/Q0Mt91PFDVMBClYJxwpHpNGpl2jf7LDmgoYv/y9NG5PPSnwS
 DKa27E5DGcb0slKF9/mBeX7fyY2WbYYW61dsXQ/k1FEWM3o0uPSL2cHAJkkMzdmpJgHMI+MTB
 sxT/6oIJiwGxX8TI0PpadGqVE5pI430f2Xq90gurYmgZLR+ctJJAjo/M/VRj2Ttd3ovieIq/l
 lQyEaNeumueA1xQekeeXJHJwbzFIbjXm5W78v6znDRxVzzg5RS3wwgiESN/Yzz6kkO8QVEfnW
 EDMX8q66xgR6HCPInALLzR767gtUMZ40MAxCTR49hcB0NJVC0aUorwXKIChNp1RNE7pmAIeYD
 SpdKdUgBCw1TSvgzXa7KR5kP4ji+/4WGKSjJHEe3Nkf2iwPulPJryou1Bkkz11ZvB9xeRZefF
 7+XpTRn5989Ja+0cp1PBaLRJbJbMKmqL/0a7MIXMaDIWC/PgmBUSH/ZqXIWqZKVVKlxiUVsmH
 CdQ7cl9xmF2JF5NDBDl42x8wTerttVgbjb73/qnUjilgl1De9u5zbMg1uYFpQaFHicjHaCqNR
 uFBjHji4vaWslYeMUeHH/JYU7G0CserJe2HNIehs9mH69CZoobMtN8Nmq/31ES/hybcW+9vCQ
 7SfCgVy6y1X379eFgrCRvLFqtArNUi7CpttOwhfdnYhfY=
Subject: Re: [cocci] Improving handling of nested if statements (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1800
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-07/067bc622-e73a-45b7-b7d5-425ce7cdab5f%40web.de>

> // See also:
> // [PATCH] crypto: lib/mpi: delete unnecessary condition
> // https://lore.kernel.org/linux-kernel/6686bed3.4a0a0220.6aa45.6c34@mx.=
google.com/
> // https://lkml.org/lkml/2024/7/4/933

I constructed another small script variant for the semantic patch language=
.


@deletion@
assignment operator ao;
expression e;
identifier i;
statement s;
@@
 if (i)
 {
 <+... when !=3D \( i ao e \| ++ i \| i ++ \| -- i \| i -- \| e(..., &i, .=
..) \)
-   if (i)
-   {
       ...
-   }
 ...+>
 }
 else
    s


Will there any possibilities become more helpful for the shown SmPL specif=
ication
to exclude the modification of a variable?


Such a code transformation approach can point seven source files out
(from the software =E2=80=9CLinux next-20240703=E2=80=9D) for further deve=
lopment considerations.
Coding style adjustments might occasionally still be desirable for generat=
ed patches.
Would you like to integrate any of them?

Regards,
Markus
