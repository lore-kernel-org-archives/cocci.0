Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF52D68BEA
	for <cocci@archiver.kernel.org>; Sat, 16 Nov 2024 11:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=2Oo8tuThL69UywoHNtNWphGeN1l/Ks7ZdfhLn6nu8Ts=;
  b=WWHTFEkfwmGCOSWw21B/uyo6/KSVWx1djQRqZpQVrZCp+gDL8N/c86vk
   WqxHTLT9QU7RNNTYA/SB7rlZwr7X+KyW5YGxlL8BsR4n/SyjnjxnCHUAs
   j2F82m9SeAQcPlK5tBGjbF8D9O/rpNtwCb+r8kRQXlU4Q3NIbeBy2X73S
   8=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@canb.auug.org.au
X-IronPort-AV: E=Sophos;i="6.12,159,1728943200"; 
   d="scan'208";a="194204496"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Nov 2024 12:26:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CEBD6E0D44; Sat, 16 Nov 2024 12:26:23 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 928B2E013D
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 23:38:26 +0100 (CET)
IronPort-SDR: 6737cd61_xtLv8rUvcsMa/WSO05guWhbakM3jSyyligk9eUgh9RRkjBV
 sWs2171TajYHE4FYtsOzHPQD0sjdR3pNfZS6/fQ==
X-IPAS-Result: =?us-ascii?q?A0G0BQD7yzdnckxKa5ZagQmEF4ErKzQHCEiNUocqAQEBA?=
 =?us-ascii?q?QaBQYtzlCEPAQMBCAVEBAEBAwEDhQACikwgBgEENBMBAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBEAEBBQEBAQIBAQIEBgECEAGBDIV7DYJiATOCFiwIYwEfAQEBA0ABATcBD?=
 =?us-ascii?q?wsOCi5WBhOFVRECslWBNIEBggwBAQbcH4FdBwmBSIFYhnQBhWmDfXpCfYEQh?=
 =?us-ascii?q?D8+iweCRYUTJQyIc5oNUoEXA1kyAVUTFwsHBYEpISwDgkl/gTaBUQGDD0qDL?=
 =?us-ascii?q?oFeBTcKP4JKaUs3Ag0CNoIkfYJPhRqBC4NhZy8DAwMDgzyDeh1AAwttPTUUG?=
 =?us-ascii?q?6BJRp10Aa92hCShQxozqk4uh2SQZaNZhU6BfiOBXE0fGYMiTwMZD5BVx1UyM?=
 =?us-ascii?q?jsCBwsBAQMJj1eBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:nTq/5aNtd1QOHsBcTtajsMiBIKoaSvp037Dk7S5MoH1uA6ilfq
 WV98jzuiWYtN98Yh0dcJW7Scq9qBDnhPtICOsqXYtKNTOO0AGVxcNZnOnfKlbbehEWmNQz6Z
 td
X-Talos-CUID: =?us-ascii?q?9a23=3A35deoGiE0JKj3uU49ws4WTReuDJuaSbBwlzNYGm?=
 =?us-ascii?q?DKWd5dbyNDlqMob9Nqp87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AIWdErg2KWHcNXprQ8BUy8q66zjUj2o6qJ1tSuLE?=
 =?us-ascii?q?9t9CBFjBcZxCavi2ae9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,158,1728943200"; 
   d="scan'208";a="101773043"
X-MGA-submission: =?us-ascii?q?MDF5lJgQMPUyE1JUHQTCYjvWROxdRdx8SjA4QE?=
 =?us-ascii?q?UVsPf/foGlErkA5TCh6gYzJ1pHq1JD2xYIA5oMPitrKfEiP0dtLugtA/?=
 =?us-ascii?q?+mbXaNb01QlJC2KbxaIly1aWa4Kuulpf87Pw9vt2hTTxmNV7QXhN+Z6f?=
 =?us-ascii?q?kGWcRe302JoyZ09blyxaQ9Uw=3D=3D?=
Received: from gandalf.ozlabs.org (HELO mail.ozlabs.org) ([150.107.74.76])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 23:38:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1731710297;
	bh=2Oo8tuThL69UywoHNtNWphGeN1l/Ks7ZdfhLn6nu8Ts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dvqBU9n8wyesGOM7wAJUVL4V50umalSR9AGyHvO50R9rHL4dRlvqV2fKiGIxclon7
	 dHEpXPpW9NVhcbFtMBHzRNkcGVSkeVB/y2szbGMNYINCZkHzmLDf1115Jxe24OTeOk
	 GNv8daj8Y6W/lBqt6k/toExNrcSvGF2/nzg0QTmOQX9jzDpl13KzERpvnsypqwk14l
	 Jr2Y6hhhHGQcduaub5tIB8ldj0pYnhXmYJw4zK368Q9lExm0iQorTgylYyIdDuEGMp
	 WagrfQz4Kwg8LTMJpR3GyN8L1t3g91kYKCDixQ+vf1WORv4sLKKi8JfCCFjRz+Eeni
	 +eMZUx+2BK6mA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XqsP22nY1z4x8v;
	Sat, 16 Nov 2024 09:38:14 +1100 (AEDT)
