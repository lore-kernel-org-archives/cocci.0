Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E60D68BDF
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:message-id:mime-version:
   content-transfer-encoding:to:cc:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=YykTfzrNsiOcwK2ra+gzipuntreyDWZKmxIft/JBufs=;
  b=t5+2CFcUv/PgEOnj+yffUfe8YqDIGGuQLAemEpVu7ZUofR/YZ39E0aSV
   wMBFZNXzz0GiSu1ikWgVnsoS4ON9qmAfD+v6xeaXzP9uVPUtz/3/N7xKi
   YxLkIr5C1eE28q4L270vK4w/rthK69+8YL4ZrpXI7S4nlPpaPSf0ezR/H
   k=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux.microsoft.com
X-IronPort-AV: E=Sophos;i="6.12,158,1728943200"; 
   d="scan'208";a="194169753"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:36:05 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AC568E0D93; Fri, 15 Nov 2024 23:35:53 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8A15BE0133
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:26:43 +0100 (CET)
IronPort-SDR: 6737bc92_R6cxWFa7/sGBKp37/Ux5q+3KLCsemacBFIi78JX+mUbBkAx
 Ku3z4LofQYNMsqwPepBuMhUHB5q7XyxAjUjs7sQ==
X-IPAS-Result: =?us-ascii?q?A0EtAABHuzdncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAQGCQn1aMwcISASEUogdiVGLdpBNgVaBQD4PAQMBSAYBAgQBAQMEg?=
 =?us-ascii?q?UyDNIpNAh8GAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AGBDIV7DUkBEAGCBwGBJFENSAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARECD?=
 =?us-ascii?q?V4BASAVEh0BATcBNAImAkgWARKDAQGCZAYCDAafOwGHYAEBAosjgTKBAYIMA?=
 =?us-ascii?q?QEGgmfZOIFkAwaBGi4BgWGGagGBbIN9O4NCgSEbgUlEgRU1h1kyg0aCaYEUh?=
 =?us-ascii?q?kQliH+Jd4IghUSIIwk/gQUcA1khEQFVEw0KCwcFY1c8AyJvalN6K4ELgRc6Q?=
 =?us-ascii?q?oE7gRMvGyELXIEpgRoUBhUEgQ5GP4JKaUs3Ag0CNoIkJFmBHYEyhRqEbGcvA?=
 =?us-ascii?q?wMDA4M8gk5kMh1AAwsYDUgRLDUGDhtDAW4HnwMBRoJCUh8BgQ8rUEGBAjeTG?=
 =?us-ascii?q?jODOI1CoWuEJIwWlUcBMqpOLodkkGUii2WBeJVzhQSCGDo8gSBGByMVgyJPA?=
 =?us-ascii?q?xkPjiGDeoUUiioBth5DNQIBOAIHCwEBAwmFRgEBgQCEOoQiM4FLAQE?=
IronPort-PHdr: A9a23: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
 p9aih2nVLJ/XCKLolHHimckNLFCHz8=
