Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240C8C433F5
	for <cocci@archiver.kernel.org>; Wed,  2 Mar 2022 03:17:44 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,148,1643670000"; 
   d="scan'208";a="23910153"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Mar 2022 04:17:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6A57DE01AC; Wed,  2 Mar 2022 04:17:42 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D2E76E00BA
	for <cocci@sympa.inria.fr>; Wed,  2 Mar 2022 04:17:39 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=cocci@lists.ewheeler.net; spf=None smtp.mailfrom=cocci@lists.ewheeler.net; spf=None smtp.helo=postmaster@mx.ewheeler.net
IronPort-SDR: lBUen7wIrb+oMdWlHG4KYrVeNqqP9UIcrsqRgQQN3YECLcPeQXbFJ33bM7W8gZvAzza6Ym0XJv
 Xw9I62JPXBhfwPI7eI3rJMwz3pvMpeofhNMepr2IzCj7C2grx0I8A1u5Bzn3lyYVdlgeOO+GM4
 lss4AXVCX+M5ac/383smf9XUtD+/epM4Wt5yFeMrpDZDZGUAImLwskcFieTGhSX9ILcrb0egm1
 5haA3lEFE+Q+PQ02D6gS3X44y77vtuQljRU1a6aBy0pTLHtVNbWCLBX/Er2jbb5k54EWakyFhP
 RHK2x6pFRfI7oYqmBzQPsNFw
X-IPAS-Result: =?us-ascii?q?A0DPFwAg4R5i/0Xcza1aHAEBATwBAQQEAQECAQEHAQEVg?=
 =?us-ascii?q?VyBOgIBaQeBTQEBASkEC5YBg1ebMwsBAwENEi8EAQGJHQIdBgY0EwECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEDAQEFAQEBAgEBAgMEAYEILAFjAWcBgU4BgXkGBAMHM4I1I?=
 =?us-ascii?q?oQshRSDF606gTOBAYl7gToCAQEBhg8TQogEHECBTYE8DIJHhgCFMQSWXxOBJ?=
 =?us-ascii?q?xGBE5Jtj3eeEYNSBYlolWkGFC6WQ5FillShP4U4gT85JYFZHxQaCCYKO4JqT?=
 =?us-ascii?q?QECAQIBDAECAgECAQIBAgEIAQECAYshgwcWjk8gAQEBaQIGCwEBAwmTcAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:JmoQSKoVRrsLLWYwCv2F/mUOlXFeBmI4YxIvgKrLsJaIsI4StFCzt
 garIBmHO67YNmf3etp3YIqyoRkCsZ/Vy4MyTANvqCkzEHkU8uPIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKicfHkZqTZMEE/Nszo68wICqtMu0IDR7z+l4
 4uo+ZWEYAX9gVaYD0pNg069gEM31BjNkGhA1rAOTagjUIj2yhH5pLpGTU2AByOQrrt8RoZWd
 M6fpF2NxV41yj92Yj+TfhkXRWVRKlLaFVDmZnO7wMFOiDAazsA5+v5T2Pbx9S67hh3R9+2dx
 umhurSXdiQALPbLg9gtDURoTSVAFKpc1OHIdC3XXcy7lyUqclPp07NjE0E7MIkV4KBxDH0mG
 f4wcW9WKErb2qTsmur9FLgEascLdKEHOKsUvXprzBndDO06WtbOXKXH6NtVxnE2i9wm8fP2P
 ZFIMGI2MUyojxtnGFYICL9njemUhXTZegVolWurvLMWyj2GpOB2+OOxboGEJYziqd9utk2fr
 WnH13/oBwkTct2Z0zuMtHy27tIjhgv+SMQfC721+/pnmhuVy3B75AAquUWThsaao1zlXMljG
 xJJynQqk4E17mD1QYyoN/Gnm0KsshkZUttWNuQ17gCR16bZizqk6ng4oi1pM4N56ZdnLdA+/
 hrYwIOzXG0HXKi9ECrFrt+pQSWO1T/5xFLuiAcBXU0I/NnurYU+lFTJQ8oL/E+JYj/dQm+YL
 9Oi9nRWa1AvYSgjjvTTEbfv3lqRSmDhFFJd2+kudjvNA8MQTNfNi3aUwVba9+1cC42SU0OMu
 nMJ8+DHsrxQVMzcynbSGL5TdF1M2xpjGGaB6bKIN8J+nwlBBlb5IN44DM9Wey+FzfroiReyP
 BGI6FwBjHOiFHa1baJ6Z4+rCsIhiPC5fekJpdiPBuejo/FZKme6wc2ZTRXIjjC1zRN1yvlX1
 FXyWZ/EMEv2wJ9PlFKeL9rxG5dyrszn7W+MF5390Tq91r+SOCycRbsfaQvcauEi8LjCrRrV/
 ttbOtHMzRhDCbWsbi7S+I8VDFYLMXliX8yt8ZQKL7LaL1o0AnwlBt/Q3aglJd5vkZNVofiUr
 HuzbUlVlQjkjnrdJATXNH06MOHzXYxypG4QNDA3OQr6wGAqZIuitf9Nd5Y+cbQ92vZkyPp4E
 6sMd8maW6QdTjXc5y9bYIb9oYFmeQ7tgw+SZnL3bD86dp9mZgrI5t69JFe0rnFTV3buuJJn8
 bO61w7dTZ4SfChYDZ7bOKC10le8nXkBg+YsDUHGFdlkZxm++oZdLSGs3OQ8JNsBKEidy2LCh
 RqWGxoRucLEv5QxrIvSnamBooqkT7l+E05dEzWJ5Lq6L3CHrG+zh4JfUOuFeT3HEmX55Pz6N
 +lSyvj9NtwBnUpL6tAgSOwzkPtivta/9aVHyglEHWnQawr5AL1XIk6ZgZtFuJpLy+ILogCxQ
 E+Op4dXYO3bJMP/HVcNDwM5deDfh+oMkzzf4KhnOkn8/yMrrrOLXV8LYkuJmGpQM7t4PYco2
 6EntdJPs16zjR8jM9CniCFI9j3WcidaC/h+6sgXUN3xlw4m6lBeepiCWCX415G4dIkeOEcdJ
 DLJ1rHJgK5RxxecfiNrR2TNx+dUmb8HpAtOkA0ZP12Ml9fI7hPtMMa9LdjjosVpIhR7PyZbP
 3gtOlJ1KKiK8i0ugsVfN4xp98etGzXBknEdCXNQ/IEac6VsfmjMN3Emf+uS/E0U929GOD5W4
 Nl0DYojvSnCJKnMM+hbZaKhg/jiVsBqsADdmM2qG8mfWZ83fVIJR0NoiXUg83PaPC/6uKELS
 SSGMgq9hW0X+BP8e5EGNrQ=
