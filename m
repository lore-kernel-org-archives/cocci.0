Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E20BC5DF7D
	for <cocci@archiver.kernel.org>; Tue, 18 Aug 2026 12:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=sgaJugQQN0jFSW3/x2Ei/owejKNyTf2phr0GdBbz+Po=;
  b=TYt53zLnOrYCNaOyGJr6Pof7dGVch617N4BuPTs3kyvUTOwsGMBCkWuh
   lqvVmM/LtIm+t2eJYw7cbqcQiXknahgjJS/6M6dSsSZn6sqoJKHX2rUCw
   e96twLa/lXCVisdMaI/lM1Oe8UPWlr8bbqNNqWKRChka5UEpa9YHfsARX
   A=;
X-CSE-ConnectionGUID: q1EJVashSl+51o4/qmqiuw==
X-CSE-MsgGUID: ieAWUKx9RsWa7AofLzytAw==
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
X-IronPort-AV: E=Sophos;i="6.25,230,1779141600"; 
   d="scan'208";a="290534630"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Aug 2026 14:08:18 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id D6979812E7; Tue, 18 Aug 2026 14:08:18 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id BEED0812E7
	for <cocci@sympa.inria.fr>; Tue, 18 Aug 2026 14:08:17 +0200 (CEST)
X-CSE-ConnectionGUID: CYjMaZSYTRS4sRhcUVklEQ==
X-CSE-MsgGUID: yx6Ek282Rr+RFKjrGDxB6A==
X-IronPort-AV: E=Sophos;i="6.25,230,1779141600"; 
   d="scan'208";a="290534621"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 14:08:17 +0200
Date: Tue, 18 Aug 2026 14:08:17 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Ricardo Ribalda <ribalda@chromium.org>
cc: dmitry.torokhov@gmail.com, Julia.Lawall@inria.fr, bentiss@kernel.org, 
    cocci@inria.fr, corbet@lwn.net, hadess@hadess.net, jikos@kernel.org, 
    lains@riseup.net, linux-doc@vger.kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, nicolas.palix@imag.fr, 
    skhan@linuxfoundation.org
In-Reply-To: <20260818120428.2546810-1-ribalda@chromium.org>
Message-ID: <2a757d6-c09d-c16c-43df-fe8fab3c1b2b@inria.fr>
References: <20260803-hid-ff-input-configured-v1-2-1dc9bbacd88c@gmail.com> <20260818120428.2546810-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: re: [cocci] HID: add documentation and Coccinelle script for FF
 registration race
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3681
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/7-WqNUQ3z4NCFlyOIkZNJg>



On Tue, 18 Aug 2026, Ricardo Ribalda wrote:

> Hi Dimitry
>
> Looks like media-ci is not particularly happy about this patch:
>
> https://gitlab.freedesktop.org/linux-media/users/ribalda/-/jobs/108127901
>
> /usr/bin/spatch -D report --no-show-diff --very-quiet --cocci-file /builds/linux-media/users/ribalda/scripts/coccinelle/hid/ff_race.cocci --patch /builds/linux-media/users/ribalda --dir . -I /builds/linux-media/users/ribalda/arch/x86/include -I /builds/linux-media/users/ribalda/arch/x86/include/generated -I /builds/linux-media/users/ribalda/include -I /builds/linux-media/users/ribalda/include -I /builds/linux-media/users/ribalda/arch/x86/include/uapi -I /builds/linux-media/users/ribalda/arch/x86/include/generated/uapi -I /builds/linux-media/users/ribalda/include/uapi -I /builds/linux-media/users/ribalda/include/generated/uapi --include /builds/linux-media/users/ribalda/include/linux/compiler-version.h --include /builds/linux-media/users/ribalda/include/linux/kconfig.h --jobs 16 --chunksize 1
> Position variable r.p2 on line 20 must be attached to some other token using @.
> coccicheck failed
>
>
> The following change fixes the issue for me... but you probably want to double
> check it, I am not proficient at cocci.

I would also like to improve this, as suggested in a previous mail.
Could it be detached from the documentation change?  Then I can take this
part and fix it up.

julia

>
> diff --git a/scripts/coccinelle/hid/ff_race.cocci b/scripts/coccinelle/hid/ff_race.cocci
> index 479f5d1e3184..7cf84936db13 100644
> --- a/scripts/coccinelle/hid/ff_race.cocci
> +++ b/scripts/coccinelle/hid/ff_race.cocci
> @@ -9,7 +9,8 @@ virtual report
>
>  @r@
>  identifier probe_fn;
> -expression hdev, flags;
> +identifier hdev;
> +expression flags;
>  position p1, p2;
>  @@
>
> @@ -17,7 +18,7 @@ probe_fn(struct hid_device *hdev, ...) {
>    <...
>    hid_hw_start@p1(hdev, flags)
>    ...
> -  \(input_ff_create\|input_ff_create_memless\)@p2(...)
> +  \(input_ff_create@p2\|input_ff_create_memless@p2\)(...)
>    ...>
>  }
>
>
> Regards!
>
