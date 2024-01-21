Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25464C47422
	for <cocci@archiver.kernel.org>; Sun, 21 Jan 2024 11:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=UWN54G8DcZhwd8CcYCFZ1mep8750dTOYSTQEJt94oPc=;
  b=mqm0hl5g5rFfzwrmM9PvmzfT2R9nJfErD2959sn5SV5w/ZKqKQ77gLwN
   H+vHh2sYolYIB6oncAdgQegQfSCEkkhxa9693s+TQ/9sXTWZdG6OT6TMG
   tZt+J91uwvmnTs+3Yj/rfS7fq1d+INpVk7Xm9S0tYnKrr/0jeLZKQmuw0
   4=;
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
X-IronPort-AV: E=Sophos;i="6.05,209,1701126000"; 
   d="scan'208";a="147776711"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jan 2024 12:00:03 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C7D38E008A; Sun, 21 Jan 2024 12:00:02 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 35CCBE0035
	for <cocci@sympa.inria.fr>; Sun, 21 Jan 2024 12:00:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UWN54G8DcZhwd8CcYCFZ1mep8750dTOYSTQEJt94oPc=;
  b=pNUlJpFoM8WUIuaolUNsU5Nq6sK9B4liqDlyzJOIsDTh2M0+7139ZDf4
   +9HohTrYH2FXLvQ+ikHA1Ub1rLTVaacZMuO94GJ30VRjoyVvKTiobSGcH
   sLu1+D5MtTjtfxl8iiCrKtpuWtH3C2J/xqFv4EA9a33gyC6zrWhCK5S3A
   U=;
X-IronPort-AV: E=Sophos;i="6.05,209,1701126000"; 
   d="scan'208";a="147776685"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 12:00:01 +0100
Date: Sun, 21 Jan 2024 12:00:00 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Li Zhijian <lizhijian@fujitsu.com>, cocci@inria.fr, 
    LKML <linux-kernel@vger.kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>
In-Reply-To: <f34231dc-186b-4cb9-889b-b3be9224c5a9@web.de>
Message-ID: <alpine.DEB.2.22.394.2401211159350.3743@hadrien>
References: <20240119062057.4026888-1-lizhijian@fujitsu.com> <alpine.DEB.2.22.394.2401202217550.3267@hadrien> <f34231dc-186b-4cb9-889b-b3be9224c5a9@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [v2] coccinelle: device_attr_show: Adapt to the latest
 Documentation/filesystems/sysfs.rst
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1461
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/alpine.DEB.2.22.394.2401211159350.3743%40hadrien>



On Sun, 21 Jan 2024, Markus Elfring wrote:

> > I subsequently simplified the patch case to contain the following:
> >
> > -              snprintf(BUF, SZ, FORMAT
> > +              sysfs_emit(BUF, FORMAT
> >                                ,...);
> >
> > This also works for the case where there are only three arguments.
> > It has the benefit that the change is recognized as a line replacement, so
> > no extra {} are added when the call is in an if branch.
>
> Would you like to consider the application of the following SmPL code variant?
>
> -snprintf
> +sysfs_emit
>          (BUF,
> -         SZ,
>           FORMAT,
>           ...
>          );

It's ok too.

julia

>
> Regards,
> Markus
>
