Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC6DE77188
	for <cocci@archiver.kernel.org>; Tue, 14 Jan 2025 17:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=602AeETnFCAL7f8UK5vWhg8zeSIee1t10MD02a+BVL4=;
  b=kPo0199GVTMCAP6BNx1Jq0NcfBL8oohZPa4q2GC0QwxMz692qWFlGsur
   tKNPeR1KCsUxXGGpZxVDyXGiE1mk+ITZXcCwqbB/e8peuqZ+PgLnXVxif
   xe3dRzVkNcTakMq1hI4drRtarSIvBxdAv2QLMIe9UPJHvoL26/5ElYiXB
   8=;
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
X-IronPort-AV: E=Sophos;i="6.12,314,1728943200"; 
   d="scan'208";a="203121241"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Jan 2025 18:49:22 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2E49BE0D1D; Tue, 14 Jan 2025 18:49:22 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E9F61E0077
	for <cocci@sympa.inria.fr>; Tue, 14 Jan 2025 18:49:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=602AeETnFCAL7f8UK5vWhg8zeSIee1t10MD02a+BVL4=;
  b=leGuSuTz6bWxrfJJKyngwD79wo4itdxR3TJfjt2DA6KaDh1oGEBvC8IW
   lcHFFk6uHoLWu5m/PYFO9FutpBqVL1n5Jg1RGwgczQdRDAqu5XNLBN74O
   4VbGBI+5HhgnqVP50VqDwosCQ1wPOBTR0gAKNCIgSv6pnl3i185qQrpJi
   o=;
X-IronPort-AV: E=Sophos;i="6.12,314,1728943200"; 
   d="scan'208";a="106344754"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 18:49:19 +0100
Date: Tue, 14 Jan 2025 18:49:19 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Anusha Srivatsa <asrivats@redhat.com>
cc: cocci@inria.fr, Maxime Ripard <mripard@redhat.com>
In-Reply-To: <CAN9Xe3T2LjcD9Xr8vAGQWu5MUvVjr-eEaMhB-JauL5DW0aA9QQ@mail.gmail.com>
Message-ID: <dcaf63e4-78bf-3111-8494-6380e6118fd8@inria.fr>
References: <CAN9Xe3T2LjcD9Xr8vAGQWu5MUvVjr-eEaMhB-JauL5DW0aA9QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1854648271-1736876959=:3494"
Subject: Re: [cocci] Ellipses usage in line addition
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2205
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/dcaf63e4-78bf-3111-8494-6380e6118fd8%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1854648271-1736876959=:3494
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 14 Jan 2025, Anusha Srivatsa wrote:

> Hi all,
> Wanted to know if ellipses usage is not allowed in the lines that we want to add in the code. To be more precise,I want to replace mipi_dsi_generic_write_seq() usage with mipi_dsi_generic_write_seq_multi() .
> the coccinelle semantic patch that I am using is:
> //rule_1 ->s/mipi_dsi_generic_write_seq/mipi_dsi_generic_write_seq_multi
> @@
> identifier dsi_var,dsi_device;
> @@
> struct mipi_dsi_device *dsi_var = dsi_device;
> +struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi_var };
> ...
> -mipi_dsi_dcs_write_seq(dsi_var,...);
> +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);
>
> this throws:
> init_defs_builtins: /usr/lib64/coccinelle/standard.h
> lexical error: invalid in a + context: ...
>   File "mipi.cocci", line 9, column 39, charpos = 298
>   around = '...',
>   whole content = +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);
>
> Just commenting out the function replacing the snippet (i.e having only dsi_ctx being populated) works just fine. But the intended change is ofc the proper usage of the _multi API.
>
> Would be nice to know what is going wrong with this approach.

Add a metavariable declaration like:

expression list es;

And then your change can be:

-mipi_dsi_dcs_write_seq(dsi_var,es);
+mipi_dsi_dcs_write_seq_multi(&dsi_ctx,es);

Another approach is to write:

-mipi_dsi_dcs_write_seq(dsi_var,
+mipi_dsi_dcs_write_seq_multi(&dsi_ctx,
   ...);

Another issue is that you may have many calls to mipi_dsi_dcs_write_seq,
or taht some code paths might not contain such a call.  You probably just
want to make such a change whereever it occurs.  So you can write:


@@
identifier dsi_var,dsi_device;
@@
struct mipi_dsi_device *dsi_var = dsi_device;
+struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi_var };
<...
-mipi_dsi_dcs_write_seq(dsi_var,...);
+mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);
...>

The <... P ...> notation is like ... but it makes the change whereever the
pattern P occurs.

julia
--8323329-1854648271-1736876959=:3494--
