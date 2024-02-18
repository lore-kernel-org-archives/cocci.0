Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30284C4829E
	for <cocci@archiver.kernel.org>; Sun, 18 Feb 2024 08:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=7ULYV8ZiytJZYUS/IvCFN9q7k/CIzo6HHAv8i9vtimY=;
  b=pzf8BCZ0ZWuPp6M+uzuiZsgbKxmcQZr4gs/G+ybmpbfl8vcKqr29wAEW
   G6/xOj1b8fUOPO2dsy6grIjSxV6T8GeoZBNnhJzz3xmCXDU7QjVnMbYRi
   YmPeIskLQgB14Sg8x2X1s7uP9+vbvwqw/42ixjS8rkiBSMPHX/BWVfc7J
   8=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.06,168,1705359600"; 
   d="scan'208";a="152482082"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Feb 2024 09:03:43 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B7F7FE0CD6; Sun, 18 Feb 2024 09:03:43 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C9E8AE008A
	for <cocci@sympa.inria.fr>; Sun, 18 Feb 2024 09:03:39 +0100 (CET)
IronPort-SDR: 65d1b9db_JvqQqfamCHPslEZu5oEuidkBpmfaPBicwIjrsZYe5kFnG4Q
 dnQSz/dYNQq+st7n6xOQ+Rfw/jewUyt1UJRqvlw==
X-IPAS-Result: =?us-ascii?q?A0FKAgAwudFlhwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+COWIaA1MyBAtIhFOROTCEO48FiHCDFj4PAQMBDTsGAQIEAQEDBDiBU4J0A?=
 =?us-ascii?q?odkAh4HAQQ0EwECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBI?=
 =?us-ascii?q?xcHDhAnhWwNglwBEIEOgSYBAQEBAQEBAQEBAQEBAQEBAQEXAg06QQECAgEjH?=
 =?us-ascii?q?QEBEScECwsaAiYCAlYGARICAQGCfAGCKgEDDiMHDbJmgTKBAYIKAQEGgmesd?=
 =?us-ascii?q?B8sIlaBYQMGgRouiCYBhSRLhDwnD4FVRIE8C4JHMT6EQ4NbgmiCFoM7mghUg?=
 =?us-ascii?q?QIdA4EFBFoNGxEeNxEQEw0DCG4dAjE6AwUDBDIKEgwLHwVUA0MGSQsDAhoFA?=
 =?us-ascii?q?wMEgTAFDRoCEBoGDCYDAxJJAhAUAzgDAwYDCjEHKVVBDFADZB8yCTwLBAwaA?=
 =?us-ascii?q?hsbDSQjAixAAxEQAhYDHRYEMBEJCyYDKgY2AhIMBgYGXQkaBw8JBCUDCAQDK?=
 =?us-ascii?q?ykDITNBEQMECgMTBwsHeIIJgT0EE0QDEIE0QoR2hGwMgVIDGSsdQAIBC209N?=
 =?us-ascii?q?QkLGwYiAR0CnxEBglCBOYJIxR80B4I0gWCBYQyKG5UdBhMvlzAOBpJfmFggi?=
 =?us-ascii?q?1iBd5sIgXsjgVwzGiSDNk8DGQ+OIBmEFIRhimZCNQI5AgcBCgEBAwmFRgEBg?=
 =?us-ascii?q?1qBRgEB?=
IronPort-PHdr: A9a23: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
 fIz
