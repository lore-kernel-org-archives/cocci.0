Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73194606A326
	for <cocci@archiver.kernel.org>; Sat,  7 Nov 2026 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=sXBSs0aX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=z9y+op9MwcAYKiVxV6x1Polc0TJVtfhV5fChD4LyxGU=;
  b=sXBSs0aXF4rMe+L+m7lg6QhObKbnp+pV3/8Ftk6i8xlLB8un1DEfLiqs
   v9GffNQR9/KIuQ7oawH/9fvX96rbejJnsQJaH5lnYyboH6PkBi2xhQ0si
   OOjaGJPb6wXBGu/EgVbGGZGNOOvJD99+hTgytMDZzRKXI1jaYSAGuWUOj
   I=;
X-CSE-ConnectionGUID: 0SdroIYpQ+ewWEnT/Llwhg==
X-CSE-MsgGUID: i3lIa1rnRiGZjtIVAEa6ow==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,200,1787004000"; 
   d="scan'208";a="304323650"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2026 11:59:28 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 2D55E8195F; Sat,  7 Nov 2026 11:59:29 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id F2354805C4
	for <cocci@sympa.inria.fr>; Thu,  5 Nov 2026 02:42:29 +0100 (CET)
X-CSE-ConnectionGUID: EaLBp8V5Qj2BjJuwMMJhvw==
X-CSE-MsgGUID: ug6x0mN6QJCglwH+XAoKOg==
IronPort-SDR: 6aebdf05_CAonSXRo8LX5BH5sZR5W1KvXk2QFwNCc3iNuWjnfq4QaynQ
 H7e6RG2xI6pu9VifOgI9NusfqAOIEvS//rW101g==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HvAADT3etqj3u8fblaglmBblOBbTIEC0mNUoZZgiQwh?=
 =?us-ascii?q?UqMc4lfgVWBfAIPAQMBCwEBUQQBAQECBIFKAYMzAo4dAh4HAQQwCQ4BAgQDA?=
 =?us-ascii?q?gMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEBAQEBOQVJhk8Nj?=
 =?us-ascii?q?BoBgSSBJgEBAQEBAQEBAQEBAR0CDX4BAQEDOgYBATcBDwsYLhAjAQUBHAYBE?=
 =?us-ascii?q?oMCgiMHSwMBA7IYi3CBNIEBggwBAQbeIAkVAYE3iF8BhXk7g0h6J4IogRWDK?=
 =?us-ascii?q?z6LCYMygXiVQVJ4eCwBVTUMgSUQMwMgCi8vFA0PARIPBBYFgS4MDCcSDx0oH?=
 =?us-ascii?q?nMGBRIgKkFCATArgRKBBwlUgSsoXQECH0YtFU4BAwKBIgIGgkuBI10CAUlBD?=
 =?us-ascii?q?gdFUwklQxJHJCIIEgkBExosCoEaNUUmPxVnCwsaBRpHCAILAgx0KBEQEx0eJ?=
 =?us-ascii?q?C8FHCZAGwqBAT03Bg8Zk2SGX5NNkj6hFAeEI6I+A4Nbk2IOkxCIC5B9I6h2A?=
 =?us-ascii?q?goHBxEkgUQ6gVxwgzdQAxkPjjuDaY89vn44ND0BAQcCBw4DC4FokDSBTAEB?=
