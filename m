Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1347FD2F7C9
	for <cocci@archiver.kernel.org>; Fri,  5 Dec 2025 10:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=cvoPCU5Vz6cRc9w0mV9AO3BPbzeYe/s2SJ5ZIGbFmAk=;
  b=uXr6rdoYztkIyGSYhP3htv8dz6ZMWYKFWj5qmp7pOdcqt2Y6Tm3ka0ns
   OC0FDG7qMeAyDvFrmWkzLY7pnJDrk7qXQclj9yoUH0P2oaOCdmgeR2PGN
   LIRf8ympf9L6LzrpklMERvsFXiLbSe75e/N3Wa6KEvMzXgYaJXYE3zhMj
   o=;
X-CSE-ConnectionGUID: opuA3KYwQ4Wfea7T4T9Nyg==
X-CSE-MsgGUID: VI5qnrqRSJCh03OpdjuOzQ==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.20,251,1758578400"; 
   d="scan'208";a="252938646"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Dec 2025 11:00:44 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5F8ECE0CDC; Fri,  5 Dec 2025 11:00:43 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id EC0ABE0CD8
	for <cocci@sympa.inria.fr>; Fri,  5 Dec 2025 11:00:39 +0100 (CET)
X-CSE-ConnectionGUID: 328nx6sRQfa+3g8KRzKGZg==
X-CSE-MsgGUID: vQBWGMTATwKD5tTgP5HR1A==
IronPort-SDR: 6932ad47_E2zK5tHDOOVOXrx8V4lXefRbjAAyEuoJCbARKrqMLut79ax
 pH3oPRMtha1T+m7PYVI2XPQUo0vb10/iy3fDcHg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FiAwCMqzJpgwsR49RagQmBUIJAZyVZMwQLSYRVj1OCJ?=
 =?us-ascii?q?IQ7hzyHVYpOgX0CDwEDAQ1OAQIEAQEDBIFMgzQCjGcCHgcBBDIHDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBOgcOO4ZPDYJiAYEkg?=
 =?us-ascii?q?SYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBESYBBAsJAhoCJgICVgYVAQGCf?=
 =?us-ascii?q?oIjAQYQAQMPJweUaJxHgTKBAYIMAQEG2mEfLCJZgWQJgR0uhW6CZQGKZicPg?=
 =?us-ascii?q?VVEgTyCUjE+hEODW4JpgiaBDoYfiXkGiTlSeBwDWSwBVRMXCwcFgSBDA4ELI?=
 =?us-ascii?q?0sFLR2BIyEdFxNgPRdAg0kYBmgPBoERGUkCAgIFAkA6gWgGHAYcEgIDAQICO?=
 =?us-ascii?q?lUMgXcCAgSCFX2CCg+HZ4EIBS57MQIBC209NwkLGwY9lQ9Pg0FCgggeOqMIo?=
 =?us-ascii?q?ns0B4I4gWeBZAyfbAYTL5dSDgaTBYgKkHypQIFvAzCBXDMaJIM2TwMZD446h?=
 =?us-ascii?q?Bq8U0I1PAIHAQoBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 t0AgKvOxBgRhQh5TCg=
IronPort-HdrOrdr: A9a23:l8qvmayTjPiWmxPmEl6dKrPw+L1zdoMgy1knxilNoNJuA6ilfr
 OV7ZEmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFeb/N5DNB7foSjjPIcOoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: =?us-ascii?q?9a23=3AfF537Gqp7TzaIWynSnZhOm/mUZt/InvNkmzqGkG?=
 =?us-ascii?q?xSj1mGJ6vW3y/yqwxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Avx/CWw9UaJleo+CILgOnC4SQf9lRyZuBLXwkrYo?=
 =?us-ascii?q?ll5SYCSNIZhen1R3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,251,1758578400"; 
   d="scan'208";a="252938309"
