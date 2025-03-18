Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CC3C282EC
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 13:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:to:from:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=hjmAAVyisl9mA82nszN5MFxxPoUHf1H+EPlRDaHqVvc=;
  b=EMknUN5vEhSz6kk6xl6KgIWDj7LMp7Q+xRqn4eZu4gwy0dGG/MBIZOMv
   SaCOumDGWNnq0weHhw5DHQYo2b0zO/D3bQjMnIkbpAkVf75DdA9/PhbTV
   c+uO3ZvQu8Kw6sfp64ufYl09zZ46PwEoHp2Catu3FjLgnpzZAR++3pyby
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@proton.me
X-IronPort-AV: E=Sophos;i="6.14,257,1736809200"; 
   d="scan'208";a="213498132"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 14:46:14 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 809AAE0261; Tue, 18 Mar 2025 14:46:13 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9BC13E0260
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 12:48:54 +0100 (CET)
IronPort-SDR: 67d95da6_rxslWBTNI8AujmSRrW+SNKHoKN0VTKK+uOtKf1a07Kop7vb
 pQ6u3f2ZcNeufgFsQfx186DP5lI340qBPh173Hw==
X-IPAS-Result: =?us-ascii?q?A0HtAgDZXNlnjxArRrlagQmBVYJCgVY0BwhIhFacPZVJD?=
 =?us-ascii?q?wEDAQ1EBAEBAwSFAIshAh8GAQQ1BQ0BAgQBAQEBAwIDAQEBAQEBEAEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECEAEBAQEBATkFSYV7AQyCW4EsgSYBAQEBAQEBAQEBAQEdAiwGO?=
 =?us-ascii?q?QEgBCQdAQE4BDACJgJegxWCQiMHrVuBMoEBggwBAQbcIIFlCYEaL4UCaoJjA?=
 =?us-ascii?q?YYkg0WBIQ+BVUSEfYRYg0YZglCCM4UqmXuQHIFNHANZLAFVExcLBwWBbAMqN?=
 =?us-ascii?q?BUcMoETe4JEaUk6Ag0CNYIbJFiCKIROhD6EQYVQghGCBYkthGQtUIFNHUADC?=
 =?us-ascii?q?209NxQbBqQGhEN8Ycg9MAQHCoQUgV0GDJ9zM4NwpmeYfiKUNJRdgX8iLoEuh?=
 =?us-ascii?q?CdPAxkPjjqHabJdRjI8AgcLAQEDCZAcgUsBAQ?=
IronPort-PHdr: A9a23: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
 hIJxfXzLdZKXmUe81R4bUV9msLPFhiINe0=
IronPort-Data: A9a23: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
 avLelaw
IronPort-HdrOrdr: A9a23:7V8iDarNkNyBWpZ9oQTnRXQaV5t3LNV00zEX/kB9WHVpm5Oj+v
 xGzc5w6farsl0ssSkb6La90dq7MArhHP9OkPws1NKZMDUO11HYSL2KgbGC/9SCIVyLygc+79
 YGT0EWMrSZYjZHZK3BkWqF+qMbsby6GdeT9IXjJhlWLT1CWuVK7xRwDQiSe3cGAzVuNN4cLt
 6x98BHrz2vdTA8dcKgHEQIWODFupniiI/mSQRuPW9v1CC+yReTrJLqGRmR2RkTFxlVx605zG
 TDmwvloo2+rvCAzAPG3WO71eUfpDKh8KoJOCW/sLlZFtzesHflWG2nYczMgNkBmpDk1L/tqq
 iDn/9mV/4DnE85MFvF4CcFkDOQqArGo0WSsmOwsD/Eusz2RDUzDo56g55DeBecy3NIhqA97E
 sM5RPui7NnSSjNmyzh68ONbR1wiUauhnInnYco/jhieLpbU7NXpZES5wduCZ8FNirn8oxPKp
 gqMOjsoM1bdluGY2uchHBmxOanWG8+dy32AHQqi4iv3z9fgXxji3EAzMgkg38c+PsGOtp5Dq
 3/Q9lVvaALQckMYa1nAuAdBcOxF2zWWBrJdHmfOFL9Ccg8SgDwQjHMkcQIDcyRCew1JaEJ6e
 f8eUIdsXR3d1PlCMWI0pEO+BjJTGKxVS+o0M1E55Ri/r36XqfiNieODFAi+vHQ38n3LverJc
 pbYqgmecMLBVGeZrp04w==
