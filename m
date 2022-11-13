Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A27C433FE
	for <cocci@archiver.kernel.org>; Sun, 13 Nov 2022 10:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=LepLNqGevRWa4XobZX3itc0ecAyJWSsHSSfcXBHE27k=;
  b=lm6pGrXL6IOrbL7gwd+ukFP6Cp13OLhEm4Ug3xj64oHC+ulvuibHb7tn
   1re+mmUqqDhRA/Hxmhyy/QzZ8BGn8MIGXZjSNaI0vr3rI85o0mKw6pP+d
   Him9OFdpTbPtdfwXPs6WFhLsHKXy+yvE9BWr9PvmKl0nvCYy8gg9QHxR2
   Y=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.96,161,1665439200"; 
   d="scan'208";a="77907503"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Nov 2022 11:30:44 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1D022E0241; Sun, 13 Nov 2022 11:30:44 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 423FCE0092
	for <cocci@sympa.inria.fr>; Sun, 13 Nov 2022 11:30:43 +0100 (CET)
IronPort-SDR: 6370c752_9534nomxfYXAjDPUZ97Q0ytnVtZuqyxLBf0iSTQ4lN+97Tx
 jbPG7e9FiLaYCfqhdNKweNPznv+FZ8efTdBfVPQ==
X-IPAS-Result: =?us-ascii?q?A0EfCgDXxnBjhwsR49RaHgE8DAILFYFOA4FDAgEBZIECA?=
 =?us-ascii?q?1MuBAtFhE+QbC6ELI5QjDUPAQMBDT0EAQIEAQEDAwGCC4JzAoR8Ah0HAQQ1B?=
 =?us-ascii?q?Q0BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEZCRcHDhAFI?=
 =?us-ascii?q?oVoDYI1In2BCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAkdTPQMDIx0BAREmAQ8LGgImAgJXEwgBAYJ5AYJtAQMwBwysCoEyg?=
 =?us-ascii?q?QGCCAEBBoFAARVBSpklHywiU4FeAwaBFCoDAQEBjGWEJycQgVVEgTyCUzA+g?=
 =?us-ascii?q?mIBA4FeTYMKgmeOd4MRhVkmBA4DGSsdQAIBCzsyDUobMScOCR8cCgQXDQUGE?=
 =?us-ascii?q?gMgbAUKNw8oL2crHBsHgQwqKBUDBAQDAgYTAyICDSkxFAQpEg0rJ28JAgMhZ?=
 =?us-ascii?q?QUDAwQoLAMJIR8HFhEmPAdWOgEEAwIQIDgGAwkDAiJWcQIuERUFAwsVJQgFS?=
 =?us-ascii?q?gQIOQUGUxICChEDEg8GJkUOSD45FgYnQgExDg4UA16BaQQ1ZppAgSqBTAhJE?=
 =?us-ascii?q?IIDljWsQzQHgh+BTIFNDIl0lHIGEy6Wbg4GkhSXNI1DmjWBeiKBXDMaJIM2T?=
 =?us-ascii?q?wMZD445hAyBC4khQDQCCTACBwEKAQEDCYVHAQGFKwEB?=
IronPort-PHdr: A9a23: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
 SGUotM8+zmb
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:wcCtLqElEpT+O0XdpLqEPMeALOsnbusQ8zAXPo5KOHtom7+j5q
 STdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/hzAV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgjWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,161,1665439200"; 
   d="scan'208";a="39593085"
X-MGA-submission: =?us-ascii?q?MDGOYvajymRUemKIqXfWKhSVjYrKTN21Ij6xf+?=
 =?us-ascii?q?s9O1Hskj+kdeIvwzzhrmdErIAF6tFO7syYGsmXVflUQy19QHIhjYDOBY?=
 =?us-ascii?q?wvEFUR7zqxVWAxPpz0Bhdz+5gFFtY0ttlYSQh2+ClSUjjg++SDxoqmis?=
 =?us-ascii?q?ZkkHKSX1hXpKjjITNA2hz2eA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 11:30:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1668335441; bh=LepLNqGevRWa4XobZX3itc0ecAyJWSsHSSfcXBHE27k=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=BoyZ7ReBmgQVzN2d/1iJQhAyESyi5Yep++80oGH8zt6ZEsAT2IpB1+DdTVPAP6cvs
	 dYVvhxLNZTzjSmpHcwtSkmiA8xTDg2+AJirVSW/pI94+wmK1R8TMHQ8lKitO25SINO
	 GilSgcaV92wvrmDrShAKzPPJYTjEG18xrQaHfCtdUkmrWUCIh1AamLCGFmCfmSMIqj
	 tp0EsguMJhr3Gh83ip4+IT+LdbIr+cPYo0GCORS7RDTKOjBPnD2th6vSHL8jzNbuuq
	 GTwUArFx/pz+BONen4H8O+RmQi2LhPyCbMl65ezn+6ZDkD6TKV+LuD4YWOn8E31bul
	 vc1ejnljxH94w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MkVwi-1pOJQM45Vu-00lujq; Sun, 13
 Nov 2022 11:30:41 +0100
