Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CE4EB64DC
	for <cocci@archiver.kernel.org>; Tue, 11 Jul 2023 05:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=F43mgdvPlM0O+EUsqpRm2mp+U22gT6QBIUq/5gV0zFQ=;
  b=jkSTFWBJcEHjZmSdYcYLUr7jjXAA8EB6998Jt2QjC7s7nvoF7+06HXYp
   +B/5IiDFvA3ad9aIta86FtfnIPNmo19JwQg+rLHjhczsQR9P1lLLkT5DF
   DEZN+zQ8P9gxiajMhkGhDxCDrkyOdGjxg8fky4rqqDzZuA68IQ8kvRXmp
   0=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.01,196,1684792800"; 
   d="scan'208";a="117001127"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Jul 2023 07:50:26 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A844DE00B6; Tue, 11 Jul 2023 07:50:26 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id ED65EE00B6
	for <cocci@sympa.inria.fr>; Tue, 11 Jul 2023 07:50:21 +0200 (CEST)
IronPort-SDR: 64aced9d_SLP+Ye9mHmuer29c3l8pr/Jq041f6Yhc2GAWYmMuuq4zetC
 +Tc7q5ly89ZcyL4/2/ntbvXQfnNThO+btQ1a2ag==
X-IPAS-Result: =?us-ascii?q?A0FZAACE7Kxkhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYIyeFMwBAtHhFKIHYcagieENocyh0eEaYQEgVaBQD4PAQMBDUEBA?=
 =?us-ascii?q?gQBAQMEhH8ChiACHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBA?=
 =?us-ascii?q?gQFAQIQAQEBIxcHDhAnhWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEXA?=
 =?us-ascii?q?kc/AQICASMdAQERJgEECwsaAh8HAgJXBgEMCAEBgnqCKAEDDiMHqUuBMoEBg?=
 =?us-ascii?q?gkBAQavVB8sIlWBXwmBFS0Bh38BhH5DhDUnD4FVRIE8DIJ4PoREg1uCZ44hk?=
 =?us-ascii?q?0aBJ2+BHoEeegIJAhFngQgIXoFwPgINVQsLY4EcUjmBQgICEScTFAVOeBsDB?=
 =?us-ascii?q?wOBBRAvBwQvBxYJBgkYGBclBlEHLSQJExVBBINTCoEJPxUOEYJSKzY7G02Ca?=
 =?us-ascii?q?gkXDjUHTH4QMQQUHXIEDgMZKx1AAgELcD01BgMLGwYlAR4CKYFXMFRwJCSlX?=
 =?us-ascii?q?kICgzbEbzUHgjGBXYFdDJ8dBhMvlxUOBpIwLodAkDggonmFJYFjOoFcMxokg?=
 =?us-ascii?q?zZPAxkPjiAZHoNwj0g/NDsCBwEKAQEDCYVGAQGGAAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:G/a5UatXBSIYsocCtsTRVSBl7skDotV00zEX/kB9WHVpmwKj5q
 eTdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniDhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQouWvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: 9a23:CR+FDWPtFAKDRe5DfjR7zkkvQpgZWVrekUuAI2aoLUV0cejA
X-Talos-MUID: =?us-ascii?q?9a23=3AMmpJ7Qz402gEiRLhxd08Sm3I/bKaqLyNNwMfwbl?=
 =?us-ascii?q?egdWjFA1CFCez3Qj0TqZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.01,196,1684792800"; 
   d="scan'208";a="61087337"
X-MGA-submission: =?us-ascii?q?MDHfWhVvjgStg68bBcrY834GJUPoKmfM3aVzmi?=
 =?us-ascii?q?D0zDkUi3a0ijOMp3hdS8LbgGhFRThA6NfexfjRUm1tBTIKGiC+sfAynN?=
 =?us-ascii?q?X85aMQLNymP7yKJ/htntjrz+YQOLxF4/A4Heqi9WcZAxZwRmjbYndN9n?=
 =?us-ascii?q?fAGb6ivf1PyFCgjPc+YkOsbA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 07:50:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689054616; x=1689659416; i=markus.elfring@web.de;
 bh=QPND7Y0dpd4X1s3FRX6N2ZLGwtuxoPBv1HCYRTAkeRE=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
 b=XdLCyml8St27iVC1NL/KXqPs+LRx1nOvO8b0J+HS+oTKyD4nk6X7LshMIKeSZawSpdmuNPc
 T75ZlshfDjWyviDLgpAnz9/xcpnWw8ogk43l404/Cpnv3JLyfgbWvujFcgYlE8ZXdECzDeEe5
 x4P1E8s+PShH23BDD+rfj0cT2l3b51ET346nt8J0XuDTWfhNF0JgIpnxJxzMK49I4Yui0VRU3
 ccIhviNpX820l3zcx0SxDCRiMb/XWuu/cbXP5dd1F2nbU6uS86MeuHqFaeuvqPegEHf3fgRI8
 CYgkfULGh0oFp5Sw2csyTgxUYr7hyZN6tIFgiX5Y0sn2OTTKEwWA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7xeZ-1pxhhT1sbj-014i3R; Tue, 11
 Jul 2023 07:50:16 +0200
