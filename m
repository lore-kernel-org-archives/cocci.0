Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7523C4332F
	for <cocci@archiver.kernel.org>; Sat, 10 Dec 2022 12:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=EOjksBIhcq//6fLEotnF9rv7hmUs5K3VpM2PRD6+hKA=;
  b=q9yXG5ofjxbd/ObYjgGdKKZCHeFM+vjJ1DOXAsBE+sZoC4mJPpfQMbTZ
   b2hEGbkEp4cHQZp8jZfh01Wucm9hUYr7IDYDLbnX4nKH+sD6F4yBfZcCL
   NrPa1S9OwUhymzpIqIXg9woYQihgixSgGOzBSdFKNk9T76TE5zdA9suTN
   k=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.96,234,1665439200"; 
   d="scan'208";a="82745400"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Dec 2022 13:20:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9FEEDE0141; Sat, 10 Dec 2022 13:20:31 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 70C4FE0128
	for <cocci@sympa.inria.fr>; Sat, 10 Dec 2022 13:20:30 +0100 (CET)
IronPort-SDR: 6394798d_hqoJkcMpxE/jkPXQuNBPky+1DLXj8tIFsG5W2NDSKMC4cFk
 1yPxMtNA3Ngl4EmqUBO3q/y44Zna8UdmvsPLKbQ==
X-IPAS-Result: =?us-ascii?q?A0FFDADWeJRjhwQP49RagQmDfIFdLgQLRYRPkG8xhCuHI?=
 =?us-ascii?q?5ASgWqBag8BAwENQQECBAEBAwSCC4JzAoULAh0HAQQ0EwECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEDAQEFAQEBAgEBAgQEAQECEAEBARoJFwcOBQsFIoVoDYI4KQF1gQgBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBFgJHUz0BAgIBIx0BAREmAQQLCQIaAhEOBwICV?=
 =?us-ascii?q?wYNCAEBgnqCbgEDDiMHkzScF4EygQGCCAEBBpwHHywiU4FeCYEULIc6HViIc?=
 =?us-ascii?q?ScQgVVEgTyDAz6DfUc/gxiCZ4ERjD6KEAqBS1IlBA4DGSsdQAIBCzsyCkM1C?=
 =?us-ascii?q?QIMTCsaGweBDCooFQMEBAMCBhMDIgINKDEUBCkTDSsmawkCAyFhBQMDBCgtC?=
 =?us-ascii?q?SEfBxURJDwHVjcBBAMCDyA4BgMJAwIhVW4CLhEVBQMLFSpHBAg2BQZQEgIKE?=
 =?us-ascii?q?RIPBiZDDkI3NhMGXAEqCw4TA1KBTgQvYIECCi8omxqBNYEJlByvczQHgiGBT?=
 =?us-ascii?q?4FQDJ5sBhMulnIOBpIYkgiFOaI9hT6BeSOBXDMaJIM2TwMZD1iNYR6DboosQ?=
 =?us-ascii?q?DQ7AgcBCgEBAwmFRwEBhFYBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 R3yN5E+0tVdAn2keArL2sGGvA==
IronPort-HdrOrdr: A9a23:tu9PBasPwvY2AYzru7ag/+D97skDotV00zEX/kB9WHVpmwKj5q
 STdYcgpHrJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDpHZK3BgDVQfexQo+WvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,234,1665439200"; 
   d="scan'208";a="42285990"
X-MGA-submission: =?us-ascii?q?MDFScsWUYMuw1Y6z5YbqadJty8lRbNmSaIifwy?=
 =?us-ascii?q?jnJ8O/ikhzrfyt55LgpbVvulnK+e+ma/HueTtrgBF9cBuczqtOOqofSa?=
 =?us-ascii?q?6GIooDJaW+QqFWTcCMyulgq/0rCC7DKbBnSfjCpYBIxw/n5w7N0ifeDX?=
 =?us-ascii?q?bkuOD5Wm0V7hcP91D2p5qVcw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2022 13:20:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1670674828; bh=m4QL9PuAzM4fvzpjOizVjDOylH0mEgPFWA9melB3Nlg=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=I3pJfP/H10oaTdFsS6xFOzPpB9OQn3a6t1dYzncH+fNs9G3Vxa0co3p1gqUxR4xVf
	 Gg5w0wHE387Wbj88qu5hlUek9HTnL5zULY8lOcL2+p8krCN+xsdXIeDrwJtDIwGnW6
	 rBEz6oggcrtUC0uR3OcoSNcA5qWmJBkPb3Wt/Bx6Nw+zIvMYXhSNJ+tG/82Z1d72yO
	 Yhfp+4gt+xChpA8ZJ5QvcavgcB5w0ImOA/NXs38nvZJp4HRuWFb5MPAdaANsQkCJd9
	 mnmImeSz/bqO8NXDq6cGjQiVhfWmKkOYcUI+QT+uf7hj3zhgHO8tzPes0iFFE6+xES
	 MFGhcaLWrF22A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDdy7-1pCTZD0kcx-00AVI3; Sat, 10
 Dec 2022 13:20:28 +0100