IronPort-PHdr: A9a23:FnElQBC2s34mNxpCepNcUyQUhUwY04WdBeb1wqQuh78GSKm/5ZOqZ
 BWZua4yygeQFtyEsboE07OQ7/u+HzRaoN6oizMrTt9lb1c9k8IYnggtUoauKHbQC7rHSRJ/N
 +l5EGFfwnegLEJOE9z/bVCB6le77DoVBwmtfVEtfre9FYHdldm42P6v8JPPfQpImCC9YbRvJ
 xmqsAndrMYbjIVgJ6or1hfFv3REd/lUyG92OFmfmwrw6tqq8JNs/Slduugt+9JeXan/Yq81U
 aFWADM6Pm8648HmqQPNRhaV6HsGVWUWnBtIAwzb4xz/Q5z8rCj0uPdj1SeDJcH4Qqg6Vju74
 6p1RxHmlT8LODEl/m7ZjMxwl79brwm6pxNj2Y7UYZqaO+R4c6jAYN4VX2tBXsJWVyxcHoOxa
 pYEAuQdMepEqYT2ukADpgWiCwayGOzvyydIhn7o0q08z+QhChzN0Ag5E94TrHjYsND5OaEPW
 u630abI1y3OYf1W1znj9oXGbxMvof+DUr1sbMXey1IiFx/ZgliKtYDpIy+Z2voLvmOG7+RgT
 +Wvi2s/pgxvojiv28Esh5XPhokIyl/E6DhyzYEvKt2+UkJ6b8OkHYBMuC6AMYt2RcUiQ2B0t
 ykgzr0Ko4K0fC8PyJk+wRPUdvOIfZSS7B35SOaRPSl3hGhjeL+nhxi/7EatxvH+W8Sp3ltHr
 jZJn8fRunwQyhDf9MiJR/9880u/3TuC1gDd5OFFLEwqlafVK58szLA+m5cSrUnOACn7k1j1g
 q+Obkgo5+ul5uT9brn7uJORN5V4hhz9P6ktgMCzHPo0PwYWU2SF5eiwyKDv8EjiT7lWk/E6j
 6zUvI7GKcgHpaO0BgBY34kj5hmjCjqm3toVkHoJLF9AZR6KjpbmNl7LLf38D/qygFehnTJ3y
 P/dP7DtH5PAJWXZnrj7Z7Zy8UtcxRIzzd9B45JUDakMIOn2Wk/trNzUFwU5PBKww+n9CNRxz
 4IeWWSTAqCHKqPSt0WH5uY2L+WRfoMapCzyK/4i5/7ojH82hUUSfa2z0ZQLb3C4G+xqI0SfY
 XXyntcMCXoGswk+QeDwlVGOTz5ea2yvU68/5Tw3Ep+qAZnNS4y1hbyOxia7HplYZmBcDVCMF
 G/leJ+CW/sWZiOSP9RsnSAeWrinTI8h0xCuuxPgxLpjNObb5ioYtZf72Nhv++LTjQ0y9SBzD
 8mFz26NSH17kX8JRzItx6B+oUl9yk+Z3qRigvxYE8ZT5/JTXQsgO57c1fR2C9bpVQ3ZZNeGV
 E6mQsm6ATE2Vt893scCY0ljFNWljR7NxTKnDb4ImrCTHpw77Lzc0XvrKctl0HbG0bUhj0E/T
 stVK2KmgrRw9gjKC47IlUWZi7ildb4a3CHX8GeP1HeCsFtEXwFqV6XFWnYfZkrKotvj4kPOV
 aOhCbMiMgdZ1MGCKapKatjxgFteS/nsNsrQbX6tlmm2HRqH27aMY5Dwe2oBxCjTEFEKnRgc8
 3qeLgg+HimhrnrEAjFyCFzhflvg8fJmqHO1VkA0zx+Fb0lm17et4hAbnOSSRfxAlo4D7QIos
 TZpBx6FxdXcEMbI8w9oZqZBepUl+lBNzn7xrwtmIpGnaaxv0BpWfB56sEDu/xF2DJhQn883q
 n8j0At1L+SfylwFPzGZx5HrPrTdO0Hx8QqpZqqQ3UvRlJ6W86EU59w7pk/lsQXvEVAttz1m1
 8FSlXmV/IvLCgcUeZbwVFsnsRl8u7zeJCI64sec0GVhOLOvtTmH398vA/Ui4g25YtpVOuWPH
 Uu6H8AACsusL+ws3VOtZwgHFO9X/a8wecihcr/O+rOvPe8ouDu5hGBDqNRfz0aN/mxYQ/HB2
 5ItwveC3wLBWS2qyB+Hs8vwnYlfLQkbGmuvgXziBYVWYqRpO54CDWa+C8yyz9o4iYS7HzZ+/
 UKjDlVO88+gfxGfa1j6x0UE000LoXWhsSi11Tp5l3cutKXJmGTowu/lcBMcclVARGhvlx+4J
 5O/p9MXRk6la04ujhTzoQ7xwKNQpYx+KXPSSAFGZXvYNWZnB4Cwq7yrZYZw9dt8uCMRT/mUa
 lmcTbj8qBIelSjkGj0Nl3gAazi2t8ChzFRBg2WHISM29SKBESkR7RLW5diHAOVUwiJDXy5gz
 z/eGlm7OdCtu9SSjZbK9O6kBCq6TpMGVy7twMubsTejo3VwCEi2mbash/XsGA491y7w3t0sX
 iLN/17neoe+762hKqp8e1VwQlr16s50AIZ7x4I2wo4N8XMTgJKT/HEOlSH4NtAIkbnmYi8rQ
 jgGi8XQ/BCj2EBnKSeRwJnlU3yG3sZ7T8K/fntTwC855tEPCaGI4aZClC8w+xyzpATWZ/l2l
 zNbwvwrgJIDq8cOvgdljiCUA7RJWFJdITSpjBOQqda3sKRQYm+rN7m2zkt32967XvmEpUlHV
 XD1d41Hf2c459hjMF/KzHz46531MNjWY9UJsxSIkhDGx+FLIZM1n/AOiGJpI2X49XEizuc6i
 1Rp0/TY9MCOLSNy4YqyCxhfMDz+bsdV8TbozO5fksuQw4GzD8B5ADxYFJDsTP+uDHcTraG+Z
 1vISWdh7C7LSfyGR1TMjSUu52jCGJ2qKXyNcXwQzNE5AQKYOFQamwcMGjMzgp8+EAmugs3na
 kZwoD4LtTua4lNBzPxlMx7nXyLRvgCtP309Tt6AMTJd5wdF4UbeOMjY5eV2VXI9nNXpvEmWJ
 2qXah4dR2gPHFOZL1vqOL6o5NLJ966TAe/0fLPeJL6Jr+JZTfKBw5mih5Bn8zi7PcKKJnB+D
 vc/1yKvRFhBEt/C03UKQi0TzGfWatKD4Qy74mtxp9y+9/LiXETu45GOAv1cK4cn9xeziKaFf
 +me4UQxYT9ekIwR7XTBzr8Z3VUbj2dlcDzlHbkbtCHLRb7dgecOX0NdMnkucpIYv+RlhFIFM
 NWTkt7v079kkvM5bjUNHUfsnM2kf41CIm2wMk/GGFfeMb2HITPRxMSkKai4SLBWkKBVr0jp6
 WvdShW+eG3Tx3+wDUv8VIMExDuWNxFfpoynJxNkCGy4CcnjdgX+K9hvyzs/3bwzgHrOc28aK
 zl1NU1X/djypWtVhOtyH2tZ4z9rN+6BzmyQ6a/HN74duP1sBCV/nuYc63M/gegwjmkMVLlul
 S3eo8Q76Vig1PaS4jFuVh1Iqz1CgMSAukAoasC7vtFQHH3D+hwK92CZDR8H8sBkBtPYsKdV0
 tHTlaj3JWQK45fO8MAbHcSRNNOfPS9rL0/yADCNRlhgL3bjJSTFikdaiv3X6nCFss1wtM33g
 JRXAr5DCA5sRq5cUx44WoVScNEuBGtskKbH3pdYuDzn9kSXHZUK+MmdD5fwSb3uMGrL1OkZI
 UJSnPWhfdRVb9ehk016NgsjzNmMQhCNG4kd8ms4NFR8oV0RoiEuEytqgR+jM1P9piZJSZvW1
 lY3klcsOLRwsm62vhFudgqM/XFt2EgpxYe80W3XKWSsav7gDccIW2L1rxRja8OmBV8vMEvrz
 RwiamahJfoZjqM8Jzk71UmF48YJQK4MC/IcKB4ImaPON6huiA4B7Hz3lQkYvKPEEccwzVt3N
 8f28jQZi1IlM4RQR+SYJbIVnAEA2+TX5HLuj7BhhlBFb0cVrDHLKHNO4RZVcOB2d2zxobQk6
 BTeyWITJS5VDads+6I6sBpiYoHih2ql2rpHYChdLsS5KKWU8yjFnM+MGRYr018Q0lJC5f5w2
 NsidEydUwYuyqGQHlIHL5iKLwYddMdU+HXJGETG+ezQ3ZJ4OZm8HeH0XKePsqgTmEetAAcuG
 cwF8M0AGpCm1EyQI93gKfYJzhAk5QKjI1vgbrwBYBWQjDIOuN2y1rds2JVFYysQBWxsdCSx+
 rvNoAYuxaPFV94wZXEbVYIAcHkxXYzf+WYRvnhNCiW2zvNMyAWG6Gy0rSDRAT/gKtt7Ma7EO
 FU1UozwoGVvtfHs0g2ykN2WPWzxONV8t8Wa7Oobo83CEPZIVfxmtF+anYBERnusWmqJENivJ
 pG2ZZN/CL68Qnu8TFG7jCo4CsnrO9P4ZKGOxx71bY1dto6d3TsqMYm2ETRUSHIS76kToblxY
 wEOec9xeRnzqwE3LLCyOi+D18m2BnygLTJHCvhZ0eigYbVTinNqZea8z30hRZg+ieKw9AReI
 fNCxgGbzvGlaY5EVCH1EXEIYATDqx0ykG15P/ozyOMyqPstmVIVNTeNdedgbCpPuNRuXTt6z
 l19A2w/QV6XhI6F6Qmpjel6F8p1hNNIyahfvXz3r9reZi6hQqqirdCM9SEpa98goqZ4NcroJ
 c7U7Pvj
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:5/BYC6COeLThcbLlHelh55DYdb4zR+YMi2TDGXoBLyC9Vvbo6/
 xG/c5rqCMc7Qx6ZJhOo6HkBEDtewK5yXcx2/hvAV7AZnidhILLFvAb0WKK+VSJcECOlNK1l5
 0QCJSWY+eAdGSS4/yKhzWQIpIOxsKY+Lukieqb43BmVhFydq1shj0XNi+rVmNzACdJbKBZKH
 Ne3KR6TvibFUj/p/7adxo4Y9Q=
