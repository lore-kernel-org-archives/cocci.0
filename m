Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76D6C2A062
	for <cocci@archiver.kernel.org>; Sun,  4 Jan 2026 21:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=/MlVxAH/+vEGUyEEvaJe6l/xGMkCzBCvrzxWePgSIyM=;
  b=cy5Dp25Rj9qp2kWaXXBuIkWZJd81B5KiwXAZDRoApSM7gfFacEjM+1Cg
   yqvQq4mVbM+sq4TvAZEo+RMlNyJ7PRw9kFN+7jsZ/81uNhoNaxj53BydF
   QUQJzSTC1ZYf6ZZyiSTRUgaS4Ta6r6pbSW6rfoynCao1HT0+lKtyXdiLG
   w=;
X-CSE-ConnectionGUID: Fp1l5vDYT0GTfexvXR+cZw==
X-CSE-MsgGUID: gqQ+Yr1SSIar0bXSmm8O0A==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.21,202,1763420400"; 
   d="scan'208";a="256861353"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Jan 2026 22:29:18 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id D730180393; Sun,  4 Jan 2026 22:29:17 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id DB36C80305
	for <cocci@sympa.inria.fr>; Sun,  4 Jan 2026 22:29:10 +0100 (CET)
X-CSE-ConnectionGUID: ygZhpGUWTxOWmFRZKep3eQ==
X-CSE-MsgGUID: +YAZUFO+Q+SqeAcAXT40QQ==
X-IronPort-AV: E=Sophos;i="6.21,202,1763420400"; 
   d="scan'208";a="256861340"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2026 22:29:10 +0100
Date: Sun, 4 Jan 2026 22:29:10 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Ricardo Ribalda <ribalda@chromium.org>
cc: Markus Elfring <Markus.Elfring@web.de>, 
    Victor Gambier <victor.gambier@inria.fr>, cocci@inria.fr
In-Reply-To: <CANiDSCvvO7+qtRUi6NyrKzdKZaSrKNgSUgnnJfOw7HYHHc8nvw@mail.gmail.com>
Message-ID: <f5449c2-3ce0-1d89-4b74-c288ca2efe58@inria.fr>
References: <CANiDSCvmboKBK=Z7uS9tnN_LcPA16rx0j_iWeEoQ=jO+pEgLiA@mail.gmail.com> <98a94966-14c6-45c4-99d8-471f65b292ea@web.de> <CANiDSCuJHTsHsFLbMGC1S47myfReZX7JBfGZFVknj8y=4-QLCA@mail.gmail.com> <fdc397c4-8823-46c3-b471-382ebb483900@web.de>
 <CANiDSCuqX7yRyJfvEJeV99fr1wEwANtg2Ak7MNogfYNEqMJ6Hg@mail.gmail.com> <66215b0-f6e-2cef-4022-4dd148fa2790@inria.fr> <CANiDSCvsBCrpwOFbwf93ighoMm+ca=jpHs6NAp9AHaEJj9neRg@mail.gmail.com> <1c92f6ab-9992-1f5-d911-f8cd52991c66@inria.fr>
 <CANiDSCvXUxdTxXZ9r3SvoVTnChkg1nRN7uAva8nHb6CTFt67KQ@mail.gmail.com> <5123b7fe-b5f6-4446-a792-b5d19873c181@inria.fr> <5c5a00f7-8955-483a-9efc-d003972c7a12@web.de> <CANiDSCvvO7+qtRUi6NyrKzdKZaSrKNgSUgnnJfOw7HYHHc8nvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-831247136-1767562150=:4148"
Subject: Re: [cocci] Cocci MUCH more slow after 6.11
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3267
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/011Zl_GftBzfcaBg0yZKQQ>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-831247136-1767562150=:4148
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 16 Dec 2025, Ricardo Ribalda wrote:

> Hi Laura
>
> Has there been any progress on this?
>
> I am stuck with an old Debian version in our CI and I would like to
> update to debian stable.

Hello,

I made some improvements to the minmax semantic patch that made it go 4x
faster on my test machine.  Maybe it will help.

julia

