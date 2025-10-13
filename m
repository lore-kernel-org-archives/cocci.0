Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E123BCCD18D
	for <cocci@archiver.kernel.org>; Mon, 13 Oct 2025 15:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=nADwgyaUJIYZ45qOW2CaQmAHh1hfRjQ18lL4euBkjP8=;
  b=dRYIAlYR+tx7RQsKx+mPeK8YEGdw5OGp/oyeodv/mXha7dr2H24kfn9z
   DRneuxEeqgFnC9q8e10AMlBjkitvPIDz+FGIFu/HWa7lKb713jMI0qAtb
   p/ZEsjVMXa83iBzQFRt+Kl2t4ck3M+ugVXU2L7IJtoTlENbDl3wLizEzV
   s=;
X-CSE-ConnectionGUID: H7puq3sVTYu9YKXVZpMYyQ==
X-CSE-MsgGUID: K+Wv2i0/TvyXJo99aWNSDA==
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
X-IronPort-AV: E=Sophos;i="6.19,225,1754949600"; 
   d="scan'208";a="243961617"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Oct 2025 17:47:33 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 01B4EE0C55; Mon, 13 Oct 2025 17:47:32 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0F0B0E0171
	for <cocci@sympa.inria.fr>; Mon, 13 Oct 2025 17:47:28 +0200 (CEST)
X-CSE-ConnectionGUID: PHHjJly4SM6d7BWGzmcZAA==
X-CSE-MsgGUID: 0ijM4Zg3RFajaCLOcyVyUA==
IronPort-SDR: 68ed1f0f_JFS79hWZV783CPTVEltrrkJivYlrt1qltw1r1fIxpNMaMN/
 jOuH88duLVQ0RYlw0rnueg5T7qE19SpwvIPexHA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0H1BwC1Hu1ogA4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VCCQGUjWDMEC0mEVY9SgiSEO4c8h1WIeYFpgWkCDwEDAQ1OAQIEAQEDBIIMg?=
 =?us-ascii?q?nQCjEoCHgcBBDQTAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABATsHDgoxhk8NgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJ?=
 =?us-ascii?q?gEECwsaAhEVAgJLCwYBFAEBgn6CIwEGEAEDDycHr0aBMoEBggwBAQbaXx8sI?=
 =?us-ascii?q?lmBZAmBHC6FbYJkAYVcS4NDeicPgVVEgTyDAz6DfEc/gxyCaYImgQ6GNJAXU?=
 =?us-ascii?q?ngcA1ksAVUTFwsHBYEgQwMqNC0jSwUtHYEnIiEeE2A9F0CDSRsGaA8GgRMZS?=
 =?us-ascii?q?QICAgUCQjqBagYcBh8SAgMBAgI6Vw2BdwICBIIxgRKCKg+ETwIBC209NwkLG?=
 =?us-ascii?q?wY9kkODdRMcFMh2NAeCOIFngWQMn2wGEy+XUg4GkwWDV4JLhHONcSKpHzaBS?=
 =?us-ascii?q?SOBXDMaJIM2TwMZD44hDBaEEbktQTU8AgcBCgEBAwkBgVWDcAEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 0xu4jY=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:nxKrS69j6uyt87Hrrcduk+AMI+orL9Y04lQ7vn2ZhyYlEPBw5P
 re+MjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: 9a23:7mGjz24YsSvvc7KmI9sszG40GOIhYyHm6SncfGWHJnRsQ4+8YArF
X-Talos-MUID: 9a23:vbgQXwgUf6S2f8bPNojp6MMpbMZqxvicBxs3v5wEsuKgEidhBSagpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,225,1754949600"; 
   d="scan'208";a="128057123"
