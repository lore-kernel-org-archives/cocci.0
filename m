Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC6C1049522
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 09:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+zLBLQzKjcztDlxJqoLP6w+B6xnZmfHibV4jlBQCebA=;
  b=WVi6wT/dwHM4e4WWiQoc+Wv+6ncKkuiQXBvXuk/VXqkhCM93o1Jb12h2
   lm836IBLuBqCFOwKm22njzm3G4+/CK+ryTFeWScRJN3t1d03Vzkum1Env
   eW8ntEPh5V9EyQ3fvlJpJ/uIEpW2irGqX8hB8m/UxgZmnC7ARgjlkNNy+
   A=;
X-CSE-ConnectionGUID: czPVQOCNQkKC6Tdi8zOOzQ==
X-CSE-MsgGUID: BfYmacZPStWRcxqhgWOMLQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267245777"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 10:46:10 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 9B718818E2; Wed, 11 Mar 2026 10:46:09 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 0819483293
	for <cocci@sympa.inria.fr>; Wed, 11 Mar 2026 03:07:35 +0100 (CET)
X-CSE-ConnectionGUID: eZMS4uFnTs2FwCKRflBtWg==
X-CSE-MsgGUID: 4Cm5TKUxQke3oQT+7OecRQ==
IronPort-SDR: 69b0ce65_7dIdpuyOBfjAxPA1ooeehrsen/zMRMAL3d3FI9ijbOl5bcB
 yM9nkSXecG0HbbnABAjRQ5adYzhBOAwjRo/gwrg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GxAQBJzbBpgTSnVdFagQmBUIJBgWU0BAtJhFiPU4IhA?=
 =?us-ascii?q?4ETnQeBfQIPAQMBDVEEAQEDBIUAAo0jAh4HAQQwCQ4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBDQEBBQEBAQIBAQIEBgECEAEBIhkHDjuGTw2CYgGBJIEmAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBHQINfQEBAQECARIRBBkBATcBBAsLCwMKAgImAgIhEgEFARwGEyKFA?=
 =?us-ascii?q?wEGIycDoGuBAkKKQ3p/M4EBggwBAQbeEQkUAQGBCS6IVAGBcINqGoQAeicbf?=
 =?us-ascii?q?YEQgRU1gj04PoRDFYNGgmmCJoEOiQqJcyYJHQMHBw4NHkYPBRwDWSwBVRMXC?=
 =?us-ascii?q?wcFXkVDAQIBgQUjSwUtHYEjIR0XFB9YGwcFEiEqZmN4ggEPhmkBeQMuXhoOI?=
 =?us-ascii?q?gI6XEo+C1oFgkgDC2ILPTcUG0qOYz6CMwEBehSBRAemfaERhCahcjOqay6HZ?=
 =?us-ascii?q?ZBzpCKFDhEkgUQ6gVxNMAhsBoIwTwMZD44tFohxw383MjwCBwEKAQEDCZIeg?=
 =?us-ascii?q?UsBAQ?=
IronPort-PHdr: A9a23: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
 iM=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:jfwy66OE31QcOMBcTi2jsMiBIKoaSvp037B17SxMoE1uH/Bwyf
 rFoB3U726JtN93YgBfpTngAtj+fZq4z/FICOYqTM6ftWXdyQ2VxcRZnOzfKl7bakjDH4xmpN
 xdmsFFYbWaMbE5t7ef3ODSKadb/DDoytHUuc7ui1hqVh9jcKxt4kNUDQyBAlRqSAQuP/sEPa
 vZyM4CiDapZGgNYt7TPAh8Y8Hz4/PO0LzpCCR2ZCLPKzPvsdpr0tDH+tGjr3Ujbw8=
X-Talos-CUID: =?us-ascii?q?9a23=3AjIS09Wk8S5wktVi0NiAyODitPcjXOXDv6UyMPmG?=
 =?us-ascii?q?+NX0zZqK+amWe/Il4rMU7zg=3D=3D?=
