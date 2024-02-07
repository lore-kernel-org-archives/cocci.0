Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2412C4828D
	for <cocci@archiver.kernel.org>; Wed,  7 Feb 2024 10:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=wjARcv9DDZkIwrbiEopLQE68T+9l16MVOWOX+mrSBag=;
  b=Qt7HsjgSF9MvA9xgovVDTT1ew0GB/EbthhHOWh9YLB/dTJ0e10FMdWp+
   S1KUW+rIYrdfg7CAS51Tw20PzuNnIv5yD7fxI5K5ICZZRaVZzJwQKJI+7
   LgpmNN1/cFQ8iPQtihibpjKYFRLEutm1N/jENh+FygP0W4atWbWuFt6fn
   M=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.05,250,1701126000"; 
   d="scan'208";a="150730880"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Feb 2024 11:06:35 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8C4A7E0CD6; Wed,  7 Feb 2024 11:06:35 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D75CFE008A
	for <cocci@sympa.inria.fr>; Wed,  7 Feb 2024 11:06:32 +0100 (CET)
IronPort-SDR: 65c35628_mDzmyGVfzOjWZnFv72fUPKQTsoH3oWJFR1/7IRPb5hjdXaP
 sn4Ky50A+RbiD4QCX0NfhDF0wGaGdqzOhCKZPtA==
X-IPAS-Result: =?us-ascii?q?A0G8AwCiVcNlhwsR49RaHgEBCxIMQIFEC4I5f1MyBAtIh?=
 =?us-ascii?q?FORZwOEO4c3h06KRoFAPg8BAwENQQECBAEBAwSCC4J0AodXAh4HAQQxCA4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXBw4QJ4VsDYJVG?=
 =?us-ascii?q?IEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXAkdCAQICASMdAQERJwQLCxoCHwcCA?=
 =?us-ascii?q?lYbAQGCfIIrAQMOIwe4eoEygQGCCgEBBq9aHywiVoFhCYEaLogmAYopJw+BV?=
 =?us-ascii?q?USBPIMDPoQKOU2DDoJoj16McVR/HQOBBQRaDRsQHjcREAUODQMIbh0CMToDB?=
 =?us-ascii?q?QMEMgoSDAsfBVUDQAZJCwMCGgUDAwSBMAUNGgIQGgYMJgMDEkkCEBQDOAMDB?=
 =?us-ascii?q?gMKMTBVQQxQA2QfMgk8DwwaAhsbDScjAiw+AwkKEAIWAx0WBDYRCQsmAyoGN?=
 =?us-ascii?q?gISDAYGBl0jBw8JBCUDCAQDKykDIXQRAwQKAxQHCwd4ggmBPgQTRAMQgTSFQ?=
 =?us-ascii?q?YJEAxkrHUACAQttPTUJCxsGPQKfIxeCKYEaEgzFIzQHgjSBYIFhDJ83BhMvh?=
 =?us-ascii?q?AWTKA4Gkl6YVoJSpiKBZAE4gVwzGiSDNk8DGQ+OIBkfg3WPR0I1OwIHAQoBA?=
 =?us-ascii?q?QMJhUYBAYMmNIFGAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:nw+Vn636TruBWxawtIyuywqjBGwkLtp133Aq2lEZdPUnSL38qy
 nIpoVj6faUskd2ZJhEo7u90ca7Lk80maQFhbX5eI3SOzUO21HHEGgB1+ffKlTbckWSygce79
 YDT0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaEZ2Ioz0ZNu6BeHcGPDWu6KBJb6
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:UynUUG3OeSNRfFWVou7WyLxfS8p8V0fmk3XrDGiKNEd0TpvMW1yawfYx
X-Talos-MUID: =?us-ascii?q?9a23=3Ax+tNpw81p+nFGgJ/XV1n3K+Qf91H76nzAwdVrZY?=
 =?us-ascii?q?bl+SaLyJ+Ch6Y1CviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,250,1701126000"; 
   d="scan'208";a="150730869"
X-MGA-submission: =?us-ascii?q?MDEnR9wAwnoC0q30nx/wJzgcmUGTZlFv0QDxfL?=
 =?us-ascii?q?V+eiLHiIJDZbAOan9ueJwBDbdAiVOShruHXmo+TaBV44Otq2Dyaqunx4?=
 =?us-ascii?q?wON76UHsY5VDJqQmraEp8GpSTmH+khUtfxD33/4ewHglvh1weLl9ryAh?=
 =?us-ascii?q?+02xmXE8uM/6FeSZ2UOxiW8A=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 11:06:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707300391; x=1707905191; i=markus.elfring@web.de;
	bh=wjARcv9DDZkIwrbiEopLQE68T+9l16MVOWOX+mrSBag=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=JvW3nJS4BMpf59XrvQndNJ2VdXBCWyJPq6TdOjUXxupgKjJSbl/Fg6XsrnhuPXkA
	 WDwk1YuLaCaobnyUvLxMG5hvjRNFIQG/iqNw+HVZJnnju6I8QnMquEj8thM3BQhUU
	 YzQZXX6ygbKnTIbBlBE08KrWuXzwH/B0gz/3WjSBzVFd87H7tDVSUdBxB3D34sSDw
	 P/o400BW9m8Ndm5O/eT3bn5FZbGesTOZRwk+4Mi14d9f24pqPxMsqe2wa/x1hmpjY
	 Pb8T//iGV4HCW//RiPfg5k3O63ZzPw2tsLSGQCMuTwS2W7AUWnqTOLYLG1JI+Lq/7
	 sdcalDrLQP1c5sOyAQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MWz8l-1rV8ne2dSb-00XUI4 for
 <cocci@inria.fr>; Wed, 07 Feb 2024 11:06:31 +0100
