Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4100CC433F5
	for <cocci@archiver.kernel.org>; Thu, 27 Jan 2022 00:30:21 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,319,1635199200"; 
   d="scan'208";a="18129632"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Jan 2022 01:30:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 156D6E027C; Thu, 27 Jan 2022 01:30:20 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 98E27E00CE
	for <cocci@sympa.inria.fr>; Thu, 27 Jan 2022 01:30:17 +0100 (CET)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=cocci@lists.ewheeler.net; spf=None smtp.mailfrom=cocci@lists.ewheeler.net; spf=None smtp.helo=postmaster@mx.ewheeler.net
IronPort-SDR: xHVPcLlPyq5DAiScmMj3ixH8hDW6aOf/7gOesabOhmjnXypR4VCZmVlobof+7LKMLX0O3yXSa8
 Aa2VzwQhjB8qkNAECKsUtnNXykjwfwjwZiQ/Hki4T8LVWI737tFq7wK8u9X+231xvZfvDDubAf
 eatcdHDoloVgD/Jr8OntV4PoxyoqxMmER3kLQ3tAsgMOutDSkWWLVvauATxFF+klmhzN0Xylzv
 fRFWwTy168FONtsyFCcHWqxF87nsJesbIRHa3puGpdZu+ZCwenVst/byEbsnFZb8sRs8Wr6IiK
 /fk+fVuV83lt1IW/CuS1EM29
X-IPAS-Result: =?us-ascii?q?A0DlHwCD5vFh/0Xcza1aHQEBPAEFBQECAQkBFYFaAoE6A?=
 =?us-ascii?q?gEBaAd3VgEBASkECzGTN4IlgymZKoF8CwEDAQ0SAiMKBAEBiGYCHQYGMQgOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECAwQBgQgsAWMBZwGBTgGBeQYEM?=
 =?us-ascii?q?A2CQQEEAQEBAQMDAwEBDAGDZTyFFAGDFg+uX4EzgQGDTgETQYVUBoE4AgEBA?=
 =?us-ascii?q?QGGCIhOHECBTYE8DIYBFwEBAQGCK4UwBJICYhoTLCCBP16SQ2mOeosfkmGDT?=
 =?us-ascii?q?wWKe4sGiT0GFC6WJpFUlkiNCpQ4gUGDYYE/JAI4gVkfFBoIJgqDJE4BAgECA?=
 =?us-ascii?q?QwBAgIBAgECAQIBCAEBAgGSDYE+iUEgAQEBMAIBCC0CBgsBAQMJjVkBAQ?=
IronPort-PHdr: A9a23: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
 3CdHlOxZly+
IronPort-Data: A9a23:QCFhYa8XqHGXubv8ydcHDrUDmniTJUtcMsCJ2f8bNWPcYEJGY0x3x
 jRMXjzUPayPa2f9L9F3YIyxo0oOvMLWz4NhGwtlryxEQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHvylYAL9EngZqTVMEU/Nsjo+3b5p6mJUqYLhWVnV4
 Ims+5a31GKNglaYDEpEs8pvlzs05JweiBtA1rDpTa0jUPf2zhH5PbpHTU2DByOQrrp8QoZWc
 93+IISRpQs1yfuC5uSNyd4XemVSKlLb0JPnZnB+A8BOiTAazsA+PzpS2Pc0MS9qZzu1c99Z2
 OhTs6WgGBcSM4LGyPtNV0NKLgV5MvgTkFPHCSDXXc27yl2AfmTszvhqAVtwO4AEkgp1KTgRr
 rpCcG1LNErbwbznqF64YrEEasALJ87gN4I3vnB70SqfAOkmTJ3HTr+M49JEtNs1rpwXTaaOP
 pFxhTxHUSjbaBZ+MBQuCp85gb2EoEnmcw90twfAzUYwyzOPklcgj+iF3MDuUteNTs5Utl2Jo
 3rPuWX/GBATctKFoQdp6VqplqnCgiP2VYYfDvu+++ICbECvKnI7GCAIU2Kr8OmCh2G0C80PL
 xYGxw4pov1nnKC0deXVUxq9qX+CmxcTXdtMDuE3gD2wJrroDxWxXTdbE2YQADAynIpnGmxwj
 w7hc8bBXGQ36NWopWShGqB4RA5e1AAQPSkPei8JQA8I+Z/lrZ1bYvPzojRLS/DdYj7dQ22YL
 9W2QM8W3e97sCLz///nlW0rehr1znUJJyZsjuktYkqr7xlieKmubJGy5F7Q4J5oddjFFQDa4
 iBfxJbCsoji6K1hcgTXEY3h+5nyu5643MD02wMxd3Xf32vFF4GfkXB4u20gfxY2Yq7oiBfkf
 0/etAdc/p5VNz7yNMdKj3GZUKwXIGmJPYqNa804mfIXMsEuL1fWpX83DaNStki0+HURfWgEE
 c/zWa6R4bwyUMyLFRK6GLUQ16EF3Cc7yT+BTJz31U33g76ff2KOD7oaMFaDau0jqqWJvFyNo
 dpYMsKLzTRZUfH/O3OLqtRLcAlWdHVrV4rrr8F3d/KYJlQ0Em8WC8jOneErdbtjkvkHjezP5
 Hy8BxFVkQKtmX3dJAyWQXl/c7ezD41npHc2MHV0b1al0nQue6i166Ibe8dldLUr7rUzn/p1V
 OUePcifAvlCTjndvTIQccCl/oBlcR2qgyOIPjakOWJjJMQ4GlWVo9K9J1nh7igDCCazpPASm
 bz421OJW4cHSiRjEN3SNqClwWSximdByuh8aE3Ff4tIc0L2/Yk3dSGo1q0rI9sBIAnozyeB0
 1rEGg8RoOTArtNn8NTNgqzY/Y6lH/EnQxhfDy/W8ra7OC3X5CylzJMZCLSEejXUVWXV/qS+Z
 LwPk6qmaKBewA9H49hmDrJm7aMi/N+x9bVU+QRTAymZZVqcDL49cGKN2tNCt/ATy+YB6xe2Q
 E+G5vJTJa6NZJH+CFcUKQd5PP6P0+oYxmvb4fgveRio4T8x8aWHXEhWMgPKjiFBdeMnPIQgy
 OYnmcgX9w3m0EZxaI7b13wN+jTeNGEEXoUmqooeXt3hhD0r/U4eM5bSPSn7vcOUYNJWP0h3f
 DLN3Pjeh65Rz1bpemYoESSfxvJUgJkDtXimFrPZy4hlTjYEuhM24PGV2TEnCAlKzhhK1+9pf
 G5mKyWZ4ElIEyhA3KB+s6KEQmmtxyF1PmT1ykAVjyvUUEmlW2jANis7NPrlEIX1NY5DVmAzw
 VxboVoJlR7ufdrtxW0/Rk5opvjuV5p3+xGqdAVL2SiaN8FSXAcJSZNCqYbFR9ULzC/xaID6S
 TFWwdtN
