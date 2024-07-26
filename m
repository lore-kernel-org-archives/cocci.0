Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C0AC3DA70
	for <cocci@archiver.kernel.org>; Fri, 26 Jul 2024 13:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=TcgWeCpmg3fgHZWMcFDda4wrJ+NgQ3D+zH1z0B7RhAM=;
  b=LsID73q9uNEWlyRCPPABsr+KVklB8eRzGqVFzE4/c+pHTqcW4cTZ7sZu
   p+QYbiqVmHV4vRiCsDCN0eu3BMJpwGge9djxOK4Y9TaBq7ohTxtUXLeec
   LayDAm38E6k/pj8oRB/GbBGIdTf7oMX930pWGxkBsTaz8kYK6e5Vz8Ubf
   w=;
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
X-IronPort-AV: E=Sophos;i="6.09,238,1716242400"; 
   d="scan'208";a="177110018"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Jul 2024 15:35:09 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 413BEE0141; Fri, 26 Jul 2024 15:35:09 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6508DE0035
	for <cocci@sympa.inria.fr>; Fri, 26 Jul 2024 15:35:04 +0200 (CEST)
IronPort-SDR: 66a3a607_3/TZPIAW97bYzeUbWdR+3AufdAtxwRtDYwtPoZuovfJKkl4
 WPUxPZHY8C1YRMzmcQKfcJCBSpfb0XMAdLLz+hw==
X-IPAS-Result: =?us-ascii?q?A0FTAAD3pKNmhwwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYJDYhoGVDMEC0iEVogdhy6CJYQ7jwuIdYFWgUA+DwEDAQ05CAECB?=
 =?us-ascii?q?AEBAwSEdQEJAok6Ah4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAEBAToHDjuFdQ2CZwEQgRKBJgEBAQEBAQEBAQEBAQEBAQEBARcCD?=
 =?us-ascii?q?TpEAQEBAgEjHQEBESYBDwsaAiYCAlYGARQBAYJ8AYIvAQMOIwcNrSGBMhNug?=
 =?us-ascii?q?gwBAQbaWR8sIleBYwMGgRouAYg8AYYMg016Jw+BVUSBPIJSMT6CYQQBhTiCa?=
 =?us-ascii?q?YxLhHJpBAUViCwDg00mjU5UexwDWSETAVUTFwsJAgUQiWAKgyUpgUkmhBsIg?=
 =?us-ascii?q?S0Vg2SBawxhh3ZigQ+BPoFfAUmCd0uDaByBZWwdQAIBC209NQkLGwY9oiaFE?=
 =?us-ascii?q?CFQghjFOTQHgjaBYoFjDIollSoGEy+DcgESjQCGNw4Gkm4emE8ijVibF4FnO?=
 =?us-ascii?q?oFcMxokgzZPAxkPjiEZg2EzzBVBNTsCBwEKAQEDCYVGAQGDWoFKAQE?=
IronPort-PHdr: A9a23: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
 twCR+0CPLTQPuwXAAJpEY5aSKo=
IronPort-Data: A9a23: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
 VUIeA==
IronPort-HdrOrdr: A9a23:KhqLl6nLpzrbL/c68Oci9TzvDlnpDfL43DAbv31ZSRFFG/FwWf
 re/sjzpiWE7Ar5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6PoSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: =?us-ascii?q?9a23=3AKMIp32jI+fPybwAtBWhlK1lXVDJuQ2OC1EyAKEi?=
 =?us-ascii?q?CO2NldueRTliIyaJAjJ87?=
X-Talos-MUID: 9a23:XwiIogZSOqK6LuBT9Dnnwz84KcVT0p+ILlEno7o9qtOPKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,238,1716242400"; 
   d="scan'208";a="93028889"
X-MGA-submission: =?us-ascii?q?MDFyoUcRADJmC7FFJdVLNW8UpwGRam74TEAHQP?=
 =?us-ascii?q?t0VA/nWKpszfIzMaq9ql0Vr6vrdwDmZS9sC+6GUO4fQz290h0jQX71DN?=
 =?us-ascii?q?1Jb2Lq650TmY7h4btdJJgJWyaCgY087DMe3BfkNqhpbZ6k46oCACGpFw?=
 =?us-ascii?q?It+L2YQ0bnjoJ7iY92TSLysQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 15:35:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722000897; x=1722605697; i=markus.elfring@web.de;
	bh=TcgWeCpmg3fgHZWMcFDda4wrJ+NgQ3D+zH1z0B7RhAM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JtUD1X3ewLHOMKgEw0TzBntYFky1Qp4joVqAN2l6acIurlOixIpn34s/F+jo3Ufs
	 cnF2G1XOH/rtvc7qLhubW0BHaXOHyYPpcEl+DnkoMvhqSN+LmI8UAzNo1hPV4RCZ2
	 sj9hWpkDIG7YEmDgnDjT4CIGjHXkloNsqMaNzNrszQwheRUV4+zfFksXJatGVh4Sf
	 UXhBFQ6mIe3VMeG9VPjM5Ks5drDMtp5xWyNNk/Itcz5XTfUyn0b2M/A/a+0s2bLXP
	 n5re9bKpeguq4HLJ03ttHAJS0vdXh4WzFPo8JovIaxXcR/pLO6++V94amVmRnpVXp
	 tQtHZLdqYc5nHo9+2w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZjET-1skrO23RLD-00XIO7; Fri, 26
 Jul 2024 15:34:57 +0200