IronPort-Data: A9a23:MeT8T6sOUpq3kxoeYoA0OfWb2+fnVGhaMUV32f8akzHdYApBsoF/q
 tZmKWuCbvyNZWX0e9p0Od638EhXsJHQzdNgQQtp+CsxFS4XgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTrSCYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbCRMtcpvlDs15K6u4GlB7gRnDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNz94X2mVTKlLjFVDmZkh+A8BOsTAezsAG6ZvXAdJHAathZ5plqPgqo
 DlFncTYpQ7EpcQgksxFO/VTO3kW0aGrZNYriJVw2CCe5xSuTpfi/xlhJHouGpIFveYqOHBL6
 u4SIR4PaQiA2/3jldpXSsE07igiBMzsIZ9ZpXxqiz3UZRokacqaGeOQv4AehWp23aiiHt6GD
 yYdQR9mdhfdeFtiPlkNCZQxtPiljD/zflW0rXrK9PtsuDmIlWSd1pDRbYTkRfWVRf51oXehg
 mDn03vLXTwFYYn3JT2tqS783rSfwksXQrk6H7qz/f9Cm0yW3mVVCRsMVFL9r+PRokq3RNtbL
 2QG+y8kt6F09UqxT9C7UQfQnZKflhsbRsYWDOAwrg2AokbJ3+qHLlMcaSFcL9x7jd4zWi4g3
 3GLmMvqWSM65dV5Vkmh3ruTqDqzPw0cImkDeTIIQGM5Dz/L/t5bYvXnEIgLLUKlsuAZDw0c1
 BimgUADa1g7iMkWy+Ok8FqBjz/ESnn1ouwdt1m/soGNt10RiGuZi2qAtAWzARFocdnxc7V5l
 CJY8/VyFchXZX13qASDQf8WAJai7OufPTvXjDZHRsZ5p238pyD8JdgNuFmSwXuF1O5bJVcFh
 2eM5GtsCGN7ZiPwN8ebnqrqUJpxnfSI+SrNB62JNLKinaSdhCfcoHE2Ph7Pt4wcuEkrl6Ykc
 YyWGftA/l5KYZmLOAGeHr9HuZdynn5W7TqKGfjTkU77uZLAPyT9YelebzOzghURt/7sTPP9q
 IoEaKNnCnx3DIXDX8Ug2ddOfABWcChhX8ieRg4+XrfrHzeK0VoJU5f5qY7NsaQ+90iMvraWo
 COOSQVDxUDhhHbKDwyPZzoxIPnsRJtz5zZzdyAlIV/iiTBpbJeN/ZUvUcI9XYAm0+h/kt9yb
 f0OIPubDtp1Fz/oxjU6bLvGlrJESiiFvwy1EhCeUGANRKI4Hw3t0f34TzTr7xgLX3aWt9Nhg
 riO1TH7YJskRiY5Pvn3dcCA8lKVlloekdJUQEHnDIRyekLt0Y4yMA33rKY9DP8tICX55Amx9
 lipEzIHg9LSsqkJ8NXtroKVnbeDSudRMBJTIDjG0OyQKyLfwFuG/aZBd+S5JRbmS2L+/fSZV
 9V/lv3THqUOowdXjtBaDb1u8KMZ4unvrZ98yiBPPi3CT3avO4NaDki25+t9nYwT+eYBoiqzY
 FyFxfdCM7bQOM/FLk8YFDB4Usu9j8MrihvgxtVrBn7l5R1H3quNCmRTGBiutBZzDpVINKEd/
 ONwn/JOtiKejEIxP8eknxJk0T2GDkY9XpUNsrAYB47WiTQX9GxSXKyECgHKzcGOT/5uLngVJ
 iSlgfueprZEmWvHXXkBNVnM+ut/mZ5VhkhuylMGFlXUmej+p+QW2SdJ+m8dVTVlzRRg0sNyN
 FN0NkZzG768wjdwiOVHXEGuAwtkFjTD3mDU1H0yi3z/c0mkckfvPV8NE7+B025B+l0NYwUB2
 q+TzVjUdArDfebz73MUYlFkofmydu5B3FTOt+7/FvvUAqRgRyTuh5KvQm86qxHHJ8cVr2+fr
 MlI+NdAU4HKBRQykYYaVbbDja8xTSqaLlNsWftipaMFPV/NcQGIhAShFRqDRdNvFdfrr2mDF
 M1cFuBeXU+f1QGPjAwhK4wiHrtWpMMttf0+Iu7FBGheqLaOjCtbgLSJ/AjEuWIbadFPk8E8F
 4DvSwy/AlGg3UVzpWucg/RHa0yZYMYFbjLSxOqa0vsEPLNdvfBOcXMd6KqVvXKUPFFZ/jaRh
 gfiZrDX/cNm249Dj4vhKYQdJgSWePfYdvWEzxC3iPtKNejwCMbpsxgHj3XaJCFUAOchYMt2n
 rGzr9LH5kPJk7IoWWT/mZPaNa12yeitfehQaOTbEWJ7mHacZcrS/BczwWC0BphXmtd75MP8Z
 Q+ZatO1ROEFSeVm23xZRChPISkzU52tQP/bmhq8iPCQBjw28w/Ndoqn/EC0S1BrTHYDPpmmB
 zLkv/qr2Mtjk71NIx05HNBjPY5zJQ7yeKkhduCpjwKiMEuTvgqgtIfhxD0a0hOaOkncRYy+q
 djASwPlfRu/hLDQwZsL+8ZutxkQFzBmjfN2YksZ/MVshiunCHIda94QKogCFooehxmaOEsUv
 90RRDBK5eTBsTV4ndHU5dP+QkGAC+ZINtqRyvnFOa+LQ3/eOW9CKOIJGuRcD7NeZTbpiu2qQ
 T3b0mOlJQC/m/mFWs5KjsFWQo5bKjfy2X8Cv0zw+yA379DyHp1SvEFc8MFxueAr3i0DeIgn5
 YT4eIycfHyGdA==
