Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A14C02183
	for <cocci@archiver.kernel.org>; Fri, 17 Jan 2025 21:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=LkgGkzZK+CFK3T/9hYP5bO23Mqwu4pm+xtnQYz0+97I=;
  b=cXvDMVGcA7QUKWUZ5cIlKeJ9uX9UgYuL/cEQVnPsQO47404ybPOi7hKE
   oB91Cjoa7jk4jYEUNvx88XLvhEKkMbBajbeiMaWRbJKOeb/06kEFSHTkM
   fI6QIkXZUkIflVnFovr5rbDBQ3AzTBRxgnv8lWPwYK+1kZCqFBbZ6mSHy
   I=;
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
X-IronPort-AV: E=Sophos;i="6.13,213,1732575600"; 
   d="scan'208";a="203764724"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Jan 2025 22:36:17 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BE14FE0137; Fri, 17 Jan 2025 22:36:17 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 61D82E0077
	for <cocci@sympa.inria.fr>; Fri, 17 Jan 2025 22:36:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LkgGkzZK+CFK3T/9hYP5bO23Mqwu4pm+xtnQYz0+97I=;
  b=Km4O8ZCC6HCf8gb87DJOr4Wd2kxKNZgLVESKeyelc+3zpG8ugu6RrHoK
   CjDSTtiX4CuGMlmG62SlbftdONh+1i8sOaKNsVoTWJzISioDpIIty6bnh
   k0pG9APxWrf0rvXNRWpzw/vmmeqfFQpSg2Qq8zRFWieu+dgo8Pyr8jhHq
   Q=;
X-IronPort-AV: E=Sophos;i="6.13,213,1732575600"; 
   d="scan'208";a="203764721"
Received: from unknown (HELO hadrien) ([96.75.210.53])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 22:36:14 +0100
Date: Fri, 17 Jan 2025 16:36:13 -0500 (EST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Anusha Srivatsa <asrivats@redhat.com>
cc: cocci@inria.fr, Maxime Ripard <mripard@redhat.com>
In-Reply-To: <CAN9Xe3TBb2GYNeqL1f1_GTPT2W5J78gniK0ZTZJyLwJL=KydoQ@mail.gmail.com>
Message-ID: <e820e9d7-16d1-8bb8-7428-936fe93bf3c@inria.fr>
References: <CAN9Xe3T2LjcD9Xr8vAGQWu5MUvVjr-eEaMhB-JauL5DW0aA9QQ@mail.gmail.com> <dcaf63e4-78bf-3111-8494-6380e6118fd8@inria.fr> <CAN9Xe3TBb2GYNeqL1f1_GTPT2W5J78gniK0ZTZJyLwJL=KydoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-724095928-1737149775=:3239"
Subject: Re: [cocci] Ellipses usage in line addition
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2214
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/e820e9d7-16d1-8bb8-7428-936fe93bf3c%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-724095928-1737149775=:3239
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

>       Another approach is to write:
>
>       -mipi_dsi_dcs_write_seq(dsi_var,
>       +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,
>          ...);
>
>
> This again throws the error : init_defs_builtins: /usr/lib64/coccinelle/standard.h
> lexical error: invalid in a + context: ...
>   File "mipi_julia.cocci", line 8, column 39, charpos = 220
>   around = '...',
>   whole content = +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);

For me, the following semantic patch is fine:

@@
@@
-mipi_dsi_dcs_write_seq(dsi_var,
+mipi_dsi_dcs_write_seq_multi(&dsi_ctx,
     ...);

If you have something different, please send the complete semantic patch.

julia
--8323329-724095928-1737149775=:3239--
