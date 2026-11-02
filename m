Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5023C606A32C
	for <cocci@archiver.kernel.org>; Sat,  7 Nov 2026 10:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=voPPt3Wi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:references:message-id:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=wGgrenPAGONjx3juK4qLijjOoygFzEm+H058XYYA0mw=;
  b=voPPt3WioFRk9RumpraSdoDU8sVwNiP3t/xrn9czZ2yJYde8atQ12osq
   Ksrg+apLaAzWQYeU82f2XkltZEZqmIwKnAPlZ358q2KQma9zFkip+pQnK
   rpL5UJJ49vYuX2oTJKjtPw/4aIlgPPaKrYbtdYZwiENWXmouTlI40JFuE
   o=;
X-CSE-ConnectionGUID: 2DEKAwzJRa2aFTRAJIS1Pw==
X-CSE-MsgGUID: I5IJNxShQ4+1UI9QLLuvzQ==
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
   d="scan'208";a="304323233"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2026 11:59:18 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 65FE1816C9; Sat,  7 Nov 2026 11:59:19 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id E568381811
	for <cocci@sympa.inria.fr>; Mon,  2 Nov 2026 09:52:13 +0100 (CET)
X-CSE-ConnectionGUID: +doOiikJQXKyAfLWKaQXjA==
X-CSE-MsgGUID: U0E7MJfUQP2vF9eCOqpg/Q==
IronPort-SDR: 6ae84f3c_Gl3epo9Sx4GWOwfnAo285srSN7v4PwbRh5qQMPhI3gyF/0e
 6RZ5KLEW3D9oiMrLeJl0BvcFKTEbm2oX4wvKivg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GrAQDGTuhqj/4EaaxaHQEBAQEJARIBBQUBghACgj+BC?=
 =?us-ascii?q?2EzBAtJhFiIeoZZgiSYPoQMg1ECDwEDAQ1KBwQBAQECBIR+Ao4dAh4HAQQ0E?=
 =?us-ascii?q?wECBAMCAwEBAQEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABAQEBAQE5B?=
 =?us-ascii?q?Q47hk8NSQGJSAGCBwGBJIEmAQEBAQEBAQEBAQEBHQINfgEBAQMjHQEBNwEPC?=
 =?us-ascii?q?xgCAiYCAlYGAQ0FgwIBgiIHSwMRvAiBMoEBggwBAQbcNYFrAwYVgQouhXKCb?=
 =?us-ascii?q?QGGNINIeicbgg2BPBuCaT6CQx4EGIFGFWeCYDqCMIImgQyXC1J4HANZLAFVE?=
 =?us-ascii?q?xcLBwVgRUMDKi8tI0sFLR2BIyEdDwgRHlgbBgUSICpBQ1uBGYEHXYErKWABA?=
 =?us-ascii?q?h9GLRWBdgKCUYEjXQIBSUEOB0VTCSVDEkckIggSCQETGiwLgRo1PAkmQRUMZ?=
 =?us-ascii?q?AsaBRpICAILAgx2KBEQEx0gJjAFHSYdbT03FRkEkzSESoF9NaVwoQ+EKYFni?=
 =?us-ascii?q?jyVVAQjDIFLgiYTjRSGO5MdLodmkHQjjWeVW4VfgX8jgVwzGggoCGUBgjxQA?=
 =?us-ascii?q?xkPjiIMDQmIc8lIIzUCAToCBwIHDgMLh0yKUIFMAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 ajZiF2omH2GdHM=
IronPort-HdrOrdr: A9a23:6BIY36xpHaQ952F09IaQKrPwKr1zdoMgy1knxilNoRw8SK2lfq
 eV7Y0mPH7P+VAssRQb9OxoV5PtfZqxz/FICMwqTNWftWrdyQyVxeNZnO/fKlTbckWUnNK1l5
 0QFpSWY+eRMbEVt6jHCUWDYrUd/OU=
X-Talos-CUID: 9a23:OID8h279uggIrOotQdsst0ITPcEkcV/k/FTBCkGcNkVgcY2XYArF
X-Talos-MUID: 9a23:Q9kH+gqu50SxuBAD0KYezww6GZhNwaqTMXhXj7tXtuKjLDR/fA7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,191,1787004000"; 
   d="scan'208";a="161461270"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHOpCI1IHubOqjEXEyYbwPaTo5noMUEUyUB8l?=
 =?us-ascii?q?Mv8ibPKzD8CHZBWM8k2KLEMa6tsgipaIHjC2HBLm9BhKbHP1/jeTxxCP?=
 =?us-ascii?q?qBq8nZW4UsLXZvp66f5sIhTZF+I18Fh5966ogpXcfRQftmc/6AJVkfJP?=
 =?us-ascii?q?mxO3y07YQzxCaG2hAgUTUyHg=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 09:52:12 +0100
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DAD9460EEE;
	Mon,  2 Nov 2026 08:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767291F000C1;
	Mon,  2 Nov 2026 08:52:10 +0000 (UTC)
Date: Mon, 02 Nov 2026 00:52:09 -0800
From: Kees Cook <kees@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>, Joe Perches <joe@perches.com>
CC: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, driver-core@lists.linux.dev,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 cocci@inria.fr
User-Agent: K-9 Mail for Android
In-Reply-To: <1a6026c4-3e19-a1a9-e637-f1842172482b@inria.fr>
References: <9b55b3e3269ef43ede64fff34f42121f7aa47979.camel@perches.com> <1a6026c4-3e19-a1a9-e637-f1842172482b@inria.fr>
Message-ID: <E7A57F75-AB90-4B41-B942-55D65F2B65D8@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [resend PATCH] coccinelle: Add devm_kmalloc_objs
 conversion script
Reply-To: Kees Cook <kees@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3771
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/kZNt1VBlofHA0lcEkuFQjw>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On November 1, 2026 3:51:53 PM PST, Julia Lawall <julia=2Elawall@inria=2Ef=
r> wrote:
>
>
>On Sun, 1 Nov 2026, Joe Perches wrote:
>
>> Like commit bdc5071d7f7b ("coccinelle: Add kmalloc_objs conversion scri=
pt")
>> with commit 1c7bbaeed110 ("coccinelle: kmalloc_obj: Remove default GFP_=
KERNEL arg")
>>
>> Finds and converts sized devm_kmalloc-family of allocations into the ty=
ped
>> devm_kmalloc_obj-family of allocations=2E
>
>Applied

Please don't send this=2E I already did this=2E See the PR I sent for rc1:

https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/kees/linux=2Egit/log/?=
h=3Dfor-linus/v7=2E4-rc1/devm_kmalloc_obj


--=20
Kees Cook