X-MGA-submission: =?us-ascii?q?MDFPlmrsrlTlwoMbqcxgi0YBP14zOKXidedstD?=
 =?us-ascii?q?1MiHhph0z/Vff6IR4axAl7j4CPcR6T+1H/8enPM4zN3pIZQ+qVDV5BXs?=
 =?us-ascii?q?zy4G9GCp0z3FPQgy8KzPD9mR+spNxZ+5tSBLkJMpRjvPxxaWDoQGKlgb?=
 =?us-ascii?q?U5Rp/VRJrVJz23sVCHxl2yuw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 17:47:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760370446; x=1760975246; i=markus.elfring@web.de;
	bh=nADwgyaUJIYZ45qOW2CaQmAHh1hfRjQ18lL4euBkjP8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uiPv1ptio66GX0LwJiFzvqfPmWF3226HL8SbInvdaOpek1fHaOb1ojht1wzMdwDx
	 t1Xs3yaQhZYs4OL359hU+V3nycC26B4xmghkMYclpxUftov/hsoQScd7MGkaYwUiR
	 kRPWlt3jX1xotH7hAUyD+Nyxsieo0msWy63j3NrVP/fZhSetWBrXsRWTGHdXOD0rs
	 xdA0vbrKsttTt0t+wnR96WKG7h1Ugvp8qQf2EA9Opu7VSh7EpY1lz/uQu+Lxwlcjp
	 /bz/YV2H/NAeo5uO2KQmuHUa1X4d3i/Zv6fgRrCImi3cDgLlBlFDPPmF3MXobHxlu
	 7wU8KtAoxoZvIWYCQg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.186]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N62ua-1uB9aI1GeG-016ecv; Mon, 13
 Oct 2025 17:47:26 +0200
Message-ID: <f114858e-84f5-47d3-80e5-febd138d68b0@web.de>
Date: Mon, 13 Oct 2025 17:47:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: linux-cifs@vger.kernel.org
References: <335b0fe9-313f-4e3d-a01d-1954f3c46489@web.de>
 <805f36f6-ea15-cbc9-f510-45856eb6f6d7@inria.fr>
 <8480276b-ee1e-454e-954f-b25890c79add@web.de>
 <dcfb5c63-ce1a-f487-df23-cadef6c45a32@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <dcfb5c63-ce1a-f487-df23-cadef6c45a32@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vT60EahRG2TBPPQjyDLiKCH8ZyAKjsGNF5sFnsQZHngJKszfLOn
 GCY70h7L8Uac6fRGAuaQ53k8NtI2Z1yRpf39K/VK3esc2tsiR1Hf90BMUmJOIafJDUArkJu
 m+z9IyN5j5V+tVfSBaIz96Ca8MOD6ewES/GDiDzLcrb2qlm5gayt7GMuGd8PssdD7FATYQa
 zZG890w+QVxx4WVIY0YrQ==
UI-OutboundReport: notjunk:1;M01:P0:qTzuIkxfek0=;/S26BvAD6xlPOjP4L5HOUNxcVFh
 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
 B+wOA==
Subject: Re: [cocci] Improving source code parsing for =?UTF-8?Q?=E2=80=9C?=
 =?UTF-8?Q?fs/smb/client/dir=2Ec=E2=80=9D=3F?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3073
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/f114858e-84f5-47d3-80e5-febd138d68b0%40web.de>

> Thank you for the more understanable example.  I think it should ignore
> the code under the #else since parsing is not successful when that is
> taken into account. =E2=80=A6

Improvable software behaviour can be demonstrated also with the following
source file example.


static int my_test_condition(void)
{
#ifdef MY_CONFIG_LEGACY_OPTION
    {
        /* Test comment */
    }
my_info:
 if (0)
    my_log("reminder!");
 else
    {
#else
    {
#endif
     my_log("test end");
    }
 return 0;
}


Questionable test result (according to the software combination =E2=80=9CC=
occinelle 1.3.0=E2=80=9D):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> /usr/bin/spatch =
=2D-parse-c test-ifdef-legacy5.c
=E2=80=A6
PB: not found closing brace in fuzzy parsing
ERROR-RECOV: found sync '}' at line 18
=E2=80=A6
parse error=20
 =3D File "test-ifdef-legacy5.c", line 19, column 0, charpos =3D 224
  around =3D '',
  whole content =3D=20
badcount: 17
bad: static int my_test_condition(void)
=E2=80=A6
bad:  return 0;
BAD:!!!!! }
=E2=80=A6
nb good =3D 0,  nb passed =3D 3 =3D=3D=3D=3D=3D=3D=3D=3D=3D> 15.00% passed
nb good =3D 0,  nb bad =3D 17 =3D=3D=3D=3D=3D=3D=3D=3D=3D> 15.00% good or =
passed


How will the software evolution be continued?

Regards,
Markus
