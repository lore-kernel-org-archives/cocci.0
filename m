Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DFE105A595
	for <cocci@archiver.kernel.org>; Thu, 12 Mar 2026 12:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:from:cc:to:date:message-id:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=33EAGUBLBYod3tzyGg7m09477vqXsAXQIQrUfRFHjU8=;
  b=jsHGpmvSQYB2N50Hly9/uZfaWz8+scaeKDkrS7tU6i1OzRJr0gRXSVxv
   gCIQPZCjwRzhUjC8KsnQ3fm54jg8E/G+eOceDMVd2La5U1Cn1SgHwfE22
   1feq04ftvSeSfzvJy0Lgow8cOvAa+xC/Berbe6vJ1w4TtUWYa4Y0naEpR
   k=;
X-CSE-ConnectionGUID: HG8d1hnOTDKr9uNWYLvJkg==
X-CSE-MsgGUID: 9UvABceqSomT72G41fxwLA==
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
X-IronPort-AV: E=Sophos;i="6.23,116,1770591600"; 
   d="scan'208";a="267476743"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Mar 2026 13:58:38 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 6473D834A8; Thu, 12 Mar 2026 13:58:38 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 76DC780F43
	for <cocci@sympa.inria.fr>; Thu, 12 Mar 2026 00:03:38 +0100 (CET)
X-CSE-ConnectionGUID: ixGyi3HTR661BrhL2fCxjg==
X-CSE-MsgGUID: TS5fwpL8S8mNPh5t9oJ8Bw==
IronPort-SDR: 69b1f4cb_AR3bO4u1qYjFcUudwxa+hycFYibrgNejFo/FfBslD2zDPZT
 4ajM1Oq41Vg+Zuq0eD9JIafGTnMNvMeywxIEBsA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EmAwA09LFphUDyp9VagQmBUIJBgWYnDAcISYRYiHuIf?=
 =?us-ascii?q?BOcMoFVgX0CDwEDAQ1RBAEBAwEDhQACjSMCHwYBBDAJDgECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBAUBJhk8NgmIBM4IWLIELAQEBA?=
 =?us-ascii?q?gEjBBkBATcBBAsLDgwCGA4CAkYQBgESgwKCIwcjJwcBr1Z/M4EBggwBAQbcK?=
 =?us-ascii?q?oFnCRQBgQouhW+CZQGBcINqGjuEPycPgVVEgRUygng+hAo5FYNGgmmDNJMjC?=
 =?us-ascii?q?Ul4HANZLAFVExcLBwVhQhAzAyAKLy0CFA0QEg8EFgUtHXAMJxIPHRcUH1gbB?=
 =?us-ascii?q?wUSISoHgUF4gWYbD4ZoeQMuXhoOIgIoEgMyBCOBBgtaBYIsAh4DC209NwYOG?=
 =?us-ascii?q?0GObD2CMwEBgQ2CQJdEryI0B4QfgV4GDKACM6prLodlkHMiqG4xgWg6gVwzG?=
 =?us-ascii?q?iOBEgZWgUlPAxkPji0NCYNejz24KkM1PAIHCwEBAwmRajSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:YazNX6tMtkx0crq+wllZ7MgL7skDddV00zEX/kB9WHVpmwKj5q
 KTdZMguiMc6Qx9ZJhEo7q90ca7MBfhHPJOkOos1PKZMjUO21HFEGgB1/qE/9SIIUSXndK1l5
 0AT0EUMr3N5DZB/KPHCUWDYrAd/OU=
X-Talos-CUID: 9a23:PbVPx2531KJAWmtq7Nss9V47C8F+UkHnkimJCVW4LTxnY62XRgrF
X-Talos-MUID: 9a23:sRn9sQpmbP/TjdxUtOwezw1Zacl3+4D+MxAIt60G5tXVMg4gESjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,115,1770591600"; 
   d="scan'208";a="267369755"
X-MGA-submission: =?us-ascii?q?MDG5Z2Kkbazxw96LLzr/3+thJVl2DgoMvqPFkt?=
 =?us-ascii?q?DX0heQidChXLPaAOfm0DAt/OTIQLM9smgK8i/xFsYGIm23RcfAICdq98?=
 =?us-ascii?q?24Taj82TnY/dOiJEbnR7B7xMH7W4puAnKFJ7Aaqx7KWDuk7WZjttD+Hq?=
 =?us-ascii?q?LPVd1D0h4+hLnAzsTDY9ZKsA=3D=3D?=
Received: from perceval.ideasonboard.com ([213.167.242.64])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 00:03:39 +0100
Received: from monstersaurus.ideasonboard.com (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CD91E448;
	Thu, 12 Mar 2026 00:02:28 +0100 (CET)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260310-b4-is_err_or_null-v1-49-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-49-bd63b656022d@avm.de>
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
To: Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org,
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org,
	ceph-devel@vger.kernel.org, cocci@inria.fr, dm-devel@lists.linux.dev,
	dri-devel@lists.freedesktop.org, gfs2@lists.linux.dev,
	intel-gfx@lists.freedesktop.org, intel-wired-lan@lists.osuosl.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-phy@lists.infradead.org,
	lin@prod-sympa-app.inria.fr, ux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev
Date: Wed, 11 Mar 2026 23:03:33 +0000
Message-ID: <177327021364.3167621.11851238159935183684@ping.linuxembedded.co.uk>
User-Agent: alot/0.9.1
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 49/61] media: Prefer IS_ERR_OR_NULL over manual
 NULL check
Reply-To: Kieran Bingham <kieran.bingham@ideasonboard.com>
X-Loop: cocci@inria.fr
X-Sequence: 3418
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/VQ3AfrfNF4oQpFT_sgd0Kw>

Quoting Philipp Hahn (2026-03-10 11:49:15)
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>=20
> Change generated with coccinelle.
>=20
> To: Shuah Khan <skhan@linuxfoundation.org>
> To: Kieran Bingham <kieran.bingham@ideasonboard.com>
> To: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  drivers/media/test-drivers/vimc/vimc-streamer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/test-drivers/vimc/vimc-streamer.c b/drivers/me=
dia/test-drivers/vimc/vimc-streamer.c
> index 15d863f97cbf96b7ca7fbf3d7b6b6ec39fcc8ae3..da5aca50bcb4990c06f28e5a8=
83eb398606991e9 100644
> --- a/drivers/media/test-drivers/vimc/vimc-streamer.c
> +++ b/drivers/media/test-drivers/vimc/vimc-streamer.c
> @@ -167,7 +167,7 @@ static int vimc_streamer_thread(void *data)
>                 for (i =3D stream->pipe_size - 1; i >=3D 0; i--) {
>                         frame =3D stream->ved_pipeline[i]->process_frame(
>                                         stream->ved_pipeline[i], frame);
> -                       if (!frame || IS_ERR(frame))
> +                       if (IS_ERR_OR_NULL(frame))

Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

>                                 break;
>                 }
>                 //wait for 60hz
>=20
> --=20
> 2.43.0
>
