Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17737C4828F
	for <cocci@archiver.kernel.org>; Fri,  9 Feb 2024 15:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=USw4rtehvf4tl1KZ2acECtYQsIWN43yf04mtVcdG45M=;
  b=R37hs42nEV/vGnvb7qXt41SAKnJ9jS/IyWwyygTH9YidNiqmhQ4kRgKU
   cUepY+knHuY450cEdH7FQ73nhu+vqR/Z3JufcCNTw6yGhBnx8/RKYOCVd
   lE3L41uZYvRRjPAEcUPN5uUuKomwII84lUGyIqW32AtDxu9zBwSkS2M5t
   0=;
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
X-IronPort-AV: E=Sophos;i="6.05,257,1701126000"; 
   d="scan'208";a="151239851"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Feb 2024 16:40:40 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C97D9E0CD8; Fri,  9 Feb 2024 16:40:39 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 11ADEE008A
	for <cocci@sympa.inria.fr>; Fri,  9 Feb 2024 16:40:36 +0100 (CET)
IronPort-SDR: 65c64773_RO9fD6k5lzokbSy2eAbRtidiVN6VFWKIibswrBWgVrbwCXO
 QM0w1Mge9D3DmXuPKYkTFmGNsKg+3nu6SeievYA==
X-IPAS-Result: =?us-ascii?q?A0GtCwCBRsZlhw4P49RagQmECHwDUzIEC0iBT4MEj0WBd?=
 =?us-ascii?q?YEZg1KBVY0wiHCDFj4PAQMBDTsGAQIEAQEDBA0qAYFTik0CHgcBBDQTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEjFwcOECeFbA2CVRiBD?=
 =?us-ascii?q?mQJOQEBAQEBAQEBAQEBAQEBAQEBARcCDTprBBkBAREnNAImAnECAQGCfAGCK?=
 =?us-ascii?q?gEDMQcNtQ1/M4EBggoBAQaCZqx0HywiVoFhAwaBGi6IDBoBBWWEOYUtD4FVR?=
 =?us-ascii?q?IE8C4JHgzmBQIEGgw6CaIIYgzyBKIg7gkQBi2WBUx0DgQVrGxAeNxEQEw0DC?=
 =?us-ascii?q?G4dAjE6AwUDBDIKEgwLHwVVA0MGSQsDAhoFAwMEgTAFDRoCECwmAwMSSQIQF?=
 =?us-ascii?q?AM4AwMGAwoxBylVQQxQA2QfGBoJPAsEDBoCGxsNJyMCLEADERACFgMdFgQyE?=
 =?us-ascii?q?QkLJgMqBjYCEgwGBgZdCRoHDwkEJQMIBAMrKQMhM0ERAwQKAxQHCwd4g0cEE?=
 =?us-ascii?q?0QDEIE0QokMAxkrHUACAQttPTUJCxsGPQKdXAGCTYENLIEAlF6yBjQHgjSBY?=
 =?us-ascii?q?AWBXAyIeIEjlR0GEy+XLg4Gkl6YV4t4gXeVPIVMgXojgVwzGiSDNhINMAMZD?=
 =?us-ascii?q?445hBSEYYpmQjUCOQIHAQoBAQMJhUYBAYMmNIFGAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:XRp+F6nuxiprHDrxqwmmr4Do5gygIkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIdDW2CaPiJYmChfdF0OYq2pkgD6pSGyIVhSFdp/yw1EVtH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvymTrSs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 LsemeWGULOe82Ayaj98B56r8ks14Kyo4GJA5DTSWNgS1LPgvylNZH4gDfrpR5fIatE8NvK3Q
 e/F0Ia48gvxl/v6Io7Nfh7TKyXmc5aKVeS8oiI+t5uK3nCukhcPPpMTb5LwX6v4ZwKhxLidw
 P0V3XC5pJxA0qfkwIzxWDEAe81y0DEvFBYq7hFTvOTKp3AqfUcAzN1AKHwoJqgR3d9cGExt5
 /wzOCoAVjy60rfeLLKTEoGAh+wmK9T3epwSsDdswFk1D958GMqFGf+Vo4YFmm5s7ixNNa62i
 84xTDN1bwnbJTBLNE0WDp0Wg+qiwHXyG9FdgA3E//FpvzSLpOB3+KLyLuOEPdWred96jlqig
 UiFon31EjhPYbRzzhLeriL03b+Q9c/hY6oZE7az99ZxkViLzyoSDgcXXB21u5GEZlWWXtVCN
 woL9yBooaVaGFGXosfVcTmFvmWhtzklcMN9MP86wxGXx5L42lPMboQbdQJpZNsjvc4wYDUl0
 F6Vgt/kbQCDVpXLFhpxEZ/K81uP1TgpEIMUWcMTZScoi+QPTak2iQ/TCMluGui5g7UZ+A0cI
 Rja80DSZJ1K06bnMplXG3ia01pAQbCUEWYICv3/BD7N0++ATNfNi3aUwVba9+1cC42SU0OMu
 nMJ8+DHs7hRVsHRxHDQELtXdF1M2xpjGGKA6bKIN8Z8nwlBB1b5JN0JiN2DDBwybJ1UJVcFn
 meK4VsOv/e/w0dGnYcsP9LpUJR1pUQRPdXiUPfPJsFDCqWdhyfXlByCkXW4hji3+GB1yf9XE
 c7CLa6EUyxGYYw5l2Deb7lGjtcWKtUWnj67qWbTlEj8jtJzpRe9Fd84Dbd5Rrlotvra+FSMo
 76y9aKikn1ibQE3WQGPmaZ7ELzABSFT6Une+pIJJN2QaBFrAn8gAPL3yLYsMd4t1adMm+uCu
 jn3VkZEwRCtzTfKOCebWEBFMbnPZJdYqW5kHCoOOV3z5WMvT7zy54gidrw2X4Idyspd8dBOQ
 cIoReC8E9VUazGe+z0ifZj394NjUxKwhDOxBSmuYRlhXps5WQD5w8LoJDXu0Cw0Cgu2qsoMj
 Lmy3SzLQZc4ZlpDDeSHTNmN3l+OrXwmt+YqZHTxI/5XY1fJ3LlxDj7Y19sbApgrB03Y5z240
 w22P08pldPVqdVozOiT1LG2kYi5NsBfQGxYJjD/xpSrP3D4+mGD/9dxYNyQd2qAaFKuqbSQX
 sQL/fTSK/ZdoU1rtbB7GLNVza4TwdvjirtZ7wZ8FkXwcFWZJeJ8E0aCwPVwmPVB9p1BtSuyf
 3C/yN1QFLGKGcHiSXo6Bg4uaMad3vA1xBjWy9kII3vB2Swmx4rfDH1uPCSNhhdNc5pzEocum
 tk6tOAstgeQtxsNM/S9tB5yyViiFHI7fp8chskoO7Oz0gsP4XNeUKPYER7zsc2uac0TE0wEI
 Q20pavlhpYH9HXjbkgcKHnp9shejKQopxpl4gIjJVOIu9ydnd4x/kRb3goWRzRv7Cds8rxMK
 E10EXZqNIOy/ztMr+pSbVCGQg1uKkWQxR3s9gEvimbccXiNakXMC28MYcC240ET9jNnTAhxp
 b235j7sbmf3QZvXwCA3ZE9Crs7jR/xX8inpupiuP+aBLqkATQvVuI2cTktWlEK/GuI0vlPNm
 sdy9uUpaaHbCz8Zk5dmN6akj4YvWDK2D00cZ8p+/ZE5P3DWIxCz/jmsF3qfWO1wI97yzEvpL
 PA2e+xuUUyl2TesvwIrI/cGA4VJkc4D4PsAfbLWJlA6jYaPkwoxjrXu8nnRuWx6ZfRvjsc3F
 a3JfR2gDGG7pCVZik3NnuZ+K0u6ZtgIPjP9+OWP9MQICJMxn+V+em4i0raPniu0MSk22zm2r
 Q/8d6vt4Og68rtVnqzoCbdmKzivDNHOCNSz7wG4tupRYeP1Mcvhsx0frn/lNV90OYQ9dstWl
 7PXlvLKx2LA4agLVl7Gl6m7F6Vm4du4WMxVOJnVKFhYhS6zZ9/+0SAc+myXKY17r/0F35OJH
 zCHUcqXccIZf/x/x3cPMihXLEs7OpTNN6zloXuwkuSIBh0jyjf4FdKA90LyTGRlZyQNaozfC
 Aj1hq6U3epmjr9wXT0KO/I3JKVDAg7TafNzPZm5/zyVFXKhjV6+q6Pv30hooy3CDn6fVt32+
 9TZTxz5bw6/o7zM0MofiYFpoxkLFzxotIHcpK7GFwJe0FhWzVLqLNjx9b0DDYxI1DP/3tf0a
 VkhqYfk5TrVBVx5ndfUubwPnTtzwsQRN92/KjFBE4a8dXKtHI3ZaFd+3n4I3pq1EwcPCMm4J
 NtY9nCY0t1dBH12bb5728FXStuLCh8XKrzkNKw9fwHP784iPIg3
