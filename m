Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD52FCD3447
	for <cocci@archiver.kernel.org>; Sat,  9 May 2026 07:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=3wC7hBXLO11u/6DEYfzd8AG62R/T00z4nHaNnlkhXJE=;
  b=XX9JkNlkgy0oPzXpBdrA1EHQpOBthvEkEA+yJXPcMAkYhfHR+FkuTU/l
   zOQUcIZaTHgsqbnMjWoYA1Io9CZPMmblv2YGkDKSwP/Nogtt1O+obogC5
   IUarA4teYVt1cGfIPUk2E+a+Oh9JmnHQ84J8hS1czSc/P3/yMUZSLiFkZ
   Q=;
X-CSE-ConnectionGUID: t8Y3lF/ZShSoHNAiTtkzxQ==
X-CSE-MsgGUID: vry9ETmbSZWzwm3oHDg8Aw==
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
X-IronPort-AV: E=Sophos;i="6.23,225,1770591600"; 
   d="scan'208";a="275964789"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 May 2026 09:05:40 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id F1E1780524; Sat,  9 May 2026 09:05:39 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 01BEA8051C
	for <cocci@sympa.inria.fr>; Sat,  9 May 2026 09:05:33 +0200 (CEST)
X-CSE-ConnectionGUID: ULM4ovk4SAm/bN2otIFztw==
X-CSE-MsgGUID: 7BHeZslgTCmywS83wv/vgA==
IronPort-SDR: 69fedcbd_owezyxkT7SbyCBjJO6VRkE+Pjstx6/PLhs3suVjg2p+v0ir
 5ryaD7ji7k1z9hgstzmlMOsSZRgd7Lo7czUljCw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0H7EQDH2/5p/w4P49RagRKBSQGCPgeBAV40BAtJhFiDT?=
 =?us-ascii?q?4wEgXSEa48RhAGEeINSAg8BAwENFAEBAQIkEQECBAEBAQOSOAEeBwEENQUNA?=
 =?us-ascii?q?QIEAwIDAQEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECgQoThiAvDUkWA?=
 =?us-ascii?q?YF7glEsgTQdAQERJycNAhgOAnMBAYJ+AYIiAQYQAQM2Bw21R4EyGgJlggwBA?=
 =?us-ascii?q?QaBCIFi13wfLCJagWcDBoEfL4VxgkscAQVuiiUPgVVEgTwLhDsBgVsCAgGCK?=
 =?us-ascii?q?oMOgmmCJoEOjnyBShwDWSwBVRMXCwcFgWYDgQY5NTIdgSM+FzRYGwcFgUuEE?=
 =?us-ascii?q?oEBAYReeCMvA06BBwIBC209NwkLGwQ9iz0dD4NqgjFGIpJgkTyhRTQHgjiBZ?=
 =?us-ascii?q?wWBXwyJCIEmlT8GEy+DcQGTYA4dA5JrmQaOCZVghViCACWBWTMaJIM2UAMZj?=
 =?us-ascii?q?gUBAQE/hB6EYL4mRTI9AgcCBw0DC4VEAQGKYYF1gUsBAQ?=
