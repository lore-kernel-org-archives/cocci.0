Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72381CD3427
	for <cocci@archiver.kernel.org>; Sun, 10 May 2026 08:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=X70JJtt6xczCmRw91qRTnIwFleJ9LLdz87qCklqX69I=;
  b=RDO5PTwzfF9sb7pBuC9MEMLGdm909Rs5l5RGaW5nLfGrRI+FVE7qNMJc
   OOSGlTE8NyvIgZh2h0s94Rfy0Q8D7Dy5XJd2G/aBHc0/gsBHs1dAsWniz
   Vtc0lqGN6n7PyQPr6vXIsvETFrGzeigW8rOHG/6g3gkJccO778auRcmGk
   4=;
X-CSE-ConnectionGUID: 6rS6X9JfQnivsuNqSNIbtg==
X-CSE-MsgGUID: GP37LGwmQO67FKPX+egCdQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,227,1770591600"; 
   d="scan'208";a="276017082"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 May 2026 10:50:53 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 15EB9805B0; Sun, 10 May 2026 10:50:53 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 52255804C0
	for <cocci@sympa.inria.fr>; Sun, 10 May 2026 10:50:45 +0200 (CEST)
X-CSE-ConnectionGUID: lYXo8MywSVihc+vkhtt9Cw==
X-CSE-MsgGUID: trQv42XMRNOpdCrq9zsFPw==
IronPort-SDR: 6a0046e5_kEnL6fHd9dE7qWabjkpRcGWMMsdbdd51yRJ1suvVoZqPne9
 MoqNejo+rV/Mo3kCFGoQVlSsV9mQE9TAp1CPQHw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0G5BABtRQBqgAMP49RaHgEBCxIMghKCP4EIXjQEC0kIh?=
 =?us-ascii?q?FCPU4IkhDuPEYh5g1ICDwEDAQ1KBAECBAEBAQIDAYR1CgKNMwIeBwEENQUNA?=
 =?us-ascii?q?QIEAwIDAQEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBOwcOO4ZPD?=
 =?us-ascii?q?YJiAYEkgSYBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQJHRAEBAQIBIx0BAREnDwsaAhgOAgJWBgEUAQGCfgGCIgEGEAEDDycHD?=
 =?us-ascii?q?Qa0RYEygQGCDAEBBtpmHywiWoFnAwYVgQovhXGCZwGGMYRAJw+BVUSBPAuCR?=
 =?us-ascii?q?zE+gmEBgWGDW4JpgiaBDo8CUngcA1ksAVUTFwsHBYEjQwMqLy0jSwUtHYEjI?=
 =?us-ascii?q?R0XFR9YGwcFEiEqbktkLFwaAwMNITVZdQoBSQWBdAKCHhlfIy8DToEFAgELb?=
 =?us-ascii?q?T03CQsbBD2LPB0PgimBQYJKHrEvlGM0B4I4gWeBZAyKLpU/BhMvhASNE4Y7D?=
 =?us-ascii?q?pMLHphoIo1nmziCACKBXDMaJIM2UAMZD44hhDWBC8IeRTICCTICBwIHDQMLh?=
 =?us-ascii?q?UQBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 TYphwE4bel/rV/R
IronPort-Data: A9a23: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
 FUI
IronPort-HdrOrdr: A9a23:uyQETalfHd1HxFQxBnhfoIXzv07pDfIE3DAbv31ZSRFFG/Fw9v
 re/sjzsCWetN9/YhwdcLy7VJVoOEmsjqKduLNhRYtKPzOW21dATrsC0WKK+VSJcREWkNQz6U
 4KSchD4bPLY2SSwvyKhDVQV+xQpuVuzciT9ILjJ0gEd3ASV0lDhz0JbTqmLg==