IronPort-HdrOrdr: A9a23:12ubbqPvap7lHcBcTwT155DYdb4zR+YMi2TDiHoddfUFSKalfp
 6V98jzjSWE8Ar5K0tQ4uxoWZPwN080kKQY3WB/B8bHYOCLggqVxcRZnPLfKl7bamTDH4xmpM
 BdmsFFYbWeY2SSz/yKhjVQeOxQo+VvhZrY4Ns2uE0dLz2CBZsB0y5JTiKgVmFmTghPApQ0UL
 CG4NBcmjamcXMLKuymG3gsRYH41pb2vaOjRSRDKw8s6QGIgz/twqX9CQKk0hAXVC4K6as+8F
 LCjxfy6syYwruGI17npiLuBqZt6ZTcI+h4dYKxY/0uW3nRY0iTFcVcsva5zUoISamUmSsXeZ
 /30l8d1o1Img/sV3Dwrh331wb61jEyr3fk1F+DmHPm5df0XTQgFqN69PdkmzbimjkdVetHod
 B29nPcs4ASAQLLnSz76dSNXxZ2llCsqX5nleIIlXRQXYYXdbcU9OUkjTRoOYZFGDi/5JEsEe
 FoAs2Z7PFKcUmCZ3ScumV02tSjUnk6Ax/DSEkfvc6e1SRQgRlCvj8lLQwk7wc9Hb4GOuh5Dr
 7/Q9tVfZl1P7ErUZ4=
