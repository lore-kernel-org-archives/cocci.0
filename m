Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF246CFD376
	for <cocci@archiver.kernel.org>; Sun, 30 Nov 2025 08:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9bLG3s1RzLdOTRFBMxzIRH7A2Az2qVAY/k/l4yxUBV4=;
  b=uhZnt0LcNM9kZkTF/iAft4HRkO9eDMTCW/k9YHkeG7HzrSNmM5kemetj
   3bBFkc5F58GJIfKy1vKFH+5uLBWrWP3u/GRqJzr0Fr4eENHJEXpRI5k7A
   XCZulemneUFZ7ygCGSnRDkDIobltf2LyFydHk56TUfQ7Nol/iZsehEjZ7
   E=;
X-CSE-ConnectionGUID: jJB+eXgmS+iyUexQRiUeYQ==
X-CSE-MsgGUID: qjNVHqO7Q+qQxN55UgMjHA==
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
X-IronPort-AV: E=Sophos;i="6.20,238,1758578400"; 
   d="scan'208";a="251934261"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Nov 2025 09:44:49 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 99911E01A8; Sun, 30 Nov 2025 09:44:48 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E8050E0157
	for <cocci@sympa.inria.fr>; Sun, 30 Nov 2025 09:44:45 +0100 (CET)
X-CSE-ConnectionGUID: UmqZAFbmSMmwgKsPDIhBWw==
X-CSE-MsgGUID: CrVtAUnvTsqhWgtfKlgjxg==
IronPort-SDR: 692c03fd_HxTjhkeDt1lY+12mUDB1GawyMLdFJkquSMltekgYg/tkF2+
 DgBnDnu5MCNgFe2t5PR2BWEg9XCiHlLvDrAuA5A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ERBQArAyxpgA4P49RaHgEBCxIMQIFFC4JAZSNYMwQLS?=
 =?us-ascii?q?YRVj1OCJIQ7hzyHVYh5gVWBfQIPAQMBDU4BAgQBAQMEgUyDNAKMZQIeBwEEM?=
 =?us-ascii?q?QgOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDjuGT?=
 =?us-ascii?q?w2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREmAQQLCxoCJgICV?=
 =?us-ascii?q?gYBFAEBgn6CIwEGEAEDDycHsQiBMoEBggwBAQbaXx8sIlmBZAmBHC6FboJlA?=
 =?us-ascii?q?YYphD0nD4FVRIE8C4J4PoRDg1uCaYImgQ6ZV1J4HANZLAFVExcLBwWBIEMDK?=
 =?us-ascii?q?jQtI0sFLR2BIyEdGBNgPRdAg0kdBmgPBoERGUkCAgIFAkA6gWYGHAYcEgIDA?=
 =?us-ascii?q?QICOlUMgXcCAgSCFn6CCg+IC4EJBS6BDQIBC209NwkLGwY9lQ9Qgy6CAIEjs?=
 =?us-ascii?q?S+UYzQHgjiBZ4FkDJ9sBhADL4NxAZNgDgaTBZkGIqkfgWkBOIFcMxokgzZPA?=
 =?us-ascii?q?xkPjiGEM8UYQjU8AgcBCgEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 vselQZ0J+ggpm+E3g==
IronPort-Data: A9a23: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
 FnwUYfpNckxsfmov/kxDBQPkzpz3tAzB+o=
IronPort-HdrOrdr: A9a23:hhzw3a1KuiG+ObG3714m3AqjBGYkLtp133Aq2lEZdPWaSL39qy
 ncpoV/6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyTMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: 9a23:7rcfZm0nCB7EEZX2kRVmdLxfJ8U8QFTzxnLrBkqnBkVycJG0SXWv5/Yx
X-Talos-MUID: 9a23:UqW52gThEM2QpBLKRXTHng9+Hfpu/Zi1EUAynokImM2LNzx/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,238,1758578400"; 
   d="scan'208";a="132312708"
