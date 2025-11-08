Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F43DCCFA13
	for <cocci@archiver.kernel.org>; Sat,  8 Nov 2025 17:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=CtBVkM0lVp3hrG0k/xw6qhufMh9TRatS2hfkFYaz0Os=;
  b=jb4LCv3OTuOC23EY0tBh5Hja5HBcXKCjSwcRshS6FVtY8HdyQsX6Tslv
   RWODHt8RHoalnrPb7KO+R2REQOYXdNJ8xjz2kBiVOpHJv/9bQy/dyBmem
   KqUvr9xSJsJkl3OAVq69mtkt5Nu2IlVEqMtYA3V22ORrMkZaUnni9uyWc
   s=;
X-CSE-ConnectionGUID: KCN65mcnTmCQnGDyaRSRzw==
X-CSE-MsgGUID: MpJqTgjOSFag/fAlhtvVIA==
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
X-IronPort-AV: E=Sophos;i="6.19,289,1754949600"; 
   d="scan'208";a="248316568"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Nov 2025 18:28:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 13CCAE0264; Sat,  8 Nov 2025 18:28:27 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 82B5AE0171
	for <cocci@sympa.inria.fr>; Sat,  8 Nov 2025 18:28:23 +0100 (CET)
X-CSE-ConnectionGUID: tdThl2BqTvW/e5ydBDZjXQ==
X-CSE-MsgGUID: r0N4tVrQRWG5lJo2Vu0a5Q==
IronPort-SDR: 690f7db5_DOJ/Eotq7s3PrPZnniEtb9cB4LIl8w/dCXSoKZbUlRr7nRQ
 bhCdJ25nf4svU8gi8QcTGwgP7/Ea/LkXHskXtMQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HQBQDtfA9pgA4P49RaHgEBCxIMQIFFC4JAZSNYMwQLS?=
 =?us-ascii?q?YRVj1OCJIQ7hzyHVYpOgX0CDwEDAQ1OAQIEAQEDBIUAAoxaAh4HAQQwCQ4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBOwcOCjGGTw2CY?=
 =?us-ascii?q?gGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREmAQQLCxoCJgICVgYVA?=
 =?us-ascii?q?QGCfoIjAQYQAQMPJwevKYEygQGCDAEBBtpfHywiWYFkCYEcLoVugmUBiWx6J?=
 =?us-ascii?q?w+BVUSBPIJSMT6EQ4NbgmmCJoEOiRWQQVJ4HANZLAFVExcLBwWBIEMDgQsjS?=
 =?us-ascii?q?wUtHYEkIh8YEWA9F0CDSRwGaA8GgRIZSQICAgUCQDqBaAYcBhwSAgMBAgI6V?=
 =?us-ascii?q?w2BdwICBIIZfoIKD4QSgQWEb0ACAQttPTcJCxsGPZUGgnWXErMpNAeCOIFng?=
 =?us-ascii?q?WQMn2wGEy+DcQGTYA4GkwWZBqlBgWg6gVwzGiSDNk8DGQ+OIQwWhBG8DEI1P?=
 =?us-ascii?q?AIHCwEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:UErBG6MIte6dVMBcThWjsMiBIKoaSvp037Dk7TESdfUnSL39qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YET0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AufNRN2qDL63lgMNHunLj5obmUdwpTn3Zll3JH1G?=
 =?us-ascii?q?HTms0WbG/ZW2SyJoxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ALf+zIwz3/lm20FzzfzMMcWh8uw+aqL72LhwRr48?=
 =?us-ascii?q?/gfaraChSPG2jkWy+H7Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,289,1754949600"; 
   d="scan'208";a="130346521"
