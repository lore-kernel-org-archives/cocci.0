Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924A1D1CDC6
	for <cocci@archiver.kernel.org>; Tue,  9 Dec 2025 10:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=uBrRE6wQOEUJLD5Bz4jV8KRzUJYrrFI4wUp8vXmllsA=;
  b=IlLKyeHybtatOWJSHLi6jAxopJ5ou/GBaRrwONPZVuz3k4zg2/RcVxhz
   8XiF+HGYG+OEbW7YlffCKaHioE694K7JBiZEgFDcOC1pBkJbH4h8nrwn7
   99QwKmlUZNONJDWANeOg+Gwm9WJRkqRryQCAgjhTfzSRdO3psX/b3/xxH
   s=;
X-CSE-ConnectionGUID: GYjevRz9RimrHGEDiygv1g==
X-CSE-MsgGUID: h47+tCd1TM6Ihs6UFEf/zA==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@grsecurity.net
X-IronPort-AV: E=Sophos;i="6.20,261,1758578400"; 
   d="scan'208";a="253494816"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Dec 2025 11:09:40 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0354DE0AF1; Tue,  9 Dec 2025 11:09:40 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D0833E0157
	for <cocci@sympa.inria.fr>; Tue,  2 Dec 2025 15:12:41 +0100 (CET)
X-CSE-ConnectionGUID: k+PmO1SFRhqHmslVFkSz3g==
X-CSE-MsgGUID: znz9KbA7QwGyGUZNU5w5Ng==
IronPort-SDR: 692ef3d8_JYnQOmxSMZzK50yAFaTPzptUFyoDgSiNrCAqglxlQYxDbFn
 oTDFms9k52yDpHJB777KEt9fqMFz9HXKR/eEsMA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HhMQCq8i5pfLGgVdFaHAEBATwBAQQEAQECAQEHAQEVg?=
 =?us-ascii?q?VACgWxSgWQwBFQDhFKPU1oBAQEGhXyHOZQjEQEDAQwBFBMoAgQBAQMBA5FoA?=
 =?us-ascii?q?h4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBI?=
 =?us-ascii?q?hkHDhIphk8Ngls7ghYsD4EUER0BATg0AiYCNQEFATcBAR6CYIIjAQZKAwGjc?=
 =?us-ascii?q?oEFQos+gTKBAYIMAQEGgmnZPoFkCQkBCoEJLgGIUgGGCYUEG32BEIE8glMBh?=
 =?us-ascii?q?X2DDoJpgiaBDoYigm+QQoFKHANZLAFVExcLBwWBYwOBC24yHYEjPhhzgRSDS?=
 =?us-ascii?q?R5nDwaBEYNPiRcPiAGCUAIBC209NwkLGwY9lQxPgT4vPIQ4pD6heYQmBaFXB?=
 =?us-ascii?q?hMvl1IOkwuZBqkWAgoHBxEkgVokLoEuMxoIJgqDIk8DGQ+OLRaINr9adw4uA?=
 =?us-ascii?q?gcLAQEDCYVpjDWBSwEB?=