IronPort-HdrOrdr: A9a23:Vh0K9qg7EPZuX+GSWiX/S3h1VnBQXsoji2hC6mlwRA09TyX4rb
 HLoBx4vSWatN9/Yh8dcLy7WZVoIkmskKKdg7NhX4tKNTOO0ADEQL2KhrGSoAEIdRefygeD78
 1dT5Q=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.88,319,1635199200"; 
   d="scan'208";a="4188813"
X-MGA-submission: =?us-ascii?q?MDEVi2tact2NsICiKg16PKcJ4LI6Ojl3B1JbeN?=
 =?us-ascii?q?poXjy0S1n3T3wP0ymjvBMGj4Oa/VsTowhPSwHvxjUZpoZnvQK5oChN0G?=
 =?us-ascii?q?yvUegUGxT3iXQ1/h/R4SQPXmgNJJFjBrNivBxj+sGdIqrNmg+9iMaK3z?=
 =?us-ascii?q?UvLUz+plLogNsAYkz9DF1NZw=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 01:30:16 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 5416748
	for <cocci@inria.fr>; Wed, 26 Jan 2022 16:30:13 -0800 (PST)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id hiUC56roY9gB for <cocci@inria.fr>;
	Wed, 26 Jan 2022 16:30:08 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id C944540
	for <cocci@inria.fr>; Wed, 26 Jan 2022 16:30:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net C944540
Date: Wed, 26 Jan 2022 16:30:02 -0800 (PST)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: cocci@inria.fr
Message-ID: <d6cf70b7-84b2-5078-f9f7-81ca8acad349@ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [cocci] How do you match complex double's in Coccinelle?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 115
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-01/d6cf70b7-84b2-5078-f9f7-81ca8acad349%40ewheeler.net>

Bonjour!

I'm having an issue, perhaps you can help.  When I try to use the 
following Coccinelle patch I get an error:


```
@ rule1 @
double complex dst;
expression a1, a2, b1, b2, c1, c2;
@@
-dst += (a1)*(a2) + (b1)*(b2) + (c1)*(c2);
+vec_fma3(&dst, &a1, &a2, &b1, &b2, &c1, &c2);
```

It gives this error while parsing the .cocci file (not when evaluating 
matrix.c because it doesn't get that far):

```
init_defs_builtins: /usr/lib64/coccinelle/standard.h
meta: parse error: 
  File "vec_fma3.cocci", line 2, column 15, charpos = 25
  around = 'dst',
  whole content = double complex dst;
```

Strangely, it works if I change the type to just `double` instead of 
`double complex` and it does produce the following patch from 
matrix.c[1] even though `*cmx` and friends are all `complex double`'s.  


Questions:
 - The Coccinelle grammar[2] says it supports `double complex` so am I 
   missing something?  

 - Relatedly, does it support `complex double` as well as `double complex` ?


It does what I want if I specify only `double`, but I would like to be 
more strict about the datatype being `complex double` when spatch'ing the 
code:

```
-            cmx[k+(jl-1)*nrow] +=
-              dataj.exk* cabi+ dataj.eyk* sabi+ dataj.ezk* salpi;
-            cmx[k+jl*nrow]     +=
-              dataj.exs* cabi+ dataj.eys* sabi+ dataj.ezs* salpi;
+            vec_fma3(&cmx[k + (jl - 1) * nrow], &dataj.exk, &cabi, &dataj.eyk,
+                     &sabi, &dataj.ezk, &salpi);
+            vec_fma3(&cmx[k + jl * nrow], &dataj.exs, &cabi, &dataj.eys,
+                     &sabi, &dataj.ezs, &salpi);
```

Thanks for your help!

--
Eric Wheeler


  [1]: https://github.com/KJ7LNW/xnec2c/blob/f7373f11551b963a78cc27b11692f41abac28615/src/matrix.c#L451
  [2]: https://coccinelle.gitlabpages.inria.fr/website/docs/main_grammar.pdf