X-Talos-CUID: 9a23:d6awAWHg8/rPtoi0qmJjxX4TSuU0bUbjzXfbYFG7CXp1GZaKHAo=
X-Talos-MUID: 9a23:R+yEJgXm6h/CvzLq/CP2vS8+bvdN2YKJEEwmi4xXqdKqDTMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,227,1770591600"; 
   d="scan'208";a="276017060"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFVQ0yuu+Tt1/iEW80eAKgG3E1RF9UwKMkJex?=
 =?us-ascii?q?/9LPcwh+pv8/l8/FV7F0i9dxyfttTDI6oC5HGHDvl6Ybz62ACVVkbKMZ?=
 =?us-ascii?q?avaQ32ycNmcxdCSQAZ9a2809S8w+2X+DWU/ROfiQ7HAGK2dut6VYFRXW?=
 =?us-ascii?q?aYXwFXVT01COzjfqFgo9MNHA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 10:50:45 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mq182-1x987y14NO-00nGOV; Sun, 10
 May 2026 10:50:44 +0200
Message-ID: <049a046d-3952-4192-9b9f-a7c2162c6ea9@web.de>
Date: Sun, 10 May 2026 10:50:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <ffd64e55-beb3-4030-8b7d-763ba6f8f563@web.de>
 <1f97d99-bf20-44f9-8781-26162f5824b@inria.fr>
 <ef0539dd-b1d5-49b0-9c20-74c5e5d977b1@web.de>
 <e5a66d9c-5462-2f54-6abf-d2ec2cfd1d9@inria.fr>
 <26e1d3aa-13f1-4e55-88d1-68b9d027ded0@web.de>
 <806afe75-8e1-17d8-dc3e-c2e33f4ab64@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <806afe75-8e1-17d8-dc3e-c2e33f4ab64@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BQd3LL2eFC31tk3F+mVh9t6MAzkmJ3aRSrakor/H4Q3hMLA4fqr
 Ip0m7doOdWNgZLHWz5lXio3Nv7/ta7LWyeXGAtF1iEu5mX/YtMDq4af+iL4CnThmXqD1EAN
 U9WSjqqUhhSY99Gp57SmFR/MN0pK7ocZi0Y25yA7fZHfIq1JD8Oos6zmXtJY2lPx1FmzKIz
 XYhiYjtwysNsX6wbxFleA==