IronPort-PHdr: A9a23:mFsKbR0G1sXZWrYGsmDOqQ0yDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BeDo601xwSQFcWDsrQY0LGQ6/uhEUU7or+/81k6OKRWUBEEjchE1ycBO+WiTWDdErvBQhd+I
 v5/UkR49WqwK0lfFZW2TVTTpnqv8WxaQU2nZkJ6KevvB4Hdkdm82fys9J3PeQVIgye2ba9vI
 BmsogjcuMYbjZF+JqotxRfErGZEcPlSyW90OF6fhRnx68m+8ZJ57yhdtfct/NNcXKvneKg1U
 bNXADM6Pm4v+cblrwPDTQyB5nsdVmUZjB9FCBXb4R/5Q5n8rDL0uvJy1ieCMsL6VK45Vzu/4
 atzRxDmlCkINzgi8GHKkcNwl75UoAigpxNk3YHZZpyeOedkcaPcedMaQndBXtpUWidcDI6wc
 5cDAuwcNutesoLzpUYBrQGmCAevCu3gxTFHiH/r06Mkz+svHhrL3BAiEt8UrHjYsMv5OaUUX
 OuozKfI1zLDb/ZO1Dn68ofIbhAhofCWUrJrbMHfzFMvGBnYjlWLt4PuIjSY1uEMs2id7upgT
 eavi288pgF+uDiv3dkjhZXUhoIPy1DE6SV4zJwzJdKmVE52eNipG4ZfuC+GLYV5WN8iQ312t
 yYgzL0LoYO2cTYJxZg7yRDSZOKLf5SI7B//VOufLzd1iXx4dby/iRu/8FStx+78W8S2zFtGs
 zdIn8fPu34DyRHd5cmKRPR780y82jiPzxje5v9YLU0wj6bWKJ4szqQtmpcSrUjPBDL6lUf0g
 aOOaEko5vSk5urib7XovJCRMpV7ig/gPqkqn8GwGvk0PhQSU2We5+ux16bs8VP8TbhIk/I5i
 afZvZXBKsgGu6K0Bg5Y34Yt6xmjCTqtzc4WkmMdLF1ffRKKl4jpNE/KIPD/Ffq/hk6jkDZvx
 /zfJ73hHojBImHNkLv8f7tw6VRQyAU0zdBY6JJUDq8OLOjvVU/2sdzUFh45MwqqzOb7ENhxy
 J8SVGaVDqKaMK7eq0KE6+MzL+WWeYMYujTwJ+Ag5/H0jH85nVEdfbOu3ZsScH24G+5pI1mZY
 XrtmNgBCn0GvgkkTOPwlV2CSiBcam21X6Ik+D47DpmmDZ3fSYC2nrOOwD23EYFRZmBDElyMC
 2vnd52YW/cQbyKfOtNukjsYWre9So8szgqutQ//y7p/NOXY4CwYtZT51Nh0/eLfjx8y9SZsA
 8SbyG6CV3t0kX8QRz8qwKB/plRwxkqb3ah3nfNYEt9d6elRXwg0KJDQ1/Z6BM7sWgzCZNmEU
 FOmTc+nATE1V94x2sMOb1tkF9WskxzO3SinD6Ual7yMA5w0/abc0GbrK8lhzHbG0bEtgEQlQ
 stOMG2rnrZx+QfdCIDXj0uUi6CkebwB0y7I7miD13aBsVlAXgBpSavLUmgTZlDOrdT3/k7MV
 aOjB6k6PAdZ0s6CMqVKZcXpjVpYQPfjP8zTbXqolWmoChjbjo+LOYHtcG4c9CTbEkkN1Q4Jr
 licMg1rIy69o2PXF3RND1vyeE6kpex/rnKjSk4cwBuRYkZ8zbup61gTiODKGKBb5a4NpCp08
 2Y8J126xd+DU7JoxiJkdaRYOpYm5UtfkHner0p7N4ChKKZrghgfdR52tgXgzUY/EZ1OxO4tq
 n5i1w9uMeSAyloUcjKe3Ij0O5XYMHL/9w21arLHnFfTzIXe4b8BvcwxsE6rpwS1Dgwn+nRj3
 cNS1i6Z74nKDQMJF5HrW1ss+jB9v7zceTM2/I7fk3ZrNPr8qSfMjvQuAuZt0RO8Z5FfPaeDQ
 Rf1CNEfDtOyJfYCnlGoalcdILkX+vdrYIWpcPyJ3KPtN+Fl9N6/pUJA5o01kkeF9i4nD/XNw
 45A2PaAmA2OSzb7il6l9MHxg4FNIz8ITCK5zmD/CYhda7cXH85DAHqyI8Cx2tR1hoL8E39e+
 lm5Aloa2civMROMZl351AdU2AwZu3ui0Se/yjV1lXkuoM/9lGTLwuLjbB4GEmFRX2RpkE3tP
 Znyid0GHQCpYwUviBq59BPi3aEIwcY3Z2LXQEpOY233NzQ4Cvr25ufEOpAXrsp37nYyMqz0e
 12RR7/jrgFP1iriGzAb3zUnb3SxvY2/mRVmiWWbJXI1rXzDeMg2yw2Mgb6UDfNXwDcCQzF1z
 DfNAV3pddyg4dWVnoyFsfq3SnmsfppLfC/w14ibuSD97mpvS07a/bj7ipj8HA423DWundxrU
 yTQqBfUbZPw2q+nK+N7bw9uCUO2uK8YUslu14A3gp8Xw30TgJ6YqGEGnWnEOtJewavibXAJS
 Fbn2vbt6RP+kA1mJ3ONnMfiU2mFh9Bmf5+8a38X3SQ064ZLDr2V5fpKh3k9rl29pAPXKf9z+
 1VVgf4n9H4bivpPuxAk0z6QKrcKEE9DJyf3mh/O5Ne75Klaf2egd7Gs2VE2x4jwSuHf5FgCA
 DCgJchqFDQVjI03KF/W1Xzv9ozoMMLda94erFzckhvNifRUNINkk/MLgSR9Pmeu2B9tg+U/j
 BFowdS7pN3dczQrrP//W0AAcGSqOJB2mHmll6tVk8eI0pr6G5xgHm5OR570VbezFypUs/37N
 gGIGTl6q3GBGLOZExXMjSUu53/JDZ2vMGmaYXcDytA3DhyUOExeiRtSXy8zg4U0Pgeyycr6a
 kxi6ztX7Vn94EgpqKogJ1zkX2HTqR39IDI9VJieJQEQ7RtL+lzYGcuG4+RoBSpD85bnpwuIY
 D/+BUwAHSQCXUqKAErmN7+l6Izb8uSWMeG5KuPHfbSEreENH+fN35+k1ZFquiqdLsjadGc3F
 OU1gwAQOBIxU9ScgTgETDYb0j7Af9LO7gnp4TV594i+6Ki5B16pvNHSTeMUaZI2pVi3mfvRb
 rHLwn8odXAAkMtLnCCtqvBX3UZO2Xs2Jn/9TPJZ736LFOWJxedWF0JJMXotcpYYqftthE8Vf
 peKwtLtiuwi16BzUQwUEwe73JnuPJ1vQSn1IlrDAAzj2K2uAzrNzom3ZKq9TeYVl+BIr1irv
 i7dFUb/PzOFnj2vVha1MOgKgjvJdBpZ8JqwdBpgEw2BBJrvdwG7PdlrjDY33ax8h3XEMnQZO
 CR9dEUFp6OZ7CdRiPFyU2Jb6X8tIe6Bkiefp+7WT/Re+eNsGThxnvlG7W4SzrJU6GRdWKUwl
 nKN8ZhhpFapluTJwT1iEVJPpjtNmIOXrBBiNKHepfwiET7P+BMA63nVCgxf/YM0TI2y/fkOk
 p6Wy/2gTVUKu8jZ9sYdGcXOfceOMX56dAHsBCaRFwwdCziiKWDYgUVZ1vCU7Hyc6JYg+f2O0
 NIDTKFWUFstG7YUEENgSZYHKYt3Xzo/172BhdMT6FK5tBTXX99RpZ3MEPmVBL+8TVTRxakBf
 BYOzb7ieM4LMZbn3kV5dlRgtIHDGk6VRMwU5yM4MVByr0JK/3xzCGY03gi2D2HlqG9WHvmyk
 BksjwJ4aul47zbg7WA8IV/SrTcxmk088T0AqT+LazP6Mb2xQZAQDSfo5RBZ2nLTRg90aUirg
 RUhOm6bGPReiLxvcW0tgwjZ68Mn8RF0SrVJZgQKzuqabLMj1lEO802a
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:SZLUPKxLXweN1g1BtQeDKrPw/71zdoMgy1knxilNYDRIb8qTjN
 C2gZ0gpGTJYUUqKRcdcLe7SdW9qBLnhONICOwqV4tKMzOW3VdAQLsSlLcKoAeQfxEWlNQtt5
 uIGpIWYLaAbmSS5fyb3ODSKadZ/DDoytHTuQ6T9QYLcShaL49lqyl2Yzz1LqS0fmV77FgCea
 Z0KvAom9NoQxUqUvg=