IronPort-HdrOrdr: A9a23:ba8QBKBTWf6SzSflHem855DYdb4zR+YMi2TDtnoBLSC8EKSj+P
 xG88506faZslcssRIb6LW90cu7MBHhHPdOiOF7UNuftWLdyQiVxe9ZjbcKHAeLJxHD
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,148,1643670000"; 
   d="scan'208";a="23910150"
X-MGA-submission: =?us-ascii?q?MDHbkORpTKAN/1gJ7UYdLFwlHZNTFOApJ2AyVT?=
 =?us-ascii?q?I8Hz45oyWIG7iBq7kw1Gi60ytMdvDvqimIZ5AeRotfBsrRRPR9S43yY8?=
 =?us-ascii?q?UYPJvxZPjsdl/HWBACar1Sy6VCOva2PfNyodkCsKBtwCsLjtTeXCm/QN?=
 =?us-ascii?q?ntCO5BYl/ggb1HD5x3+pSOtw=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 04:17:38 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 3CA1445
	for <cocci@inria.fr>; Tue,  1 Mar 2022 19:17:36 -0800 (PST)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id cYb5bcF6jEkn for <cocci@inria.fr>;
	Tue,  1 Mar 2022 19:17:35 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 6985941
	for <cocci@inria.fr>; Tue,  1 Mar 2022 19:17:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 6985941
Date: Tue, 1 Mar 2022 19:17:32 -0800 (PST)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: cocci@inria.fr
Message-ID: <9225d1eb-8211-53d7-9cec-bdbda52f743b@ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [cocci] How can I find all static variable declarations?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 162
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/9225d1eb-8211-53d7-9cec-bdbda52f743b%40ewheeler.net>

Hello,

I'm trying to find all static variable declarations (either global or 
within a function:

	static int global_x, y, z;

	void foo()
	{
		static int a, b, c;
	}

with a patch like this:

	@ rule1 @
	identifier I;
	type T;
	@@
	static T I;
	+ // static ^^

It gets single variable declarations:
	   static gint iv[4];
	+  // static ^^

but not multiple variable declarations like the foo() example above 
because 'I' only matches a single variable in the rule.

It also matches functions, but I really only want variables (if possible):
	 static void subph( int nx, int ny );
	+// static ^^

I tried an identfier list:
	@ rule1 @
	identifier list IL;
	type T;
	@@
	static T IL;
	+ // static ^^

but gives the error:

	init_defs_builtins: /usr/lib64/coccinelle/standard.h
	minus: parse error: 
	  File "nec-static.cocci", line 5, column 9, charpos = 50
	  around = 'IL',
	  whole content = static T IL;

What is the right way to do this?

I'm just printing the diffs so I can inspect the code, sort of using 
`spatch` like a semantic grep.  Is there an official way to do "semantic 
greps"?


--
Eric Wheeler
