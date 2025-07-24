Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4AE8C83F1A
	for <cocci@archiver.kernel.org>; Thu, 24 Jul 2025 14:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=9bmT/++sLa039glPjZ27kAjuVByGnJT3fTy33aavGLg=;
  b=f/WvXevQG4gfCsoHtrdkOINuekSjhaLGFQ7HU/d9DALAcPXZaGiFpC1u
   atpnthIXlV16XiOiYbscxhHQjeHLm6L1yROqec5/svUJlcPbC23KgP0hk
   Ltc99FWYlYsM4i8DE2vajQJ381jzJnsNLA9SO3s4giTWs1OIsWqrj3Itj
   I=;
X-CSE-ConnectionGUID: fKB7sB1ZTqKUbvUZOVWnow==
X-CSE-MsgGUID: rtyJB+cvRgaf2OqiNvV3dA==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.16,337,1744063200"; 
   d="scan'208";a="233010846"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2025 16:47:40 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 274ADE0C55; Thu, 24 Jul 2025 16:47:40 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E3B4CE0171
	for <cocci@sympa.inria.fr>; Thu, 24 Jul 2025 16:47:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9bmT/++sLa039glPjZ27kAjuVByGnJT3fTy33aavGLg=;
  b=Kvl/IWN6a3jkRzRO2FWhol1kjPUCbpAbuz69At9ISoAeNWbGPDRCWnxR
   3Zvn81r+R7+JXKkfNYWQaSkOYesSqVE0JVvm1ZxO5fPQUijvIvg4S1R7H
   QxvSxqba37GwyfjfRKFZxiXpEGhxaMQIJhcCXSmfCbpYQAf/sNAyyF/CA
   c=;
X-CSE-ConnectionGUID: 143HF9mvSbuu84un002mpQ==
X-CSE-MsgGUID: ImWWN4oWQxiha6MFatn0pg==
X-IronPort-AV: E=Sophos;i="6.16,337,1744063200"; 
   d="scan'208";a="233010839"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 16:47:35 +0200
Date: Thu, 24 Jul 2025 16:47:34 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Erick Karanja <karanja99erick@gmail.com>
In-Reply-To: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
Message-ID: <fc1427ca-c2a6-4c12-a8d9-c8c692f1544a@inria.fr>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-204080335-1753368454=:3509"
Subject: Re: [cocci] Searching for questionable call pairs (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2908
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/fc1427ca-c2a6-4c12-a8d9-c8c692f1544a%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-204080335-1753368454=:3509
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 23 Jul 2025, Markus Elfring wrote:

> Hello,
>
> I noticed another contribution.
>
> I got into the mood to construct another script for the semantic patch language.
>
>
> // See also:
> // [PATCH v4] ALSA: usb-audio: qcom: Adjust mutex unlock order
> // https://lore.kernel.org/linux-sound/20250721114554.1666104-1-karanja99erick@gmail.com/
> @display@
> expression x, y;
> @@
> *mutex_lock(x);
>  ...
> *mutex_lock(y);
>  <+...
> *mutex_unlock(x);
>  ...
> *mutex_unlock(y);
>  ...+>

* just highlights lines when there is a match.  Theer can be several
possible matches.  In that case, the union of the relevant lines will be
highlighted.

julia

>
>
> Questionable test result (by the software combination “Coccinelle 1.3.0” for example):
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> git checkout next-20250722 && time /usr/bin/spatch --no-loops …/Projekte/Coccinelle/janitor/show_questionable_unlock_call_order.cocci sound/usb/qcom/qc_audio_offload.c
> …
> @@ -1580,7 +1576,6 @@ static void handle_uaudio_stream_req(str
>                 goto response;
>         }
>
> -       mutex_lock(&chip->mutex);
>         if (req_msg->enable) {
>                 if (info_idx < 0 || chip->system_suspend || subs->opened) {
>                         ret = -EBUSY;
> @@ -1613,9 +1608,7 @@ static void handle_uaudio_stream_req(str
>                         ret = prepare_qmi_response(subs, req_msg, &resp,
>                                                    info_idx);
>                 if (ret < 0) {
> -                       mutex_lock(&chip->mutex);
>                         subs->opened = 0;
> -                       mutex_unlock(&chip->mutex);
>                 }
>         } else {
>                 info = &uadev[pcm_card_num].info[info_idx];
> @@ -1646,9 +1639,7 @@ static void handle_uaudio_stream_req(str
>                 }
>
>                 disable_audio_stream(subs);
> -               mutex_lock(&chip->mutex);
>                 subs->opened = 0;
> -               mutex_unlock(&chip->mutex);
>         }
>
>  response:
> @@ -1662,7 +1653,6 @@ response:
>                 if (atomic_read(&uadev[pcm_card_num].in_use))
>                         kref_put(&uadev[pcm_card_num].kref,
>                                  uaudio_dev_release);
> -               mutex_unlock(&chip->mutex);
>         }
>         mutex_unlock(&qdev_mutex);
>
> …
> real    0m0,501s
> user    0m0,460s
> sys     0m0,035s
>
>
> Now I wonder how these diff hunks fit to my source code search approach
> for finding call pairs of known functions (or macros).
> Will another clarification become more interesting?
>
> Regards,
> Markus
>
--8323329-204080335-1753368454=:3509--