Message-ID: <289a052b-86ff-4ecd-ae55-89fc0238373e@web.de>
Date: Wed, 7 Feb 2024 11:06:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <41052adc-2065-4cf2-9160-2e986de1bf9b@web.de>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <41052adc-2065-4cf2-9160-2e986de1bf9b@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dKDKAHo8FeKMk2ztsx8OE0Tob11m5WEm3lwKewmN2eutW2efknt
 5zpdPe7eTHcdfxURIv3BjJE28YNtWJbOdhFrtUpS4KKE5LfkFFpVBENd8Z907P4t4KZoQRq
 DF8/JIByvOs1tiHttYwcQ+cLQaDOxI4ITMzj4cpiCWHt9gXi86I0lR0a0DaHvgq+djHnM6n
 63TH1a8MKBH5l8g+aRthA==
UI-OutboundReport: notjunk:1;M01:P0:o/+yEyw+tBo=;ReNGdGvGDDn6mi+0fWHPPz9cCDQ
 E1wnGRdMHaZd+HRO//kJ9TjikFvNMhoPhsu3p5A4K5IPNz3CV+GP1B13+c+SccSt/ZhBT5rG5
 IzgnMRfaz7CYeOmmk3kVzrGDTU4vdzPBWCFHmSC6VIzDJ0Mp8FYXvtw+688v1v+xKQsd2PHzG
 HbW+bw5m3Xkas3lMYlh24Op3budJLi6euXC7f7NtUmERt562RNQ5fZJH7Ypdzk2D6jOzTKaMp
 H64M1//qR6Bl7UUIWLCbQo/kvDLKzyVCcGzCKSMbvYWlbsRkk5QDMa7SZQnBdf1+dQkQvAIMV
 7OSHgyUamvQU7zDgPm/HKybpJFdRQhDi9M7d/G1Z9uQ1vTyAn4Bi98l0EKBYgE2Mr17aNv9N6
 o9G+NoNFslH64akPRGqzRIyieAhtDMjGa5x50d8gKXUHv8jZQOq3+OzDDxkSCAcCZVFPOl515
 8nM4JEdljcR/8N7Fh9i/FgYG6zv5kXm7hy1cHFCHSjGZeXlsUDh7iXFnN4xA4rRnSYheY7lNR
 DtNy7i9o40wQ1b0ziGD6hY7b4VvXy7VF7Mou1j0O2u6fnNuh/CDYMU7rIvQq83rR5iC04RRIM
 8Xv77KSUMEDbpzbmXidG4rfyz7F1bFhbTyWbmBScUOj8Smwo+GchSUyX0iJp3PJXaeS5ZGYxP
 bNlERrOg87E/SBz3TpqLrJ/ue4dUaz92Sx4e/BJqwn3HEtJGj2RVOvx8isCJQ8SYEqRBicqN3
 pop3UIvGbCkSceHKB+0c5TaURQvbsXuVIFUWR6JmWonYxnY+/ZS6lLL5335qKtlWNbK5sh0Jz
 9Avj0v8qoSH2Llh/ZuBpREebEK1TDbxZhMwllKPRWzOdw=
Subject: Re: [cocci] Supporting transformations better according to reduced
 number of function call parameters
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1509
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/289a052b-86ff-4ecd-ae55-89fc0238373e%40web.de>

> Corresponding change possibilities can depend then on the detail
> if references to previous data items would occur in subsequent control f=
low
> (or not).
> I got the impression that the data processing with the semantic patch la=
nguage
> has got special algorithmic properties.

Update candidates will be searched by an initial SmPL rule.
The search pattern needs to refer to variable declarations
so that their positions can be reused for subsequent queries.

Selected variable identifiers will be specified for an =E2=80=9Cappendix=
=E2=80=9D
which indicates the potential for further usage of them in another SmPL ru=
le.
How do you think about to support a software extension so that the complet=
e
SmPL code from the first rule can be applied once more (as a known submatc=
h)
without repeating it?

The submatch probably contains statements which should also be reusable
for desired change specifications including the deletion of variable decla=
rations
that would not be needed any more in a function implementation.
Will development interests grow accordingly?

Regards,
Markus