>
> Regards!
>
> On Tue, 4 Feb 2025 at 16:10, Markus Elfring <Markus.Elfring@web.de> wrote:
> >
> > …
> > > spatch version 1.1.1-00610-gd151c4895 compiled with OCaml version 4.13.1
> > …
> > > $ time make coccicheck M=drivers/media
> > > real    14m31,975s
> > > user    92m46,656s
> > > sys    0m47,545s
> > …
> > > spatch version 1.1.1-00611-g4388e1d92 compiled with OCaml version 4.13.1
> > …
> > > $ time make coccicheck M=drivers/media
> > > real    33m0,638s
> > > user    218m47,039s
> > > sys    1m13,807s
> > …
> >
> > Would you become interested to increase the measurement granularity another bit?
> >
> > See also:
> > Selection of benchmarks
> > 2018-04-24
> > https://github.com/coccinelle/coccinelle/issues/133
> >
> > Regards,
> > Markus
>
>
>
> --
> Ricardo Ribalda
>
--8323329-831247136-1767562150=:4148
Content-Type: text/plain; charset=US-ASCII; name=minmax.cocci
Content-Transfer-Encoding: BASE64
Content-ID: <cf82dc2-fd15-806d-ab45-ce5aa3c49e40@inria.fr>
Content-Description: 
Content-Disposition: attachment; filename=minmax.cocci

Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KLy8v
DQovLy8gQ2hlY2sgZm9yIG9wZW5jb2RlZCBtaW4oKSwgbWF4KCkgaW1wbGVt
ZW50YXRpb25zLg0KLy8vIEdlbmVyYXRlZCBwYXRjaGVzIHNvbWV0aW1lcyBy
ZXF1aXJlIGFkZGluZyBhIGNhc3QgdG8gZml4IGNvbXBpbGUgd2FybmluZy4N
Ci8vLyBXYXJuaW5ncy9wYXRjaGVzIHNjb3BlIGludGVudGlvbmFsbHkgbGlt
aXRlZCB0byBhIGZ1bmN0aW9uIGJvZHkuDQovLy8NCi8vIENvbmZpZGVuY2U6
IE1lZGl1bQ0KLy8gQ29weXJpZ2h0OiAoQykgMjAyMSBEZW5pcyBFZnJlbW92
IElTUFJBUw0KLy8gT3B0aW9uczogLS1uby1pbmNsdWRlcyAtLWluY2x1ZGUt
aGVhZGVycw0KLy8NCi8vIEtleXdvcmRzOiBtaW4sIG1heA0KLy8NCg0KI3Nw
YXRjaCAtLWRpc2FibGUtaXNvIG5vdF9pbnQyDQoNCnZpcnR1YWwgcmVwb3J0
DQp2aXJ0dWFsIG9yZw0KdmlydHVhbCBjb250ZXh0DQp2aXJ0dWFsIHBhdGNo
DQoNCkBpbml0aWFsaXplOnB5dGhvbkANCkBADQoNCmRlZiBjaGVjayAocCk6
DQogIHJldHVybiBwWzBdLmN1cnJlbnRfZWxlbWVudCAhPSAic29tZXRoaW5n
X2Vsc2UiDQoNCkBybWF4IGRlcGVuZHMgb24gIXBhdGNoQA0KZXhwcmVzc2lv
biB4LCB5Ow0KYmluYXJ5IG9wZXJhdG9yIGNtcCA9IHs+LCA+PX07DQpwb3Np
dGlvbiBwIDogc2NyaXB0OnB5dGhvbigpIHsgY2hlY2socCkgfTsNCkBADQoN
CioJKCh4KSBjbXBAcCAoeSkgPyAoeCkgOiAoeSkpDQoNCkBybWF4aWYgZGVw
ZW5kcyBvbiAhcGF0Y2hADQppZGVudGlmaWVyIGZ1bmM7DQpleHByZXNzaW9u
IHgsIHk7DQpleHByZXNzaW9uIG1heF92YWw7DQpiaW5hcnkgb3BlcmF0b3Ig
Y21wID0gez4sID49fTsNCnBvc2l0aW9uIHAgOiBzY3JpcHQ6cHl0aG9uKCkg
eyBjaGVjayhwKSB9Ow0KQEANCg0KKglpZiAoKHgpIGNtcEBwICh5KSkgew0K
KgkJbWF4X3ZhbCA9ICh4KTsNCioJfSBlbHNlIHsNCioJCW1heF92YWwgPSAo
eSk7DQoqCX0NCg0KLy8gSWdub3JlIGVycmNvZGUgcmV0dXJucy4NCkBlcnJj
b2RlQA0KcG9zaXRpb24gcCA6IHNjcmlwdDpweXRob24oKSB7IGNoZWNrKHAp
IH07DQppZGVudGlmaWVyIGZ1bmM7DQpleHByZXNzaW9uIHg7DQpiaW5hcnkg
b3BlcmF0b3IgY21wID0gezwsIDw9fTsNCkBADQoNCglyZXR1cm4gKCh4KSBj
bXBAcCAwID8gKHgpIDogMCk7DQoNCkBybWluIGRlcGVuZHMgb24gIXBhdGNo
QA0KaWRlbnRpZmllciBmdW5jOw0KZXhwcmVzc2lvbiB4LCB5Ow0KYmluYXJ5
IG9wZXJhdG9yIGNtcCA9IHs8LCA8PX07DQpwb3NpdGlvbiBwICE9IGVycmNv
ZGUucDsNCnBvc2l0aW9uIHAxIDogc2NyaXB0OnB5dGhvbigpIHsgY2hlY2so
cDEpIH07DQpAQA0KDQoqCSgoeCkgY21wQHAxQHAgKHkpID8gKHgpIDogKHkp
KQ0KDQpAcm1pbmlmIGRlcGVuZHMgb24gIXBhdGNoQA0KaWRlbnRpZmllciBm
dW5jOw0KZXhwcmVzc2lvbiB4LCB5Ow0KZXhwcmVzc2lvbiBtaW5fdmFsOw0K
YmluYXJ5IG9wZXJhdG9yIGNtcCA9IHs8LCA8PX07DQpwb3NpdGlvbiBwIDog
c2NyaXB0OnB5dGhvbigpIHsgY2hlY2socCkgfTsNCkBADQoNCioJaWYgKCh4
KSBjbXBAcCAoeSkpIHsNCioJCW1pbl92YWwgPSAoeCk7DQoqCX0gZWxzZSB7
DQoqCQltaW5fdmFsID0gKHkpOw0KKgl9DQoNCkBwbWF4IGRlcGVuZHMgb24g
cGF0Y2hADQppZGVudGlmaWVyIGZ1bmM7DQpleHByZXNzaW9uIHgsIHk7DQpi
aW5hcnkgb3BlcmF0b3IgY21wID0gez49LCA+fTsNCnBvc2l0aW9uIHAgOiBz
Y3JpcHQ6cHl0aG9uKCkgeyBjaGVjayhwKSB9Ow0KQEANCg0KLQkoKHgpIGNt
cEBwICh5KSA/ICh4KSA6ICh5KSkNCisJbWF4KHgsIHkpDQoNCkBwbWF4aWYg
ZGVwZW5kcyBvbiBwYXRjaEANCmlkZW50aWZpZXIgZnVuYzsNCmV4cHJlc3Np
b24geCwgeTsNCmV4cHJlc3Npb24gbWF4X3ZhbDsNCmJpbmFyeSBvcGVyYXRv
ciBjbXAgPSB7Pj0sID59Ow0KcG9zaXRpb24gcCA6IHNjcmlwdDpweXRob24o
KSB7IGNoZWNrKHApIH07DQpAQA0KDQotCWlmICgoeCkgY21wQHAgKHkpKSB7
DQotCQltYXhfdmFsID0geDsNCi0JfSBlbHNlIHsNCi0JCW1heF92YWwgPSB5
Ow0KLQl9DQorCW1heF92YWwgPSBtYXgoeCwgeSk7DQoNCkBwbWluIGRlcGVu
ZHMgb24gcGF0Y2hADQppZGVudGlmaWVyIGZ1bmM7DQpleHByZXNzaW9uIHgs
IHk7DQpiaW5hcnkgb3BlcmF0b3IgY21wID0gezw9LCA8fTsNCnBvc2l0aW9u
IHAgIT0gZXJyY29kZS5wOw0KcG9zaXRpb24gcDEgOiBzY3JpcHQ6cHl0aG9u
KCkgeyBjaGVjayhwMSkgfTsNCkBADQoNCi0JKCh4KSBjbXBAcDFAcCAoeSkg
PyAoeCkgOiAoeSkpDQorCW1pbih4LCB5KQ0KDQpAcG1pbmlmIGRlcGVuZHMg
b24gcGF0Y2hADQppZGVudGlmaWVyIGZ1bmM7DQpleHByZXNzaW9uIHgsIHk7
DQpleHByZXNzaW9uIG1pbl92YWw7DQpiaW5hcnkgb3BlcmF0b3IgY21wID0g
ezw9LCA8fTsNCnBvc2l0aW9uIHAgOiBzY3JpcHQ6cHl0aG9uKCkgeyBjaGVj
ayhwKSB9Ow0KQEANCg0KLQlpZiAoKHgpIGNtcEBwICh5KSkgew0KLQkJbWlu
X3ZhbCA9IHg7DQotCX0gZWxzZSB7DQotCQltaW5fdmFsID0geTsNCi0JfQ0K
KwltaW5fdmFsID0gbWluKHgsIHkpOw0KDQpAc2NyaXB0OnB5dGhvbiBkZXBl
bmRzIG9uIHJlcG9ydEANCnAgPDwgcm1heC5wOw0KQEANCg0KZm9yIHAwIGlu
IHA6DQoJY29jY2lsaWIucmVwb3J0LnByaW50X3JlcG9ydChwMCwgIldBUk5J
Tkcgb3Bwb3J0dW5pdHkgZm9yIG1heCgpIikNCg0KQHNjcmlwdDpweXRob24g
ZGVwZW5kcyBvbiBvcmdADQpwIDw8IHJtYXgucDsNCkBADQoNCmZvciBwMCBp
biBwOg0KCWNvY2NpbGliLm9yZy5wcmludF90b2RvKHAwLCAiV0FSTklORyBv
cHBvcnR1bml0eSBmb3IgbWF4KCkiKQ0KDQpAc2NyaXB0OnB5dGhvbiBkZXBl
bmRzIG9uIHJlcG9ydEANCnAgPDwgcm1heGlmLnA7DQpAQA0KDQpmb3IgcDAg
aW4gcDoNCgljb2NjaWxpYi5yZXBvcnQucHJpbnRfcmVwb3J0KHAwLCAiV0FS
TklORyBvcHBvcnR1bml0eSBmb3IgbWF4KCkiKQ0KDQpAc2NyaXB0OnB5dGhv
biBkZXBlbmRzIG9uIG9yZ0ANCnAgPDwgcm1heGlmLnA7DQpAQA0KDQpmb3Ig
cDAgaW4gcDoNCgljb2NjaWxpYi5vcmcucHJpbnRfdG9kbyhwMCwgIldBUk5J
Tkcgb3Bwb3J0dW5pdHkgZm9yIG1heCgpIikNCg0KQHNjcmlwdDpweXRob24g
ZGVwZW5kcyBvbiByZXBvcnRADQpwIDw8IHJtaW4ucDsNCkBADQoNCmZvciBw
MCBpbiBwOg0KCWNvY2NpbGliLnJlcG9ydC5wcmludF9yZXBvcnQocDAsICJX
QVJOSU5HIG9wcG9ydHVuaXR5IGZvciBtaW4oKSIpDQoNCkBzY3JpcHQ6cHl0
aG9uIGRlcGVuZHMgb24gb3JnQA0KcCA8PCBybWluLnA7DQpAQA0KDQpmb3Ig
cDAgaW4gcDoNCgljb2NjaWxpYi5vcmcucHJpbnRfdG9kbyhwMCwgIldBUk5J
Tkcgb3Bwb3J0dW5pdHkgZm9yIG1pbigpIikNCg0KQHNjcmlwdDpweXRob24g
ZGVwZW5kcyBvbiByZXBvcnRADQpwIDw8IHJtaW5pZi5wOw0KQEANCg0KZm9y
IHAwIGluIHA6DQoJY29jY2lsaWIucmVwb3J0LnByaW50X3JlcG9ydChwMCwg
IldBUk5JTkcgb3Bwb3J0dW5pdHkgZm9yIG1pbigpIikNCg0KQHNjcmlwdDpw
eXRob24gZGVwZW5kcyBvbiBvcmdADQpwIDw8IHJtaW5pZi5wOw0KQEANCg0K
Zm9yIHAwIGluIHA6DQoJY29jY2lsaWIub3JnLnByaW50X3RvZG8ocDAsICJX
QVJOSU5HIG9wcG9ydHVuaXR5IGZvciBtaW4oKSIpDQo=

--8323329-831247136-1767562150=:4148--
