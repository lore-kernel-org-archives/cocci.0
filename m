Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54624606A31C
	for <cocci@archiver.kernel.org>; Sun,  8 Nov 2026 20:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=fA8TKgS0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:to:from:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9YVvd2ias7oqjMEqARskIvZbwtnDIqdVNAS8nBJq/RM=;
  b=fA8TKgS0gtqHH0tQ0pVyPyDJyHsVhrPjH+WivbsgRO4G80m0exyiuBzE
   7Lvvw+YitDAQQp/qqdiCVBmfWGx1ywSYyFNYJDhJRYHGzquBbkuVVk7Uy
   /dBhb6eE7mvX8eX4EIvzGFQ0tgzyYkGeWY7AYl55N7cBzwYJiYhQXnIM0
   Q=;
X-CSE-ConnectionGUID: sirKgxi3R3ewshwQAHVoqQ==
X-CSE-MsgGUID: 3TRhTXzmTBa+Xj3D+Qm4bQ==
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
X-IronPort-AV: E=Sophos;i="6.27,202,1787004000"; 
   d="scan'208";a="304433251"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Nov 2026 21:43:40 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 16E62806EA; Sun,  8 Nov 2026 21:43:41 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 27CD2806EA
	for <cocci@sympa.inria.fr>; Sun,  8 Nov 2026 21:36:49 +0100 (CET)