X-Talos-CUID: 9a23:qkfSFmE3KZo/23cjqmJl7WcrQ80CSUTE0X70Dmy6DlpNYoS8HAo=
X-Talos-MUID: 9a23:Cm12jgn3GQU+BaBl/dijdnpfOMBV24e2EnsCtr89nNmZNSB7Ch2C2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="111895760"
X-MGA-submission: =?us-ascii?q?MDFfEzr0BLTEhIUKt3YGe7NbZfJqdp7DL2YbYb?=
 =?us-ascii?q?5iI0jhrmjTenHueEnZXPfxa4sPMFir85xXxeUJ5jML+76WqywYVqegcD?=
 =?us-ascii?q?cly4VOjzP9nnT1myhSpHBYhT+iYI4plfWLeZG0/AQ8Z4XwiWEm2Zf7Lm?=
 =?us-ascii?q?IsHiLlTpvWmZemk3e3o85pNA=3D=3D?=
Received: from mail-4316.protonmail.ch ([185.70.43.16])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 12:48:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742298532; x=1742557732;
	bh=hjmAAVyisl9mA82nszN5MFxxPoUHf1H+EPlRDaHqVvc=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=Mc3j9ZmtdyBoouUnOOdZLPKmiMs79kI7qzneTftbCfzXSuwvZgLy0us1F1WST5KVz
	 bGnG6GgW8TWugCzC4OiGT0Nko3kiB5nZlF7lxEWtSlEFJpnNUfg7bk2lRi97oKS/oM
	 O87xNfvs2+6TvFADhstIaetEfIoYsT7zUoCm2skOGcZ0nrlUQsUQKD3Pk18UcwRUPo
	 2uMp2hjuU62VtDg6bvi1Pc5rVUGomgIN32sMHz0LPjAqy6QV8mBSQ/+6fzi6qjeWmX
	 ZovuUu7BiFW/9mqyx6xjMqht1cgUBD/8yNE/JNXliDlyRnop4jQMt3HGauTFe0CYU/
	 DCSI5jS4AwcTg==
Date: Tue, 18 Mar 2025 11:48:49 +0000
To: "cocci@inria.fr" <cocci@inria.fr>
From: Florian Stinglmayr <florian.stinglmayr@proton.me>
Message-ID: <Cj-R4IgEgd_zgRLBVFxVy7ffXmhDSmTrxrSQhr83u3Lf9M8N9dEBDK8M_idtO0mGjO480pEeMHrQHH4xWmQn1uSwLUHW-jXSt0mlIy_HiNY=@proton.me>
Feedback-ID: 120159168:user:proton
X-Pm-Message-ID: 7baeeff809246cf12aca25c17beb30b2c97bb832
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] Bug: cocci seems to have issues with math expression in
 struct initialisers
Reply-To: Florian Stinglmayr <florian.stinglmayr@proton.me>
X-Loop: cocci@inria.fr
X-Sequence: 2622
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/Cj-R4IgEgd_zgRLBVFxVy7ffXmhDSmTrxrSQhr83u3Lf9M8N9dEBDK8M_idtO0mGjO480pEeMHrQHH4xWmQn1uSwLUHW-jXSt0mlIy_HiNY%3D%40proton.me>

Hi,

cocci 1.3 seems to have issues parsing math expressions used in struct init=
ialisers.

Given the following code:

> enum {
>   SYMBOLA,
> };
> #define SYMBOL_WIDTH 100
> rect_t dst =3D { SYMBOLA * SYMBOL_WIDTH, 0, 0, 0 };

cocci complains about the code around multiplicator in the structure initia=
liser. If I change the code to:

> enum {
>   SYMBOLA,
> };
> #define SYMBOL_WIDTH 100
> int x =3D SYMBOLA * SYMBOL_WIDTH;
> rect_t dst =3D { x, 0, 0, 0 };

Then cocci parses it without error.

Regards
Florian
