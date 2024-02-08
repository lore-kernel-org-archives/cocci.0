Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26EEDC48260
	for <cocci@archiver.kernel.org>; Thu,  8 Feb 2024 13:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=dPQGkPNeMapCqbcaphWxeqEZX2aBTqsuIs28qxfwxYE=;
  b=kdaQ4gc/xXLCR2dud4N3p9cYuTDneVpGjixmAXfl8lEvMWNHo8lqnuJC
   KRuUlDgnbM9ZRdZTe71YZKBSGQa0BoMsoI66NtCKkVRYXG0BMMv8cP11Q
   viNqoFxOIHRrKtI+3B3tiwuYHalnj3yUtprKZD+D6J29nLYt2vxHAJS37
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
X-IronPort-AV: E=Sophos;i="6.05,254,1701126000"; 
   d="scan'208";a="150971376"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Feb 2024 14:45:11 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7F920E00B7; Thu,  8 Feb 2024 14:45:11 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3F63EE008A
	for <cocci@sympa.inria.fr>; Thu,  8 Feb 2024 14:45:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dPQGkPNeMapCqbcaphWxeqEZX2aBTqsuIs28qxfwxYE=;
  b=mpuJnYVoUe7hL+oejKqdSBc2uuvl1mCgIvUtj5eP+QWBqkITagUhCqXj
   EqKTj8eobKDWWXyrplfhLgBua0Ye1jLbb/D9zoHfv0j6YdF9drO7BHklJ
   AmBm4Ha+y5FYe+axAQA+H4fdwCvtsfAWjIFhuq5wti1EOo1c8PomI0hi8
   c=;
X-IronPort-AV: E=Sophos;i="6.05,254,1701126000"; 
   d="scan'208";a="79110532"
Received: from wifi-eduroam-85-031.paris.inria.fr ([128.93.85.31])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 14:45:09 +0100
Date: Thu, 8 Feb 2024 14:45:08 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <22f84f21-9780-4c75-81a4-c97ecf0d1a21@web.de>
Message-ID: <22662763-d0ce-afb4-b866-8daee481f72@inria.fr>
References: <dcb996ea-f041-406e-b641-0e6b515b9a0a@web.de> <7639c70-41e8-9a1-3a5-3a7711fc465@inria.fr> <1f8cb65b-715f-404c-84f7-8eee6de02352@web.de> <e2189114-2fa3-1045-1ae1-fb308b8c5c1f@inria.fr> <cffc1d24-5bb3-4a90-9593-31d3905449e4@web.de>
 <510575-bbc0-442-85a3-3c2fa510aba7@inria.fr> <55ea3e4-8ef8-b457-ea92-9d612ba9d943@inria.fr> <22f84f21-9780-4c75-81a4-c97ecf0d1a21@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-495436826-1707399908=:3227"
Subject: Re: [cocci] Improving support for code positions with opposite SmPL
 dependencies
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1522
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/22662763-d0ce-afb4-b866-8daee481f72%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-495436826-1707399908=:3227
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 8 Feb 2024, Markus Elfring wrote:

> >>> How will the handling of  “if … else …” constructs evolve further for SmPL code?
> >
> > You need to figure out how to put the two cases in the different branches
> > of a single disjunction.
>
> I got the impression that SmPL disjunctions would not be relevant so far
> for the discussed test case.

Perhaps, but it is.

julia
--8323329-495436826-1707399908=:3227--