X-CSE-ConnectionGUID: JBQTx+WdTjqIdYhIdMo1uQ==
X-CSE-MsgGUID: 4jNl3IkQSeOvP6fiZDQTgg==
IronPort-SDR: 6af0dd55_JUXyywgJGesGGvKNBfX0nKKEWHTzgBfvJDi/VybD77nUwRH
 e7oqYe1qM3PhYvB+9vVQ7S81l9cTgdKUJUEdh1w==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FzAQDz3PBqjXf04G1aHgEBCxIMhFGBazQHCEmEWJF3o?=
 =?us-ascii?q?B0CDwEDAQ1RBAEBAQIBA4R+Ao4eAh8GAQQ0EwECBAMCAwEBAQEBAQEBAQEBC?=
 =?us-ascii?q?wEBAQQBAQECAQECBAMBAQEBAhABAQEBAQE5BUmGTw2MGgEzghYsDX4BAQEDI?=
 =?us-ascii?q?x0BATcBDwsYAgImAgJWBoMVgiMBBksHvRCBMoEBggwBAQaCatlLgWsJFYEKL?=
 =?us-ascii?q?ohiAYl8eicbgUlEhEA+hEODXBmCUYImgQyXQFJ4HANZLAFVExcLBwWBJUMDg?=
 =?us-ascii?q?QYjSwUtHYEjIR0XER5YGwYFEiAqQUNbgRKBB12BKyhdAQIfRi0VgXYCglGBI?=
 =?us-ascii?q?10CAUlBDgdFUwklQxJHJCIIEgkBExosCoEaNTwJJj8VDGQLGgUaRwgCCwIMd?=
 =?us-ascii?q?CgREBMdHiQvBRwmPhsKNm09NxUZBJN1hGx7lEmzT4QqoV5NqnEuh12QfalEg?=
 =?us-ascii?q?X8jgVwzGggbFYMiUAMZD44iGYNpyhVHMj0CBwIHDgMLkhyBTAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:UWCKNKBhmRdDRhVW//znw5YqxClBgxIJ4kV8jS/XYbTApDp00TcBn
 2BLDWHVaPvcZWTzfop3OdvjoRkFsMSDx983TANkpHpgZkwWlceUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOiTraCZmYqHVUMpB4J0XpLg/Q+jpNjne+3CgaMv
 cKai8DEMTdJ4RYtWo4vw/zF8kwHUMja4mtC4AVnPaAT5TcyqlFMZH4hDfHpR5fHatIMdgKKb
 76r5K20+Grf4yAsBruN+p7nclcHS6LlJgOHjHxbQcCK2nCucQRvukqTHKN0hXZ/011lrfgoo
 Dl+ncXYpTMSA0H5sLh1vy9wQ3gvZ/UekFPwCSPXXcS7lyUqepZ3qhlkJBle0YYwo46bDYzSn
 BCxxf9kgh2r3oqLLLyHpuZEpO4aENmoA48juGhBwQDZLPoDRsneevCfjTNY9G9YasFmGP/fY
 49DNWY2NUWGewdIJlARDZs/mKGjhhETcRUB8APT//BrpTKPkEooiemF3Nn9IrRmQe1el26do
 W7L+2H4GRwActeYzFJp91r33rOTxnmkAdt6+LuQqvxMhAayxVUoBToIbQW1oMuVs3KxVIcKQ
 6AT0nFy/fNspR3DosPGdxa/q3WFlgUNXsJZVew88gCEjKTOizt1HUABRz9FLYZ66JZvFHoyz
 FiVmNXsDD1r9raVIZ6AyluKhRGYABQFblAOWS0dbAc04/jvhYZqkyuaG76PD5WJYsvJ9SbY6
 BDikcTTr7AajMpOjfnnpAmWxSq2oYTOSAs85wGRVWLNAuJFiGyNONTABbvzt6wowGOlor+p5
 yhsdy+2sLtmMH11vHbRKNjh5Znwjxp/DNEjvbKfN8J9p2/zqi/LkXF4+Ct5OEBves8LEQLUj
 LvokVoJvvd7ZSLyBYcuOtLZI5pwk8DIS4+/PtiKNYUmX3SEXFPelM2YTRLJhzi1+KXt+IljU
 aqmnTGEVC1CWPs6lGroLwrfuJdyrh0DKarobciT53yaPXC2PxZ5kJ9caAPQPNMqpriJuhvU+
 Nt5Ps6HgUcXGu7nbyWdtcZZIVkWJDJpTdr7uu5GRN6lewBGIWAGD+OO4LUDf4c+ob9ZuN2V9
 V6AW2hZ6mHFu1v5FSuwZEtOUojfBaREkSpjPAgHH0qZ5Hw4UIP+sIYdb8QWeJckxsxCzNl1b
 fs0Ru+cCK51Tj7ooiwWN6fsiIlEah6QpBmvOhC9a2MVZK9QRA3u+/3IdyTB9wgjIDGFlek6k
 ZKN1w3gXpsIQTp5PvvWcP6Cy1CQv2AXqNltXkDNHMZfSH/s/KduNSb1qP09eOMIFjnu2RqY0
 FywLSoDhOyQvbIwzsbFtZqEo6itDeF6OEhQREvfzLSuMBjl7niR+pBBXMmIbALiejvNoov6X
 tpsztb4LPEjt3RJudAlE79UkIQP1+G2rLpelglZDHHHamqwMYxZI16E4NJus5NczboIqCq0X
 UOyouNhA4urA/+8MlAtJ1sCVN+hhNU0gTjZ6MonLHrqvBFX+KW1amQMHh2uphEEEp5LHtIL/
 eMTtvQSyTSDsTsxE9Pfjilr52WGdXMBdKM8t6AlOozgiyt161RkYaXzUzHEz6+UYepIIHsaA
 yKl3vveprVDx3jtd2g4OmjN0NF827UPmkFu530TK2uZnuHqgqcM4yRQ1jArQiB+7AR148gqN
 kdFb0RKdLizpRF2j819bkWQMgBmBizB3HfuylEMxVbrf2PxWkPjdGQCaPuwpmYH+Gdhfx9ez
 rGS6EDhdR3IJMjR/C8DaXRJmszZb+5a11P9wZi8PsG/AZMFTyLvgfauaUo2uhLXO54Nq3Odl
 9Z63tRbSPPdDjERkZ0ZGoPB9LU3STK4HkJgb8xl3ps0GTD7RGnv9xmIc1u8a+FcFczsqEWYM
 fFjFuhLdha51RuNkAwlOL4xE+d0ssIEtNsmUZH3FFECqIqa/2ZIsoqP1y3Qh10LYtRJkOQhG
 7zVbBa+MzS2qVZEvFSQs8JBazKyO4QYVTL4x8Sw1uIoFo0Cgs5oY0odwru5hFTLEQpFrja/n
 hLPWL/S9MNmkb9TporLFr5SITm7MvXxX7m4yx+yuNFwct//C8fCmAcLoF3BPQ4NH78ud/lot
 LaKovjl9VjkuesobmXnhJWxLalFysGsVu5xMMisDn17nzOHafD88Sk45GG0BpxYouxzvvD9a
 VODV/KxUtoJV/N25n5fMXFeGilALZXHVP7roCflosmcDhQY7xf8E+qm0n3UdkBeSD4DPszvK
 w3zusv23OtikqZ3OEYmCc1lUrhCG32yaZt+Ipe1/XOdA3Kzi1yPhqr6mFByoXvXA32DC4Dh7
 YiDWhH6cw+otbrVyM1C9bZ/pQATEG03lNxYkpjxIDKqo2vS4K86weUh3VEuD5hVlmmoiM2hP
 WCLdHElFSL7WD1FdVP34LwPmy+BU/cWNI6RyiMBpiuph+WeXetsw4eNMg9l5Ht7fj7i1+y9b
 9oZ/xUc+zCvl4pxS797CuOT2I9aKzCz+p7M0UX6n8H2BhcFDK9M33tkdOaIueorDOmV/Hj2y
 aMJqayoja11pYMd0SqtRpKNJCwkgQ==
