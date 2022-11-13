Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0814C4332F
	for <cocci@archiver.kernel.org>; Sun, 13 Nov 2022 14:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=irLrKYK4EzwvkPmU6nB6xSIz5srTaA1ZBQd6up8T6OE=;
  b=bCSXaeRkiW6Bc9YIA7lje+ospLacfwNSsRpQrpqwfUAHEgR7jtnBEfnz
   nQzcvDdFHkt7hfVztO5QwL0DmaUrCH1hzMgCFSnPLTVUJm2sl3ZWVOSO+
   BAlTp9vVmq2gq+6lJwGAg/mR9r/aOeDqIKsncwAB5ti9CehIEyp/aPTKv
   I=;
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
   d="scan'208";a="77917082"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Nov 2022 15:23:16 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B9C24E0241; Sun, 13 Nov 2022 15:23:16 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7F4F7E0092
	for <cocci@sympa.inria.fr>; Sun, 13 Nov 2022 15:23:12 +0100 (CET)
IronPort-SDR: 6370fdcf_mn0gNB2+oXZi3l1wiIjTyrUtSloGAudlGI4WXG2CSEx8cgJ
 LUnOq2Xwm3j3lyj3TU6spom2enZaD5bZzR4U77A==
X-IPAS-Result: =?us-ascii?q?A0GGDAC//HBjhwwR49RagQmDfIECA1MuBAtFhE+QbC4Dh?=
 =?us-ascii?q?CmOUIhhg1QPAQMBDTsGAQIEAQEDAwGCC4JzAoR8Ah0HAQQ0EwECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEDAQEFAQEBAgEBAgQEAQECEAEBARkJFwcOEAUihWgNgjUpAXWBC?=
 =?us-ascii?q?AEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAg06G?=
 =?us-ascii?q?Ds9AQICASMdAQERJgEECwsaAiYCAlcGAQwGAgEBgnkBgm0BAw0jBwysHYEyg?=
 =?us-ascii?q?QGCCAEBBoFAAQMCDAJDmW8fLCJTgV4DBoEULIxggzZ6JxCBVUSBPIJTMD6CY?=
 =?us-ascii?q?gOBX4NXgmeOd4hqJgQOAxkrHUACAQs7MgMKShsxJw4JHxwKBBcNBQYSAyBsB?=
 =?us-ascii?q?Qo3DygvZyscGweBDCooFQMEBAMCBhMDIgINKTEUBCkSDSsnbwkCAyFlBQMDB?=
 =?us-ascii?q?CgsAwkhHwcWESY8B1Y6AQQDAhAgOAYDCQMCIlZxAi4RFQUDCxUlCAVKBAg5B?=
 =?us-ascii?q?QZTEgIKEQMSDwYmRQ5IPjkWBidCATEODhQDXoFpBDVmmkCCFoE/AiJvNJZzr?=
 =?us-ascii?q?EM0B4IfgUyBTQyJdI19hnUGEy6DZVySLQ4GkhSWVGAgizSBb5UNhSiBeSOBX?=
 =?us-ascii?q?DMaJIM2TwMZD445hAyBC4NWhUtANAI5AgcBCgEBAwmFRwEBhSABAQ?=
IronPort-PHdr: A9a23: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
 klQqY4=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:MmZwLqro4x5TB2gVMAu6GwsaV5r/eYIsimQD101hICG9vPbo8v
 xG785rtiMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaWSS5vyb3ODXKadD/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,161,1665439200"; 
   d="scan'208";a="39599651"
X-MGA-submission: =?us-ascii?q?MDHr8MFSu4eSkjEZPobHISQxAhX3ejK/jq6xd1?=
 =?us-ascii?q?CYev1h6KISBD+1s9JKeilRMQLYv+9J+mrpp5ryuTXtA13fLvOPb8FcA8?=
 =?us-ascii?q?NYrs9bT2ejHHGUg2R1tMiOq89gWgPpEsEkOLxHOJyFeUm+kEIvB+jwpX?=
 =?us-ascii?q?aMDe9papxTFCrPzQwwNbZFiQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 15:23:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1668349390; bh=irLrKYK4EzwvkPmU6nB6xSIz5srTaA1ZBQd6up8T6OE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OfY6gsewwluYVJoKtdp3lDgN3IXIEE+gfERNqJ876qMIl/0CBONu1LEhsrBoDnA3Y
	 jZ20ufLlRN7BbEXW+a39BERiKaoZDie6HgRvpfRomES3pxPDfByiTm8AOfvPLrhqV9
	 51AWEMush0/GzVbq1CqI0susjZm5jsWpQCPk5hhHe4er+1IozcO6npHQ6IimTHR5LH
	 HFaXJT2rF4ZRIiJjFWHfs8pIb4+NYlqoqOAQ1kqSN3u8OqOSmsV6rBMNg7GLHZcFSu
	 EnfC54HFmn1v67+JLdIUz2Q3vNlPo3eMtqprbqpCUVtTDNAOYpel7ol3c9ozIIrYjX
	 DWfKlPn5qZrLg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mcpuy-1pTpoy02Us-00ZlTx; Sun, 13
 Nov 2022 15:23:10 +0100