X-Talos-CUID: 9a23:GRDxxW6EE83Ry6RKmtss2UcwMNh1TCDkzi36IW2lFkNMar2LVgrF
X-Talos-MUID: 9a23:DueL/Aqh6QUlzE9u8vUezyxtatcw5oLwMWImnpEZm4q0HCtTHDjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,196,1787004000"; 
   d="scan'208";a="161790103"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFM2Q7SStYP++4U8kyj4+8Em6WcE5AeqgFoHw?=
 =?us-ascii?q?D5HddjLB6iA/UDRQOjTT2t67pz0G1KigjKB24g5WOmxhlLYSR9Uh0Gh4?=
 =?us-ascii?q?a1z5Zf6Jz6zBkSE8lZs0Hca0bS6l9gbe2cp/13G/4g7vFeWd1sILef0u?=
 =?us-ascii?q?sWNHedrd2Ph/0tESkrVVuBUQ=3D=3D?=
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 02:42:29 +0100
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7056E3F61E
	for <cocci@inria.fr>; Thu,  5 Nov 2026 01:42:28 +0000 (UTC)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36a6dfa7657so113453eec.3
        for <cocci@inria.fr>; Wed, 04 Nov 2026 17:42:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793842946; x=1794447746;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z9y+op9MwcAYKiVxV6x1Polc0TJVtfhV5fChD4LyxGU=;
        b=dKQuiGb6sNIrcLkW0wNu7zMPWzUBALIaCLOCqg0sB+Ww2l9VOmbPMSpnOoah/uS5Q/
         JcxuuHqN0XihYrVmvwvdDdjwCcuP2i8aumBcdupjzVfxxtJEhxEYbyrarzSjWVt2WdR/
         T/ugeJ0qF8PLSF1LWrEDnjJvYHzqdTYO6zPssJswRYQwrcWR80MHOxuyx+DH9bxlbl6A
         p3f/czhsXEjRnGFWfwBFvcwZ9isk6pymOp9UNzU3x0K2+Dv61ADiL2OP4RwpRKAipBjH
         QPVsbL2f4Vecopzx9FaG2luga6m+8AHZvPUrm9ZT0vtt+60GpdYcsO6iM02Od2KsWWAi
         pDCw==