X-Talos-CUID: 9a23:iJ76Km+5JzsZDMMe9cGVv01XIsUCK0bz9nfJA0qjDVhHS4aHElDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AW4kyzgwfWrDYRUYL82nj7hjJSjaaqLaoGhEum7x?=
 =?us-ascii?q?ZgtarJANNCRGg0SvqZIByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,243,1758578400"; 
   d="scan'208";a="132554894"
X-MGA-submission: =?us-ascii?q?MDGG5kWRQ5WAlcKjC8LOGQUr+cEpg+Bl1Z0tUB?=
 =?us-ascii?q?jIDm7SRix3Z7e6iBlpDwL7M/qsZ/NgAIZyDQnPE6XO3gDB7LV+C36P51?=
 =?us-ascii?q?grBKTouW/R57YSdWwErnU1MhTYiADApclXkXXcQfw1o2r+zKRtqm66jN?=
 =?us-ascii?q?wWzi2LVWQIaUIclKOeju81xA=3D=3D?=
Received: from mail-qt1-f177.google.com ([209.85.160.177])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 15:12:40 +0100
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ee2014c228so42112261cf.2
        for <cocci@inria.fr>; Tue, 02 Dec 2025 06:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1764684758; x=1765289558; darn=inria.fr;
        h=content-transfer-encoding:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBrRE6wQOEUJLD5Bz4jV8KRzUJYrrFI4wUp8vXmllsA=;
        b=BhEmLxEH4icjMj7tzXjteHuk4iw6uXsO4zgaTi011CYRImB3bv9ALOsF5C/EjA7tzc
         meILBq/+aTbhWavwrCoT4lPpiDQNwOP8e+mIkZhPO8heWx/YzxS2iM4LhLn08aLxiGzf
         WUTgeqxh91xiqrSUzDfdc1P+ZPdEgaWLmokcHT7SK9cQ4dEeKuoaEAfXeI9u/UIVGOBC
         56inRoo+SxvRi+fG5G6WvqgxVq0WNdn5X8hvwE1dU/qXeEQtLo9s/XyFWrPBqc6mZRBO
         8EdpF1es0JCC66pcLwigv18rq079M+LKzP+4cWGk+XvwYF3C1Z0I+CgcbU4AgGy0/ExH
         s5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764684758; x=1765289558;
        h=content-transfer-encoding:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBrRE6wQOEUJLD5Bz4jV8KRzUJYrrFI4wUp8vXmllsA=;
        b=fahBM6IM2PQonk8g/vuXw1PtAxXZS/q4SWFpZpeaY/MRiladI7xKiFzS/gswjXGDOH
         mcgEL6RiZamiTvlzFtrBJYL16mz89e7zyur/Zkp5q/gCalcdDaoUp2dTGRHCVggtgqRG
         xzvR5NMnP6L15/2QMk5S8se8VTZcWZpHaxugU7XPmaPtZ+Njpu0cjjLBSRoKbDT4nEUm
         7o22lMwf8Z24U6qwZ9+NM1RcgVA9DUgFM8XpHg2rxhpVyQ2vJLk9BmNQX0l0NLWMuxcV
         YzTtVXg6ZRAOaC34mhdAbigzg5l8Tpk47XNu4rvomCcfruV/0Tjq7M23CsQbK8NQiP7T
         cYKQ==