Message-ID: <4ae6751f-fc14-782e-013d-af6be69c1f7d@web.de>
Date: Sun, 13 Nov 2022 15:23:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Elia Pinto <gitter.spiros@gmail.com>
References: <CA+EOSBm7wxOoXmhbAP7YhTDXJxNQJJ6QRU8Rb47QV_XmvyyaGg@mail.gmail.com>
 <516d8b97-907f-5a7b-41af-ff162ffe7316@web.de>
 <b73dc7c1-d5ad-dd23-f559-7b73939ed710@web.de>
 <0a1acdf8-64be-6e43-6fc1-9160781bc7e0@web.de>
 <b48551e5-3792-e563-469-57f2b17164@inria.fr>
 <2dd76fcc-0f76-e99b-80a1-2ade40e65380@web.de>
 <6cedba8a-8765-fd51-2980-b64a6f86aa7@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <6cedba8a-8765-fd51-2980-b64a6f86aa7@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cUytQlZAnmRBKjICQbnbBamYsj2e0WxUQy53MQNlUjy51kgYaKI
 gTFK+tyhg/A4dTstRRTBsmmTuoLb89VwIAfCtOQywvoWhs2vt3BicIeLguxkgs1YUEsvirz
 EDN9zwg3Dh6KQqBiLKENd5aH0Zv6y1bWEYqZWAv5UA0Zt9saV+202Bb+PO4eidrW8zyYls5
 a6kiI7KCzMr2f+EzgnhOQ==
UI-OutboundReport: notjunk:1;M01:P0:zlhvQuATC0k=;5a90IHlapIseDsK81gIhKUOt5lw
 7tXeeL82jyEorzosgiz3RDm1INPnpxinbp4jvFSCCaox+Spr8piJuHHv+Img2SlXQDGpDeiPR
 N5zgiPBmr7R5Qm76+/BcmpTIOyGVJLZ6Vra2xBe+rjCnoPu0smJNUuzINjTd9MC5uvTT6sRge
 usO97vz1B6oTleg7v8s3erFRA8aE5amDpXEQb99B963d44W4UZ4rhEqTXrVIUqpBRw8vcXGHK
 OgW99xl3Nrz+T+ihTIDNaz8SycMO+/k8W0Roq8n+W3/HEsVzAZaVWZUjlbeQjZBTpXTcTS8wJ
 c4gNNxHFSIQMmUmVJOZ2Ci7KQZ69gypYfelz1o0CVLT3T1x/9dx73vlxtcdfrzuK7o9YkeQOk
 hrFx12hCtLszylfdbOohG1/weZKUME9+j0BR4e997QmU917QhX/4DnEOCvXoqEfnT4z7rDzr5
 Bqf/5OIFjym+V05yhf/boMjuNHBE/gJOjeI6YoE7rnHKLTa1bYR3bf4MDWO084J+CoVwzdQXW
 xjnpA50mxI2d2LQ+Ynm9GVbu8EUdJsA4S+4noUpo+mdToQwVonEiZzPVTSsRcvaY+pBPd2Tsl
 uZctoUUj12b2YUMqmkCJJnSx2jOZoGRTfRANtgedL9K+4Cc7tT0QRmkmQ/UeWPt4v8ABX2B0B
 wl9CaHtaIY6hfQRqjWpLSw5vfePNJb9eD3kO/+Z13qu+dbgAaVUIlHeOeMgKOKzqdczrgKyaM
 rgl8oSOPZnxy1T537E1C1UJ3CkeHsVn3S2C7Ynf/cQhBiRZ9/PPdnQ5+vYWP/WitWnkSddFUk
 JxIOc/5b/aFR7g0T7KmRuK3lBgylp+SJaVAzHsV6joW2brR2PHfS2z1ee/jrjB8k60bR3TG+6
 dIPGqsKCaHOukbP81PoaKSSq/Q/8ls5TUI8zDuI47z3nnA9YAxQFcKwRuIfO2DUSvSAY4hkG5
 KH/5mA==
Subject: Re: [cocci] Fixing the adjustment of variable declarations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 743
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/4ae6751f-fc14-782e-013d-af6be69c1f7d%40web.de>

>> Why do I observe test results which are different in comparison to
>> the previously mentioned SmPL code variant =E2=80=9C-T I;=E2=80=9D?
> Elia Pinto's problem is related to the management of *s.

Do you notice really only open issues with the handling of asterisks
for pointer data types so far?



> You can't see the problem on a simple type like int.

I find that my mentioned test case points further questionable software be=
haviour out.
https://lore.kernel.org/cocci/b73dc7c1-d5ad-dd23-f559-7b73939ed710@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2022-11/msg00040.html

How will development considerations evolve accordingly?

Regards,
Markus