Date: Sat, 16 Nov 2024 09:38:15 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik
 <kadlec@netfilter.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Julia Lawall
 <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Daniel Mack
 <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert
 Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Ofir
 Bitton <obitton@habana.ai>, Oded Gabbay <ogabbay@kernel.org>, Lucas De
 Marchi <lucas.demarchi@intel.com>, Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?=
 <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Shailend Chand <shailend@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 James Smart <james.smart@broadcom.com>, Dick Kennedy
 <dick.kennedy@broadcom.com>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Roger Pau =?UTF-8?B?TW9ubsOp?=
 <roger.pau@citrix.com>, Jens Axboe <axboe@kernel.dk>, Kalle Valo
 <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Jack
 Wang <jinpu.wang@cloud.ionos.com>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Xiubo
 Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes
 <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, Joe Lawrence
 <joe.lawrence@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Lucas Stach <l.stach@pengutronix.de>, Russell King
 <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Louis Peens <louis.peens@corigine.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao
 <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
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
 linuxppc-dev@lists.ozlabs.org, Anna-Maria Behnsen
 <anna-maria@linutronix.de>
Message-ID: <20241116093815.5d37eb43@canb.auug.org.au>
In-Reply-To: <20241115-converge-secs-to-jiffies-v1-3-19aadc34941b@linux.microsoft.com>
References: <20241115-converge-secs-to-jiffies-v1-0-19aadc34941b@linux.microsoft.com>
	<20241115-converge-secs-to-jiffies-v1-3-19aadc34941b@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4rVE82Kt6y+3_PbwMmwogMj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH 03/22] arm: pxa: Convert timeouts to use
 secs_to_jiffies()
Reply-To: Stephen Rothwell <sfr@canb.auug.org.au>
X-Loop: cocci@inria.fr
X-Sequence: 2057
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241116093815.5d37eb43%40canb.auug.org.au>

--Sig_/4rVE82Kt6y+3_PbwMmwogMj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Easwar,

On Fri, 15 Nov 2024 21:22:33 +0000 Easwar Hariharan <eahariha@linux.microso=
ft.com> wrote:
>
> -#define SHARPSL_CHARGE_ON_TIME_INTERVAL        (msecs_to_jiffies(1*60*10=
00))  /* 1 min */
> -#define SHARPSL_CHARGE_FINISH_TIME             (msecs_to_jiffies(10*60*1=
000)) /* 10 min */
> -#define SHARPSL_BATCHK_TIME                    (msecs_to_jiffies(15*1000=
))    /* 15 sec */
> +#define SHARPSL_CHARGE_ON_TIME_INTERVAL        (secs_to_jiffies(60))  /*=
 1 min */
> +#define SHARPSL_CHARGE_FINISH_TIME             (secs_to_jiffies(10*60)) =
/* 10 min */
> +#define SHARPSL_BATCHK_TIME                    (secs_to_jiffies(15))    =
/* 15 sec */

It might be nice to keep the alignment of the comments here.

--=20
Cheers,
Stephen Rothwell

--Sig_/4rVE82Kt6y+3_PbwMmwogMj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmc3zVcACgkQAVBC80lX
0GyUXgf+Ii9yOHf1vRadjfzExIFyJR4I0mG1VXDEBH24ASdL/jVIFlfW31h/JIe9
7JJFAL5Aa+C8Xw22mmq/8e0wbWCe+DqEq+SLtggkTN8kHtwf7Glda0a/aIix0pNM
s9nQXwrTFFvaCt2ocRmPUcm7K/jwiG3YxWawYBvIoSF9l/TfQXwD4LBbP2glFEL2
BkTvGG0/asLCHZK2LHwDsWsZ5XskgJmmQfbYEdygcm9C3bP40tFYUM22B6iEYNez
WKquyY7lAmwUJQsIAWZig/PKPz8e6uux6ghIdGbwFC0ezQqIOAz8ZqllWy1Dpa87
vCjZSu4lRCFBg5npBBL5wIOagKFSCw==
=vmyn
-----END PGP SIGNATURE-----

--Sig_/4rVE82Kt6y+3_PbwMmwogMj--