X-Forwarded-Encrypted: i=1; AKwUvBz+2uCZ7EBV7duikiAZ5VmfPyTghsZ5V2dwIKUQD1/XdCv1xpTG8QRNE0j1ajsZTJg/44NzJA==@inria.fr
X-Gm-Message-State: APuU4Z89o+5E1hDaUk5n6eqIRuzIyxResVi5l85Xi8gP+sa7YBIJaWFF
	dKXkWLcIdK6LbuhQNVfBhmeiVoV1Ck1WXhkDA8Oa+xQlJ0zWXUrIUGbLyXM6t1kebXRAH9WIKN/
	H0jkt596OwGFEC0XrT20q1isltuVpzH1wgrwo3fRdzpPLd7H+ut1TUJekbmdHMr8=
X-Gm-Gg: AYBFou1l3y6OTGgtt5908bMsQBynDKfGZwUfasWpJCMZCYoL0CExwR64kPDu7RYrDet
	yBnjK4OfQ9LxcqhlEKMC7FIvFFUjw6vNa2hlMtWAW3YnD9LEoeefMRhSV7JuWg15NVC5UunnCfU
	g39FUMq2a0zqCDy/xgK23eaF7kmvXfQjmaQyeXyE4L0S4/yyVk5bFNq8oclzAdoLcRG1TfROZa3
	oqmmINzGlnlJnqHCIpjfqun5vVc+E9TMKAAhJqn9Y44nPBUr7DydVxHbKHaOqUhLk/c38UJpvJl
	+OH56hPFOAbqffDkrB4CCMkIA1fcYbz4g5dT623YEbep7aielJVgwPTk+Hmd3FAV2fpmeZoBLT5
	0tx4GeCrEOipxz+WLPx433shenb0vGaAmI8yAecsbu4rUen9GYz+hrLgcI/SskPj8MUeLXibfFF
	V/IuIBopmTChzIbFojogLNzTD968kHxVViBufaN/jDrMqiZvrzlrm45oZnT40hl9luqmUiS6iMb
	/9JP4aUkOKuD3z3EHpgsbHnLs/VWwVBCfIqfsTJTEelGwxtCWoF3TXKAG/5j03tZlOKFR8ZSpw=