Message-ID: <833178e5-29f9-5e7f-6ec7-8ac028dffdc3@web.de>
Date: Sat, 10 Dec 2022 13:20:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
To: Jonathon Reinhart <jonathon.reinhart@gmail.com>
References: <CAPFHKzf2pDTK_O9_m23D4R0ryFknAy_bjSSdLsu+ujJcZYCcdg@mail.gmail.com>
Content-Language: en-GB
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAPFHKzf2pDTK_O9_m23D4R0ryFknAy_bjSSdLsu+ujJcZYCcdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mEQx1xtQw0z96VOTyEFq4weyjkrKz2RLrjLSEEwq1UKWljV+KfM
 rVz6ZAqadmKeNMZ0gzxtXR0ElI5YfaZgBtKjnX/l528U1X9OrKpQ4ULVxNTxUPEQeqHWteo
 ZtQtWi1a6tD3ZSTSjVCXGlbp47Gx0OElenNBZPQEVsqVbUhuEG3K1jasalMFyxc5bEdX6Lm
 fHhyCe66ELWHJvOdYxMiQ==
UI-OutboundReport: notjunk:1;M01:P0:d8e04So2tPc=;I4jCRZ3bch+8D5iymM5vxPeAkL+
 /iE71j3zX+DmmYazTTOCYRBvolrZYogBdBk2/1cYDntvjaUPr25rcnC/ktLpvlt9ntoHynBzU
 /lUSycZCaiyRUu/UeBWKVILVLkf/JUEbXac6ZDbVNc6tH9UYs7IcXsZfmuuZ+huFmAlS2eZDM
 Aftj3/O9+btz/sTPZaBpJJK1hK/mWqOIYwIHzC+erGd+LBWTmnFjMi/hCs23WhLYzTh4lWlTF
 OxZnzkKBrtoWbDj3fCGop0XeCUgmrGB37kn/Y6CGz9QKbFv6Oy5m+dVdulJtBWqqp5C0QOx9+
 rWypCdGNzApNZDJJ8IAvWLbfwTXjCIUMx0EqY6gt9WuFUvonYE+5FFC3ybuOmFsi7Dmwv50f/
 vq6v/LS1V6Nr5UOOqx1zmwA/sbEI7xLdCsxN4ZVhegKPOPapeyk8XZl8PsAnHer8T6AOBAJNY
 cPKBq8lTaIYCZFcOKieyL3yITykj73mut4AePpkLVN5/dh3S+N1npxLfohzjakpjePdDZtvyy
 Bw7zqfGi9Swqtv0D7TKloSaWU4zJ8o8sYq6hCgz2vHkWOM2poo3NSKfarj+G5MvAT+VuCMGdJ
 Hu9BS1dD2bCcBj0k4agitkVud/TDOdBqvgqO4xEW6EgvmoGy69UE+NaJew6QlCAfINJMbAwu6
 Cnwsy+SUHdBg7l+ezTK7cOjR5mhRzb9QJXFiKGxUOMgcXO6RPHl4zFNLdtawlgSBGmyfZcFj3
 CSmbba2zG5n4/0GblqCJotViGHQ2L3feIA9fZ9XELivjmvZM6+0TFGKbFU6sPtthgL7r26Cw0
 BxrJ4tpB2EK7Ez21p6v62OWVXlwwQlBdY0K+yhdGdfeKFk0jTas6qT0kfN6CgbqEjeFtv/Dyr
 EEK2Qhgumlo9QJ63vjy0p2RLHbAxxXNCFGF/xlhYs05oBf+BPCGSjz9iJW2W0JfZbHjP9mOLO
 NzaMeA==
Subject: Re: [cocci] Converting strncmp() to strcmp(): constraint on
 variable cannot be evaluated due to disjunction
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 774
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/833178e5-29f9-5e7f-6ec7-8ac028dffdc3%40web.de>


> Hello, I've been using Coccinelle for about 2 hours :-)

Thanks for your growing development interests also for this software.



>     @initialize:python@
>     @@
>     def string_literal_len(sl):
>         if not (sl.startswith('"') and sl.endswith('"')):
>             raise Exception('String literal not enclosed with double quo=
tes')
>         return len(sl) - 2
>
>
>     @@
>     expression x;
>     constant char[] literal;
>     constant int n : script:python(literal) { string_literal_len(literal=
) > 0 };

I imagine that you would like to use the condition check =E2=80=9Cstring_l=
iteral_len(literal) =3D=3D n=E2=80=9D.
The extra parameter for a known function call can be omitted if the determ=
ined
length for a string literal would be equal to a passed number.



>     - strncmp(x, literal, n)
>     + strcmp(x, literal)

I suggest to take the following SmPL code variant also into account.

-strncmp
+strcmp
=C2=A0(x, literal
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 , n
=C2=A0)



> Can someone let me know if I'm on the right path here?

Your transformation approach looks promising.


> Examples with constraints are scarce,

I know that such examples were published.


> and I haven't found any examples of using Python script constraints
> on a normal (non-position) metavariable.

It seems to be very challenging to find similar demonstrations for
the semantic patch language.

The software documentation can be improved considerably.



> I also have some other patches to handle arguments like strlen("foo") an=
d
> sizeof("foo") (which is wrong).

Would you like to point any source code places out where you observed
false positives?

Regards,
Markus
