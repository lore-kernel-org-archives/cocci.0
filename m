Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9822C4167B
	for <cocci@archiver.kernel.org>; Mon,  6 Nov 2023 22:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=references:from:to:cc:date:in-reply-to:message-id:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+Gs2KfJDjKpyeNsYsoB7MM9tjWbWOy/qv7wmNzZsOc8=;
  b=PYT9kNCX7VW2uxjp90swKzXc5XJtqeUgElxDICSabY3KyJlCqffze/HY
   mBp8n4lOoHzcB7lJZLwDhZGz/rWpvD/u7PGLbWgG29r3IHYL0GZOpLz/x
   47IeibxeG3Xd2WvdLvINTKGhEhStVaIu6O7wx7XqnhfoiwJn8TSdkUEog
   A=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.03,282,1694728800"; 
   d="scan'208";a="134903205"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Nov 2023 23:23:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E71F2E00BA; Mon,  6 Nov 2023 23:23:47 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1D7A9E00B6
	for <cocci@sympa.inria.fr>; Mon,  6 Nov 2023 23:23:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=+Gs2KfJDjKpyeNsYsoB7MM9tjWbWOy/qv7wmNzZsOc8=;
  b=K3oEZO7WSVQNf5fFkGiwFtYkL5sEudKY3lyP5HMwpHHKXeAXyTfU36Ri
   iaNdpQj1RkKXou3yVrb5KWpAE6deJYLUp/xgST4d1h/2hfiEAU90Mlt0o
   EuVUbMbmeOcZv7PHAR0rrA6SkN4oDcEv13OQgv7YCvF73LXU22bmsecf6
   M=;
X-IronPort-AV: E=Sophos;i="6.03,282,1694728800"; 
   d="scan'208";a="134903067"
Received: from unknown (HELO MAC-02008476) ([37.168.108.241])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 23:23:41 +0100
References: <20231026075755.GA19414@redhat.com>
 <20231106192759.GB19414@redhat.com>
User-agent: mu4e 1.10.7; emacs 29.1
From: Thierry Martinez <Thierry.Martinez@inria.fr>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: cocci@inria.fr
Date: Mon, 06 Nov 2023 22:19:38 +0000
In-reply-to: <20231106192759.GB19414@redhat.com>
Message-ID: <isdqzbsf5i1pxv.fsf@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] Report that Coccinelle doesn't compile with Python
 3.13.0a1
Reply-To: Thierry Martinez <Thierry.Martinez@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1293
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/isdqzbsf5i1pxv.fsf%40inria.fr>

Hi Richard,

Richard=C2=A0:
>   "The use of _PyObject_NextNotImplemented actually comes from
>   ocaml-pyml.  There is a new version of ocaml-pyml out that drops all
>   support for python 2.7, including this symbol.  I will build it and
>   rebuild coccinelle.  That should fix this bug.  I will do mock
>   builds first to ensure that is the case."

I indeed made a new release of pyml last week to fix the bug you
reported (and following your report, thanks!), by replacing the internal
_PyObject_NextNotImplemented with public API calls (but I don't think I
have broken the support of python 2.7, but I should test that). I didn't
have time to bundle the new release of pyml in coccinelle yet, but I
plan to do that in a couple of days.

Thank you again for your report. Best regards.
--=20
Thierry.
