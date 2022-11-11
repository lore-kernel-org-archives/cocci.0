Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F1AC433FE
	for <cocci@archiver.kernel.org>; Fri, 11 Nov 2022 19:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=qefWo8trF1AGupM/9uqTXO7e363XU5t69Jvpo2h/3QE=;
  b=bsA+BzLCGD5+33rowG+mrzTQvBH6hDioLW1hH+tPqFdDQo474zNzqK+8
   JCDi0E3DgJ3XbH8AZR7iJzB5g/kiJrbrp7D+IwrT63EJpkjbtBOOMNLon
   ZVm4tj2szQ6pEGiNm/koourA5IAUG4OPeZ48ozyLA1vBudiKQS5pKkp3G
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
X-IronPort-AV: E=Sophos;i="5.96,157,1665439200"; 
   d="scan'208";a="77818048"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Nov 2022 20:10:25 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 39648E0241; Fri, 11 Nov 2022 20:10:25 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D070CE0092
	for <cocci@sympa.inria.fr>; Fri, 11 Nov 2022 20:10:23 +0100 (CET)
IronPort-SDR: 636e9e1f_FtqXbfXEHwNpQa2ZVxyYwCRMs9QZ77rDYSYpC9Aq5eOPuJ4
 KHkL5MurlwTLMyHYs9LBQOQJkQn7Dr9D4J4wM1Q==
X-IPAS-Result: =?us-ascii?q?A0GqBgC0nG5jhwsR49RagQmDfIECA1MuBAtFhE+OdYIoh?=
 =?us-ascii?q?CmOUIhhg1QPAQMBDTkIAQIEAQEDBIILgnMChHwCHQcBBDQTAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBGQkXBw4QBSKFaA2CNSJ9gQgBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBFgINOhg7PQECAgEjHQEBEScPCQIODAImAgJXB?=
 =?us-ascii?q?gEMCAEBgnkBgm0BAw0jBwyPHJwXgTKBAYIIAQEGgmGZJR8sIlOBXgMGgRQsj?=
 =?us-ascii?q?GAJhCcnEIFVRIE8glMwPoJiA4Ffg1eCZ453iGsmBA4DGSsdQAIBC20DCkobM?=
 =?us-ascii?q?ScOCR8cCgQXDQUGEgMgbAUKNw8oL2crHBsHgQwqKBUDBAQDAgYTAyICDSkxF?=
 =?us-ascii?q?AQpEw0rJ28JAgMiZQUDAwQoLAMJIR8HFhEkPAdWOgEEAwIQIDgGAwkDAiJVc?=
 =?us-ascii?q?QIvERUFAwsVJQgFSgQIOQUGUxICChEDEg8GJkYOSD45FgYndA4OFANegWkEN?=
 =?us-ascii?q?WaaQIJ2XwKYMaxKNAeCH4FMgU0MiXSUcgYTLpZuDgaSFJc0II0jmjWBeSOBX?=
 =?us-ascii?q?DMaJIM2TwMZD445g1kziixANDsCBwEKAQEDCYVHAQGFKwEB?=
IronPort-PHdr: A9a23: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
 rDy
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:spJ3N6wN+yzcxh8uxJkhKrPw8r1zdoMgy1knxilNoG9uA6ilfq
 eV7Y0mPH7P+VAssRQb8uxoV5PufZqxz+8X3WBVB8bEYOCEggWVxeNZgbcKqgeIc0DDH6xmpM
 JdmsNFaOEYY2IK7/rS3Cn9Nco8y9+a962Sif7Z1GoFd3ARV0gt1WZE4h3wKDwPeOCqP+tDKH
 IWi/Asmwad
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,157,1665439200"; 
   d="scan'208";a="77818047"
X-MGA-submission: =?us-ascii?q?MDGhgcqjBzaRsLmDPnp0Ui1teEUCBMLBpggfRr?=
 =?us-ascii?q?PHTEURNjZwkCd5746+JrvdK2t6pkQ13TAsgRcY3+mtJFv2eBD1pwM+0l?=
 =?us-ascii?q?rhsOYJlyniOoYX0ludwEUgs3fjultCwGXYZ/kFdjS8cy4wo3+NBY02mt?=
 =?us-ascii?q?pPaQsjJMxIVv0DRFQJVQpthQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 20:10:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1668193821; bh=qefWo8trF1AGupM/9uqTXO7e363XU5t69Jvpo2h/3QE=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=UnJx07V0vZUR1U6ExnCJihutUKuqhLTYMmtmxD43igVt0CtrQl2O232nVHU4FDhRd
	 nPXOFnM3t+BggmIdPgaE5PH5g9TlMovNgNYeiT9NZocMyMmUb8Cj8QNqRksnlSSUXd
	 kQoMmA9p1TCNN81csckXaakNb29J7furXzWbOPUVAAT5MQKMUXdDWutYtPrWeQSmbS
	 BFktUcgHZLQFXcaRVIFJFVGcCj0HAXHLYO3fw35rqLtGPuenQvOayip/l/0rnokxIW
	 AFnGmKkJj01rtiHncT0VtHcZA7J12alfzTKEGXyaCrxJDgL2O24mg/S1RUmkXmZl3D
	 r6k4w+drMgDsg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4627-1p2c1c2zfF-00zfn0; Fri, 11
 Nov 2022 20:10:21 +0100