IronPort-Data: A9a23:TUboHayQN9QOWxUun4l6t+etwirEfRIJ4+MujC+fZmUNrF6WrkUCx
 zEXWzjQOveDNGH2etp3aom0pBsA6sCHmINjHVY6pVhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefSAOCU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEAHjgmQc3l48sfrZ9Eo25amq4lv0g3RnDRx1lA+G/5UqJMlHTU2BByOQapVZGOe8W
 9HCwNmRlo8O10pF5nuNy94XQ2VSKlLgFVDmZkl+B8BOtiN/Shkaic7XAhazhXB/0F1ll/gpo
 DlEWAfZpQ0BZsUgk8xFO/VU/r0X0QSrN9YrLFDm2fF/wXEqfFP22t9uKWYdAbdfoMt7XVhK7
 M0DCjE0O0Xra+KemNpXS8Foh8I+PI/uPYgFvWpnwy2fBvEjKXzBa/yRo4AHmm5t2oYXTay2i
 8kxMVKDaDzNah1GIFYXAbo6neG1lj/6cjZCr0mSq7Zx6G/WpOB0+OG1aYWKI4XTGq25mG6V+
 XD80FTdASoXC4y+yWO68n+RnMvmyHaTtIU6T+biqqECbEeo7mgaFxQSUXOpoPyzkEf4WtRFK
 kVS9DBGhaM1/0eqZsLsWgWx5n+CpB8VHdRKe9DW8ymJy6zJ80CcB2MeSSVGZsBgv8gzLdA36
 rOXt8nwLzxKl5apczXH27vIlDerCDM3LFZXMEfoUjA5y9XkpYgyiDfGQdBiDLO5g7XJ9dfYn
 G/iQM8W2Ot7sCIb65hX62wrlN5Fm3QkZgo04BjHGGek5Rl+f4mre8qj7l2zARd8wGSxEATpU
 JsswpH2AAUy4Xelz3PlrAIlR+/B2hp9GGeA6WOD5rF4n9hXx1atfJpL/BZ1L1pzP8APdFfBO
 RCI4F0JtccDYCLyPcebhr5d7ex6nMAM8vy1B5jpgiZmPMkoKmdrAQkyOxHNhzyzzCDAb4lmY
 MbCL5j3ZZrlNUiX5GHtHbtCuVPa7iU/znnUXpf101ys1qCGDEN5up9UWGZimtsRsvjeyC2Lq
 Ik3Cid/40wDOAEISnCLqdZLRb3LRFBnba3LRzt/LbfTfVU9Qj55Vpc8A9oJIuRYokicrc+Ql
 lnVZ6OS4AOXaaTvcF3SNCJQe/n0UIxhrHk2GyUpMBz6kzIgeIujpuNXPZc+YbBtpqQpwO9WX
 ss1XZyKIs1ObTDbpBUbT53297J5eDqR2AmhAiuCYRoERaBGeTDnwNHfUzHUxHE8NRbv7coai
 J+85zzfWqsGFlhDDt6JSfeBzGGRnHk6mcBpVnSVe9R4JVnlz657IXfXkM0xGtw9c0Tf5zqF1
 jS5BQUTivnNrrQUrvjIp/GghKW4H9RuGnF1GzHg0o+3Ei3B7E+P/JRlUtvUTQvCVWjxxrquV
 d9Vw974LvcDulRA6Kh4LJpG0oM84IHJi4JB7wE5AkjOUUunOolgLlaCw8NLkK9HnZ1dmAmuX
 3Ow6stoAqqINOzlAWwuClIcNMrb7s4tmx7W8fgRC2f57nUu/LO4DGNjDyPVgylZdLZIIIcpx
 Nk6g/Ev6iu9twELN+iXhSUF5kWOKX09C58cjK84O7OyqAQXyQBlW6f+WwvW+5CEbutePnY6e
 gG0gLXwvJUC507gXUdqK13z87tzuZA8tipO7mc+HHWSu9+chvYIzBxbqjs2aQJOzyR46eF4O
 0k1FkhlPa+IwWtMgZFbbjuOBQobVRiV0RHzwQFRlUnybUqhZkrSJkITZMeP+0E49TpHXz55p
 bu39kfsYQzITurQgBQgfFFDkOPya+Bx+inputGVL+7cE7YUOTPa07KTP0wWoB7ZMOYNrUzgp
 9gy2t1vaKf+ZBUik4diB6a0jb0vGQ25fkpcSvRc/YQML2HWWBe2/ROsc0mRWMd8F8bmwH+CK
 f5FB5xwDkyl9SO0sDokK7YGIOZ0kN4X9dMyQO7XClBcgYSPjAhCkcz2zTf/tl8JUt81sMcaK
 6HtTRygPFGUp0Npnz7qkJEZFEu+OcIJdS/t7tCTqe8pLa8OgMtoUEM104a3gUmrDRtaz0qUk
 j/uN67y5M5++LtohLrpQ/liBR3rCNbdV9ao0QGUsvZVZOySaMrl6h8clX/2NV9wI4kXYslGz
 +WRkd/o3XHquKQ9fHDZlqKgSYhIx5SWd8hGPv3nKEJ1mXO5Z/btxB8Y6UWUFIdsku4B1vK4R
 gC9VtS8ReQVV/hZ2ndRTSpUSDQZNIjacYbionmbg8mXKx1AzzHCEsyrxUXpYU5faCUMHZ/0U
 S3wmvS24+FnvJZ+PwAFC95mEq1HDgfaA4V+TOLItB6cEmWMqXGBsOG7lRMftBf6OkPdG8P+u
 Z/4VhzycSqpg57xzfZbjpdTuyMGB3MskMgyeUMgo+RNsQ6YN1JfD+ohMsQhMKp2wxzCjMSyI
 HmHaWY5EizyUAhVaRi2spypQg6bAfdIIdvjYCAg+0SPcSqtGYecG/1b+zx952ttMC7WpA19x
 QryJlWrVvRw/n1oeQrXzvi6h/p3gPbbzWgP4kfzj4r5BBN27XAiyil6BAQUPcDYO5ilqakJD
 TFdqaN4rIWTTU/3DNYmfn9eAhYCuz3ziT4vaE9jBf7B7p6DwrQoJOLXYonOP35qUCjODLoPQ
 27nAW6M6HqRwXsdpe0ivNdBbWqYzx6UNpDSEZIPjjH+U019BqrL8i/CcecyoBkexTNi