X-Talos-CUID: 9a23:NNZM/W/5ViKjU2ZrEUWVv2AwJ94+V3T69VzJDmyqCU15UrCtZWbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AW+GIJg3q4h9AQInIa21+6sNuxzUj+buwMRFKmLQ?=
 =?us-ascii?q?6oeaUKRZXEXTAlTina9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,257,1701126000"; 
   d="scan'208";a="79236440"
X-MGA-submission: =?us-ascii?q?MDHOk4jJwMCiUloGpxPBI1Wjm8hLDC+gHQu4i/?=
 =?us-ascii?q?S7IpsiWudqn29RVOJjSA0Zwa/K/ggYyjtveuIlu69/ar0hgcUFZIs+ZZ?=
 =?us-ascii?q?O89TNdFiBUrluceTx1/TzH7xxs4SXdax6aH5lEw7MexCCbM/pIe0Cy9o?=
 =?us-ascii?q?ZzAwqXn4OMCCoAv883jrlUiA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 16:40:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707493234; x=1708098034; i=markus.elfring@web.de;
	bh=Pr1jy60OloeGRvAOC7hMdKA1Cxz5gJkj+h0ZeFskx1I=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=s2+QTdDoBO7ivcNzaLi45cIRxAv9VkQx2b8FRTEBRxtVl8t/XU1qt2kc2vnQEYh1
	 b63HG3rEv8AuoeY0LvZ120e7nPs08yHIXUoHe7pSQV60LYLgECEFpI7rDjE/3GHIp
	 bxczAbBfs2gtWC9y3Xuah2QMLvU6KU4SZjIKLw8nzB/IoD3SrT9M3IbnIdD7LCj/3
	 TbVoXkMJVL+1FEcs5oHkxvywVh+Xer1oUiBIkV7xoFoChojqUSFOglNuTvc6NPhfK
	 rlJCyAARh2ZCtQO2hLPRqGVuJKyNLqYTZZn3cuIQ11EEdqvqUKzbmFIBfUEA2UMg5
	 1FueZ88gyEKDQUow4A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N45xt-1qqqY71F6v-0105nC for
 <cocci@inria.fr>; Fri, 09 Feb 2024 16:40:34 +0100
Message-ID: <c5bcc0b5-1a19-4256-8572-b9ee5e78ea0f@web.de>
Date: Fri, 9 Feb 2024 16:40:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BDrl4MHdlg22pwLprmcBx8aTsU/AYdeeWI6132WBZxvNp6/i/av
 n2i0RBnPtCEAsAWPzohqBevdnWlfA+h/kW/JtCLKnvgBSxrjIfSucxhZx5hbM757gJt0em7
 jAFsn9bIpdZNowbslFZ0f8FAfkykbM4L7y3WaorQ0+6zblIePfFkzxRMRZPrhOhpS7dSLqx
 QY6F+iDEB6a9RCYmF0WNg==