X-MGA-submission: =?us-ascii?q?MDH2bemmR1REydG7M73toaZzJgiG0jCJc3joJD?=
 =?us-ascii?q?ODVHa+EMIm13Upfy5FpYgs1qDoaLOHs5FlOQ7bkTzZXOFEqr1A7PPWXN?=
 =?us-ascii?q?3OFmsgPe5U+XiuyvrVGBr8Gr2ggYTmCwXCSvwuqh4HWBAtNZgtaBoTqy?=
 =?us-ascii?q?bVJbgpEL3yrxYvvEgOjG+G9Q=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2025 09:44:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764492283; x=1765097083; i=markus.elfring@web.de;
	bh=9bLG3s1RzLdOTRFBMxzIRH7A2Az2qVAY/k/l4yxUBV4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CLvcP06xyAXDY3qvO8Bid4EZG7QBcgZ5/OEHZjIBCRqNOhl2fqoSbml9ImAKlcf9
	 zsZuHTXjSECuiMIjrYFAHxpUB3meLGLLy/QsV8E8eoX9AgtRJjxhc2gCJUfk9qqkr
	 P+iTc1SN9ihA8Q7mjngoaIIQJPG2hODI7YxWvPT80XzUGjaxL+36Mvu8EnRW8jXXu
	 0QyPFoTK1Gn6OKjO/FbYtnDcF8OOxjRCNkA3KG+k8uX5/eGHhxxqyB7nXkvAJqvFf
	 4Y52akoe8DDeemYwdTBshm9eYjB3SJykati+S1HYkQGwvgSbEqrSFQzTNkJEWtV/0
	 ruFR1G6ZvFtZ+6RMow==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.203]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MzTLI-1wL31926aG-00sSHm; Sun, 30
 Nov 2025 09:44:43 +0100
Message-ID: <92304555-3aa7-4ef3-af2b-9f5d77a1b5fb@web.de>
Date: Sun, 30 Nov 2025 09:44:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <4f6e259891de0666aa1fa10b810a5dd3@posteo.de>
 <b4884a21-4a59-c549-8466-164a20a76abe@inria.fr>
 <2897bda0c438111e967017f6bb3422f0@posteo.de>
 <caf02577-eee9-d55d-1f42-7b1f3bd2f60@inria.fr>
 <3ae5bc93f8cae1f28a068d89d3d1b070@posteo.de>
 <67f9e0f2-fa4e-c7a-d388-3732d8aec1e6@inria.fr>
 <67d1e00d2e22a4655cb10ec55d1a99db@posteo.de>
 <83c8a7aa-9b98-8ac1-d563-e8fe2588f9a@inria.fr>
 <fd7307f8024706d4bd128d0b7f43bb96@posteo.de>
 <29c204aa0f1f08074279425b7de42dd7@posteo.de>
 <825ab32a-2544-d2a8-bc48-38f26c62bc@inria.fr>
 <ded004b275d73e35c46c3d30c057d58e@posteo.de>
 <50ab756b-f81c-bc24-fcd5-4eea4e01f78@inria.fr>
Content-Language: en-GB, de-DE
Cc: Tobias Deiminger <tobias.deiminger@posteo.de>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <50ab756b-f81c-bc24-fcd5-4eea4e01f78@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EUQp/6YlGIiVW2pYjK1v8zk2rjkxnydPTrdry+Mjx+J2NZOdLCt
 NfHUEH5ZYvuMiJYE2Jo/vIZ7U4DHDogDaK6UAXgXF1JdjXTAqSiL9SoqGkSJHW76EX25HHQ
 acfAFHOwT4GantfNaEqdcpdBXmwjZQYvkaq5jMngcjHtTwSZLaVr1KG9UFqAQ1qZBBgjtc6
 KGha0g1BHKqLrxbKwybLQ==