UI-OutboundReport: notjunk:1;M01:P0:PWUwgxMlISw=;C83g4gVOY5nKnoTIY8JsT93KmAh
 dE61hVlbGD2V6MX0QnywciK0Lchyt0AI/4zjiRKRTCslI8iT3BE7Lpi7C4Wc2lVCvE+CfIWiF
 5lO+g3Qq+JtDgH0P7JBqfPRISMbqkh5G/NvoTEQoOnVrjg/2iYQAn8kQB2LSWe/BfyRDWMVet
 8lzTauB0EemQxDS/Us33WMNC+KUnCS8zPz06w6Q9BS6+oKgD+B7SVaDRbrJWFlxIBDkA6SU8k
 z2dstUggrFZqOPxVDj4ra1PP5BBO2kg+IMeCM9kha8xlSINRK2OzgJB9W1Pgfcx/DNDHNHq6b
 pH1o4gGpM4RGP2w5yq0Vvf5KbZozVeTZO/RKQ4//8I28zpoZ0NGsOTQnBXnhv2fKFYd/fbHg/
 NPnWXh5QKeBOOIzhYYyPGCi+MzOrgUdKSh3yqTstQsMXMVOuL/S/TAcJj0lSZD3OkFPPoGqvZ
 fVPepQ42zmvPqbDE2R9ffTyAANEasBOPHSFh7H1RltKZCivp8NYCXG0NhORHa9yH6V3KDWqaZ
 moPDWGk+XEm34cCXIOmzm+y2XTEAD4pVE56GJdOGpyoR9ymECXcGgrAYOYEqJdHcGsnGLPktZ
 xg8Qg9jM/2qzsJ9ZPkxJpNbelNabCFuDk9OyCs8TuxGFZ9TdJBvmMgfvSPGn4ALqQ9TzklQTK
 K+7bqxYiyLydYVJHpcfhEyU1GFbkbQ1NhxFZNKcSd92bVUAg4JBYxihuTjJw0lzEELSkcq1j3
 0a7MqE8AS62dlbvGS00lRrTZr8jqOSAen2xi2Sh+2EEit6FQ2DQ9VrnvypIuooqOW7QkukVHv
 oXPXpxfSXQOP9aKHpvgyxaYqoEuRw1j+yKMVRAT7318k9/OZ2twET+bu0eNJSpjX3nP/iFYsO
 WPaEDzGx7KfIXPp5czpXUNGgNPGXtXgISQE0arMVsuB3qrEibUMURJYFSqF6atMEreVBz9gRh
 vnWMDLzKwlOB2DGoiqzoDQ6apEUjXQke9bSW6EwerOmqLNM8jsANdKB6w6yFcUr1a2jDyQFjD
 nJmyA3DoYg1ieQDYFBwEOP+UhTtuO5j/c/i64xl3zcanopx9xDE0WN09ibueXLu3TzuSpXye+
 cVPao7/H5OSaAY345EoIAG4W4QX5LyNOvmHPze2+fYhyzjsYd/OfEoxBij4aWLg4iWMlBMyn3
 vdER7bmDZuKDmA9EpM5UXehqMEb6fbNKcijuMCAPTnhRhI/I9RC4lkGfLo40QQBTt12omG6JB
 R18LbQ3Bg4TlfvERUUj+jud6becqgz4YVaUR23V1EtgU4wCrLlQpN5KxJBhOG5FQKJSnbmmjl
 8qYCljtkxLQjk/hAdtaV+GKbsZGAk91ENtWrE4iXkHlmceVyYL20nN4rAH+fdp4U0I1tgPzoK
 paCCuCBE/Th+el3ZctgWnMKUyiC1PTHAByvJ+IP0QejvRuBNitUu57qNMPS12qKxlGrFSlCni
 MjQ1Gp9avaLxIvktmcV/g71DlAsA/KXIYt/GIfuEArKLv1bi9yBJbrAMIEc8aXMShsBpubLEB
 vmQY8ENfPOokjP6PopIRf7SHtLxQRp5avqEJ9+EM5WYq2YAbT/uZ5lDWR5Vt5ERm7TK4Vsv9B
 gb7+hUmEa++04SWvdfGiqODaq+Shl/jiPDsm1xh9jqZiV+0MKQqt2hPyWbVfbiX8RVAisIDJD
 GuOknFxg9X4638KHF9VtJadmszurSUmCVRJsiuFSF9zjYibpMh/FGSCgalXWfSGvB2dOsG4Eo
 RLdSnq1QEiGn2/45O/ToQVm0idKmkjgUN76adI28fzu0aZ74WC4VunytePayvsMQ2seeEnTHZ
 96HPyC3sZD06TrPCy2n8PDIkmrQYpgA//xs7LwXPq2y9N4ystwR0TGc8/Oq0B8JLsdYPpnyv9
 XQpmHnI4hYkc9akTZ8Cyjt5mUuTtc8nXKQxlhuK5M+O3IAQd+zn9tZ+Y1zR3tOn0MFmgmUXf4
 q8XgSCqzuiQVJubKYNP/MuZ0cC+MGs+5WFSCEGlasdnTkhIfEYB3fXZt+Fdk6+uG8p+9RBmH5
 PKt9c0Gph2f4zzPsmO9eHCd7V0B7j5ijG/eBGiCrzTdiAmQv6pryj3AC3QijcicBPGqAFAKGA
 8caFF191qpD9FmwXX7zyusxGRcygrv1bRybO27V1qEYrxvSl0ta2yqlCPulJ2C1f7CLC0X3X2
 ygiy4lanbaOrK1knr7/2IdK1hvjJLhzf6ERtviZvUKo3w6oQ0Bj5ruj80mGUH1EC9WOdErgME
 hI+jzipZH2nnWxnBV4QrBM2ztgb2FaWUgkor18nD9ZcNXlvjyomMn4cRxgTWBtUtrzsfjwY1A
 v32OYe+wcuyEC+VyYtgcI8WaCTn+PANdDVM2K50Cp5PFad2YKFgpC57rv0JNElwS3eg2/2x78
 A/hhNzsynmKN6b1xCuB3D4NIVSrvSEH/JKRmowzXsBG53izZAC+eKO3mV9yKQnMko9xRci3RY
 Mlcl+BtivOrwJaJyT2k7g4W6O7UF3bn/BrVuzwIx1MWFIW1Zz4nnfVIuTHtaz1g3oeRcUkC8T
 4xl6Oj25SMTBpJUTZ9TxvD5N+tFFp45+abGhJLcTY6WZ/9W+1J+mGLz5g52G0JxNJHt6DP+ju
 hRii8TZfAHZxEDLlFh7++WEFTAN1dqPMsXznpLy3RtULDdVS2Ahem4LEwmcf2moKaVh9QKYgm
 976Xy6UVmEdY+DUvTHLpmiR0fMO/bQa4vjAFL0GjII0jyYzCy/4TWnzMD6aHWx7sLJMNw3XCU
 rkJEqg8cho/b6IiZorx5chugfCXkr7yqfJQLaH2sNBX6wX46MA/6LYE96/zFklfZWdaZ1FIG0
 up+xj2SJGE8s6U9IQs4vYFu2+Wlgzq+tda53UG3EmLufoJwiB/3Ig+0dlkmsM+tGSiLi4hnmw
 dNZ55lnpAfgozfkBjEnZZFpt6asfdQ7lzhmvvrj7WHoxP2DzvC5kTiDQPgu51KnxOZSvYAvqb
 QmxiRZe93R45lbdALmsv9X27MAq7zy4Z1XbZoFNF9xX2LbMQKIiHbzuXEPXBcxGiXoFg2G5gx
 0Tr+r1i6nZdKO0BpafSJSTs3qiVwnhx0qeEVfWquPsFlg3nyGHCQ30AZ837RIFTsB2JdYf1m3
 srJE7jRaPKLqw3Gzr5CfeN9MsCjUfSxGkHOq3AtOCYV/qhE/k4OrqPLK9uZ/chc9qrHphvHFY
 GsKVP732BInWOLjgnJ1JuGTHI0hlIST2Y+p5D2SKQMHGltvLXLf70CIt0l4GrG6WHV1sf+OXT
 zQCkgcyeUs6hmHzEaw4FHMCyGxBseKB1s0u7j1l2uI1rQJ10zehKJ3qJXcfbjZwrAy0SFm5aJ
 iTPkNszTQNr7+sTGi2+sehqP02OYjvz8qOVJHasfQAizpzjNuIaMZyxGcK8hZ+lK3s//GEsBh
 z9zu+puHyFQ+SyKdjS34CBNR7sQkdtFSi77n/U+u0TdBhNvk7pEYUUWA2em09VWgNtUjvJl3r
 B7KUuX4aX1yXSQu/P84zDpbJO5nnqUvpEW8mBAYXnrLJliQJdw7hYzY5+ozJSymSUaQM6nLOH
 eF1hW32waMEjFr4m+yjmOREaE4s1SzAp8ucDuYGUtbQvnJ2Tv7YZUjQ/UwVkYSTqT+dJo+kgJ
 ESwBoulA1H5AVPshsBt5B3aM8k2smu1Xy6jw/WPBNp3LH8iuGnN/65j0GET8lHR6SHrV6Pl6y
 P9hJcFHg4oGim28xTV2wtnENJ02eXbNpiTkbCyB8EHcLWgsSDt6JTL5P4QagztSrd9XwLAKXm
 dkyjdvNczljH753X3Xo6TeUGXQrnXFP56viq2Q6/3IKsuywStxm2kchshKpvkbBOHtkttaTI6
 qT7fMJ9bQJKS56panQftOtY14B4qlVI+0qOGJsV1tq4Oo6args67mSVlHBHbviBrieE0/gbTd
 2Rc6PJfP2jPTcnTBvcmKhtYUhdNoYDOwPmWTK/jUnvxSNpe0qXJDIBY+WsNdZLWjhnoVeNc7I
 iiPqpxo/XRyrGwgSkq81NygIiqle3PgDKqNOlRzCqmvq+B5ZiUSQh3/fyqiVPIhrchIXHip77
 cDiX/QoiZvdFFJ30MLpsKhZf+epyUIsRevGd5f/akG5iIvvb8wJL5eO/BhmukmfgQ28k5DX0o
 6WQt87H2AfI0rCw07vvG0pxJ6/do4l4saYYX4qPseQpWHb5fMc9HY4ZncLKT+LmwyjbMimIZk
 5gOttTAnziwMbVVZffxwxdvFPWC66Q5KyAf/8SegOyOppwM/+KTXaZa5AMvLkdBFo58VTDIP1
 yXidVXQsjQujpBQ9zgXW/UXtvP6ImENg/x9mMLxu54EoKj2ffUXGIojhyc0S91fqIQnOdBPKc
 cGA3TqZDtLLDH49CyBcMO1jvcs+VPjpZv0DhoDTOrUlHGrfvxo0ipdAR3/PYKYd6OdIbTmxBu
 kiBCembNrg3R9d2vY3Ed4DW/iYhnMjeNnpKheJRBa1BlzLoVQeFSQZMQmgoYHh7n23dUuuvZD
 UW95ZAHSQifVEmHgG//yIbSr9Ne0xW9yv/2GWXh6sChAlEBj0um+SZF09ixklLyLxK9zG5tj7
 qDJT2PZVqbez03u0i3eDfjx9rm7XnNGvUMh+LgrHfKKP7ZDF9BiX11BG8i6/hL0VCQnXMzxuK
 GAqOEIZ8E1CFu5g/9nHBzMB6ew0/RePRBow7p62UcQyWi33YFq0CkRP2wcTY43gv++Q+zJsrK
 753+FAis3OWcXCzCl7dXtFuC1BzxB4IdzQgD3Do2fOw5GFdnOcPMaP00uYqHBAf8ZaTbhAABW
 zyn+Gbh8cH6DuTXmBFNL0SHfHxFPMJd6PyORkrkavWSSwU7t/Ak5ZfZtOuXjnrZepuono0Zag
 tvOZoVn16VWYM6C80HuxUwZj6wXvK24iSeFlCdBLtTACp2NCA/UIcdJ5YYq5bITggYGfpP3vw
 fzw820hWkbG/VXKugm1DRwvhlNrdYYa/uLbpqYLbYKehEBm2gwszAQjxyoAtTlKYpKZwgFbA2
 1sQhr5l1sYnL8ziL8H5lcVJ8a6Mwr1YM5uBy/Xwson8H7vZrsfWe0HuQmoBwgYi4UCvJfXdte
 +A1kZNEfxFGGvDdvDXbHCuj8plLlcLsPEFyOdKfJmLt/Ks9pBFVuz/PpzAPrOLc2k6jsecH/m
 2CQkBfjXZkdtM/qydzsdGzTOmt4nxF+sySy3PDeIIeejiZAmpY8rS92sDL0qVFTibuVadw2Vh
 nVYZTnj7ibCTrYYiUKvEZZLPUpDnqDIsM980VtA/vwyFx299juY77qGlipJBJZ2sej44HiGqR
 VraFdO+pVtcqAi72DZHSqFvmbL54bHSFZPOsNYQn61AUc8WNltMkid7Jy4iXFVdgVk9fnOVaL
 fN1OSmqHboNPYaT0vEjfcp7H5ApmLZd461Fq4zKgeyyEVPHNvG3QeYq//zyzolylkedgBSfBH
 acg/uSgo7ByBlPCDYL1i1VpUaA62vVXuUl98X185O3AoUpWb6r5Yh125catH8o8iRC
Subject: Re: [cocci] Merging results from parallel data processing?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3492
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/zNPajjfMRSpb34JiNgGyfQ>

>> How do you think about to point the circumstances out under which this =
one
>> would be applied?
>=20
> When the semantic patch requests it.  Please see tests/merge_vars.cocci =
or
> merco_vars_python.cocci

Thanks for another hint.

https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/03a1af0a3316ddfc2b54d=
827b8b9627a841c85c9/tests/merge_vars.cocci
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/03a1af0a3316ddfc2b54d=
827b8b9627a841c85c9/tests/merge_vars_python.cocci

Do you distinguish =E2=80=9Cmerging=E2=80=9D from data concatenation in su=
ch code?


>> Would you become more interested in the clarification of corresponding =
case distinctions?
>=20
> There are no case distinctions.

How will such a view evolve further according to the use case =E2=80=9Cpar=
allel data processing=E2=80=9D?


>> Do you care for the ordering of generated data anyhow?
>=20
> No.
I find this feedback strange.
Data users tend to prefer some information ordering, don't they?

Regards,
Markus
