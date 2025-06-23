Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C629C7115B
	for <cocci@archiver.kernel.org>; Mon, 23 Jun 2025 08:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=0CeWndhcNIl5hI2uPV3nNRmJbfN7h9Zt3nquQBuC0Ks=;
  b=ZE1hM+N52sTTj/hzatqfjpvOpUTKwJpI1V9xs8/KMstXufX1RK0EXBtb
   1+LcKwaL7XoPVt955rXZmcwgz6GlNcFVOtpZylY/b8X69NGh1X50MXCoQ
   /nox+ABpEnfJilyrCKt/ERluB6uVfy+xRJKqSJnguY5n7/ismhsrlw6V5
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.16,258,1744063200"; 
   d="scan'208";a="228438881"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Jun 2025 10:05:30 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4F8F0E02E4; Mon, 23 Jun 2025 10:05:30 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BFBA8E0131
	for <cocci@sympa.inria.fr>; Mon, 23 Jun 2025 10:05:25 +0200 (CEST)
IronPort-SDR: 68590ac5_Gt4u8aUo3ID6YWclg6QnCF01U3oeMKu7D1U5Ih/jdm6R8tX
 hk+4eKYmqJU+Ntvwsxf5FnnulZAYxyhBAd+SSCA==
X-IPAS-Result: =?us-ascii?q?A0EjBAAKCllogAwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VOCRIEABlQzBAtJCIRNj1CCJIQ7jw+Id4NSAg8BAwENRAoBAgQBAQMEggyCd?=
 =?us-ascii?q?AKLaQIeBwEENBMBAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBO?=
 =?us-ascii?q?wcOCjGFew2CW4EsgSYBAQEBAQEBAQEBAQEdAg06RAEBAQIBIx0BAREmAQQLC?=
 =?us-ascii?q?xoCJgICVgcUAQGCfgGCIQEGEAEDDiQHDQawSIEygQGCDAEBBoJp13UfLCJYg?=
 =?us-ascii?q?WUDBoEbLoVtgmQBhieEPCcPgVVEgTwLgng+gmEEgiuDDoJpgiiBFoVNkzpSe?=
 =?us-ascii?q?BwDWSwBVRMXCwcFgSBDAyo0MSNLBS0dgSeBAIFOHIMhgRuERStPgyKBfkwZQ?=
 =?us-ascii?q?YNeHgZwDwaBIRhAAgELbT03CQsbBj2SY4IrggsrgkowpC+hQjQHgjiBZoFkD?=
 =?us-ascii?q?IotlTsGEy+XSw4GkwKZBCKNZZszgX8jgVwzGiSDNk8DGQ+OIQwWg14zyBhBN?=
 =?us-ascii?q?QIBOQIHCwEBAwmFRgEBinuBSwEB?=
IronPort-PHdr: A9a23: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
 QPNo9Qor1z0yoFnJRJ4XRAIpjsZ3eq2
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:0Kjtm6/Wdpt+dKTGD5Ruk+AMI+orL9Y04lQ7vn2ZhyYlFfBw5P
 re+MjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNSftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njbL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3AbGEJ/mokAOcgFfeg4v0KjYvmUdw/Q1jlknP5GnS?=
 =?us-ascii?q?DM2tHRbelSX3To6wxxg=3D=3D?=
X-Talos-MUID: 9a23:zWpzHgSf5sSFFZEPRXT3hTJvF+lB752CS2FXl7E5ipLHMTdZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,258,1744063200"; 
   d="scan'208";a="228438873"
