Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15E4C54EAA
	for <cocci@archiver.kernel.org>; Mon, 30 Jan 2023 09:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=4TcVGNeZ4fdWBkNpAgCdLwTYlaFRWOFi2aK1Z3moR6A=;
  b=o6EyvZ+/V4TcsVQ25gaN8BNSNXFhLncST18n6BoT1bPJ0ZV08eFaCO24
   pym8UXkn6BdP5LMkoqmCyfXptpDIcq8spsOcm1EOjEfyM3aNIApWHhZut
   W9097vPYw/KdhkJ7TZ6krJx4yEqoUgxceyHihJy7g2UohiVtcBRdc/Xnn
   g=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.97,257,1669071600"; 
   d="scan'208";a="90025301"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Jan 2023 10:35:19 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DDB5BE7442; Mon, 30 Jan 2023 10:35:18 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6E94BE743E
	for <cocci@sympa.inria.fr>; Mon, 30 Jan 2023 10:35:14 +0100 (CET)
IronPort-SDR: 63d78f51_6vbJu3WNKU38RbKIfMgV+MPcjCAx6TWFJacaR7TsXYQjhmh
 kvm9IhYQMalodELAnXzj58k1Cpc3b2nvAK8Cg6w==
X-IPAS-Result: =?us-ascii?q?A0EgBgDNjtdjhk7ASNlaHQEBPAEFBQECAQkBFYFPAoIrg?=
 =?us-ascii?q?QhWLgQLRSaEKZEihCuOWYhjgVaBQD4PAQMBDRQBAQMkBAECBAEBAwEDgUuDN?=
 =?us-ascii?q?QJrhDoCHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECE?=
 =?us-ascii?q?AEBARgJGQcOEAUihWgNgjcpARFWDoEGAgEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBEgINOhg7PQECAgEjHQEBESYBBAsLGgImAgJXBgEMCAEBgnoBgm0BAw4jB?=
 =?us-ascii?q?wypPIEygQGCCAEBBoFAAZpIHywiU4FeAwaBFCwBjHWDNnonEIFVRIE8DIJ3P?=
 =?us-ascii?q?oJLFwQYgUaDWIJnkGGLBwqBOXWBJQ6BRoEPAgkCEXRAJQQOAxkrHUACAQs7M?=
 =?us-ascii?q?go/NQkCC0oQGxobB4EGKigVAwQEAwIGEwMiAg0oMRQEKRMNJyZpCQIDImIDA?=
 =?us-ascii?q?wQoLQkgHwcVESQ8B1Y3AQUCDx83BgMJAwIfT3ACLhETBQMLFSpHBAg2BQYbN?=
 =?us-ascii?q?hICCA8SDwYmQw5CNzQTBlwBKQsOEQNQgU0EL16BBAYpJp0ZgSyCLYIfwxw0B?=
 =?us-ascii?q?4ImgVKBUgyJfpR5BhMuln8OBpIcl08gjTCaQ4FiOoFcMxokT4JnTwMZD4hKh?=
 =?us-ascii?q?WINCYNQM4RhjTtANAIBATcCBwEKAQEDCYVHAQGGWgEB?=
IronPort-PHdr: A9a23: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
 yY=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:+rWcgqpjh8N0O/rXXu3zijUaV5r/eYIsimQD101hICG9vPbo9f
 xG785rsSMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaGSS5vyb3ODXKadC/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,257,1669071600"; 
   d="scan'208";a="46333004"
X-MGA-submission: =?us-ascii?q?MDEhWZrR5TIq6q4Po5mTx1qHVkVErnDYY6jH2H?=
 =?us-ascii?q?zcphO9VSu+tKqL1G4CETHuHA9u4OmGXesKU28yBbZDfvByDE8HWrQw5w?=
 =?us-ascii?q?6Pi6oS6vCVIDrsa5mECORPi5vAJHEFuYf/RXHlfrO8NKt0DTAwhOfQTr?=
 =?us-ascii?q?rj5tTgDtQw+DsgFoaCna40XA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 10:35:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1675071311; bh=Ev5NwZ8TxrqBqVdhfK7+rThvJqBHhoctdrSN+2qdSAA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GllR3JQYh9aDTRURpkzAqBnXzDiyRl0yMoFAWlaaTuBznyjgXTPWxjZwwa8QK/SQb
	 f4Vvk7Wwj+6AAAvxeWBoaIJdBirUGbcjuNBznK3wcWBjQW0SGQMIiZl02mtSjeo8Lq
	 0UpAt7OX6imTzzdoiFSmUTxeMtjzKFnIM1o989uKTX0C3IATuMEAHek49s0rF50+m9
	 oJiW4JC+kjidKX7V+SQ3xI46ckVpYECZI7AXRuDoKhMBRc2pzwR0cNfvWsJjfi4XZc
	 RkNbUemfKGc8Zy5KnPJ2tc8ywu0caLbAAuotB1WBHaK/DfpB3divgOpPEA9RX/8BuE
	 eWX0lcWEWHNyg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNwjS-1p2hpH1hJQ-00OKds; Mon, 30
 Jan 2023 10:35:11 +0100