IronPort-HdrOrdr: A9a23:VElMLqNUp3NvNMBcTh+jsMiBIKoaSvp037BZ7TETdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwI080sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVybygc378
 ddmsZFebjNJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: 9a23:rgj8KGCb2Ffq4XX6ExJ/01EJXcB4S2zY02XaKmG6Dn5qFKLAHA==
X-Talos-MUID: 9a23:xxpLRApYp4Ioe/kRQU0ezw0/avZXyruuM2AyoKwiueioKh4vFijI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,168,1705359600"; 
   d="scan'208";a="79933931"
X-MGA-submission: =?us-ascii?q?MDEPZQ9S+vS9yk/JYBRyPnxrnZxR1p2+C9pvwS?=
 =?us-ascii?q?/+qAy86ZQUEvLZih8Op+USjjgXH9x6yRNPRSqrAfytMjyTFnZJBRPhva?=
 =?us-ascii?q?Vh6fwFcdVqkyGIAvV4NuXkOwVf6qEjABLENPfAi/NWDmSrHJO7MDQROI?=
 =?us-ascii?q?5YD2VkhhsD6dvF5u2NZ8xwTw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 09:03:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708243418; x=1708848218; i=markus.elfring@web.de;
	bh=38tHhxnlgpLrvhsBUmN/Sy4zFJdXLClHhlBzx5UpYqA=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=EBcYSd8EzLOzVMUQk3wdR9DW5HqKy4NbyDBlajN5G35s0mQJeOZBU+Fh1883id2L
	 6jSwhei5kRk5i8GFQx3u0o8H1QdBMoIAduyKqh9ieie0p/7NrHNTZuuZt4v5s+Wrm
	 NPy0D8na5r+TOEmGEF/sxT+C9Ve2XmqcczynEyqQPimlsz7XkpUqC25P2wPXYlPfA
	 +TG1N6E+yUuF4nBtc5Sneay2VqnrnLvWtmGxgRmWnAjYni+PPgPTfoZSuhAEJUgXg
	 Ei3mW4/fPeoe29agvG4I+1Vp1bH4thYwoCsEoD9Wftww386klIdE/UH8GEtKC//Qn
	 PUbLLKWuOvLDW99+6g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9LIO-1qqCUw04n6-015Lbb; Sun, 18
 Feb 2024 09:03:38 +0100
Message-ID: <6a89e704-5561-4f44-b9d7-7c8f78976e71@web.de>
Date: Sun, 18 Feb 2024 09:03:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <c5bcc0b5-1a19-4256-8572-b9ee5e78ea0f@web.de>
 <12009cea-f93c-4a80-a95f-9bde16dc78a5@web.de>
 <4bd9de70-de02-4fea-9d41-095304edf4fe@web.de>
 <38d77d89-ffb7-d495-ff80-898861d46d32@inria.fr>
 <5afbaf9d-892b-4105-a54a-35f1e40e6749@web.de>