X-Gm-Message-State: AOJu0YxK3oWSgdiNFF1eIZAJjeb4VzQ4XrdteqKsqDcnx9AmRXyo2Qj4
	HdgL6mzahZLOZuMe9nujKC0v/smcDJve7tjdlOch7ol0n0So8wKhkLl2Cgg3TCVkIvgM/VUEirY
	xJ0NI
X-Gm-Gg: ASbGncuIw3/QBkVDGUVqgx5RB6pUX0D2povcU32EznE2vA3z6VmLkcWTx+oMlv4STu3
	JNaH8blWmrQsxm3J8vimM9ANdHX9b3U3d65Xt/j/AtabddFZTYPn663ug7fXuQiTUFugRZOvJzE
	tWCvY1pGtW676W1Ltyu6Gz1afFfVlW9P+MTUjb4kXRuRz3B4fnm5Tos1i//Cs4vLxZhKw3TLWA+
	QCTyCxDtw8J+/nvsZOyh1EGn27qsrWmpfpDFJZBnNBXq4syGLjKk1MfjT6lF5g/PrFQKHDwc0Zv
	1GGdg9/3JJ11P6v6zVxgbd10SBIcwCVH5Ud8RbVThvIIXudGqJ51k45u4KC2+FPgOXkdWr+CmjI
	y9IJ+ihs15l0xsurmhGhOBnMizg5GdS3v2PPoZoW6ERYayOKSeaaQbb26A8qgT+PkAllDa+s8we
	X6X2YJ8i2fUoveA4imqpPR90K+WB519n8T6ivpSWOhCsia2a+CeAWyP91M1CLvQenxQFrnthiAJ
	Gokc8njpe7iLvBZQrQ5X4FwBV8CjJYF6szP/dSFwjBvPNno/yAd0nVn
