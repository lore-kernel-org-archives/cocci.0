Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C62C02194
	for <cocci@archiver.kernel.org>; Thu,  6 Feb 2025 10:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=nfntBHwU/NZIQ1AFajrOHWbIP6EV/WKmSslur0sRdKk=;
  b=i1feuN+3f6U40yqjMD2xJ0e26ey3ihk4D9sj4EPFxKNBleWuoRs99ZvV
   /GPgHztqHU02e3zyGg8GxBNmlumeP02dM+sz4keO/nupx0/gREZ1tnjh9
   /25o/eKnr3DmpIestWQIUZ4cfJn7EEguLBhIPNP8v32UWYew7fQl66kQI
   U=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@sipsolutions.net
X-IronPort-AV: E=Sophos;i="6.13,264,1732575600"; 
   d="scan'208";a="206887354"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Feb 2025 11:07:39 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7EF6CE0D1D; Thu,  6 Feb 2025 11:07:39 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 78BA6E0260
	for <cocci@sympa.inria.fr>; Thu,  6 Feb 2025 11:07:36 +0100 (CET)
IronPort-SDR: 67a489e7_hE/EziblUhbb9oc+tHFxy8p23ZEB7hctpW7LCGSOFQDjsde
 iBY9gQ2NLVhxmzF0ZOF9gDByUa1JLz2g6uTBpUg==
X-IPAS-Result: =?us-ascii?q?A0HKAQD0iKRnhRAmd6hagQmBU4JEgVY0BwhIhFaIfIh3o?=
 =?us-ascii?q?BIPAQMBDUEBAgQBAQMBA4UAAosCIAYBBDMGDgECBAEBAQEDAgMBAQEBAQEQA?=
 =?us-ascii?q?QEFAQEBAgEBAgQGAQIQAQEBAUBJhUEIMg2CYgEzghYsCGMBHwEBAQMjBBkBA?=
 =?us-ascii?q?TcBDwsYAgImAgJWBoMVgmUDsB9/M4EBggwBAQaCadk3gWUJgRouhWyCYwGBb?=
 =?us-ascii?q?IN+AYR3QoINhD8+gQUBhxiCaYIzgW+BAoI+hkycKglJexwDWSwBVRMXCwcFg?=
 =?us-ascii?q?SlIA4ERI4EjBTUKNzqCDWlJOgINAjWCHnyCK4IggjqEQ4RNhVuCEoFiAwMWE?=
 =?us-ascii?q?AGDIXocg20dQAMLbT03FBufRIUmHIFgMxyTR7MlhCWBY6AwgUupB5h8qS6Bf?=
 =?us-ascii?q?SSBXDMaCCYKgyJPAxkPjC6CCgKIOcNeRTI8AgcLAQEDCYVEAYpsgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 J85q6ZhI4xb55DLhZYUhg==
IronPort-HdrOrdr: A9a23:uWbNgaj3NITt3tAVTs5rEmf4rnBQXtkji2hC6mlwRA09TyX4ra
 6TdZEgvnXJYVkqNU3I5urgBEDtewK4yXcN2+ks1O6ZLWrbUQiTQ72Kj7GP/9SIIUSXygc679
 YDT0FQMqyVMbEQt7ed3ODXKadG/OW6
X-Talos-CUID: 9a23:S5hOHm6T0r0CPvPRs9ss2A0tPv8gbV/mz1jrflKeV0d1ZoaKVgrF
X-Talos-MUID: 9a23:GxKYzgaPEhu4I+BT5jzogQxDE9ZRs5uPUXsIrqwNm/e4HHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,264,1732575600"; 
   d="scan'208";a="108365014"
X-MGA-submission: =?us-ascii?q?MDGflY+le1S5rcCvJ5a/1PSTIwnQibakZM3AkR?=
 =?us-ascii?q?saK0YJ6uu5kcoLcWRm6y6C3w48aQ/lsbUjzHMVbaeyRPYzw9VfS7Eoeo?=
 =?us-ascii?q?mf5OjHQEOQtTjKbbl9/NhmiHSsEiWtmHxP3dG7v+pdtPjI/J6/SDdJ7W?=
 =?us-ascii?q?285oDg2R8q0uVo6LV3cA+GCA=3D=3D?=
Received: from s3.sipsolutions.net (HELO sipsolutions.net) ([168.119.38.16])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 11:07:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nfntBHwU/NZIQ1AFajrOHWbIP6EV/WKmSslur0sRdKk=;
	t=1738836455; x=1740046055; b=xhpgBli69dmgxttDGo24smwpSAS63uVUJ+4wp54MZySW3Wd
	OaljRK2rhn2VEMEThY1gpXD4J9Kt04cLTodH/otSTPnFVZAKgWV7B/cJSR18UKtlkEGkFMnL/VOms
	hZjW4hqR+W5S4hqzz+Q4VT5fja6Q8CiY3IOCD0DzhLHs8hJReJPamrNi83FLjuZnFLc3kVSLz8EEe
	bUMMEsYfoRh1WCkPWcssfNYXSLzNPiAsl/HnCCi2kUBXgWqwsP17UhiujXEy+J8K3ZPO9zw2m+iMP
	Rm5pUutwoI5RwM6Jm274aMDpIknvuq9tfJ/U2y6/CfAz47dN6+ZhJDHdhD3U5HyQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tfynG-00000004ybr-1KAo;
	Thu, 06 Feb 2025 11:07:34 +0100
Message-ID: <9063a6e6c83f9169456bc009cc35426889cc46e1.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci <cocci@inria.fr>
Date: Thu, 06 Feb 2025 11:07:33 +0100
In-Reply-To: <ca7c1a14-522a-9c2c-4f85-2fda289b83e8@inria.fr>
References: 
	<381b5a9cb89cc068ca13546f69636291874010b3.camel@sipsolutions.net>
	 <061f1b6b50d305671c02742382a3df0ff95f9c6b.camel@sipsolutions.net>
	 <ca7c1a14-522a-9c2c-4f85-2fda289b83e8@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Subject: Re: [cocci] possible regressions in 1.1.1 -> 1.2
Reply-To: Johannes Berg <johannes@sipsolutions.net>
X-Loop: cocci@inria.fr
X-Sequence: 2356
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/9063a6e6c83f9169456bc009cc35426889cc46e1.camel%40sipsolutions.net>

On Thu, 2025-02-06 at 10:59 +0100, Julia Lawall wrote:
>=20
> You can try --profile to find out what it is spending the most time on.
>=20
> --show-trying shows if there is some function in the source code that is
> particularly problematic.
>=20
> These options might require also using --debug; I don't remember.

Interesting. It says:

> [...]
> rule starting on line 86 =3D=20
> -----------------------------------------------------------------------
> dependencies for rule rule starting on line 86 satisfied:

which is indeed the rule that modifies a function in the header file, an
inline:

@@
@@
static inline int
ieee80211_get_mbssid_beacon_len(...)
{
...
-if (rnr_elems) {...}
...
}

That seems ... simple enough?

However, the debug log continues:

> [...]
>      trying  something else
>      trying function: vif_to_sdata: ieee80211_i.h:1215
>      trying  something else
>      trying function: ieee80211_get_mbssid_beacon_len: ieee80211_i.h:1237

which makes sense, that's where the function is, but now it's just
"stuck". I guess it'll finish eventually, but that seems ... strange?
That spatch fragment doesn't even seem so bad, least compared to other
things?

Isolating just that spatch above results in the same. Looks like the
profile isn't very good when I abort it, so I'll let it run and report
back what it says later.

johannes