X-Talos-MUID: 9a23:0AQ8dwkd+99/fVt6yCWEdno+H8I134eTGHkOnM4BgvXHagt9MA2k2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="140980477"
X-MGA-submission: =?us-ascii?q?MDEDUhrCrWox68KVXxFp1LZvULHJvoKJOpYphC?=
 =?us-ascii?q?64xPPwfXYRirB1zeo8UlCODwz2Do/qpQWMDDZVEA00RT3Bj9Qm4VJDAX?=
 =?us-ascii?q?yGOo8qte1JBAFpeU9XxpbEbWef0+18luHDeLMUODo5+S8fopzwuDRMtY?=
 =?us-ascii?q?lWMSbmfZKCO9uYBEcQ96WCbA=3D=3D?=
Received: from mail-lf1-f52.google.com ([209.85.167.52])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 03:07:34 +0100
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a13d1c6f25so4703796e87.3
        for <cocci@inria.fr>; Tue, 10 Mar 2026 19:07:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773194852; cv=none;
        d=google.com; s=arc-20240605;
        b=YlmyyfuQxKPrnQrI3ARDBEqkMIgROEKepUQU4hqqLS/4CFYjduwXPjtwRXtkv/dgPH
         6fSR7AYBb6UgK+fzoYmxLbZvvYVNThQxV2+tOEgkfZtdcFaTpbfx3dnP10R2cMihpOLw
         6H6GbrYpw+ZmkmXuHzdajwnws4Yl7yB1Aw2aDT9CLLbhBO5d14H/sog56SwnTkhKBdjI
         LjeHt1W3NwGyX8O8nuAgqlBdpJ0ZhWDdYVdK3QFix2Ng7iEGIxe301x2aR9+Qm66KgP2
         E+JqjcnIQzWhCzdY+CSlmqvm6enhA2I9fd8HSi07+eRLSw57ZM6KF6F0ImiyfJqQuZf3
         CnAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+zLBLQzKjcztDlxJqoLP6w+B6xnZmfHibV4jlBQCebA=;
        fh=/NohwpxtNglCLQpisqNlFkSP7iHkwdBUqh8Ugn4VJI4=;
        b=k+00Ijh4Msmag8OxkUOI/RzjDP1PYU76A8O7Bpq40OazbR7MdMcm3lDr/MwlmiOpaE
         wn7ztg/3JpfHZ+3RkpvoLONA3b9YYfB1ZzK6ZiXrWXOKuwv7XRRp7HSxGrmugAfPBN4S
         z7muLhvAZXOljjOTQhwKnCxcctrOggydJeuVrWlpua+1xed3pQaFbRiDQEJpRRSlSBhl
         ne7G39Vb2b27ao5e10ZGHhUNUT0Kn8oWIkkWhXDgmHGuvJ5pdUI++dWty8Zx8LYZVI70
         VWUITrAHDjC6RgZRxA3LLrthDW8+NyF7pVwHIgzF53ay7VZG19xuVky7samNPLxoH+q7
         i22g==;
        darn=inria.fr
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773194852; x=1773799652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+zLBLQzKjcztDlxJqoLP6w+B6xnZmfHibV4jlBQCebA=;
        b=Po87v5TvJYT82wb3NQOq8m3U8RiLuVCaI0/pEAgOCiYx2vJawQ70KwM1ceU1Qf+4X8
         ofeoTY2jtEzPQvQYJ5wrYbi2d2c5vtPlhCi23ow0ClubKT8qPNxeILfCiyvVb/EgoJl5
         ThHYUMKGCJbpOvSh8p5qjhyv4EeRpuCYnch1ouqCP/zCVESBbYhrJTOf9awagZWmQy9Q
         iiZmf9rYx5N3aBkCMZL6izQran6UaGLnrkZ3TykUoiaMnAAzdLe1fvySJTz0nzsVTTic
         4mFkUpK2ApAMkpvBcBW79QGZE6Ga3yY8Y/tWqcutHk5kl94OqOA1a6rIU0TCPOmIsoLq
         PZ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYytrNcP3hzQyrbAH1Vccn/vUHuzBnQ8QuUcASfm1GUEz982S6hURFoqXU5xPJtuVIuKzYLg==@inria.fr
X-Gm-Message-State: AOJu0YysVqz+JovvBKOzeuPKE5ML3AR9kRWtyuF8tN73Bi4t3zilx15i
	kIXQGUmdw7IYN/qPbhVcXvodmkHMDmsaWtaIU7owSZXYz7nq68pTQgSK56VIfb+LlCNk/xLVGHF
	wGVabgLKpFSXSHdcFcrdahJ8YhSZU9Kx6qh1MLpA8