Message-ID: <f7cb87e7-3a17-44b7-87a1-8fec22e649ea@web.de>
Date: Fri, 26 Jul 2024 15:34:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Chen Ni <nichen@iscas.ac.cn>
References: <959b8771-76a1-4cee-a7b1-2b391deb23cc@web.de>
 <1584412e-94b-4c10-6f96-9da68f4ed1d@inria.fr>
 <d3f11294-5751-442e-b7d4-616c3bd217b9@web.de>
 <bea5cf4d-0e4-d141-1365-4d5f76bcf513@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <bea5cf4d-0e4-d141-1365-4d5f76bcf513@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k3BBlz93nAIk6FHPbyfP4y5cWOPsHl/7BJTpUIpFlX+MGJYYjiR
 B8lCD+T4rPiUao/h+3pCE3+IHz8bt6YuV5MWKuSpnszN+MzruIasbGvJZhDEgY/J2St1nfQ
 PllY1srVcSAZsg3PhnBBFHil8K0w4tzSFp1uzUYZFWa92FH3mIhFqeC5Rj2IMSDL9LIIEYC
 QumkBixgb4vZOC7neUKow==
UI-OutboundReport: notjunk:1;M01:P0:TtVmWNETSNA=;IV6KWj0FcKFUMRz/qJO63JpvUNf
 NYAQDtf2L+ZCDMismqyJupw8Y0ev3xgH03GckDPDXDuhsNL0SZ6agxw0mHQslCA9L40RQhL2q
 LHNSnJWLYn73B6sfjf+WIj9zDAmbYhBZ9gPPI6E60MIL1Bf+q1phL+hG+3kTTw7xOH75wUWnN
 QJPxQv21+QBtalAoPBJnmYfzoPlFEfCTLKyUcasXcA/eaUvb9UOuPEm3+Xke+i3BadOrCiZyF
 t1OOv+h+DWr4Dpib4yvjeBOrhlNQBF4gpvKrMg/6LFfdZxdftuFL9GblY9GDBC5bSRpRcvG5p
 6JCJd51fvYZEPGhOvjnZKr0dPOoKNK9wdvKXLIejrhfvsglwifknh0thd9EZIsvA3kcmJlTfw
 hMKM1ZL/gpWtPNU4POOXkjxbM22c5FalNJ3ng1prB0lxlTx7Ed0Tk7PIV44OD2RwSy3NUwhLV
 um4+aW9wGxaKyP78a9KFZjXk9Fwa1HS5zJI1UnX/qfqei54XBer2FtR8OVEuN+TfJvfbmgXh5
 BOGM8eQJxAbsWTNVTUeAZsf8pJtUkc0UGiT+ZeYekJUQnSWJgGhCharNVHUchN/11eNh/i6+A
 jCa5WsT8ScThw4PqOqw28Be7r6rQEcXEEdlDIMoFxD7a0cNLpefVvNfsjsXApG9tIYyeEj0bT
 aPVKZTx8uNTTUtbtpRdTDDQCUZcdyQgmrMnioGfbLAGk9yg/2e3kIpBB9pccrdhjdtO53xxzd
 LInNFHxfhN9hJZd0Vcd54Ob1qfVcm4uA/qqvWHpxt3TTZfbWfxcOd7kn0LJNuTbaxVHCV3aXh
 Q0nTwr9+XjWC87BntHiVkWYA==
Subject: Re: [cocci] Data processing challenges according to the comma
 operator
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1818
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-07/f7cb87e7-3a17-44b7-87a1-8fec22e649ea%40web.de>

>> Please reconsider such a view once more.
>> https://en.cppreference.com/w/c/language/operator_other#Comma_operator
>
> The link you cite says:
>
> The comma operator expression has the form
> lhs , rhs
>
> That doesn't end in a comma.  There is no rhs within the <+... ...+>

Can subexpressions be supported by the semantic patch language
for such a =E2=80=9Cbinary=E2=80=9D operator?

Regards,
Markus