IronPort-HdrOrdr: A9a23:fHhe0qtu3ZejdSdvfdo69Nay7skDVNV00zEX/kB9WHVpmwKj5q
 aTdZMgpH3JYVcqKRIdcbLpAsO9qBbnmKKdjrN+AV7PZmXbUQiTTL2Kk7GC/9SIIUSXndK1vp
 0OT0ERMqyWMXFKye2mpDSiG9wjwN6ImZrY4Nv2/jNGTAlsZa0lzyoRMHf+LqQPfng+OaYE
X-Talos-CUID: =?us-ascii?q?9a23=3AzmoIuGpS6K6+J2c3g7iUGiDmUdo8WH3461zsGQj?=
 =?us-ascii?q?iJGo1cbmMeESy+Zoxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AGQPbPg1dgRhh2Zedka+9O1ANLjUj7vu8Mm89tZY?=
 =?us-ascii?q?9tvbUFCwpBDeQsS6Ta9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="101771117"
X-MGA-submission: =?us-ascii?q?MDERaTgL9QWovPcJmtISxF+fzq7rIhoZ1e5xed?=
 =?us-ascii?q?CUm23KrDQDzXDPT8IYsJ7PvBA/xBw149CCX8a6fXXb8C281Hil5eeaBY?=
 =?us-ascii?q?jjP9pvhQ/VcTttpDOKGgIbGi7QKiUkUenp2HB6uYq5GKR/labGj+qJ8+?=
 =?us-ascii?q?8073ZjMGSrkzs8996aEA2QOA=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 15 Nov 2024 22:26:43 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id ED203206BCE3;
	Fri, 15 Nov 2024 13:26:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ED203206BCE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731706001;
	bh=YykTfzrNsiOcwK2ra+gzipuntreyDWZKmxIft/JBufs=;
	h=From:Subject:Date:To:Cc:From;
	b=WqskY8aZnBCmF3dfwxSLgVobxBO9fmOKJ8FdxV64GRKJyH+NQE4wui7qbxKlFnao4
	 BPR2hAMwYMqOqBxv5A69nRuXpaXJ0f1nikMlY5jjS8QJVhEj5FSlf1exAy6E/F7mHO
	 WumIfMdFmtWMw60hujxPTvq6hp3VaQHUHUHLjiOs=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:26:17 +0000
Message-Id: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHq8N2cC/3WNwQ6CMBAFf4X0bAlb0aSe/A/DAdqtrJEW29JgC
 P9uxRhPHmeS92ZhAT1hYKdiYR4TBXI2g9gVTPWtvSInnZmJStQAILhyNqHPPqAKPDp+I2PyA9d
 Saqjg2GkAluejR0Pzdn1pPuzxMeVC/MmeQnT+ueUTvO23dPhfSsArDrJttdrXsobufCc7zeVAy
 rvgTCyVG1izrusL3G0RRd8AAAA=
X-Change-ID: 20241112-converge-secs-to-jiffies-d99d1016bd11
To: Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>, 
 Nicolas Palix <nicolas.palix@imag.fr>, Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, 
 Russell King <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Ofir Bitton <obitton@habana.ai>, 
 Oded Gabbay <ogabbay@kernel.org>, 
 Lucas De Marchi <lucas.demarchi@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jeroen de Borst <jeroendb@google.com>, 
 Praveen Kaligineedi <pkaligineedi@google.com>, 
 Shailend Chand <shailend@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 James Smart <james.smart@broadcom.com>, 
 Dick Kennedy <dick.kennedy@broadcom.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 =?utf-8?q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Jens Axboe <axboe@kernel.dk>, Kalle Valo <kvalo@kernel.org>, 
 Jeff Johnson <jjohnson@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Jack Wang <jinpu.wang@cloud.ionos.com>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 Louis Peens <louis.peens@corigine.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, cocci@inria.fr, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-scsi@vger.kernel.org, xen-devel@lists.xenproject.org, 
 linux-block@vger.kernel.org, linux-wireless@vger.kernel.org, 
 ath11k@lists.infradead.org, linux-mm@kvack.org, 
 linux-bluetooth@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-rpi-kernel@lists.infradead.org, ceph-devel@vger.kernel.org, 
 live-patching@vger.kernel.org, linux-sound@vger.kernel.org, 
 etnaviv@lists.freedesktop.org, oss-drivers@corigine.com, 
 linuxppc-dev@lists.ozlabs.org, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Easwar Hariharan <eahariha@linux.microsoft.com>
X-Mailer: b4 0.14.2
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v2 00/21] Converge on using secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2028
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v2-0-911fb7595e79%40linux.microsoft.com>