X-MGA-submission: =?us-ascii?q?MDF/40x2oykee2BzyJEk6opKBmPOp3JnjnVqtJ?=
 =?us-ascii?q?g/iubffEzKu6zGhfjOGqoGvVxbq3r4vbgOBFZLFA9Yxz+F3cl57N2/PN?=
 =?us-ascii?q?mCZ6fJAcgKslrIiLk5mKLTrVnwNZa4DB6f5Tatw9Jmp0Zwa36aggjr17?=
 =?us-ascii?q?GnuBxfc62anYW0GYsgCmISSg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 11:00:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764928836; x=1765533636; i=markus.elfring@web.de;
	bh=cvoPCU5Vz6cRc9w0mV9AO3BPbzeYe/s2SJ5ZIGbFmAk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OmWePgjwGMHT26vhpBu5K2sCcmwQ2f0zsAH+PneQSAn/TInPrjVju0rRtkT1YRVi
	 RfZ6xMemLdy/LkjtvnkMFcFzYjtXOn0i1PS8DHXsWe+wlQoeQ9YgpT/fX830qzyxr
	 QTTtgELKSpApLVqXLUBGWfGUtdsXSaCkPF/qHExnSKTGA6jlc8t7r6LQmKsOOF+xr
	 MIVtoO3zzTtU8NtHJZKEoB1dSK4IcCMANHRUCBK8loPsnVH+AUemxgusO4SUKtln4
	 RykqWDvV6d7C9Xo4937OfbIO6B4nSPTTsUo1iBnMD7Rs2uQuw1fm+wq/e0YSoX4UC
	 ZE7SP85LuxPlzFfSOA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.211]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MeUc2-1w1cJM2gOS-00hu6g; Fri, 05
 Dec 2025 11:00:36 +0100
Message-ID: <abba7598-a407-4e0a-a615-6d6a6a6ba703@web.de>
Date: Fri, 5 Dec 2025 11:00:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tobias Deiminger <tobias.deiminger@posteo.de>
References: <1b8dad8151ef1409adc8cb24c728907a@posteo.de>
Content-Language: en-GB, de-DE
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <1b8dad8151ef1409adc8cb24c728907a@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y1NFt1+HjGbFc+28vWBtO1j7RwMvKadLtzRVlTDA3RauNMaGhlm
 xp0QDB7P6hsfu4U/621DKc2Px1xNVzTv9ju71mbRK4icW7BHEpxSgBXXy1jf3zZ1j0kOzSi
 OeyIraFmjzbdMPNvMUM+Fd/c9gVqOR1qG9bS/Z/UIsPSnG3Bx7rn8luqPhgtJ0iQTh9nMCS
 MOB+kSbKFD/Z7Oqt1eoew==
UI-OutboundReport: notjunk:1;M01:P0:/wWuut33qRY=;fqsAYM6C4VShsuZ9FCKLbbCLHGn
 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
 +kucWKXBJhMObcieU0DQ+XfeJ5loc
Subject: Re: [cocci] Analysis of device attribute usage with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3244
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/abba7598-a407-4e0a-a615-6d6a6a6ba703%40web.de>

> I'd like to find the position of all functions assigned by DEVICE_ATTR_R=
O.

I guess that such a data processing idea will trigger further collateral e=
volution.


> So I thought to use a 1st rule to search for the identifier inside DEVIC=
E_ATTR_RO,

In which files would you expect such an item (device attribute?) to be fou=
nd?


> then use a 2nd rule to search for the inherited meta variable, concatena=
ted with the fixed string "_show". Like:

Will a need evolve for further data processing steps?


> @device_attr_ro@
> declarer name DEVICE_ATTR_RO;
> identifier attr_name;
> @@
> =C2=A0 DEVICE_ATTR_RO(attr_name);

Can development interests eventually grow for imports of such information
into databases?


=E2=80=A6> =C2=A0 attr_name ## "_show" @ p_fn (...) {...}=C2=A0=C2=A0=C2=
=A0=C2=A0 // invalid syntax, but you get the point
>=20
>=20
> This doesn't work and I couldn't figure how to do it correctly.
=E2=80=A6

You probably know further programming interfaces which support the recombi=
nation
of captured data in various ways.

Regards,
Markus