Message-ID: <0a1acdf8-64be-6e43-6fc1-9160781bc7e0@web.de>
Date: Sun, 13 Nov 2022 11:30:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <CA+EOSBm7wxOoXmhbAP7YhTDXJxNQJJ6QRU8Rb47QV_XmvyyaGg@mail.gmail.com>
 <516d8b97-907f-5a7b-41af-ff162ffe7316@web.de>
 <b73dc7c1-d5ad-dd23-f559-7b73939ed710@web.de>
Content-Language: en-GB
Cc: Elia Pinto <gitter.spiros@gmail.com>
In-Reply-To: <b73dc7c1-d5ad-dd23-f559-7b73939ed710@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b2GZitW0p6DW/rnEhrhafgYnBuOTjKptZpeRrVl13AS0sBGTwMY
 d/aAly000IuifEji2vLIKlXhX8Re+ptOLYf2WRSF3amy5cXUnciaFA939fHhizNdibBu5Tt
 cMplTJAyBq0IjjB6B+8SFrkoz8eBrwO41OO9sjs+wkV9qVVAcQyagUv9XmUIR6Egu9f5iDG
 r47v5G9ev/PMdmJAvzJzg==
UI-OutboundReport: notjunk:1;M01:P0:rOXI3GEM2xY=;mrAF9L8dgSiVOltjDFDZU1z/wGf
 97hYg+ITlWKaKimk8xnq3NnCFZuL9ct/h5okf526wpo9xmPxufaWF9Fb0K/l2h9vKGDL5YEMf
 p8QR7prGRPug3lae4KXLG06qHF+p+0TlF6mItdQmhm0AbE3IeQDTTtCwVjlIAGdRPIIiieJiN
 cbVUmtioEE3tFoxD6SYReytrd3zPKEC18woDnN+DCGmF9YK8F3q0gKlLwkhmDF10yV+r4MCcd
 k5nLbkin1ba+zno0I36OIXewuqfpNFmqvSnvVUmht+47C3lhGfyWWnnbnui/hPZJsG0HUNm0E
 +LnoyIjMlQ0WeuE70umB6ADeauixFDT15ao8Csy5Tc3gSjq1gh9hkFrKNgIqMdr2CYrZwpBv+
 M8cFttvczgTa9sViax2WCbfuQ1thAGFDbLLovp0FpPhow0eC/PIY1738F1cH34ffflxNWUknW
 rjdu4zWPMqvoYrHNK+isKwk41GsIrFVGsgA4sODsDEbHG/yFfxWHsnw7CQw2p9bX+JXhvSYtk
 EyfqY89XCJeTQT1vptKPPM84KtEtM4X5BIBf+SuIWjbvCoJ0H/8o4RyfLXCBx9ww08aIKvUBt
 G8aiIzLfGc71tg5rsBun7mwEsoSwKDyZz9nsJeIAQAemVtpYFDp5Uzb201I1l3OTKPPHUIVqq
 u7ic+Vz2vlXWfAYeDF+JMpZ1bEVQyWXuncs65n2s6qK8YTYe3DZn5h5ohz8yfYckQM8gOHmeK
 /jLZTkKblVaouf0PlXWGSyuimSzZOKBVg1vZTCOWUGfSHXqD9xpoKK+a3TTK9X7C9w5446k4Y
 Bb7uv+44FtYs7iGerTv4eHteAjYGqcJ8ZZmbdjB6mlN8KN4BkkO9k+18EbyVy9NoClw5U+DSu
 mQy4jPv3cmrGUg6Ad7Snh3wJhd9wvbI3M11BVmUCD+JT5Af8Sh0xE75WKTGMGriedYIB52Sb4
 ixp+1w==
Subject: Re: [cocci] Fixing the adjustment of variable declarations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 739
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/0a1acdf8-64be-6e43-6fc1-9160781bc7e0%40web.de>

> @moving disable decl_init@
> type t;
> identifier x;
> @@
> -t x;
> +t
> =C2=A0x =3D 'x';

I would appreciate further feedback also for this tiny SmPL script variant=
.
I got the impression that additional clarification will be helpful
for some aspects.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/768bd6eb0a2cbede8f139=
0009cc997ff57c339a4/docs/manual/cocci_syntax.tex#L1022

This transformation approach would require that a data type can be determi=
ned
from a source code fragment which should be adjusted before the same type
can be added to a subsequent statement.
How good can such changes be supported by the Coccinelle software?

Regards,
Markus