This is a series that follows up on my previous series to introduce
secs_to_jiffies() and convert a few initial users.[1] In the review for
that series, Anna-Maria requested converting other users with
Coccinelle. This is part 1 that converts users of msecs_to_jiffies()
that use the multiply pattern of either of:
- msecs_to_jiffies(N*1000), or
- msecs_to_jiffies(N*MSEC_PER_SEC)

The entire conversion is made with Coccinelle in the script added in
patch 2. Some changes suggested by Coccinelle have been deferred to
later parts that will address other possible variant patterns.

CC: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>

[1] https://lore.kernel.org/all/20241030-open-coded-timeouts-v3-0-9ba123facf88@linux.microsoft.com/
[2] https://lore.kernel.org/all/8734kngfni.fsf@somnus/

---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20241115-converge-secs-to-jiffies-v1-0-19aadc34941b@linux.microsoft.com

---
Easwar Hariharan (21):
      netfilter: conntrack: Cleanup timeout definitions
      coccinelle: misc: Add secs_to_jiffies script
      arm: pxa: Convert timeouts to use secs_to_jiffies()
      s390: kernel: Convert timeouts to use secs_to_jiffies()
      powerpc/papr_scm: Convert timeouts to secs_to_jiffies()
      mm: kmemleak: Convert timeouts to secs_to_jiffies()
      accel/habanalabs: Convert timeouts to secs_to_jiffies()
      drm/xe: Convert timeout to secs_to_jiffies()
      drm/etnaviv: Convert timeouts to secs_to_jiffies()
      scsi: lpfc: Convert timeouts to secs_to_jiffies()
      scsi: arcmsr: Convert timeouts to secs_to_jiffies()
      scsi: pm8001: Convert timeouts to secs_to_jiffies()
      xen/blkback: Convert timeouts to secs_to_jiffies()
      gve: Convert timeouts to secs_to_jiffies()
      wifi: ath11k: Convert timeouts to secs_to_jiffies()
      Bluetooth: MGMT: Convert timeouts to secs_to_jiffies()
      staging: vc04_services: Convert timeouts to secs_to_jiffies()
      ceph: Convert timeouts to secs_to_jiffies()
      livepatch: Convert timeouts to secs_to_jiffies()
      ALSA: line6: Convert timeouts to secs_to_jiffies()
      nfp: Convert timeouts to secs_to_jiffies()

 arch/arm/mach-pxa/sharpsl_pm.c                      |  6 +++---
 arch/powerpc/platforms/pseries/papr_scm.c           |  2 +-
 arch/s390/kernel/lgr.c                              |  3 ++-
 arch/s390/kernel/time.c                             |  4 ++--
 arch/s390/kernel/topology.c                         |  2 +-
 drivers/accel/habanalabs/common/device.c            |  2 +-
 drivers/accel/habanalabs/common/habanalabs_drv.c    |  3 +--
 drivers/block/xen-blkback/blkback.c                 |  2 +-
 drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c            |  2 +-
 drivers/gpu/drm/xe/xe_device.c                      |  2 +-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c        |  6 ++----
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c |  2 +-
 drivers/net/wireless/ath/ath11k/debugfs.c           |  2 +-
 drivers/scsi/arcmsr/arcmsr_hba.c                    |  2 +-
 drivers/scsi/lpfc/lpfc_init.c                       | 18 +++++++++---------
 drivers/scsi/lpfc/lpfc_nportdisc.c                  |  8 ++++----
 drivers/scsi/lpfc/lpfc_nvme.c                       |  2 +-
 drivers/scsi/lpfc/lpfc_sli.c                        |  4 ++--
 drivers/scsi/lpfc/lpfc_vmid.c                       |  2 +-
 drivers/scsi/pm8001/pm8001_init.c                   |  2 +-
 .../vc04_services/bcm2835-audio/bcm2835-vchiq.c     |  2 +-
 fs/ceph/quota.c                                     |  2 +-
 mm/kmemleak.c                                       |  4 ++--
 net/bluetooth/mgmt.c                                |  2 +-
 net/netfilter/nf_conntrack_proto_sctp.c             | 21 ++++++++-------------
 samples/livepatch/livepatch-callbacks-busymod.c     |  2 +-
 samples/livepatch/livepatch-shadow-fix1.c           |  2 +-
 samples/livepatch/livepatch-shadow-mod.c            | 10 +++++-----
 scripts/coccinelle/misc/secs_to_jiffies.cocci       | 21 +++++++++++++++++++++
 sound/usb/line6/toneport.c                          |  2 +-
 30 files changed, 79 insertions(+), 65 deletions(-)
---
base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
change-id: 20241112-converge-secs-to-jiffies-d99d1016bd11

Best regards,
-- 
Easwar Hariharan <eahariha@linux.microsoft.com>