Message-ID: <23ba4681-0b9e-cf60-5422-64526cdf462a@web.de>
Date: Mon, 30 Jan 2023 10:34:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To: Luca Coelho <luca@coelho.fi>, Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <df710cc39e1da39521f09827f5528703887e9bce.camel@coelho.fi>
 <alpine.DEB.2.22.394.2301272148570.4094@hadrien>
 <add79b45c4369d40ced6ae5fb43535e14a7aa792.camel@coelho.fi>
 <808cd549-f96d-872d-a4db-30ea33095207@web.de>
 <alpine.DEB.2.22.394.2301281048270.2822@hadrien>
 <8f3f48170bab688aff69571913dbe27fc195fe1f.camel@coelho.fi>
 <alpine.DEB.2.22.394.2301281432120.2822@hadrien>
 <a1eed78f1f3f24c20fc11bb7328c3cb05db1611c.camel@coelho.fi>
 <alpine.DEB.2.22.394.2301291826510.2852@hadrien>
 <543612938885a445d33ca5ae6d04a06a753c1caf.camel@coelho.fi>
 <2338a91ffe751ceb6325e76bc526b84ca85fc4c8.camel@coelho.fi>
 <alpine.DEB.2.22.394.2301292109320.2852@hadrien>
 <3f376cb31e9050d005417809a9fa51d92cdc57d6.camel@coelho.fi>
 <dc9d939d-e1bb-8447-e950-deacc7a3645a@inria.fr>
 <13bf65ac8504fa5ebcaf69539422fcd38bf157d1.camel@coelho.fi>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <13bf65ac8504fa5ebcaf69539422fcd38bf157d1.camel@coelho.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nehPJkaaDrkxU4t9lPmP7CRucwMKTMsxXTstyXEebjLE4U0V3HP
 zyZxvt0plq+mwXgjNq54gXz25P9zoZkhcy3xttbuYIMwetwt91dRt9uwUuhr1kjfhZu04Ep
 /fSzvltoWljggabeh5My//qVnUIS0h9zJVOhVGgp1zB6h0r78w0kKTUyDeLXaCiJsvYLxLb
 xKCeq8SBEKPuwR2A9SQUg==
UI-OutboundReport: notjunk:1;M01:P0:KNQCOdIE864=;cNHKYi/53+V/SElAUyJ3w67cAMs
 0h7+ytvNJm86zhAF+PAhFj0bFaLX7MoyrwryTdY7STxJyspKs1t/fJdn4Q63Mqlfg80twMOgd
 igPjBjJbIS48hyykXPg9tGUwfluqT0KKTQOMtj4H5f20hVa/mch3HdlS9udsk1bgGMC50329k
 blJRsAtbZ/HFImIeUNRGBz9GvPePIo3TbVO4jgH1yGX6zW7L6zIqTwHFhdOulI8+Zu7ohpObm
 ZNGSiB51+Wv0+IexPFWrX09m+A9iaFVOQnKEv11odbVWNzTW7kQf358tdJQsXHFv4PUWtB3+y
 mbQ87eBWfyty9o/pehOw31owXkN55p7MZHSfPT2CCs84UwUr4KBHcWeWh6cNfXlpi7B0OdBkL
 33HhlMyLcIcgQzDS/9aaYHXpEZdlvzkzYETulZArxGCexWkRgUN3hf8j+NG+wJtbrkR3aLGjV
 l05At8yQ5vTfn2aeOPMM7FGH0Du9ABEvkQeJseOcCHK3MVVb5EPOkvbfQF6e47LzthS9U56qx
 ZrZ9fTgN7hq8IdLjZ8U3OeSm98hSrCViJNdpj3BBOw7V3Tm5R/AePRTjmehzDPhff0/AYL0K0
 A/WFYusWrWGZl+X8bQ+UAIwwIXdFqOx43DUFMxddrzchnZa21ISSgkd45pqVzihHO9fNE9ONu
 WVfxXo2Wen4xr8m6X2JNM9FkLmBrLvNPslVpsc+4Nm6WqdK6bxajaj2f0CMSCXnJ3iCxNpD6s
 tE59XfVb3pDJCkdmvT84cO8xIn20CtT+YMRv8zLADo7jfFpgW7kZWLIuzXTC8LHS4oM75bprS
 6pA3kd2Tuq9MNUpOKdEtdv7hbLB8682YfLjH6cZ96Qunv9tLL73rv8iWN1UmBuSiPOhaCac1p
 /tZH7F+J2q1fDfDHy7RGdsujVVMbO68Z6tLH/LjBsmhz2JY2E72jrdP0/Y0KLfIKOYK2SDh6I
 wtZMYQ==
Subject: Re: [cocci] Searching for special function implementations with
 SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 847
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/23ba4681-0b9e-cf60-5422-64526cdf462a%40web.de>

> Maybe I celebrated a bit too early.  There is still one instance that
> is not matching...
>
> I currently have these rules:


You present an additional SmPL rule.



> @@
> identifier nested_macros.nm;
> identifier dev_priv, f;
> expression list el;
> @@
> f(..., struct drm_i915_private *dev_priv, ...) {
> 	<+...
> 	nm(
> +	dev_priv,
> 	el)
> 	...+>
> }
>
> And then we have this function in
> drivers/gpu/drm/i915/display/intel_display.c:
>
> void vlv_wait_port_ready(struct drm_i915_private *dev_priv,
> 			 struct intel_digital_port *dig_port,
> 			 unsigned int expected_mask)

=E2=80=A6

See also:
https://elixir.bootlin.com/linux/v6.2-rc5/source/drivers/gpu/drm/i915/disp=
lay/intel_display.c#L497
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/gpu/drm/i915/display/intel_display.c?h=3Dv6.2-rc6#n497


> Any clues?


Can it matter to omit the search pattern =E2=80=9C...,=E2=80=9D for the fi=
rst function parameter?

Will any additional SmPL disjunctions become relevant?


Regards,
Markus

