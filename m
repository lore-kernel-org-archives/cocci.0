Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CBAD68BEC
	for <cocci@archiver.kernel.org>; Sat, 16 Nov 2024 11:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=8q2Y3qiG3ZOOjZQQW66Agp5RO04F9uaeWnu9irwI8zs=;
  b=T97HkEWoyfk+TCNk7H618pjMvdxxNCyFMksC9MS7CzTUsrS2DDLJ8qnf
   k5VPMc92KCfhun/SKcR7pz3csTQxYTxQwF1U9z+C0qy5Qwo3jXUfUh2mu
   DkXZtlgu4ROxaOt6ko1Tj88UIQs9eqpFx51i6V9UqjdVjYp7j1sCbu8gM
   A=;
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
   d="scan'208";a="194204453"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Nov 2024 12:26:23 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0023FE0D1D; Sat, 16 Nov 2024 12:26:22 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2D203E0133
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 23:35:31 +0100 (CET)
IronPort-SDR: 6737cca7_HJH1iS99Hxs/L9o9O6daPX75F117j9FheEW6mIWShXUJSSa
 B4ch8epFDhraapyc8ezaFvJZFW7UQcdlM8wMfLA==
X-IPAS-Result: =?us-ascii?q?A0G0BQBzzDdnckxKa5ZagQmEF4ErKzQHCEiNUocqAQEBA?=
 =?us-ascii?q?QaBQYtzlCEPAQMBCAVEBAEBAwEDhQACikwgBgEENBMBAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBEAEBBQEBAQIBAQIEBgECEAGBDIV7DYJiATOCFiwIYwEfAQEBA0ABATcBD?=
 =?us-ascii?q?wsOCi5WBhOFVRECslOBNIEBggwBAQbcH4FdBwmBSIFYhnQBhWmDfXpCfYEQg?=
 =?us-ascii?q?RWDKj6LB4JFLYRmJYh/mg1SgRcDWTIBVRMXCwcFgSkhLAOCSX+BNoFRAYMPS?=
 =?us-ascii?q?oMugV4FNwo/gkppSzcCDQI2giR9gk+FGoELg2FnLwMDAwODPIN6HUADC209N?=
 =?us-ascii?q?RQboElGgzUxSplEAa92hCShQxozqk6Yd6kngX4jgVxNHxmDIk8DGQ+QVcdXM?=
 =?us-ascii?q?jI7AgcLAQEDCY9XgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:YaPNRqpXQ4tgO56DwT2UHCsaV5o8eYIsimQD101hICG9vPb3qy
 nOpoV+6faQsl0ssR4b9OxoVJPtfZqYz+8X3WBzB8bGYOCFgguVxehZhOOJ/9SjIVydygc378
 ZdmsZFZ+HNMQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AwJlPu2pjc5mWt+xBS8d95SvmUds/fizFy3b9Gl2?=
 =?us-ascii?q?bMXRYTealVlzLwKwxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AUI3FnQ6q3DUR5im84VT+ofRtxox0wbXyGB5dia4?=
 =?us-ascii?q?JtuCNPAgoIRaMohCoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,158,1728943200"; 
   d="scan'208";a="194169049"
X-MGA-submission: =?us-ascii?q?MDEz507DaD3pRn0fxiJl18xu5U9QqADvnKooN3?=
 =?us-ascii?q?jecvSAHAcDUYixcwCLcd+UbcUHd6lBKo2twVKFDCm6v5jyGLDLf2yE36?=
 =?us-ascii?q?Blo+GE0Pr4gPZyVklbQTaJD5iy2ChQkorAz/JQL3h3uhb5s8UMu9phGk?=
 =?us-ascii?q?Gwav9R09qVNkS9OXr8jIlxOw=3D=3D?=
Received: from gandalf.ozlabs.org (HELO mail.ozlabs.org) ([150.107.74.76])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 23:35:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1731710109;
	bh=8q2Y3qiG3ZOOjZQQW66Agp5RO04F9uaeWnu9irwI8zs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TBKjQ+jwynGqippSpjmesy2LJHz5G28IT7vT4TaT88JCuw46fBO3BDRAIPv6hRM7/
	 XbOWv6yTpIGUBOHVpD+GgH5bOcDzYCKCOUCxtFJITpudgYieUI+GdoU8psZqrHYs9B
	 plWGzIOASib2U9DXo1e9xJXfQHkgKNH8Cirh/o/LRzKV85o+Cp3r3eBc9AZ3AQZa0F
	 DYP1RPyQiMfC70ZKaMZkgpPnHyLFqXq1SQIh8oIfiAurmRjt4FWX01yMlsvyocz2uk
	 oad7uD2rsh8nj5e0aZSH5jUluHbC7REOnBIrLNo1QEsXfDYgF3levquGraIQNcBhLm
	 5y9gdjsr1Cmwg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XqsKD5FnLz4x3p;
	Sat, 16 Nov 2024 09:34:56 +1100 (AEDT)