UI-OutboundReport: notjunk:1;M01:P0:ABAfPmpMcsM=;5AF7WZ0B7NDucSYwuGk+2VDbgIE
 nB/mZRM+xwjFNotdNE9/8/lxiPsWqndvPB52ax0tDrJeASH9+Doo/3Vnw/4toaLQQvSleiHV0
 IrboN3OATehURUFlJQEuZ9V1GlpuENEiHJ+q2FbAthDZaL1qWLWKKbzJdE45x6ySLsTMLvRw/
 8a4RHlCOxRyfgjPLn1BaOu2wJrK11IneJP5sBXBicYPdnXFQAbd5Tuq5EVlyIXfUcFKVvWMwG
 J4nuhvxwX7P9m60Y6uPWIRzRxzG1h38KUnG5v7zQrhBzzs3A5MiO7WStQSd9inuLcHvCfVnKN
 Hk19n8/rU2smpXLfXOsCDmw/6sKn24d/OgGwwLuxfcDagi2szj0uRp7X3r6JiF0OmNBIviQPZ
 UIPxWvZa4VVBb/uaFf0tyu9TTX3gu2ZXqTmAtcJmFMNsGTd0PjIc3wyFBjyENAmpL+jslVYDE
 +gYnUIDTMkoIfFCRqJIe5yHyF0OHr9Mx+BcpPFiLtHl3tz2qCt2CzW5nNhQFIlrme4M7knsMl
 RcM/M5tPwKuOo9AA9jZEhXILYPism3a74NJnxVc98XgRCnHvQxtomN5WWpzccFyZI/Ww6hPBx
 qq4FRH+Jz2WFzGOvbEchHGFwYmIqybrSZ/DdpBJBySThgcE2I58vy/YTlGY9/SXAJoNwNHygY
 aXuDIHnWzECWM/JqkI1CfeUzJ7BCF2QF7bD3Gp35HihHeQL6WREnbFiQkuOeSaHihT7o/z8lR
 MGgqq7KxnhzI4CWlNOAPbi+YwNK55QSYVskgorQD/uPgahO71pJD/rUsPW9uDRmCtIxbY1lIa
 /lnYo5/4dpj4Rs6Xl7k4Huo2rUbu66rsE2YfxSRBljHDIDsuZdR5pLfWWOSxL6avu5tHEl7ql
 HJyIuCeRSfAWIXI2MTCIGkZjf8RFou5jfUG377g3oqgH9nwAg4r+dgCiUklwAYOdtpqhVt2pm
 1mMviEM0vYjuq078TiA1CaZrqHVKSrso7Hl6b99P2aTPd2vwSFITsk6emjs6S0qc8hqj4dsh2
 JNBg6J1nLc2MHjKn03YGvVZ9MAQtJj/ZAWQTdQLrZX4Ke3Ns2mVxVW394hjKgAEIzweMkQvTa
 jYl88iwUq8iJv/1u8NVLjf8gO281cLHnLz3JiaGH/KhV6xm9CkWGz818YYov8kbyWL6n9On17
 cwACyap8xKRveymOtWWYEqiDdXsMHrxZQXPNyAeda1QPBm/RD7PYZ1OACVXQkOSc1VWs3B3jc
 L6djC4l1JX8mo42naoRpMbGDAzXjmN74ZQ7ZZl78OgHraiDt8osSDGVCvJMGuLX68UKIWavlx
 uj7YZdxT7NlQk237aDzHKn4Hb0XU4CY9zW0HTTLfIIglYVtxnJxhyEAju8r8V9BP3gK5FjfHz
 xl/YYt2BjEqcBcxhfAOWuPoxujzFzVNUFRU0VupLHtfNlwBPvgEZSzG1l9t/tsMWrg0muGJL+
 uNR1cJ3+WGNhw6d/uD8+Z4m7UtmokLKctNMB6mdyJXcNljAYN6Yakw6TwfjE4bva/wG+HmTbq
 xMr+PT/RYJjqQvAwgM9+a3mMOokteoDZTof7fKh31vbMTLrcW4QXyP76ZQDT7Baf1FZ0szDDE
 rmNVDeZUpGFuENtH8PTzgUWJ5k/QYClaJvls0BX5nmS5L3xe2QvIIb3ktlLzS2/I2/hgsxRTR
 Pj9PhJJATIz9Uxb4ZDG2HuQDR3uQ/k9xsaJIcD+tyRiXrURSdIgK5bcGEVvKb5ALlzrzMRXNS
 1xvfMcJXU6j9EsvmqtANegOV7qgo4dZNGeBrBzwzoulpdMxPoJKhcF4Cks3o3zfID6SuKW+y/
 +qU3k6PywxDt+QuY85ax+hULuePgyoApg5LYmnL9GfilMave8ggemC3QuZNGajl4SEB3U8GeD
 7CoOftJTRwm+Mv1N07yNeF0nZnRGII/ZorpDlBY5ffE3DxEwmv1qmFWpfHLny98/RF7weLvMr
 Tv/nWmXSnjsHBSuFTFBVSS5cCgO8g/8NscbfEfdLzJZsk/0QeDiWt60G/tw9BxC7wrcpdXiAc
 uLbgTBe7aeVu1WA/v+EnP3Ti9wepGzCTuZvqYkZzFvj00R91zFSRoIG3zzs9E1UnLE/EGInA9
 grz8m0DiyTMzRF5HZCMd5VZ5chpTP5Rx89H7F1UYagxPn8Fjfj44k75svqRcVzQY/CElmf/Z5
 rV/9g/DB0gSKKzyStj2z6SzeoB7vln1q33em7PjWFEsqACnN6AtaUgiAn906Q5e4m/sCWXdGP
 Xlu/O7qP3hGQt1XCYIcasunUaPGic/d3c42jf+3Wqc8K58tykDtHOjB7Xh6P7YkcCCwdV9KY1
 GMB/4Nrqh5fp8sJeSMHddkai+n0zJwnfZxUxP6pcxqNWe8CBhC7LeQWlbMRDlivBqpg4QFqys
 iNzRFJI4nglTWj03CVmcNMUXlvv7P6zCKcQ5juGGrZw7YdFhUAx6HQ1GlJPZK8atLb68SLb/I
 yMX/tTncUZYMg8KKfdIfC82+0SKZ0PNFdqyKzzMR6LaQIIvRgLqHaBTACQMqCm0xHq3Gy8gTU
 SqUTQ2bvICRYwcoMqNDCH3KC20+ymtd11WFrG9DQ+NPpW8/7J7gGpCJzN8jCCQeFNYevnJtOI
 A30n7K4e201jsSZ2y/DBW0fqSz1DoyyAPqyrRKAYw7kg06iAkLOxPd/BkpULA9XcFBClxT5qy
 0l1uSJyMDUswwlzgvMhRYS+pPrSP2pNUTiiplUmO/0P5DasdBjWUUR5Kh63iLPRBWIr7cnLHx
 B5LF8L4G2RVs0XqHx1ISY/Tv3N6TGUQ43PfiVCsifM5a6rJrJ/bOLlLEoUO8CdeQeuN9TBICo
 UviaR/0O58kFW5P03+F4ZWeF5uyNCKNMmU29GgLAevlBsE+oMm/n42LJELz6O5uo0zoPo9+ui
 cUzffWlXlXAXDKpp/lZXcA1G+9OyfZj4OiTyLIo3u5Lu4NwmeGWXgLGZFxSk0ABArjNxH7lMF
 OdWQiFujNU3khXYJrBm7A95cENg9DEx+hlZQ6lHT8oD2BjUsQakaIvkYlsnwbnq5wL29V2PdT
 WiQgfRCwAJa7nPaIs4EDnlkCBADL6U+WqnlQBLcsprVLsjAgReDO8vebmxC5c7kL3AWQ2WaDf
 Tv3sLsOL4UxcBkOD6QNIW1frozpxD8sGXffF+fEJFSu43KdswXawfkXCu+nGKXMk6kbKHI4KL
 FMO+bkmgNx8iV1Y6UZ1yvEnMEXH5ZPX41ioUhHYgegBH2Xsz1iI/9I67D2/cTCFZ75xU7TKNm
 kd0YWW7fZMSVpWrNaIQ7u9cSIjg5WMo7703q8mCif+VXpb+0kfaM4gIcD70a8spPiLOr2rsIR
 iNU2FRa3jl7fUyo2UYJ3PIKRjKiomZYWgPOfm7eoPtNCRyPlzFLiJdjQll3qBuc9QjTxiaDBM
 OinRMsSR4AYAvWd1n9NSfl8svmoxx6igbZ+f3JiM8ukrnK8rP4Ipyznb4tsLj24iPetyG51Ct
 0MAoLTscq7xOJGxt1nkKZ+BN9EHiqWowtBq9twre2W/fjdGlO5Tp3VPlQxYBGb51T5MX6ohbC
 m2ILJ0LCYEffayZv8aUO69EGmEjgdpQkN00EbuKBCy5prdAl3bPGSoCBhHsheEgoIFaQUY7jo
 pdFnPLYAlA7BpqiqdNeOl5WXVOxJn/FijO038mNf8QviagYURtTWPFVONJ0Yu0mbLcGNdoPZk
 HE6JsnK7GDXhwS1RSIky2gkIW9Qz2KTKogJypFcCb14GZ9p5q3U2qLxbOgwd3rl55V4sCmQEV
 jH9+KQeW3jCGT6VxfmkSSBT3F8c/j3G9fwQvk5hYV/cF6zDvokOct3bmyu9GWnXwjRlKHHOUl
 ixnUj/2nwKGibhrVkgD0pPPsZBYzE0ZMG7BwRFkk25zY58R3OKTUC3uHwQg1ZdVfzWDVc+VnG
 UnxaS5w/mzBnb3WOrTDfqwGVby6NWPPAUn+iOMILsk+o90hrqFvs905hJiOjY70vKoW6INSNd
 bvLkNj7yPcAJS+knOUhw5ZsUY6ZWKuL8lr92XUF2zN5SbJoC0DAhDbyyT8NOg99MkZIGAWITc
 34k4uAzLJ/yzniI2tbJqv4uSmEVJJg00Qmywh45LRdo8ZfCuq3QpiAIhWIKqdSCNXUzG3AL3K
 8bJ0pajPV4R/fqSe8Fxmh4LiebbdRGKaiuKKrM+k+Islf0X3MbikSaUI2DRjDIDSH2n185gvW
 Tca3m60X1VjBksCbeomILtobFFJQkyzeDD3jTsR3d9CbuH9UoHAxcG//9yR3UbYuN79jvPZZY
 AoENkkQBKLX6NETftsTY1IzEmC9inLdtK7LkPxqffTrWB4PruV6LzY82hEfBATK5vY+IgW+G5
 PAv2vY+nfcCcGjtSJ2zomVZ0Vt5Ns7jCJH/akynIkoPrj6iXkSkWGXNgumtgq+MZnJYcAF2m9
 mbG01GzjSKA2HjrFwy9UnLK5pVHQes9N0yxqQJFcQnIadw4XpvtDe6OyvES22kr3nSXI7x+pi
 Ar7UTIiPjuzv1POmMsrLT75zYJOR2fYtrtRSQe/gq4tHIRRI3c5AY2vbzxiAunoGZyGBZmQmJ
 DL6a2Jhk1lxwyPLHMr9e5ijQGU+n0vGMGDvqDrpL1kHyH9uV8SuDFprDx1rAlyS8dO0Y5a1l+
 UHKQTXM7WmG50Dna2c1TNaP1UZMMNVOzyx9329a80775JetnwmE5sawaCYPBteN+a7PMBH4iI
 zNhjWJpho2K8bhgkjA0IGExXlWjWGlhq/h900ZIDW/szUNtIoYsFdt+eEnzw7iFSs/O9iwfCd
 3SuyfEqRj8vfmvS8We9yW3MmiXR15+VapfKTpsWqdjh0A/x8tzd1y8Tvzu1MUZo8aimlt7NWg
 FHyXaOEsY+RSfsIJVxDDhlsv3EZNd3CLbE91xrpZCGKN+Iopl9ic9cu8BJR7Vt27i+rx8+n1c
 35PBzPsi6N8vlDMYykkbJ6lYZAZqXO+U2OuA5ELHsWwspZf1ugwcueb2+VpnjC6wpav+j5zX4
 TmLdyj4amwa7OlxzSqh1+UHq/7q7DfFpWtocOTrCd8qPbrGnmlVgLLzfkXS/QUrUYqbuhVOZI
 xNHpx5CrzoGDs5JMonvv+/pIAhjr92VfTzzjBFdAGlUHu7Uke1N6QKuuDiMyLW/Go29qXGx9u
 WPa/YSKsT/nqTfljU=
Subject: Re: [cocci] Clarification for parsing capabilities?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3224
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/92304555-3aa7-4ef3-af2b-9f5d77a1b5fb%40web.de>

> In general, Coccinelle does not expand macros.

Are there any =E2=80=9Cspecial cases=E2=80=9D to reconsider?


>                                                 So you can match them
> with no problem.

Some data processing challenges were discussed.


>                   The problem here is tha there is no way to parse the
> code without expanding the macro.

I find this view debatable.

Several developers (and code reviewers) got trained for advanced pattern r=
ecognition,
didn't they?

Regards,
Markus

