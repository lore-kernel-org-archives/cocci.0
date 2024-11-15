Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E916D68BDE
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:cc:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=OEAxYqndmV97fB2t7JocLL7u1S4ql6E8JdtDlfM98mA=;
  b=VimCwBSJ5HdmZi6GwbzuhyUT3lZVxIwgNoQVpCc0c1TDOLDKanIWAUbO
   gh48+iqqFHm9rQE7GP2MstH54uFVVkl8rRkH+95fCC/XEpsQDpreZYiYZ
   w5lGCTwAAZzPwaQNf8pK686SFE0M/e1CHd/89k0GQDu1Mc8aRuXdI+3ki
   Y=;
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
   d="scan'208";a="194170258"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:36:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8213EE0E2C; Fri, 15 Nov 2024 23:36:04 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 78293E00B7
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:34:51 +0100 (CET)
IronPort-SDR: 6737be7b_EH0gPEKQIyB+pXEaLFLGNVUy21qoU/xH+jaf+O+BmHJkjU5
 0hRzxb7XfFiurgNTfYJUsWchgZD+3mBjlrn+JfQ==
X-IPAS-Result: =?us-ascii?q?A0EhAADcvDdncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYIbKH1aMwcISASEUogdiVEDi3OQTYFWgUA+DwEDAUgGAQIEAQEDB?=
 =?us-ascii?q?IUAAopLAh8GAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AGBDIV7DYJiAYEkUQ1IAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEQINXgEBH?=
 =?us-ascii?q?gEBAQMREh0BATcBDwsOCgICJgICVgYBEgIBAYJ4BAEBgjADMQMDAgwGn0ABh?=
 =?us-ascii?q?2ABAQKLI4EygQGCDAEBBtwfgWQDBoEaLgGBYYZqAYVpGyCEPCcbgUlEgTwLA?=
 =?us-ascii?q?4J1PoRYg0aCaYJFLYRmJU1Gh2yHOgKEW41sUnscA1khEQFVExcLBwWBKREQL?=
 =?us-ascii?q?AMib2pOf4E2gVEBQYJOLxshC1yBKX0dFAYVBIEOBTcKP4JKaUs3Ag0CNoIkJ?=
 =?us-ascii?q?FmBHYEygSUEBYNsgQuDYWcvAwMDA4M8gk5kOh1AAgELbT01BgMLG0OffQFGh?=
 =?us-ascii?q?G5QIx40ORUBH6Rea6EAhCSMFpUyBg8EL4QEjQKGTo8tg00uh2SQZSKLZYF4m?=
 =?us-ascii?q?neCGDoQgUxGByMVgyJPAxkPjiGBLgEIgkOFFIoqAbY/IjUCAQgwAgcLAQEDC?=
 =?us-ascii?q?YVGAQGKD4FLAQE?=
IronPort-PHdr: A9a23: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
 F+mho9gPHt8p079ZLa0mj0=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:94KTJqBOK5pWNrXlHemc55DYdb4zR+YMi2TDGXoQdfUnSL39qy
 nIpoVi6faUskdpZJlD8errBEDkex7hHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8KT0E9MqyUMbEQt7eY3ODXKadD/DDKysGVuds=
X-Talos-CUID: 9a23:1577cmH2xKK3FwdtqmI2yR83QtEia0TX0UXhOXOdSkp0RoeaHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AZHM9aAzi7e3Tm8mSzbZ6642LmRmaqPyrKUkJt44?=
 =?us-ascii?q?kh+3HPG9TNSyZgiroSaZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="194166371"
X-MGA-submission: =?us-ascii?q?MDE5P9wJjd8y7TWj2xfpZm1GUvyU4KJwTgKnDY?=
 =?us-ascii?q?mJdgUgqSj0O1i9TB7uDAVgKbgYjW+wRaAGU8irqiCaJU6G8i96siaIBi?=
 =?us-ascii?q?cf0UKDyUfCWerWGwlW7OE4iFa64+C/kB/iMrrznmoI0xggIIEZmBzWwU?=
 =?us-ascii?q?4GHNslqE0nK+mW9EDiLaoilQ=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 15 Nov 2024 22:34:50 +0100
Received: from [192.168.35.166] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id 684CD2064AE8;
	Fri, 15 Nov 2024 13:34:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 684CD2064AE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731706489;
	bh=OEAxYqndmV97fB2t7JocLL7u1S4ql6E8JdtDlfM98mA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Xurk/K9NZ4Pt7R0qwaS9VSYSKCTMSaNp/aapEsQZCtIT74ft5tvctXWuFivs3Zswx
	 hrelPOn+ppZ3FOsJiI+79MeaWo7lX97CMgyLO8+gyOebFfO+/iJc5GjxBT3U1ILKzl
	 NFamFr9+2AnMiAp4lQnkRWbNDRlCI9FqXsyeg14c=
Message-ID: <ae1f83c3-88fe-4b75-9446-e7e711b954ae@linux.microsoft.com>
Date: Fri, 15 Nov 2024 13:34:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, cocci@inria.fr,
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
 <anna-maria@linutronix.de>, Michael Kelley <mhklinux@outlook.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, Daniel Mack <daniel@zonque.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Russell King
 <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Ofir Bitton <obitton@habana.ai>,
 Oded Gabbay <ogabbay@kernel.org>, Lucas De Marchi
 <lucas.demarchi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
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
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Jens Axboe <axboe@kernel.dk>, Kalle Valo <kvalo@kernel.org>,
 Jeff Johnson <jjohnson@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Jack Wang <jinpu.wang@cloud.ionos.com>, Marcel Holtmann
 <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Xiubo Li <xiubli@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Louis Peens <louis.peens@corigine.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20241115-converge-secs-to-jiffies-v1-0-19aadc34941b@linux.microsoft.com>
 <20241115-converge-secs-to-jiffies-v1-22-19aadc34941b@linux.microsoft.com>
 <e1ff4b71-7abf-4ac6-8b82-86aad5394de6@quicinc.com>
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <e1ff4b71-7abf-4ac6-8b82-86aad5394de6@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH 22/22] jiffies: Define secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2051
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/ae1f83c3-88fe-4b75-9446-e7e711b954ae%40linux.microsoft.com>

On 11/15/2024 1:30 PM, Jeff Johnson wrote:
> On 11/15/2024 1:22 PM, Easwar Hariharan wrote:
>> secs_to_jiffies() is defined in hci_event.c and cannot be reused by
>> other call sites. Hoist it into the core code to allow conversion of the
>> ~1150 usages of msecs_to_jiffies() that either:
>>
>>  - use a multiplier value of 1000 or equivalently MSEC_PER_SEC, or
>>  - have timeouts that are denominated in seconds (i.e. end in 000)
>>
>> It's implemented as a macro to allow usage in static initializers.
>>
>> This will also allow conversion of yet more sites that use (sec * HZ)
>> directly, and improve their readability.
>>
>> Suggested-by: Michael Kelley <mhklinux@outlook.com>
>> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Reviewed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> Link: https://lore.kernel.org/all/20241030-open-coded-timeouts-v3-1-9ba123facf88@linux.microsoft.com
> 
> your signed-off-by should be last.
> 
> and you have a patch ordering problem since this patch must come before all
> the patches that use secs_to_jiffies(), otherwise this series cannot be bisected

Thanks for the quick response, indeed this patch is already in tip[1], I
pulled it in for testing the series but missed out on removing it before
sending. Please review v2 that excludes this:
https://lore.kernel.org/all/20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com/

[1]: https://git.kernel.org/tip/b35108a51cf7bab58d7eace1267d7965978bcdb8

Thanks,
Easwar