IronPort-HdrOrdr: A9a23:s0bk1qFHlkS7DHmFpLqE3seALOsnbusQ8zAXPo5KJiC9Ffbo8f
 xG/c5rsiMc7Qx7ZJhOo7q90da7MBHhHPJOjbX5eI3DYOCEghrNEGgB1+rfKlTbckXDH6xmpM
 RdmsNFZuEYY2IWse/KpDC9V/It2sOO/qztpcq29QYJcT1X
X-Talos-CUID: 9a23:LifSrWNLqUGrWe5DegNeyF5XJcwZcGT8wEbQAkOdDj90cejA
X-Talos-MUID: 9a23:HL4wmQqmaTs5XrFk2wYez21gEsMzwqeXM00qj61Ytci2GRVMNDjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,202,1787004000"; 
   d="scan'208";a="304432711"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDExGebjtrIyPa7is8vW+t1bm8cjlLdn1sglDV?=
 =?us-ascii?q?AzuDKkzYquU0KcRn61JGxJBIZENWuSBjoC4c9gtSASX7vhX17Xq3miby?=
 =?us-ascii?q?UJCLL5jwyN/l22mNpt8G9fN6xXnaMXG7dACpo33n158InAZxXGGAypHB?=
 =?us-ascii?q?AEU3r5BDPNMXFKLSuzlWlyIA=3D=3D?=
Received: from mail-244119.protonmail.ch ([109.224.244.119])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 21:36:37 +0100
Date: Sun, 08 Nov 2026 20:36:32 +0000
To: Julia Lawall <julia.lawall@inria.fr>
From: Chad Aldreda <ca@modelmiser.com>
Cc: Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, linux-kernel@vger.kernel.org
Message-ID: <20261108203625.2517017-2-ca@modelmiser.com>
In-Reply-To: <18f23c2b-d76a-8b94-bc4d-f298354c8f8b@inria.fr>
References: <20261106193517.3267013-2-ca@modelmiser.com> <18f23c2b-d76a-8b94-bc4d-f298354c8f8b@inria.fr>
Feedback-ID: 232753253:user:proton
X-Pm-Message-ID: 397ed8c69a1c40a50facf91283c12a512d61ff6a
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] coccinelle: api: add a checker for device nodes
 in devm_ memory
Reply-To: Chad Aldreda <ca@modelmiser.com>
X-Loop: cocci@inria.fr
X-Sequence: 3787
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/XRdpaCzBV1NTftQWT64zFA>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 8 Nov 2026, Julia Lawall wrote:
> I get the same result for
>
> spatch --dir drivers/media/pci/intel/ipu6 scripts/coccinelle/api/devm_fil=
e_reachable.cocci -D report --very-quiet
> spatch drivers/media/pci/intel/ipu6/ipu6-isys.c scripts/coccinelle/api/de=
vm_file_reachable.cocci -D report --very-quiet
>
> Both report the line 990 issue.
>
> What version of Coccinelle do you have?

It was 1.1.1, the Ubuntu 24.04 package. With it the --dir run reports
nothing. I built 1.3.3 from git (11b93adb6), and with it both of your
commands report line 990, as does the --include-headers --dir command
from my note, so it was the old version.

Over drivers/ with the script's Options line, 1.3.3 reports one site
more than 1.1.1: drivers/misc/pci_endpoint_test.c, whose probe function
1.1.1 fails to parse. I'll redo the measurements, including the -j
variance, with 1.3.3 for v2.

Thanks for the pointer on the parsing nondeterminism.

Chad