IronPort-PHdr: A9a23:Q6EfYBw7GCJbbV3XCzLtwFBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 xGZva0m1QaTANuTq6odzbaN7+a4AS1IyK3CmU5BWaQEbwUCh8QSkl5oK+++Imq/AdjUKgcXJ
 4B8bmJj5GyxKkNPGczzNBX4q3y26iMOSF2kbVImbuv6FZTPgMupyuu854PcYxlShDq6fLh+M
 Ai6oR/eu8QYgYZuMLo9xgfGrndVZuha22NlKFOOlBr4+su84YRv/itetv8u7cJMTbn2c6ElR
 rFEEToqNHw468LsuRTfVwWE+2ESUn8RkhpGAgjF6A/1U5LsuSbkteRzxTeXM9TuQb47QTqt4
 L5nRQHnhikaLzI2/33ZhcJ2jKJAvRKuvAd/zJLOYIGUL/VxYKXQds4HSGVbX8ZRUytBAp6gb
 4YKEuEMM/pUo5X7qlATqxa1GAuiC/71yjJQhXH406I13Oo/Hw/GwQIvA90AvW/IrNj3LqoeT
 fy5wLfKwDjFcvhY2S396I/Nch05pv+DR6hwccnMyUk0CgjLgVGQqYL/PzOU0OQNvHWQ4u1nW
 +21kW4nqBxxoiO1yskjjonJiJgVylHC9SV224s0K8O3R1VhbdG5DpRdrieXPJZ5Tc0+WW9no
 jo6yqEYtp6heigH0JQpygPBZvGaboSG7A/vWeaeLzp6mn5reLKxiwiw/EW9xOPxVMa53llUo
 ydLjNTBq34A2RzQ58WDRPZz8Eev1CuJ2gvO5O9EJkU0mrDaK54n2rMxmJsTsUfCHi/uhkr5k
 a6WeV8+9uiv8eTnbbPrrYKfOY9skgzyLLkiltKlDegmLAQDXXKX9fm82bH54EH0T7NHheAsn
 KbDqpDVP8Ebq7a5AwBL1oYj7A6yDzKh0NQFgXkLNlxEdwycgITzJl7BPuj0Dfa5g1uyjDdm3
 +7KMqD/DpnXMHTPjrXscaxg50Nc0gY/0N9S64pRCr4bIfLzXkHxtMbfDh88KwG6xPzoCM9+1
 oMDQmKDGKCXMKfcsV+S5+IvJeaMaZQbuTnjMPcp/ePhgmEhlV8HYaapxYcXaGy/Hvl+P0qZZ
 mbjjcsAEWoRpQo/TOnqiEWYXjJJZnayWbg85jAhB468A4fDXJihgLqa0yijBJ1ZenhGCkyQE
 Xfvb4iIRu8AZz+RIs9glzwJTaCvRYAv2h+wqAH317xpIvLJ9S0dr53jzsR66vXLmx8r7TJ6A
 NyR03qVT2F6hm4GXSM70r1ir0Bl0VeDyaZ4jORYFdNN4/NJVR83O4bFweJiBN6hEj7GK9yOQ
 12natSgGzA4CNwrkPEUZEMoPty4jQ3YlweuDaUUkbPDULk96KHBxD7cI8hnynDJ/LYshR8qT
 50cZiWdmqdj+l2LVMbymEKDmvPyHUx99CvE9WPZiHGLoFkdSgl7F6PMQXEYYELS69X//ELLC
 bG0Wvw8KgUU78mEJ+NRb8Hxy01cTaLGMc7dfnn3tmO+HxeOyZuTYYCsd2hOlD7FBh08mhsIt
 W2DKRB4Ay6gp2zECzk7MFv1YF73t8R6pmm6SEAc0AyAKUFshPKu4hBAo/uaRrsI264c/icsr
 zIhBFGmw9ffEMaNvSJke7hAJ8ww6hFL2Ao1riRbOZqtZ+Bnj18aKUFsul/2kg9wAcNGmNQrq
 3UjyExzL7iZ2RVPbWHQ25e4IbDRJmTomXLnI6fLxlHT1sqX8aYT+bw5rVvkpgSgCksl9T1uz
 dBU13KW4piCAhAVVNr9VUM+9h4yoL+/AGF1worO1mB3d4SwvCXD3d0BG+YvjBqtPp9ePK6CC
 A7uApgCHcH9YOcumlWvclcFJLUIrfRyZZn5MaLbnvf3b4MC1Hq8gG9K4Z5wyBeJ/it4EKvT2
 oodhuuf1U2BXiv9i1Gotob2n5pFbHccBDnaq2CsCYhPa6l1ZYtOB32pJpj949xkhIP2HVNc+
 kSiAVwux8KjPxafJQ+Yv0UYxQEMrHqrlDHthRl9iTI0teyy2CLUwuLtXAUKMChHSSMx6DWka
 ZjxhNccUk+yagEvnxbw/kf2yZ9Qo6FnJnXSS0NFF8TvB1lrSbD49r+LYsoVrYgtrT0SSuO3J
 1aTVr/6pRIelSLlBWpXgj4hJXmmvZDwnhoyj2z4Tj47iXPDetxrgzrb6sbdQ/F5wTcMAiV1w
 TXaHVmzOdC18M7czc6Z9LrkCCT4C9sKLWHi1suYuTG+5HF2DBHa/bj7gdDhHQUgkGf629RsS
 STUvUP5a4jv2b69NLEvdU1pCVngrstiT9snyM1q3s5WgCVc38nGmBhP2X3+Othax6/kOX8ER
 DpRhsXQ/BCgwkpoaHSA24P+UHyZhMpnfdizJG0MiUdfp4hHDrmZ6LtckG57uF29+Ej0aOJ+g
 yxb5P8g8n8cjMkWtQBrwijXUdVwVQFIeDfhkRiF9YX0iaxNZ3u0N5W02lB/m9+JE7yI5A1RE
 iWcGN9qDWp76cNxN0jJ2Xv459T/edXeWtkUswWdjxbKi+UGYIJ0jPcBgjBrfH7spXBwgfBul
 gRghNvp2erPY3Uo5q+yBQRUcyH4d99GsC+4lr5Qx46fjYWoA4knBTgBGpflBfv6FTUPqbH3O
 QGUDzQmpjGEFLCZEQL6ig8upiDKFI23cnuQOX8SwJN9SRPbKEEXiVIRWygm25UiHB2ux4q4e
 UF1v3Ya4VudyFMEw7BtMATjF2zErwCycnFtQZ6TdVxd6QQK8U7RNYb2AvtbOSZe89XhqQWML
 jbefAFUFSQTXUfCAVn/P76o7N2G8u6CB+P4IeGcKbOJ4fdTUfuF3/fNmsNv4iqMO8OTP3JjE
 +xz20xNWmp8EtjYnDNHQjIelibEZcqW7Bmm/Sg/ose6+fXtEAXhgOnHQ6NVKslq8guqjL2rM
 umNmGBmJDwe2p5NjX7Exb4D3UID3iFjcz7+dNZI/SXJTa/WhupWF0tBMnk1bpEXqfthmFARa
 qu5wpvv27V1j+A4EQJAXF3lwISyYNASZnu6PxXBDVqKM7KPIXvKxdv2aOWyU+417q0cuhuut
 DKcC0KmMC6Ekmyjchm1MvxXygyfMgZfvo6VbRtnT2TuBoGDCFXzIJpsgDs6zKdhzGvNLnIZO
 CNgflllq7qN8WVHj/85F2ELvR8HZaGU3i2e6effMJMft/BmVz91m+xt63M/07JJ7StASZSde
 QPXqcNy5U6rmK+Dx2g/OPKhgilGjsSHsBc7UU083oZNUzDI8UBVhVg=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:zvavXavaH0hWKyzeyLrtaQ7s7skDXtV00zEX/kB9WHVpm6uj5q
 eTdZUgpHvJYVMqMk3I9urwQZVoLUmslqKdg7NhRYtKNTOO0ADJEGgF1/qF/9SJIUzDH4VmpM
 VdmsZFebjNJGk/o8K/zgfQKbkdKRq8nJxAR92y854Ud3AQV0io1WlENjo=