Date: Sat, 16 Nov 2024 09:34:58 +1100
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
Message-ID: <20241116093458.4aa19a0e@canb.auug.org.au>
In-Reply-To: <20241115-converge-secs-to-jiffies-v2-1-911fb7595e79@linux.microsoft.com>
References: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
	<20241115-converge-secs-to-jiffies-v2-1-911fb7595e79@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gpyLfQXA_rG=N5QDCu3kL6w";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 01/21] netfilter: conntrack: Cleanup timeout
 definitions
Reply-To: Stephen Rothwell <sfr@canb.auug.org.au>
X-Loop: cocci@inria.fr
X-Sequence: 2056
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241116093458.4aa19a0e%40canb.auug.org.au>

--Sig_/gpyLfQXA_rG=N5QDCu3kL6w
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Easwar,

On Fri, 15 Nov 2024 21:26:18 +0000 Easwar Hariharan <eahariha@linux.microso=
ft.com> wrote:
>
>  static const unsigned int sctp_timeouts[SCTP_CONNTRACK_MAX] =3D {
> -	[SCTP_CONNTRACK_CLOSED]			=3D 10 SECS,
> -	[SCTP_CONNTRACK_COOKIE_WAIT]		=3D 3 SECS,
> -	[SCTP_CONNTRACK_COOKIE_ECHOED]		=3D 3 SECS,
> -	[SCTP_CONNTRACK_ESTABLISHED]		=3D 210 SECS,
> -	[SCTP_CONNTRACK_SHUTDOWN_SENT]		=3D 3 SECS,
> -	[SCTP_CONNTRACK_SHUTDOWN_RECD]		=3D 3 SECS,
> -	[SCTP_CONNTRACK_SHUTDOWN_ACK_SENT]	=3D 3 SECS,
> -	[SCTP_CONNTRACK_HEARTBEAT_SENT]		=3D 30 SECS,
> +	[SCTP_CONNTRACK_CLOSED]			=3D secs_to_jiffies(10),
> +	[SCTP_CONNTRACK_COOKIE_WAIT]		=3D secs_to_jiffies(3),
> +	[SCTP_CONNTRACK_COOKIE_ECHOED]		=3D secs_to_jiffies(3),
> +	[SCTP_CONNTRACK_ESTABLISHED]		=3D secs_to_jiffies(210),
> +	[SCTP_CONNTRACK_SHUTDOWN_SENT]		=3D secs_to_jiffies(3),
> +	[SCTP_CONNTRACK_SHUTDOWN_RECD]		=3D secs_to_jiffies(3),
> +	[SCTP_CONNTRACK_SHUTDOWN_ACK_SENT]	=3D secs_to_jiffies(3),
> +	[SCTP_CONNTRACK_HEARTBEAT_SENT]		=3D secs_to_jiffies(3),

You have changed this last timeout from 30 seconds to 3 (presumably
just a copy and paste error).

--=20
Cheers,
Stephen Rothwell

--Sig_/gpyLfQXA_rG=N5QDCu3kL6w
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmc3zJIACgkQAVBC80lX
0Gw+jggAlx/FpdCsBUGWHj/3D1FyMKcJOE8x+VIKqw9c10Hqa/DPZEAcUaXlmvJJ
1NS+WrDFLS34ZiI4SbtosexC7tobHh/TkpamqrN+fG8STjNbtTVLYQ8QiWT/NCDx
IeMkpH/EiSg0ow+0U1XenGHORnkKPdtLr7lxlRq1R7ylUYNZK0eDlX4r2dwmOLYg
r0lFld/TwA434BDqTqj8KzVt9p1k2QiHm+LUntdk7Xu/Rlami4y/+Bahn9gmN3ji
wRFxXLzm6upqhGxP5RYNyz3FB0oQgUvILDpklyPzzLTZW+L+bPkhgY5RZTFXpk9k
KeR+GZcOjbCNU/RaWT8zDXVC32LJaw==
=DzpI
-----END PGP SIGNATURE-----

--Sig_/gpyLfQXA_rG=N5QDCu3kL6w--