X-Received: by 2002:a05:7022:7e0c:b0:165:be2f:c56e with SMTP id a92af1059eb24-1ac5b7dcb2bmr43089056c88.2.1793842946364;
        Wed, 04 Nov 2026 17:42:26 -0800 (PST)
X-Received: by 2002:a05:7022:7e0c:b0:165:be2f:c56e with SMTP id a92af1059eb24-1ac5b7dcb2bmr43088986c88.2.1793842945775;
        Wed, 04 Nov 2026 17:42:25 -0800 (PST)
Received: from localhost (2001-b011-2008-445c-f38f-16e4-9788-cb61.dynamic-ip6.hinet.net. [2001:b011:2008:445c:f38f:16e4:9788:cb61])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1bcedsm11629150c88.7.2026.11.04.17.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 17:42:25 -0800 (PST)
Date: Thu, 5 Nov 2026 09:42:23 +0800
From: ChunAn Wu <an.wu@canonical.com>
To: Markus Probst <markus.probst@posteo.de>, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com, mpearson-lenovo@squebb.ca,
	derekjohn.clark@gmail.com, Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, cocci@inria.fr
Cc: linux-serial@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Message-ID: <auve/wI4t7A+2G5W@an-XPS-15-9520>
References: <cover.1792856688.git.an.wu@canonical.com>
 <263a607c3602f31a3f6fdd245e3c2008cdf97abd.1792856688.git.an.wu@canonical.com>
 <75e6d86340073638d966acb85465c28e6a08ceda.camel@posteo.de>
 <20261027214742.3624605-1-an.wu@canonical.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027214742.3624605-1-an.wu@canonical.com>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v6 1/3] serdev: handle devices without an ACPI
 or device tree node
Reply-To: ChunAn Wu <an.wu@canonical.com>
X-Loop: cocci@inria.fr
X-Sequence: 3780
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/BK8xgeXFELwDWwoksU4Kbg>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 05:47:42AM +0800, ChunAn Wu wrote:
> On Mon, 2026-10-26 at 13:59 +0000, Markus Probst wrote:
> > Reviewed-by: Markus Probst <markus.probst@posteo.de>
> >
> > You should add the maintainers for the modpost scripts to To/Cc.
> >
> > $ ./scripts/get_maintainer.pl scripts/coccinelle/misc/of_table.cocci
> > scripts/mod/file2alias.c scripts/mod/devicetable-offsets.c
> > include/linux/mod_devicetable.h
> 
> Hi Markus,
> 
> Thank you for the reminder. Adding the Coccinelle and modpost
> maintainers to Cc now.
> 
> BR
>     An
gentle ping