X-MGA-submission: =?us-ascii?q?MDFup7zn9v1q/aZikvk1RCbfJ67AlxnwwV+4kn?=
 =?us-ascii?q?KN+Zm/gcNEg7fkup4sxT3s++WdDfxdiNv7G2GArY2Zs4m3T7vF+OlgWL?=
 =?us-ascii?q?f8/quaWim1uUEcaCl34qy/6ED2PZEG7SshcyFT4lmEv/10Et1tfPtjf1?=
 =?us-ascii?q?O9mkbeDpTr4kG9bPMcuuFq8Q=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 18:28:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762622900; x=1763227700; i=markus.elfring@web.de;
	bh=CtBVkM0lVp3hrG0k/xw6qhufMh9TRatS2hfkFYaz0Os=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pxd/4VD5PZQI0tJOOm4M5dz5zMQEK7z8H2JwDaGIJwzbUtBiSn8f6qI7ZqAGWOyX
	 XIevbaAkol7e+6mFci+TwyNPrDeWlqrCnouwnbMoVdf2A778xV+oHhiX1lPGzLg2r
	 OuT67Fh0O3NiNXG49m4XEvgQZ+ZvSA7G4/tm9KRfDY7SStlkcdd1jawAJK24MfeFD
	 8pTBw2FNX7NXltnd8N7ddKo96DrD+Eres8yiAxO5XvSS/8Xzu9KH9DRaKQ0mlg+qS
	 py+lycAJfOWgNQELB77V3wBIdhKlP+rHMVN2XAY3Fqgutf6IJVL/mzp1KsceEyTqE
	 hTRX7eT7nZBKVdlADA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.239]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MTOhc-1veley2aGC-00JzgN; Sat, 08
 Nov 2025 18:28:20 +0100
Message-ID: <fef2eb18-8ec4-40ff-9ba2-217a68a7bd5b@web.de>
Date: Sat, 8 Nov 2025 18:28:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: cocci@inria.fr
References: <71e805cb-29bf-4fcb-bd90-9d012f977c4f@web.de>
 <0A7E25B0-BD29-4AA0-80A6-AB5B351CA52D@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <0A7E25B0-BD29-4AA0-80A6-AB5B351CA52D@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tfyeuVqoeQONFqYeqw28NQMBcfsrqozo0+CFGbz2jm7Ohkl4o02
 /Ydc2KvRV1yumr9F47n4rkECg1yaaiECgkJ3t0qakNyFoc6bsXxgLAejyA64GeElSSAhWiT
 lgarYkotvhrRu7LjDh3vWpf8qElZgXwtyaUyUMV6EQ/a5OCGONmoq3opL2Mptqq237C6qGq
 pFoHAwpL9k8XObkjv4vrQ==
