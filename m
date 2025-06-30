Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07E5C8302D
	for <cocci@archiver.kernel.org>; Mon, 30 Jun 2025 08:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=tV+vXQ7qQFxFDgE7P0smeB/WisUsnsztfJwZq2JjpCg=;
  b=fRkp/cjZRpuYGxsjUJPoVZGms02LM73rfcGq5ve0jjW6zNr8qDXJ6eJX
   AOjdK2276FDc1zqK7+EEuPOdlHybuhQeDvT+tGC13VawNgkPw8gYDxswJ
   CI/akspUQ1rXwV7f/UpVJR8u6RzLerC5Xfk4fXMhk8mlrvji3UWeJ3DvF
   M=;
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
X-IronPort-AV: E=Sophos;i="6.16,277,1744063200"; 
   d="scan'208";a="229547718"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Jun 2025 10:51:57 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3C9A4E0CCC; Mon, 30 Jun 2025 10:51:57 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 38B43E0131
	for <cocci@sympa.inria.fr>; Mon, 30 Jun 2025 10:51:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tV+vXQ7qQFxFDgE7P0smeB/WisUsnsztfJwZq2JjpCg=;
  b=KjbdSI9GRH3hPnaunWsVeREgfiuDZXmdeUKDLT3bLwmOHZNPWUAeollQ
   gHHIyM0DTEViL/btkChgqQuSgnQE1rQcZoOdOy89FJysjtB18DuBFpOe6
   wLt9whCVXfT7Z+DRbnrputMPtRQLGLzdppGfUw0syob7ji7BvigwNFBcc
   4=;
X-IronPort-AV: E=Sophos;i="6.16,277,1744063200"; 
   d="scan'208";a="229547697"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 10:51:55 +0200
Date: Mon, 30 Jun 2025 10:51:55 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: devnoname120 <devnoname120@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <1a234d32-e87d-414b-8566-490618417f6c@Spark>
Message-ID: <c08d6fa1-e53c-d21-7892-1132133087fb@inria.fr>
References: <7c65be39-dfc3-4b9c-9acd-dd94d1225db8@Spark> <alpine.DEB.2.22.394.2506291925100.95572@hadrien> <55f3b1f1-2537-4bc3-88d3-d7da1136060a@Spark> <alpine.DEB.2.22.394.2506292109470.95572@hadrien> <1a234d32-e87d-414b-8566-490618417f6c@Spark>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [HELP] Using macro `randomized_struct_fields_end` as
 context?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2822
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/c08d6fa1-e53c-d21-7892-1132133087fb%40inria.fr>

randomized_struct_fields_end will soon be supported in the C parser.  It
is not currently supported in the semantic patch parser, but you can get
the same effect as illustrated by the example below.

I will let you know when this is all available on github.

julia


@@
field f : script:python () { f == "randomized_struct_fields_end" };
@@

struct task_struct {
  ...
+ int something;
  f
  ...
};