In-Reply-To: <5afbaf9d-892b-4105-a54a-35f1e40e6749@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BaVlsgvJIF+S6b6NLv1wbfIM5Dphbt1yc7FfhXIEZDvEJ831CdL
 5LCbSR0Ux72RSLge+Le4WbLdcyOvHnvzVEh9pfxcnICApt1c1dVoJORzibF2bIZ5D6Ib6I+
 eVkEZ9HJzaIrhGgWIIClMlGJ6KigzUd7PmlWDxPDoBSr5AtnnaApRc/3lwJDt/4vok+21s+
 qW+u/TRtO7mxfsvyHaRZg==
UI-OutboundReport: notjunk:1;M01:P0:yLw+a9vZ2kk=;eMC1CL0erq2p4AljtWddnzG00CC
 OaFZ8baWgcKByyQLMIDWYtWI/BshC45YFHWIvA6lX47whdFOTaegYyo4+a+rllm0JJYuy8sWQ
 zHnidHA7k8lHWRbp41yDPsiuARkG5K24y8I293HlPb9Q/5r+GwKxmK+cGI6o7ZGV8PLaaL0PN
 W0DUw9KSbRer8ODihjSoHYkK/e+ASAafnxgjsM2MyOqC8d+U7kNJBv5G4ii+JpYgzLJy9xSPN
 +I70mzp6I/GquvjzQtaNfDuOG9ElsFyD8dZzagswZGEH20gl0jmsausearajd/A53zVkZBeCe
 M8u7J9qpDV492XM867wrBZVBwCBuPmTNHSWEanWoiJi1TOlFSUgG7OIjtqAKW6QUP4Ej9h0so
 CaFqiuIODOEp//SB/c2Wt77uOhv5joWO4ujLoCYktJm7dZvaoWGUtn5DLThQgp66HAAetnkR0
 AyGnelk7/sRXb8iE2D8nnnVOwi9SR8o+92A5/WyOnR1kGlhzafRUWGYBZOeKol1uPH/IQANCP
 tENGwjyCBDPAFoib2O7V7zPMrYj3EryNOY7qd0HEwkWpPJAhHma7B4V0y4ihEyhw+CQj0DtFm
 vujswjgo1SZq026JY5BrmINtjq9G8w+6A3P4xr9QEZVMuV8rBEDA5atu1ZYjTGy8+ZNHu/+PZ
 TSElwEeO+s1FrOnXcUdlnztcX+f7BfGR2jV60ikrs6QyUTmbqB9Ngm5vZZqCWG+m11tJyd3bh
 VuBXB5FS57Jj77J2mKnAwrEx873fanBfpSbfu9YEgCUX/7iTfi/JihViahlE1zJ/6rH82BEBi
 DGDvckeMDPWrViUJkrrIhgpEMvmZ9i2yFZU3xk6JJAk74=
Subject: Re: [cocci] Checking the search for a repeated condition check with
 SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1575
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/6a89e704-5561-4f44-b9d7-7c8f78976e71%40web.de>

> I became curious how the corresponding software run time characteristics
> will evolve further.

Another contribution was published yesterday:
binops and assignops need to be stripped before being put into metavariabl=
es

Thus data processing can be measured after such a development progress
also together with the software combination =E2=80=9CCoccinelle 1.1.1-0073=
6-gcf3ea16c=E2=80=9D
for the following SmPL script variant.


@deletion2@
binary operator bo;
constant c;
identifier var;
@@
 if (var bo c)
    return var;
 ... when !=3D var
-if (var bo c)
-   return var;


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> git checkout =
next-20240209 && time spatch drivers/md/dm-vdo/slab-depot.c =E2=80=A6/Proj=
ekte/Coccinelle/janitor/delete_redundant_if_statement2.cocci
=E2=80=A6
@@ -4100,9 +4100,6 @@ static int allocate_components(struct sl
=E2=80=A6
real    0m1,211s
user    0m0,981s
sys     0m0,095s


* Can such a test result trigger any development concerns for wider applic=
ations
  of SmPL conjunctions?
  https://lore.kernel.org/cocci/01fe8b37-9fff-4137-818c-8a851ce588a3@web.d=
e/

* How will comparisons of source code search and transformation algorithms
  evolve further?


Regards,
Markus