UI-OutboundReport: notjunk:1;M01:P0:KnM1WjjYdDE=;Tskx6ZJagSjHuTjeklaSHPKK8O2
 +7vzQ26uW7ggKeSCKlMIa/k7FTMaE5HTA9JTw820xMUOhlmXwkdPzwXgmwxOQfnvRsr8LWfwW
 NX32DGaCYwQOzgbMzKmOe1+sPNDnsUS98bI2WxAH1q6gfy8eA0I7U9c7kDXmk9+Dg+bC5J74S
 Y2qduel/bjWodQHXn6qsIfbQb6kwS/DLuK5PmcQSG6MIO/FvjTaymMaaWgEjcE49MJigRztZy
 CdSDg4cgpzVNgCVlkHGgrxnjih356l4jdvBjjGw8M4e1jXDEObvcCuF00Uy6qqu+PM3x8Lfmw
 Q8FTQD+wu/qu5zxwXJOcYPy2R0bd+m0+cqJVKmpY8I9rnXopJ2+thJmxi2nU3qndA6bMM5P0m
 YDwwLzAJS3Keqe28pBteI4otJIdbFMXuL+fFOgu1SNUSVY3K2Z4fdnFCA1mm2Twds5lXu7RHO
 9mIxivNSDKlei2qh0dORQevDn6HsbMGlxAtweMZuH2PBuHv6KEAwzO8LaKWBoBoGCxHS6+jZQ
 XvRq270FDEWFUC4DkwikLXy+2VZvEiW3cLi1+PXHBZ6dLST2O+edHnLZ/B0f1q21MUnqlpYq+
 5MxGXtpe18DgVtY5RBSC/rUs834bxUmfwU1bbE+fJI4JX4Qpx9PixAZF6CwEzmb0aZEBYSGiH
 BFPwG3X/JNdwz9hKP+Chl/R4tgbPB4jMBpda/e/K6VEgrO2urmGZ+pP646GQjY5EyPEWwbo6k
 wuq7hAsN7BhTn2x4I18qw3/R2SK6CxKgV0zd67GDPDJTU9biU9ho3AfI1EQ1omnLopPhDEsgb
 jZ/MG9DE2JzWZjqZMTWFH/ApDzoE4zpIanlB57sHNb+dH2hLJOfxydEAv1lzDL5pjV5lWoO/s
 AQ4+S5TSC1hyOZjLX1pvMxtTW6Vxq1xWsGNAjs5x0MLk3dIV56m12z3Ev9z9tC9BpgbehH9lo
 o5J9C2v8VqGYZy2YeKgMaNcHB6RVMJRVrdr181kgzRZYYgLLvoy5a6GL8V02Bv1nbgRTtG/mX
 H4mulpl4s09bwOUNvClg40DxAFoy4WHm4bfwGFp4/LaaXs9ctFlyXkkmMdbhIKWGqfHk9uHh4
 KEhNk2SvKXXqLNa1skWiyrVu/1X5/tgMv5Nfq5GJ0SM0Fx/E1nKB+dA9qtnZ4FsOX5XlfiAR8
 9cjGDFUrJktkznC3hwMTTmvv8TdquJFnCJliKXN1bKTbJLRBl719jr/QZ4UvcE/H4iyf6o1yR
 WSi36ejwCHw1rFL9hbRM5ustgFgJcpyU9384ls3yasLFqD6ZIYJFjygQkXtV8p4ibanG+fd5s
 QALAAQuICDiuvLyQguRYhUFeSqyVqjioEVOd84GolTSTLm1KjUJv34QyFzjjSqehY1RkVlKWH
 RRPJYP+G+KpBK8UtG6bDkT1zCGhH9FDOJonLlf3wvfICUm1sBiKqAv8mWCHGRWxeqC2P9tK1n
 7lIR0iezJbi1znbMGSLpnP5Jf1rSMtrwXJhrYLN/2g5oab28wAeCyoDxAk78ZcvNc4b7IYFsv
 mUuEn8kBtPr5LKmN/5ckY3klH17X3de6f5gzfKk0geT+mbtqPHO4on6yDhscn2ahMLLGKMo3J
 GS57fY9eoQgPPBulj/Zi3/miZyatDGfR93nVH5lfe3NGtVCuilWXXIAy369y8TqeFQH3Ylw1T
 bf/1R07v1/2ctL3QAq8DHI9XggVIFeu7CH5Y3OYtVjnUcWgIhz5B6U41pB0QF4JOzNe+Dg5eL
 q63gO9ZTM2ezjwiEKxJ4CqRuhDEt3dbhvfwj1uZpjWneRe9tXGgkHtA4aJWxdzG2/5dGW2HWz
 824JwMyHU6jSk+UQCSiVkpJ+uzdaaDMwe1Pp1/rxe52xsV3rrD+CRU5O+94RwMPr5dAqg6P9Q
 wJiGHdP08SyPmjmDqq6f5lmIDbV60Nu+X8wLFXeSn3xoYRvusdnjTo9ZNtPf4B118CxZ9p1XZ
 +9n/QCaHUpgews5hjmZE8uirGXZeTvaupLTRT8jZfIpEx/uTJQX7XwtUadK/yvsaUh7JRbDmy
 Y2js0dEGRlyYIOQz4txPOFD29KxowjurMM7K9SiWm5jYjjYvBmOsQLGyl3kMwvm2jSuLjpq3n
 d3U9oB7J8YgYrCvhwo+ItZqAq6YoS29CgQceVX3pIPFhmIAvfIiCaMyaw1TBKT0p7B8mH0aao
 f6eaJTvgkh8kQ6bp+1AM60SPm73W7KR+GyeA2nYBzFtEIWJwKsevQ9Ci/uXkXMenzc8GN4doM
 t2SrW7I+TlXtQuhr8IjWcRNpyZvvxDSmzbtmaMTBTWD2rBdXCKfwehyTCXBjZNCsFbtT2ZAr2
 eHS9lnnEdJyJicxd3shlvhlkHoYQo6zS8o5qVLU5zPcPGLwfRBP+6aXUrLmafVIP2M6jH7EJA
 AjBMol+EZBFT0pZaqxEL7s1Dil0/MJDu5aC8eIAWkQ2MV5VU2rWV5hWtmCqQ7D/ifwHZHHd2w
 GVmfuBhS0bmgZXaM65yuqlJIj7wFmhXXTwRtGKSrzJMNcaYw6PqfH4x1Nb+WVsSfcZGa+x715
 7q79s/jx6+AbEmHAzQzWP5hGQDR6MlPbf9P6BRafT4LwIei+bON6tEqytkOHB0KcwpzfzOT2b
 OOuB8LwfK5Vxh5jaIa4U/8rqvg2tsFImM2g+OR1PHExt5/doFYWXrTQC9EaCM/zwCDu3d0h9/
 IomTw+MoRbmRs+OlPogFvejTdu381EbVc6lXTqaO4D1GmxVabdjJQNeTYYHTZrUHWGxJjFXyj
 pCYJBkHvGmpCggnz1zdZml35oWu3MP7IvuDB6YKaWIZyQGF934ZEb2JmhdlRs64ATL32xbsI5
 70IQWXB7B+tzfJtfIA4unnb2INPjlW4+c0L+mvA/5bFvo2vVGEwoIqMZiGjRZ8WKdvqwWrjyt
 9ArEENgkrkYve2Kczn2Pcz6FrLzCy01lNlr/1c+65xscJRSSlDkJjsQugdgul+esN6Chzo502
 xcSwJ9yzSwOSKItGTvU+BzxdP1aPBWAPIY9hl+YX5a+50yOXPpKuv+mFo70LikhFzJ0axOo/0
 JbNra2mKE0gatUWkYpE0CsqK/fD8LYUed2s/3fE9ck+nXp9mqX1pYgemISBxcwengjfk4nNqm
 UXATnQvuY0Uz+9KyfI+ys+gnyfCIi23lL9xXhnxDtO/JvGFVbesEjWFtqNomdn6EXsxSln7n1
 VrWQcuMX/o1prMsf+TAJVwQfRkOIzRpEU9X0JdtXcZ0hLRLL0tOKaLk95vdk02qbDwEpdcSOH
 kEA4TxrMx+RnqsbBKkDRwVOY0RSXfNe0hnlcnDsLHsklWP0Et407QimzywvmvGPBS0Ht/EmbL
 D3x1bRned48M6o8nLAwqdMVMboOA4KmShYs4zkTXS1NRV4xApx6/8h/oYc5SBMZVC/HvlOHmu
 +2bjaSiqxNWCQuQ5PHktP7vzuCDgiTwSAqkm+YSXnVS30MtN+s4HTKryi2mkNBA3vuirHUHVs
 uTtBn7dp+/NGA6eQ6AAHeK0Ff8NSWojGuSwvmBmc492QHIj0tve/2tzQKucEXI576EYTHr7Z2
 FlIvSt4dE65V3RCAZGmzMWbE6KnJmNZTHDzTTgJvhE1rZ/5jDuTNwqokDRieUyxIvYKtJua7R
 Mka5js6Wu55IZ0hKD2wbZ+FCGOG03mJPIyArS4FzYEVyptCci2MyyHzm9FUBCWYBgqVg/Oh34
 oQPSdT9FrMpl1SGc6R8SFQWT551lEr+a4LUwx/Azg9s3bNaUVG/eqlLBqtrQ2jDqnAvu5ucae
 mg/qAPt5IAi40dNn4HjegMWUKJFclEMvUl7NJAVb4/kCgMKkfxD/VWLThTh9itt8L4ACVy9Wc
 rCy9dWGMU2D9eT5vxC1alNL0LoBDRZLLGFNoTuvHJ2voJh8FYFDnAfIb1kZHMCAKbWgL7B0vq
 B3zmypnr9deoeurz9T8C52cO3ADLP47tfoEGvHVLOWfsqSJd+akO8i1W0w3ITEqxIZT5aFphH
 o55tBcPCjuzs3JcsgpAIELaKylDS7RTMxMV1BBNsPpoAS8TUwBYVw3KbR58WY5dnVepkDVixh
 ochUNloU8+G8o3HlbS6mBgbvnIgYCZRWUQUX06JvrerKRSws3gvga2euf+7S+ITK7bFOU1hXI
 tgh3Ym3KBvrRD+QBRmthVfodj2pnOOnR5gpv6yjH+40QkAFTeoE+DmqIFPehCA/iGz6gW7vqD
 c6L4/OuHpt1VPCjUyEnw4E0Zkax+Z2ik+mw/LRkZGi6bmXucgJF6p7KShEK2DyM3rW4qttzBI
 Q4XrqipXL5C9JhTRYQivfmiF6DybKLKgiQLGCLtWfQViKuFsCtmW3CAhGiOhyQyWIGRZ6X7Mp
 Kq5HMGXN3sbUvSqxkFpl+TL14FwP48f5Fe22Ti7fDPtGZ9s+niKfMY+vXYdfW2P2FNvUBmi3j
 UDzdk6hRVjj8DP0wQ0znKpdkpba2cemf8bCYzfUEHo1Oo8U5UbT1LNl26aQ5kCpgS5DlgKFR0
 M2SpLLyn0A8iTs4JJTDN9bprwo+VqZ8K+5BY0xqvdQcg4m0h0Lc0DRdxXEUZLunPH8rXj3JWy
 mFaS1I7NI9Qlt2hqoc8OUtJQ5UvNFdm0+riVcJzyIfGsvg82K/qkKnPG7Sm3ByZUEVP2WG6RV
 KpDALA486+VKXIpv+z841aN3SxjQzr+4BkcDmNlp/y22cMC9JiXlNxShZetl8XGF6vAh8kJeq
 Z2YqHsm00cVxakvbqd+1y1pbLOAEVdWk3mLa1z+7xqk/pou+6nOmt0nAop6JMv40S9Dl9O+zf
 /VgEO1hkYFm+2Y3bNBGY/gQBYFaCQm0wYD2CH+ydp8HPjL2uWvBV6xPYHOD5JGVybhxx1VfR2
 2V7lnWtocxGvBugHTz7H9DhKtC7cPPD/1J/FLR//WsBp1hpx9hm06C/KLpLtP6hXKuoNw6/VU
 ejDMbxhSudgK7oFgP5aOCquRyY/Os/NmuTF51E4/LOQ0zg5uNJVNrGzqsvV4epgDvaBGAXchZ
 Xa0BAiWASu/agqH/5hNGM4ooIxopoRCEIdN+6wRc0ZSTMKxfaEFTCQKmuQ8CTNq/cvfctwfnh
 gFQLA==
Subject: Re: [cocci] Searching for switch statements with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3148
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/fef2eb18-8ec4-40ff-9ba2-217a68a7bd5b%40web.de>

> Yes. You used * so paths are considered individually=20

Our development views might differ again on affected technical details.

* Which metavariable type would really fit to variable case distinctions b=
y switch statements?

* Which implementation detail did hinder the desired parsing of SmPL code?


Regards,
Markus