Message-ID: <a1679697-827b-0e3a-0948-c84510fcbecc@web.de>
Date: Tue, 11 Jul 2023 07:50:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-GB
To: Sean Christopherson <seanjc@google.com>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230710170652.473788-1-seanjc@google.com>
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Julia Lawall
 <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230710170652.473788-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HFVBrcRTu9cyMLjz2NozeWJBV0JLuvquWf44RsHUVsWosc8tg2w
 Q4n0V2v+UdcQRTjiSup8XpouFj2FGfeRPF4eVrcC/JBkWm+5y8s8hnPLXKDLnOh/FdR0vq0
 4u37Nd8TwdQ9dsSyt0lgnJhC0UpSCPebp74DEzU2KUg6nFla6HL8kXIW6CDoCpcGT48iSD6
 WBwRz6wYaoGGi0rQDSYiA==
UI-OutboundReport: notjunk:1;M01:P0:AYwvBFF0OY8=;KltEzUZ5hWxe8g4weoE9uJLYsv+
 OtWU++mBdnf5LDqjaZ+4MUr/BktNuyiTUePCmoxd+MjCm5FBzN8caNfmsx1HPACrmgeYTYxgW
 g7apx0sRxIcm37owdNRyiQs8t7x3nIjhAukAonWxQQW8bp727jBoxpDPY4VZpY0unAtigwiFF
 kFo+ndX1AErFJLziDevM4i2v39kwOlej6/eKp3gXOfKQwdl4Yu3hJ+HQmgw+L4CfHAzcgHvsh
 F3yBOFXy6r25xW4ycpHOU/69V36faqwpLEXWTQdYOpmj1OmspCYCSqLcEeKbnsno6sDa96H12
 GsEqmkWRTwDNfDw0udTa/Jp8bmsHD/rfJ7p51e22p9YE6Ta/jAuqfR6ZNZkYK44408h1Qbcbp
 S5u7xZQfHhCBo0/oEoHdf/ehJmLwZl2BpSyytds8Oq2cDzX6gRwtv3IELT0Rc9swnMWRTleTh
 EZzP1kvJdchRYL5THxOjdrDMxFeX/R7f3scZJ4ZslIplIFBsA8z+aJxlreGhds5YYgAXx7c2e
 bjxMUhFqs6YB+iUVMBpn2S7Hp5CvWiIjafkkDBdAjQ1vdOCBsC7lSYP567+l8D09H8FZGyiP1
 n/1QuRElirFFV13p/qpbR/TfsjSiI1FI0Hy7CSTxgmjsnuffrw1vuNOX70HoM+wntNmCM4M9g
 X3J4sxRFlNN2szEY26gR2nTwlC5IlIT6KJ5h85W89ZpfgijM1XkX3iFEObZZdr9rL7dqt3yBY
 tn5ty7ZU6OMUc/CnFYhSO3ZBmBkQMZE2GvLc4S5jGaFxn/QQcaTlEDd1hB62lbIUIIo1OQGqH
 sP6GM2eIeIO7do6545AAG2jQf5nSNgZw/ENsixCyzsoxHLxY3UFyzQEdtAO1T6U41vEdAaqZV
 v82ZhetWK7/8024DC79/lMMNpWX/ebKWxUI+sS4DuLwIPCKpRPBpSEEZ4Y63hmbNxoWLvLD7r
 RSuKCg==
Subject: Re: [cocci] [PATCH] Revert "debugfs, coccinelle: check for obsolete
 DEFINE_SIMPLE_ATTRIBUTE() usage"
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1215
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-07/a1679697-827b-0e3a-0948-c84510fcbecc%40web.de>

> Remove coccinelle's recommendation to use DEFINE_SIMPLE_ATTRIBUTE()
> instead of DEFINE_SIMPLE_ATTRIBUTE().

I find this wording inappropriate for a change request
because of an undesirable term duplication.
Would you like to refer to the identifier =E2=80=9CDEFINE_DEBUGFS_ATTRIBUT=
E=E2=80=9D here?


>                                        Regardless of whether or not the
> "significant overhead" incurred by debugfs_create_file() is actually
> meaningful, warnings from the script have led to a rash of low-quality
> patches that have sowed confusion and consumed maintainer time for littl=
e
> to no benefit.  There have been no less than four attempts to "fix" KVM,
> and a quick search on lore shows that KVM is not alone.

Will such information trigger any further clarification?

Regards,
Markus