UI-OutboundReport: notjunk:1;M01:P0:4w4BkLQ+um4=;Rv4Gu0g7IuJuLj87NX2zuUcXYdF
 kjlWRvORPXEQnXyD1V/+0AL7ayFHs/7jW2vEpUn/xyeQKCmBD5TXzSr9LOjP5rXD6CdjwkHW7
 s4ks/48BuP6sauFkmpuBqk2AVj7lzHVSqwf2+IxfV7MTSlfanLjvdB5BBamzCFdDOGk+0AbRq
 IsMgHa/rIJMfgtXBiENHaVRapp+7+f2KO6yBKX7qGH/u4bRdFeUpnT1zpIGMRGNhVDUb24D2B
 gMllF5Kpolgng6vdz76B4Iv2xgPyCP3aNBltUe+6XkFDzIf/gMY4lq3F1e/KzYyrKu71OZymv
 lMCyf0oXYEh8Dutd7nJA20KlCwzH3i/ZS63YsyYaRWIMh5uVOCZwEpVp/JqnCLaXIv4dYjlfP
 8JKK8OuLQ8tW8WJvBj8EFgrE4/aOyCzEIF19iOHFO1zCDXDOmMtkB2tPBXAje8nBLTAarrKGu
 dFEL7qOHZdMO5pVv1Tj9Q4TewdGxEmUEnB8FP6D167nHNkU+hsoJTHEz73qpsVCEeZEhQlVvr
 xv7nAqLQUSPT5pcUKAuYtcRL/Yd7VGIc/6S8NKqJP5+GhPBPiQMZQOqOMNGSDVG2ekpa32EX4
 NLe9Xj+Eg+aOGrDPq7LdYhps83/fnoF2hjIPbP6RWji+5DKfmjK8vocuuNq5mU9Qslk1iW7wn
 K0ps6uHRmWVPiY+q1Bi/R4MrYxPuys0Wun9Jok/AdbuN2F33MQ8MOkJjxZyaw1wKlx96MrrhI
 pcPAFzXBzpq1eRWgF201spEB0k1iMDRuW9sz3UQS3o0tOmiBpiCKdlp92JO+H1tX4nzO9RCor
 yqxJDHY414EhhSPVxQUPeD4ZYVbv9x+8cxvhi+QvwEGOY=
Subject: [cocci] Checking the search for a repeated condition check with
 SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1531
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/c5bcc0b5-1a19-4256-8572-b9ee5e78ea0f%40web.de>

Hello,

I noticed another contribution by Dan Carpenter.
[PATCH] dm vdo slab-depot: delete unnecessary check
https://lore.kernel.org/lkml/16ffd614-48a9-42b8-961d-2dc8a69c48d6@moroto.m=
ountain/
https://lkml.org/lkml/2024/2/9/397


I constructed another SmPL script variant accordingly.


@deletion@
binary operator bo;
constant c;
expression e;
identifier var;
@@
 if (
(    var bo c
&    e
)
 )
    return var;
 ... when !=3D var
-if (e)
-   return var;


The known patch is generated then as expected for a source file
according to the software =E2=80=9CLinux next-20240209=E2=80=9D.

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> spatch =E2=80=
=A6/Projekte/Coccinelle/janitor/delete_redundant_if_statement.cocci driver=
s/md/dm-vdo/slab-depot.c
=E2=80=A6
@@ -4100,9 +4100,6 @@ static int allocate_components(struct sl
                };
        }

-       if (result !=3D VDO_SUCCESS)
-               return result;
-
        slab_count =3D vdo_compute_slab_count(depot->first_block, depot->l=
ast_block,
                                            depot->slab_size_shift);
        if (thread_config->physical_zone_count > slab_count) {



I tried also the following SmPL script variant out together with
the software combination =E2=80=9CCoccinelle 1.1.1-00676-g99513ec1=E2=80=
=9D.


@deletion2@
binary operator bo;
constant c;
expression e;
identifier var;
@@
 if (var bo c)
    return var;
 ... when !=3D var
-if (var bo c)
-   return var;


I wonder then why no patch is generated by the corresponding test.

Regards,
Markus
