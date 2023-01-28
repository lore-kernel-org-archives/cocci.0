Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D8AC38142
	for <cocci@archiver.kernel.org>; Sat, 28 Jan 2023 13:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=riFwChrhbbqGxeBtUlx0kF64M1TOhlXP6XcntzoIFwU=;
  b=HZSBztkM9JpVFfMJ5p4roM9kKdktPre6bdzB7RPKMYHJouGfpa5JOaRj
   C8HrPockaB5bVNRruiqWv0g0JlO+HwJ1sDwhdiTwrN5cO/I/IPX+EWGhj
   3ZsaPoI0lOTUCqNRP5LgQAHMY+Y1zp7Lfl950DnMkgTBZbRb49zAzLUh4
   s=;
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
X-IronPort-AV: E=Sophos;i="5.97,254,1669071600"; 
   d="scan'208";a="89872849"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2023 14:44:11 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AA02FE0294; Sat, 28 Jan 2023 14:44:10 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2130EE027E
	for <cocci@sympa.inria.fr>; Sat, 28 Jan 2023 14:44:08 +0100 (CET)
IronPort-SDR: 63d526a7_h3RPtcA4/yd9OauF3v7c4tEij+8X6ofWk3V2LcYB6Tzqkas
 I/AUIXcZ+T/P6/x/YRtg0fXKOoqRxxSY7zoPONg==
X-IPAS-Result: =?us-ascii?q?A0H9CQAvJtVjhwsR49RaHgE8DAILFYN8gQhWLgQLRSaEK?=
 =?us-ascii?q?ZBxMYQrjlmIY4MWPg8BAwENOwYBAgQBAQMBAzqBEYM1AmuEOgIdBwEENBMBA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEaCRcHDhAFIoVoD?=
 =?us-ascii?q?YI3KQERVg6BBgIBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARICDToYOz0BAgIBI?=
 =?us-ascii?q?wQZAQERJgEECwsaAiYCAlcGAQwIAQGCegGCbQEDDiMHDKkOfzOBAYIIAQEGg?=
 =?us-ascii?q?UABmkgfLCJTgV4DBoEULIx2gzZ6JxCBVUSBPIMDPoJLFwSFNoJngQyPV4sNC?=
 =?us-ascii?q?oE5eIElDoFGgQ8CCQIRdEAlBA4DGSsdQAIBCzsyCj81CQILShAbGhsHgQYqK?=
 =?us-ascii?q?BUDBAQDAgYTAyACDSgxFAQpEw0nJmkJAgMiYgMDBCgtCSAfBxURJDwHVjcBB?=
 =?us-ascii?q?QIPHzcGAwkDAh9PcAIuERMFAwsVKkcECDYFBhw2EgIIDxIPBiZEDkI3NBMGX?=
 =?us-ascii?q?AEpCw4RA1CBTgQvXn8KBikmnR+CIAWBCSuVKY5igTOffTQHgiaBUoFSDIl+l?=
 =?us-ascii?q?HkGEy6Wfw4GkhyXTyCNMJpDgXkjgVwzGiSDNk8DGQ+OOYNZM5IvQDQCATgCB?=
 =?us-ascii?q?wsBAQMJhUcBAYZaAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 FUI
IronPort-HdrOrdr: A9a23:WhmWs6vAmLoILcF+gJsz93Y/7skDotV00zEX/kB9WHVpmwKj5q
 KTdYcgpHvJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQo+WvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,254,1669071600"; 
   d="scan'208";a="89872842"
X-MGA-submission: =?us-ascii?q?MDEH9Jxd86uqFM7n5AP2UY0GQH/uaKDETEB79D?=
 =?us-ascii?q?9svjPRNmHeCJsWi/HrEE6wYpkWUO0bhz+tkHHDGl9JiY5gTJ+6xxpHc1?=
 =?us-ascii?q?h18lOcJv0O+WBEJ1qlxfcJ/rhEtKyd/xJOMp6Qxtc0Btt12+CJKG24pZ?=
 =?us-ascii?q?dn1Y4jkfQI7nUUj19qatcIjQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 14:44:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1674913442; bh=bs7USx2iPwGQF9MQ9FwDqnTw+HgSmmEKWbgwbXtosUE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YtGa+2cCSHThhEX76yvyjdTrmheFNCv4kFNUmABH9ghOXAiJY9PcCrJP0jbJv9IfU
	 bCxrmkjUZVpFTy00Jcq/OIe8uO68OFyNXr67BXST7OoIvqWmxC11Yd/7Lk49kMxZ9F
	 QZnVrg8yAfz163rXgMwYkZqh8hjgf6de1D5x3Wyjam9myzyJyqS2Pi84KxMDP6No7f
	 SdZPu+OfwW0aL6sGd5RkLeWJgbbifg+qUw+25XjyrOPubVI8mtc6QFuyuktFLgPrx+
	 1SBli2ietuuREBEPLxdUbk0jC0zu8CLt56qWC0+urumx5vVRpCYhTg77sThwG9Vxnk
	 HTwKnNvdj5Z+g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N79RG-1oaf3W1rwa-017WuE; Sat, 28
 Jan 2023 14:44:02 +0100