X-MGA-submission: =?us-ascii?q?MDHdtSMEXfYBpfQtRibzsjfXTXqR/MiOExvjR4?=
 =?us-ascii?q?IWL9i+IeoLytOd/4CSTi85AUHqNs++KgIVuMqa4tdXDj8vIXjrJbS+Ml?=
 =?us-ascii?q?DDb51mBxDvauAygdl5ywDV5zEhFWIiMBh671rC5aPj3IBrqt+oJrPjLq?=
 =?us-ascii?q?2q4WfuA0GfCqIjj1mwZS/WEg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 10:05:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1750665924; x=1751270724; i=markus.elfring@web.de;
	bh=0CeWndhcNIl5hI2uPV3nNRmJbfN7h9Zt3nquQBuC0Ks=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pwY4oUm0X8NLIU2rLJHYOoeWIpzQNf5qCqhTTVP+/0t+SwnpoGtMiQS+cjGJG3yl
	 9KYRljd48Y9R3tmcF5zDL7m/5Za2HgbU2CsF7lkxpveecz2Li7LPtnFvi0qCJ51Tj
	 oz7BCFvEmJuF4IFJHmz+lledSN5tJhNccU/nQGx3TVfVR6xeBlPZFR4N0v7VEyOGw
	 HSB3GGBSryU/H0Gm4fjEjBreuTlPvKFBzLtbbl+I1ljcqaK/MdUPbcPeadICNzP6W
	 Q1KXSHMJA9cuK/OlV1b/gml0aSHLZqaftG2JlPNtPeyRHHN/Hy0Q3T/8JadmbBSYB
	 J3r+OMzPQUd9TYpALg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.229]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MyNwk-1ufvs81wrc-016rg7; Mon, 23
 Jun 2025 10:05:24 +0200
Message-ID: <481faa1d-7171-4657-8dc0-c37b153e6eaa@web.de>
Date: Mon, 23 Jun 2025 10:05:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr, kernel-janitors@vger.kernel.org
References: <2dc257b4-d310-47dd-90ea-9b081727be2a@web.de>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <2dc257b4-d310-47dd-90ea-9b081727be2a@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:MilD3xF2BpV/G3Yl0V/B62GKXM0vi87bwwAPv1k71aM7uonjTxf
 PhxboLO9VVpPUpcnZqXhJYsAgvJdnDeh1acHJpa/x/ivXWPw7S+rDhi9Eqkrj8dY/6KCM2d
 lvjBKEuQzUK+GEnxp6HcjWivJetfPN85vbnIkTkMbuYFJUmdDu+4MthYi3OAfFuEHiBlIXF
 I2NpZ9guKyRzxxUOYgwsw==
UI-OutboundReport: notjunk:1;M01:P0:fvz84xA5Omc=;U5cZQXExZgzxEV8r85OjEiAl5V8
 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
 glpj8URqhziWtOBq8rHVNGSZIN+lPTl2RI/ofg==
Subject: Re: [cocci] Passing code replacements by APIs (for SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2793
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/481faa1d-7171-4657-8dc0-c37b153e6eaa%40web.de>

> Desirable source code adjustments can also be generated into SmPL script variants.

Will any more software users get further development ideas from an SmPL script
like the following?


// See also:
// https://elixir.bootlin.com/linux/v6.16-rc2/source/include/uapi/linux/usb/ch9.h#L472-L678
@initialize:python@
@@
import sys
x = {}

def store_data(action, input, code):
    """Add information to an internal data structure."""
    x[code] = (action, input)

@find@
expression e;
identifier action, input;
type input_type, return_type != void;
@@
 static inline return_type action(input_type input)
 {
 return e;
 }

@script:python collection@
action << find.action;
input << find.input;
code << find.e;
@@
store_data(action, input, code)

@finalize:python@
@@
if x:
   sys.stdout.write("@replacements@\nconst struct usb_endpoint_descriptor *epd;\n@@\n(\n")
   sys.stdout.write("|\n".join("-{}\n+{}({})\n".format(key, value[0], value[1])
                    for key, value in x.items()))
   sys.stdout.write(")\n")
else:
   sys.stderr.write("No result for this analysis!\n")



Would you become interested to convert contents from any header (or source) files
into more advanced transformation approaches?

Regards,
Markus
