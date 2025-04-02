Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BDDC36014
	for <cocci@archiver.kernel.org>; Wed,  2 Apr 2025 11:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:date:reply-to:message-id:mime-version:subject:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=G7k0LVCerJbxlLBiRMhM+O4GHL0s8SAzJUurPGWjKCY=;
  b=tPVgx+ThZPCR5yndsUIrxsIMW87ZpGfRsNSe2QNzPnBxmRuLReQHjV8Z
   iamuow4DAoW2A9bUNNJ//IE2qINQUNX7FLazDThpDMLgzNhOcXkTE+Rb0
   JGB1OOYYXmefCUPoZzBAQ2OgqpcfOr5uKECCMbLEVmEG16UlNZT6UXHm0
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@stefan-winter.net
X-IronPort-AV: E=Sophos;i="6.14,182,1736809200"; 
   d="scan'208";a="215989685"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Apr 2025 13:24:22 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B7727E0D1E; Wed,  2 Apr 2025 13:24:22 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BBD32E007A
	for <cocci@sympa.inria.fr>; Wed,  2 Apr 2025 13:24:20 +0200 (CEST)
IronPort-SDR: 67ed1e61_D4Lv5vTQRGLyDrRGKSAl88N9Ae0/urLWVWblmBuP3U0F8ZF
 E29vBjZqWVAiKmsPArrpTAi62++tLSQsVTlZnsw==
X-IPAS-Result: =?us-ascii?q?A0E9AwC/He1nfoSDDVVaglyCRH1aMwQLSI1RhlWCIRaff?=
 =?us-ascii?q?g8BAwENOQkCBAEBAwECAZArAh4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBEAEBB?=
 =?us-ascii?q?QEBAQIBAQIEBgECEAEBQi4bhXsNgls7ghYBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQECQSpmAQE4OzQBg2KCZAMEAQwGr2GBA?=
 =?us-ascii?q?YIMAQEGgVhBN9lQgWUDBoFIiFABhgeFAxs/AYEJRIQPAYNOA4IshXeCM0WEZ?=
 =?us-ascii?q?YlHiFGZNQcHYV4cA1ksAUsKExcLBwU5gTMDgQ+BRXuCPWlJOgINAjWCCBNdH?=
 =?us-ascii?q?4ImhEuDHIEggy2BEIFig2uCEYIEgjCCEAICgn6BXoRdLU+Deh03CQMLbT03C?=
 =?us-ascii?q?AwbBkVCHRKjMjuFJBoTKgKCPTqSfLMghCUFjBOVfRODXZNkkwOYfo4Fmn0xg?=
 =?us-ascii?q?X0kLoEuMxoIJgqCEoEQTwMZD44tFoUWgxrFaUE1AgE5AgcLAQEDCYVpijOBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 fA+rTAeZe0IPG6Chng=
IronPort-HdrOrdr: A9a23:03u8xq4SkqKwA/s6dQPXwPTXdLJyesId70hD6qkRc20xTiX8ra
 uTdZsgtCMc5Ax8ZJhCo6HjBEDjewK+yXcd2+B4V4tKOjOHhILCFu9fBOXZrAHIJzfz7apU26
 tmbsFFZeHYPBxBlM7/7U2SG81I+qjizJyV
X-Talos-CUID: 9a23:w37kt24NLzN5KcQHMNssxF8pEJsvYHLnkmbTDUK2C1ZDa7DMVgrF
X-Talos-MUID: 9a23:KqVAaAg4yZUpci+y7//F1cMpL4Bjv4CgEGM3ybYHnOqdFXFCYWuUg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,182,1736809200"; 
   d="scan'208";a="215989663"
X-MGA-submission: =?us-ascii?q?MDGhgMPTB6C1LjDdXv0fBWSRpZp+Kr4EIC5Kfo?=
 =?us-ascii?q?uNt5dLDQKGrzXBGYe+Mtgc7VsuJ+ah20iQkHhGQv6K0r45uT9TkE1B1R?=
 =?us-ascii?q?c6T8cbecRL7orkC7HkttYE/8M18tfVzLC5CHWTdonQsJ4tq1+CEzXJzu?=
 =?us-ascii?q?IzVKjeEHPJvtJOwSJv50B2RQ=3D=3D?=
Received: from dd13314.kasserver.com ([85.13.131.132])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 13:24:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stefan-winter.net;
	s=kas202501011043; t=1743593056;
	bh=G7k0LVCerJbxlLBiRMhM+O4GHL0s8SAzJUurPGWjKCY=;
	h=From:To:Subject:Date:Reply-To:From;
	b=FuHQRHloN+sAdVSfylZVYb5lYNE1Wt5wAFqTGzCZhQ+dDgjfeR1hWJSUBQ307xvb4
	 OQNuh0vch7SyWaCKl/ISSYyACbI3ikFfA3yWcG5+yNSxurMmIg35jQoKJ/FWmyJ327
	 QbCl4qKC5fBvez8oW4/kz0JzupozTpilyOB4mDTaTYAh3LpCC7mBAlJLwhqWpg4ZKx
	 KhcKh6Ny3JXzYo5tFkNUPXrQbELwEEWNFzdTSkuzMNO+gKb8VbnLKuUN2j/kPkBJeV
	 UDZ/E5il2aDkEXbGxKvIidmBSry9BOsnrHPjsfwgh7qo/btdQqDrfgJ34H2QyNeAQ8
	 3D7qEwgIBvBUg==
Received: from debiant14 (dhcp-138-246-3-54.dynamic.eduroam.mwn.de [138.246.3.54])
	by dd13314.kasserver.com (Postfix) with ESMTPSA id 089271DC11C7;
	Wed,  2 Apr 2025 13:24:16 +0200 (CEST)
User-agent: mu4e 1.8.13; emacs 28.2
From: Stefan Winter <sw@stefan-winter.net>
To: cocci@inria.fr
Date: Wed, 02 Apr 2025 13:23:42 +0200
Reply-To: sw@stefan-winter.net
Message-ID: <87r02an6w0.fsf@debiant14>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Bar: ++
Subject: [cocci] Support for unary operator matching
X-Loop: cocci@inria.fr
X-Sequence: 2680
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/87r02an6w0.fsf%40debiant14>

Hi,

I'm trying to match a unary operator with Coccinelle:

$ cat unary.cocci
@@
expression x;
unary operator o = {-};
@@
- o x
+ x

But it seems Coccinelle is choking on "unary":

$ spatch --cocci-file unary.cocci <(echo "int i = -42;")     
init_defs_builtins: /usr/lib/coccinelle/standard.h
meta: parse error: 
  File "unary.cocci", line 3, column 0, charpos = 17
  around = 'unary',
  whole content = unary operator o = {-};

Did I get something wrong or is this supposed to work according to
https://coccinelle.gitlabpages.inria.fr/website/docs/main_grammar.html ?

Thanks,
Stefan