Message-ID: <a47bc3c9-0d72-6fc6-03c3-2c124381bd81@web.de>
Date: Sat, 28 Jan 2023 14:43:52 +0100
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
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <8f3f48170bab688aff69571913dbe27fc195fe1f.camel@coelho.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:U9hvluQlvTGsU2uNKN4xafJVrN90vx75m6V8XLHAx1jH74XCoJt
 Q4gRo7gPmpa5aBRFgY3k0CK+iem2tLfw0dvXfe7FlHq1TC7WWsNEMWkAn37X7KuS5DGsifa
 MWYAUw5SYeACpP56R38BYn07MkITzNbQVfrfW96S2lJ0NlLncAsPkHareAig8plVjkqWFTW
 3COKzroYYfDW1pk3RQysA==
UI-OutboundReport: notjunk:1;M01:P0:7y/DTIU9tPs=;sGu5mibBZT0byWdy+XNh7fs1phS
 E6hFs0bmtm6m9hCRF3XuKsOlQSc/1tv6RVO0TbbQMJ9MQC0S2GBtigtAf3U47StWF8RCX5x3U
 mZXRLmpdfWW/YY5TANehiTiVR0bXoZSAqwtiyIXTMP1gVrYS+V+kFV/LFhpZf24VpYvtQV3f7
 42Z6xn8itHnibuIDMRi8ofopAG62befAt0n0nxif+/gAcNMQtOtkqdRtm8vBEqO9yuEo1/+Pz
 ccZ4hH3bSEB0Dml3uhq/e5BNvAarbEFYlwLrRKARq25g3bVTjWp/I6ULgtymWo0xKGaXnqI6+
 JAKOCkWBWUKkQoPcmnOnfdbJiX7Phs4uulj2v6T2KI9XRFvJVh30yfIhOwSj4z5y9D8D481FZ
 yrUqJ9SPd2J90+TumLUMQy8ucUYCahx6dSwjhGex2HKJMUnogAY9FvcbgujGswc5mf/fSv7lm
 yzxu21Ies5WH9IWs8WCyc2hI3LYkTNEKc1Yet0sDHzg7ElhfGlwjEAj6CzDJQc/hgkZdopzVu
 BAQDXjg7rqztSLOKWM84sMo46IC4bdtfwjUSYw/fhMKkO4N2TH5qG9EFmNZngMd18YqVHft8n
 B/Xm8gU+DVyhae4RprESA2qe5PQEYKa7L9TnMKd/hx8zJWfS9x9aT1aOSODB/kGwRkoXDeUVC
 tl9/AUzx7AoiEhnIH1vgmtJ/LE+rxi8iKaeJLPYjhi0D4v9lEN3zgVqe7ALoZOmD+HEotFh01
 0cNH7j+b8kR+bNHu2KFWy2ubySkmyK+Q2GO1L9EQU5JEVo1Bj5BbIcchT950tt8ryaGeZpazi
 5GLkBWeZNZdAxJQwnR6huq3Wwnmvje/K6plTQxXc9E8hggr9fgsviS7M/1YXOEbyEJvWyUwQH
 Y5+3OQZ3YZiVfI7pFEXDO4JhtTxsE6DrUDDqCBsqgWL8wYIfC/Pml2avtV24pOfkLZkN6UBFK
 n5694g==
Subject: Re: [cocci] Searching for special function implementations with
 SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 830
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/a47bc3c9-0d72-6fc6-03c3-2c124381bd81%40web.de>

> @@
> identifier nested_macros.nm;
> identifier dev_priv, f;
> expression e;
> @@
> f(...) {
> 	...
> -	struct drm_i915_private *dev_priv = e;
> +	struct drm_i915_private *i915 = e;
>
> 	<+...
> 	nm(...)
> 	...+>
> }


You would like to rename a local variable.
How do you think about to check if the chosen variable name will actually be used?



> +++ b/intel_display.c
> @@ -3943,7 +3943,7 @@ static bool bxt_get_dsi_transcoder_state
>  					 struct intel_display_power_domain_set *power_domain_set)
>  {
>  	struct drm_device *dev = crtc->base.dev;
> -	struct drm_i915_private *dev_priv = to_i915(dev);
> +	struct drm_i915_private *i915 = to_i915(dev);
>  	enum transcoder cpu_transcoder;
>  	enum port port;
>  	u32 tmp;

Which function-like macros should be found in such an implementation?
https://elixir.bootlin.com/linux/v6.2-rc5/source/drivers/gpu/drm/i915/display/intel_display.c#L3991



> Many other files are handled, but there are no matches, though I
> believe there should be.

Would you like to split the SmPL search patterns for another test
so that your expectations can be clarified better?

Regards,
Markus
