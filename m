Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36E5C3DA7F
	for <cocci@archiver.kernel.org>; Mon,  5 Aug 2024 08:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Q6pxxYKVn828W28CrgulH/cwYYXkUidqHVVt3F9dkj8=;
  b=RvyGVCMO39YQjTxoIzkKa3Ljmifuty3iREZcb2YI54Ebw978cCLQSBnU
   9O1r0vdabWXeXC3mbz+DJkv6XHahGeQsCjlpXsrn42n3Qdv+B/VgXFgDD
   y5mV3drBPVGvRF6zlsoJV1vDy7ampm5ihgDIos4FHwXxMEuqiuFVvdMP7
   w=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.09,264,1716242400"; 
   d="scan'208";a="178115056"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Aug 2024 10:56:04 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EB2A4E0133; Mon,  5 Aug 2024 10:56:03 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 86710E0035
	for <cocci@sympa.inria.fr>; Mon,  5 Aug 2024 10:55:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Q6pxxYKVn828W28CrgulH/cwYYXkUidqHVVt3F9dkj8=;
  b=omm9Nz82TEXoAi008GNHXRF0zzNz8ONu5Uvv1YkDmj/F8ZKV8Ia3l1Q0
   wodFfBAyjQbGwEYQBbgDKCZVTbKJpGzZvRmIRC6hLBGc4Ed59SssIk9ZI
   3jAxoFfbX4OK8Pe3Irw7Mc5/flOAn9AH9H98vexgB9nsiCE8GF78I8z/b
   U=;
X-IronPort-AV: E=Sophos;i="6.09,264,1716242400"; 
   d="scan'208";a="178115050"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 10:55:59 +0200
Date: Mon, 5 Aug 2024 10:55:59 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Ricardo Ribalda <ribalda@chromium.org>
cc: cocci@inria.fr
In-Reply-To: <CANiDSCvmboKBK=Z7uS9tnN_LcPA16rx0j_iWeEoQ=jO+pEgLiA@mail.gmail.com>
Message-ID: <c67dba3-db9c-8ba3-772c-6efc1d69205@inria.fr>
References: <CANiDSCvmboKBK=Z7uS9tnN_LcPA16rx0j_iWeEoQ=jO+pEgLiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Cocci MUCH more slow after 6.11
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1831
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-08/c67dba3-db9c-8ba3-772c-6efc1d69205%40inria.fr>



On Mon, 5 Aug 2024, Ricardo Ribalda wrote:

> Hi
>
> Our CI went from 5:40
>
> https://gitlab.freedesktop.org/linux-media/media-staging/-/pipelines/1225915/test_report?job_name=static-upstream
>
> to 42:13
>
> https://gitlab.freedesktop.org/linux-media/media-staging/-/pipelines/1235432/test_report?job_name=static-upstream
>
> We launch cocci this way:
>
> make coccicheck M="$dir" MODE=report
>
> Is this something expected? Or shall I investigate at my side of the cable?

Thanks for the report.  Could you try adding the V=1 option, to get a
litte more information about where it is getting stuck?

thanks,
julia