Message-ID: <7cdca517-6fda-af5d-a7fc-75989e4e79df@web.de>
Date: Fri, 11 Nov 2022 20:10:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From: Markus Elfring <Markus.Elfring@web.de>
To: Elia Pinto <gitter.spiros@gmail.com>, cocci@inria.fr
References: <CA+EOSBm7wxOoXmhbAP7YhTDXJxNQJJ6QRU8Rb47QV_XmvyyaGg@mail.gmail.com>
 <516d8b97-907f-5a7b-41af-ff162ffe7316@web.de>
Content-Language: en-GB
In-Reply-To: <516d8b97-907f-5a7b-41af-ff162ffe7316@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UOZk9QaH/EEBpX9o+QQCiW2aKKz0km/dhVcwBLWJeHOqix9DNHj
 P/AwcIalLSIXHsFzaV4HAQ9QIeUkDUbN8bNvQ8VEhTpyj3TcAatVe5U8nggnkC0aXxyEpsD
 gjQwGkZ3ZpT3XObeeJ+j04dhv0X530FCsOazdKAboTMVVVC8dpa/1vQVVI11BrFujInxNVs
 IITf6E5kbHoQDyp78jxOw==
UI-OutboundReport: notjunk:1;M01:P0:qveRoyxnoZA=;eCnStP3yaOfAUJ3xHMvukbuszKH
 iTqUs4G8zhliLIwqjmp9quLB+hoGlrNUge8/kRfzl7OkRLGUNZ1oy8TApBvcErKgb4clLlOff
 KfAd+HIIkmuRFoDZ7tqaNxyowBLRUykcGa1gkmgE7Q4qpGVMR41Fqu5luODeqioUqLz09YzmH
 OeYr44IwmzCvZO8IA+l3s9NEhbzrgh0t2gfqaCzbXHphL3ZVqIIuXpi9oY8Olx89Ur8d34EMN
 IKgXarZMGta1bI2WTFNXq1Gd45wnda6tnB8twk7gdnXnMP8CLrhHPq1rQDkUg5nMacEXatp/6
 t5q91cpnaYsbImnRfiNkQ5rZ41v2YjZ+FLJ4+Wp3+Nu/u7pyy+vbV8jytZJMjes4UQloLUgMF
 93PDlrfvN+NjWoErW/PmneqeMA7KLRE9OscEvgayXA5lv9Ef439d+Y3IiBwl7GEkOi/Qo2Hg7
 xdsXIO0VVkq9UC+kYjYiG6VGdx/o8VQmulsdp3MJ8baFEEzkSGNf/+Lz/53AO83BjzJbIT1W8
 ZnsQ/3MKCabJ4H+AUJv665GWxHTmunOGNJn+TSW35a+pUbsaPDw5iCfiMXjniLHwadi0c1b47
 hTEEeqXk1/L7zSjMBDsv9BH7lrjZgkSE1I4E1UEK8xGtll9wXsm/X0ID0TF1RT18jHcYfGZ7A
 5EdfDsBwecO6cMhN2OAX5hVszWiL5KVKFbJdt0+atPibIIorLTcQvPgdSeVQ4DKX+6P9Rsen4
 MGTkhry94/Muhe6f6VQcn1vTPbAYBmT2307RNPCbNuuC+PCbpI3mQtPC38UzvCYH5B7iMPs6T
 P/jx+M9XMn2p+pDHeHtwBdx/iNRGj6KaRzJ8mUp2jjm43ymjW0h6eYSrQFpftecsUMkhwUBOZ
 8JLc4iilElHeSoRedepSoouk7pdtogVYPTM5D22aNhgh86xQ24TXwKcVpmg7P/yFLBqrMS8Q4
 MtpLhQ==
Subject: Re: [cocci] Reducing the scope for variables with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 734
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/7cdca517-6fda-af5d-a7fc-75989e4e79df%40web.de>

>> or should the semantic patch be done better?
> How do you think about software development possibilities with the follo=
wing
> script variant for the semantic patch language?


@movement disable decl_init@
type T;
identifier I;
initializer init;
expression E1, E2, E3;
statement S;
@@
(
-T I =3D init;
=C2=A0... when !=3D I
=C2=A0for (
+=C2=A0=C2=A0=C2=A0=C2=A0 T
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I =3D
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 E1
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 init
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ; E2; E3
=C2=A0=C2=A0=C2=A0=C2=A0 )
=C2=A0S
=C2=A0... when !=3D I
|
-T I;
=C2=A0... when !=3D I
=C2=A0for (
+=C2=A0=C2=A0=C2=A0=C2=A0 T
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I =3D E1; E2; E3
=C2=A0=C2=A0=C2=A0=C2=A0 )
=C2=A0S
=C2=A0... when !=3D I
)



Would you like to reduce the scope for any more variables?
https://refactoring.com/catalog/reduceScopeOfVariable.html


Does such a source code transformation approach point also any opportuniti=
es out
for further improvements of the corresponding software documentation?

Regards,
Markus