X-Google-Smtp-Source: AGHT+IHl+Dm6fjQGoFEar+AyGTRUSoTFZ/JkM8vwXxbOMwJhpxA12DTB/Sva0gqYeibAjPqFVsesxw==
X-Received: by 2002:ac8:570e:0:b0:4ee:146f:2503 with SMTP id d75a77b69052e-4efbd90da52mr446914391cf.3.1764684758494;
        Tue, 02 Dec 2025 06:12:38 -0800 (PST)
Received: from ?IPV6:2003:fa:af29:b100:e8b2:7dbf:b11:65fc? (p200300faaf29b100e8b27dbf0b1165fc.dip0.t-ipconnect.de. [2003:fa:af29:b100:e8b2:7dbf:b11:65fc])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4efd2f9a755sm94901851cf.3.2025.12.02.06.12.37
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 06:12:37 -0800 (PST)
Message-ID: <ccea6cbd-8c39-425d-93ca-0685c8154619@grsecurity.net>
Date: Tue, 2 Dec 2025 15:12:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 xsDNBF4u6F8BDAC1kCIyATzlCiDBMrbHoxLywJSUJT9pTbH9MIQIUW8K1m2Ney7a0MTKWQXp
 64/YTQNzekOmta1eZFQ3jqv+iSzfPR/xrDrOKSPrw710nVLC8WL993DrCfG9tm4z3faBPHjp
 zfXBIOuVxObXqhFGvH12vUAAgbPvCp9wwynS1QD6RNUNjnnAxh3SNMxLJbMofyyq5bWK/FVX
 897HLrg9bs12d9b48DkzAQYxcRUNfL9VZlKq1fRbMY9jAhXTV6lcgKxGEJAVqXqOxN8DgZdU
 aj7sMH8GKf3zqYLDvndTDgqqmQe/RF/hAYO+pg7yY1UXpXRlVWcWP7swp8OnfwcJ+PiuNc7E
 gyK2QEY3z5luqFfyQ7308bsawvQcFjiwg+0aPgWawJ422WG8bILV5ylC8y6xqYUeSKv/KTM1
 4zq2vq3Wow63Cd/qyWo6S4IVaEdfdGKVkUFn6FihJD/GxnDJkYJThwBYJpFAqJLj7FtDEiFz
 LXAkv0VBedKwHeBaOAVH6QEAEQEAAc0nTWF0aGlhcyBLcmF1c2UgPG1pbmlwbGlAZ3JzZWN1
 cml0eS5uZXQ+wsERBBMBCgA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEd7J359B9
 wKgGsB94J4hPxYYBGYYFAmBbH/cCGQEACgkQJ4hPxYYBGYaX/gv/WYhaehD88XjpEO+yC6x7
 bNWQbk7ea+m82fU2x/x6A9L4DN/BXIxqlONzk3ehvW3wt1hcHeF43q1M/z6IthtxSRi059RO
 SarzX3xfXC1pc5YMgCozgE0VRkxH4KXcijLyFFjanXe0HzlnmpIJB6zTT2jgI70q0FvbRpgc
 rs3VKSFb+yud17KSSN/ir1W2LZPK6er6actK03L92A+jaw+F8fJ9kJZfhWDbXNtEE0+94bMa
 cdDWTaZfy6XJviO3ymVe3vBnSDakVE0HwLyIKvfAEok+YzuSYm1Nbd2T0UxgSUZHYlrUUH0y
 tVxjEFyA+iJRSdm0rbAvzpwau5FOgxRQDa9GXH6ie6/ke2EuZc3STNS6EBciJm1qJ7xb2DTf
 SNyOiWdvop+eQZoznJJte931pxkRaGwV+JXDM10jGTfyV7KT9751xdn6b6QjQANTgNnGP3qs
 TO5oU3KukRHgDcivzp6CWb0X/WtKy0Y/54bTJvI0e5KsAz/0iwH19IB0vpYLzsDNBF4u6F8B
 DADwcu4TPgD5aRHLuyGtNUdhP9fqhXxUBA7MMeQIY1kLYshkleBpuOpgTO/ikkQiFdg13yIv
 q69q/feicsjaveIEe7hUI9lbWcB9HKgVXW3SCLXBMjhCGCNLsWQsw26gRxDy62UXRCTCT3iR
 qHP82dxPdNwXuOFG7IzoGBMm3vZbBeKn0pYYWz2MbTeyRHn+ZubNHqM0cv5gh0FWsQxrg1ss
 pnhcd+qgoynfuWAhrPD2YtNB7s1Vyfk3OzmL7DkSDI4+SzS56cnl9Q4mmnsVh9eyae74pv5w
 kJXy3grazD1lLp+Fq60Iilc09FtWKOg/2JlGD6ZreSnECLrawMPTnHQZEIBHx/VLsoyCFMmO
 5P6gU0a9sQWG3F2MLwjnQ5yDPS4IRvLB0aCu+zRfx6mz1zYbcVToVxQqWsz2HTqlP2ZE5cdy
 BGrQZUkKkNH7oQYXAQyZh42WJo6UFesaRAPc3KCOCFAsDXz19cc9l6uvHnSo/OAazf/RKtTE
 0xGB6mQN34UAEQEAAcLA9gQYAQoAIAIbDBYhBHeyd+fQfcCoBrAfeCeIT8WGARmGBQJeORkW
 AAoJECeIT8WGARmGXtgL/jM4NXaPxaIptPG6XnVWxhAocjk4GyoUx14nhqxHmFi84DmHUpMz
 8P0AEACQ8eJb3MwfkGIiauoBLGMX2NroXcBQTi8gwT/4u4Gsmtv6P27Isn0hrY7hu7AfgvnK
 owfBV796EQo4i26ZgfSPng6w7hzCR+6V2ypdzdW8xXZlvA1D+gLHr1VGFA/ZCXvVcN1lQvIo
 S9yXo17bgy+/Xxi2YZGXf9AZ9C+g/EvPgmKrUPuKi7ATNqloBaN7S2UBJH6nhv618bsPgPqR
 SV11brVF8s5yMiG67WsogYl/gC2XCj5qDVjQhs1uGgSc9LLVdiKHaTMuft5gSR9hS5sMb/cL
 zz3lozuC5nsm1nIbY62mR25Kikx7N6uL7TAZQWazURzVRe1xq2MqcF+18JTDdjzn53PEbg7L
 VeNDGqQ5lJk+rATW2VAy8zasP2/aqCPmSjlCogC6vgCot9mj+lmMkRUxspxCHDEms13K41tH
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
To: cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] Matching function pointer casts
Reply-To: Mathias Krause <minipli@grsecurity.net>
X-Loop: cocci@inria.fr
X-Sequence: 3249
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/ccea6cbd-8c39-425d-93ca-0685c8154619%40grsecurity.net>

Hi,

I have a hard time trying to come up with a semantic patch that would
match function pointer casts, specifically (void (*)(void)) in my case.

I want to get rid of these and replace them with a properly typed
functions that'd do necessary type conversions. (I already have that
part, though.)

Below are two attempts I tried and did not work;

1.
@pfunc_cast@
identifier fn;
fresh identifier fnthunk = "THUNK_" ## fn;
@@
- (void (*)(void)) &fn
+ &fnthunk

Above doesn't parse for me (spatch version 1.1.0).

2.
@pfunc_cast@
identifier fn;
fresh identifier fnthunk = "THUNK_" ## fn;
type T =~ "^void (*)(void)$";
@@
- (T) &fn
+ &fnthunk

as well as 3.
@pfunc_cast@
identifier fn;
fresh identifier fnthunk = "THUNK_" ## fn;
type T =~ "void \\(*\\)\\(void\\)";
@@
- (T) &fn
+ &fnthunk


This basically matches all address taking expressions, even without
casts, and replaces them by &THUNK_... -- not quite what I want. ;)
It looks like to completely ignoring the regular expression for the type
match beside complaining about syntax errors when one does some?

Is there a way to match function pointer casts in spatch at all?

Thanks,
Mathias