X-Gm-Gg: ATEYQzwHlCmhz3jAdkB/cCZoMp4Dg3i62b3NdhJXuuatUtQFzQuWvoZEEKOHzo/4Zwy
	b76EOuJ9YJMkA8fXabbJtJ68XVjA/h717PoRJjYAvUkd53coJ+TMl8qYclAWgN/dDQ1mdagFq2i
	qdW++27YDYz5AArsduOmRZKE9IKXK60i1lXHZny/OjfkLf2JlzwfJdcpt+OfQ+W6mP8oTt1Hda+
	IeDPtJxHd2fSu6ffK+bMyROIcI2m0k0sUgv2mFJo8hjGnge8tryzcoo9olag9ACTA2LvYE9KO7b
	d378LfprtA==
X-Received: by 2002:ac2:4427:0:b0:5a1:3134:9bac with SMTP id
 2adb3069b0e04-5a156cbd1bbmr169453e87.28.1773194852284; Tue, 10 Mar 2026
 19:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 11 Mar 2026 11:07:21 +0900
X-Gm-Features: AaiRm5028PWt8n-JnveiRgn8oYMksdR_-_nk4JOkvxMfplWs-GDr7RRk-OxICyw
Message-ID: <CAGXv+5FQAVaJjqhv+Xq-ysOc4SHQn2mCNTgCAp8XocmWBWGGoA@mail.gmail.com>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 56/61] clk: Prefer IS_ERR_OR_NULL over manual
 NULL check
Reply-To: Chen-Yu Tsai <wenst@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 3391
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/QLyNqH-C6CrUOTGmJD5Biw>

On Tue, Mar 10, 2026 at 9:57=E2=80=AFPM Philipp Hahn <phahn-oss@avm.de> wro=
te:
>
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Semantich change: Previously the code only printed the warning on error,
> but not when the pointer was NULL. Now the warning is printed in both
> cases!
>
> Change found with coccinelle.
>
> To: Michael Turquette <mturquette@baylibre.com>
> To: Stephen Boyd <sboyd@kernel.org>
> To: Daniel Lezcano <daniel.lezcano@kernel.org>
> To: Thomas Gleixner <tglx@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  drivers/clk/clk.c               | 4 ++--
>  drivers/clocksource/timer-pxa.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 47093cda9df32223c1120c3710261296027c4cd3..35146e3869a7dd93741d10b72=
23d4488a9216ed1 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -4558,7 +4558,7 @@ void clk_unregister(struct clk *clk)
>         unsigned long flags;
>         const struct clk_ops *ops;
>
> -       if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
> +       if (WARN_ON_ONCE(IS_ERR_OR_NULL(clk)))
>                 return;
>
>         clk_debug_unregister(clk->core);
> @@ -4744,7 +4744,7 @@ void __clk_put(struct clk *clk)
>  {
>         struct module *owner;
>
> -       if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
> +       if (WARN_ON_ONCE(IS_ERR_OR_NULL(clk)))

clk_get_optional() returns NULL if the clk isn't present.

Drivers would just pass this to clk_put(). Your change here would cause
this pattern to emit a very big warning.

I don't think this change should be landed.


ChenYu

>                 return;
>
>         clk_prepare_lock();
> diff --git a/drivers/clocksource/timer-pxa.c b/drivers/clocksource/timer-=
pxa.c
> index 7ad0e5adb2ffac4125c34710fc67f4b45f30331d..f65fb0b7fc318b766227e5e7a=
4c0fb08ba11c8f9 100644
> --- a/drivers/clocksource/timer-pxa.c
> +++ b/drivers/clocksource/timer-pxa.c
> @@ -218,7 +218,7 @@ void __init pxa_timer_nodt_init(int irq, void __iomem=
 *base)
>
>         timer_base =3D base;
>         clk =3D clk_get(NULL, "OSTIMER0");
> -       if (clk && !IS_ERR(clk)) {
> +       if (!IS_ERR_OR_NULL(clk)) {
>                 clk_prepare_enable(clk);
>                 pxa_timer_common_init(irq, clk_get_rate(clk));
>         } else {
>
> --
> 2.43.0
>
>