X-Talos-CUID: 9a23:CZqXX2ygdG8RDa7oDVaVBgUpPuV5dWPekEz5JgiyLzxuVJy7W0OPrfY=
X-Talos-MUID: 9a23:dVXAtASSy2hDLseTRXSzrhFvBtxs7JiFDVESqsVdpNfDKyNZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,225,1770591600"; 
   d="scan'208";a="275964728"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGhXP831a3m+YoT5Ks5XEp9f7lPJWadjJFFMN?=
 =?us-ascii?q?Z0Ln3o7IzCe9wOIn9vOXDZuY9dh1pk6s4WfOKY39gd4qNPYeOCll65mx?=
 =?us-ascii?q?97pnw9b/Tz2Wvq2SZ/OU1s9P2A7eerII7UO7jqtgxtpWsjmBzusYIdQ/?=
 =?us-ascii?q?ab9ATstRzw+OdmOeeKPxTE+Q=3D=3D?=
Received: from unknown (HELO mout.web.de) ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 09:05:33 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZSBG-1vp6ep3Zzy-00Wy7g for
 <cocci@inria.fr>; Sat, 09 May 2026 09:05:09 +0200
Message-ID: <a556de5c-f8b2-4d80-9415-dd1a9c7a431d@web.de>
Date: Sat, 9 May 2026 09:05:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:mrA6lrXT3ct5Lo7xOk4tPFqjNI11uMyZG5kapb6foP/eLM7aIsY
 BxQOq08bXgDUAZfxa61fdTdpSDPo2anVaKVpvhKUqsZN17dtkUeB4h9SCAv6hXv3jvlSkjS
 GsoagKXKh1EFj5n4xuitX2KN02Rb9GaLeMk7j5Xpj48w2UnmCG9W+eGOM+Q9LpA7TyiHwgF
 AbmhiSwZGI6UWJGwnLJxg==
UI-OutboundReport: notjunk:1;M01:P0:EHx7A3aHH+s=;trg7wUipq8daZTn7Y39UIdfp3+d
 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
 EUk36wpjoZ5
Subject: [cocci] Supporting task identifications?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3487
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/LOojRUwt7oKTpkm4NztbDw>

Hello,

Some tasks generate also data processing results.
https://en.wikipedia.org/wiki/Task_(computing)

Can it occasionally become more interesting to determine which data were produced by
selected work units?
https://en.wikipedia.org/wiki/Responsibility

Regards,
Markus
