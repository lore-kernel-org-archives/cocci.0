Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79CAC433EF
	for <cocci@archiver.kernel.org>; Sat, 25 Jun 2022 16:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=RyXrC6hoPcUl3RZdBOo0ceJfsnqmIs0XwwGqQwbWuiw=;
  b=r8Hv0oiDwXZzevl1vALTFL/p+hQCIUPgcsb6cplZavYgeczlV8f/+T5V
   QKcxDagU2Py4ZEM+EwmQCpJaeEVEjJYFVLPef+A9Wdw7z2y2QYxaKCukc
   +D2aeDLZ522r9G3MikV4J4p0opISF+lWG4ZGEetvM0lROXXRuv7n8CQe0
   g=;
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
X-IronPort-AV: E=Sophos;i="5.92,222,1650924000"; 
   d="scan'208";a="42849592"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Jun 2022 18:56:18 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 84F7EE00CA; Sat, 25 Jun 2022 18:56:18 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 38F3AE00BE
	for <cocci@sympa.inria.fr>; Sat, 25 Jun 2022 18:56:15 +0200 (CEST)
IronPort-SDR: TEhvkEtozrBsOjkYzPRkpQEpNyKirm3wq6xfJYlu15owEXnzlwhkiNzFXeytFwjrtNYdDDYpyN
 QaU9iaa6mWKwQGovLnfJmbJJauJ0vka+jLMVT4J/207EQsDnNpTCV8MehjZJuHiBvYpIXBaVfA
 y1UPEwBCW2m4TkSvcG+wTCKS9zc8Fx1OBbzN5MY9yrrqWkaEKwsEEf3GTc9P/sn603MKAfFHci
 m4rxUFzfKMhVfG4iAYqdxpypmNUxNt/RhtWlgwLM7kwqjxwTqzSHmPj6h/BnYMqoWm0fP2mYr+
 usnCoujJhyTGzsr7ytkoT/7y
X-IPAS-Result: =?us-ascii?q?A0BwAAA/PbdihwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYIjgQFWLgQLRIROjmiCKGmDOppLCwEDAQ0yDQECBAEBgg+CdAKFS?=
 =?us-ascii?q?gIdBwEEMwYOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQwNC?=
 =?us-ascii?q?QUICgcOEAU2Bl4GZASBSwSBdAs0DYI1KQGDZAECAgEjHQEBESYBBAsLDgwCJ?=
 =?us-ascii?q?gICVwYBDAYCAQGCeQGCZAEDDSMHC6tHgTGBAYIIAQEGhEsfLCJSgVwDBoERL?=
 =?us-ascii?q?AGKWoQdJxCBVUSBFScMgnc+gQ+BPBcEGIUcgmWZRiYEDwMaLS8SgSBuAQgGA?=
 =?us-ascii?q?wMHCgUwBgIMGBQEAhMSTQYcAhIFBwoGFQ4UHBISFwwPAxIDEQEHAgkSCBUrC?=
 =?us-ascii?q?AMCAwgDAgMgCwIDFgkHCgMdCAocEhAUAgQRHgsIAxkeLAkCBA4DQAgLCgMRB?=
 =?us-ascii?q?AMTGAkWCBAEBgMILw0nCwMFDw0BBgMGAgUFAQMgAxQDBSQHAyEPJg0NBBsHH?=
 =?us-ascii?q?QMDBSUDAgIbBwICAwIGFQYCAhhWLg0IBAgEGB8kDwUCBy8FBC8CHgQFBhEIA?=
 =?us-ascii?q?hYCBgQFAgQEFgIQCAIIJxcHExgbGQEFMicQCSEWBgofCgYFBhYDI0gmBQo7D?=
 =?us-ascii?q?yg0NjwsHxsKgRosCSIWAwQEAwIGHAMDJQISLQYMBiMbAptGCIEhEgaCMZVtj?=
 =?us-ascii?q?EGeazQHghSBPYFEDIlRlGAGEy2WVg4GkXotlU51II0Qmg6Bd4F/MxokgzdOA?=
 =?us-ascii?q?QIBAg0BAgIDAQIBAgkBAQKOHQwNCRWDboRhhUw/NAIBCDACBgsBAQMJhUcBA?=
 =?us-ascii?q?Yk4AQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:dL22NK62ENsEOtrRl8pVuAxRtBXBchMFZxGqfqrLsTDasY5as4F+v
 jdODG2BaPqDMWD8ct52aI7l80sBuJfQyIRlTFQ/rnowZn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOK6UoYoAwgpLeNeYH5JZSlLxqho2OaEvfDjW1nX4
 Y2o/pWEULOY82cc3lw8u/rrRCxH56yaVAMw5jTSstgW1LN2vyB94KM3fcldHVOgKmVnNrLSq
 9L48V2M1jixEyHBpT+Suu2TnkUiGtY+NOUV45Zcc/DKbhNq/kTe3kunXRYRQR8/ttmHozx+4
 NsdjY6iey0gBZHnib0nFAFIKn1MbLITrdcrIVDn2SCS50jBbmeq3PhkSk07VWEa0rwuWycUr
 6NecW1LNXhvhMruqF6/YsxlnMc+N4/GOI0Fu3dv5S7UB7AqTPgvRo2TuoAGhmxp16iiG976P
 /cocQdkbi3+PTpzHkcrK7E3kva30yyXnzpw8Q/J+/NuvQA/1jdZ27/mO9v9Yc2PXcwTn0CCp
 2uA8X6RKhUTK9WbzRKX83emnOaJnCXhWYtUGqfQyxJxqFiU23BVFxAcE1e2yRWktqKgc9wPE
 14GyAAnlpQZ5RWRCcHtZkGK8WHR63bwROFsO+E97QiMzI/d7ACYGnUIQ1Z9hDoO65ZeqdsCi
 Qbhoj/5OdB8mOHEESrGrd94uRviZXJKcQfucAdZFVNt3jX1nG0kpj7iJjqJOI28lNnuAyzwz
 lhmRwBh2exI0qbnO42R9FzKhXeTDUzTUhI44w/aRG3N0++UTIuiepDu9lXRq/pNRGp4crVjl
 Cha8yR9xLlfZX1oqMBraLtUdF1Oz6jcWAAweXY1Q/EcG82FohZPh7x47jBkP1tOOc0ZYzLva
 0K7kVoPucELbSb2NvcmMt3Z5yEWIU7ISoSNuhf8MYomX3SNXFPflM2TTRPMjj62yiDAb4llY
 MbHLK5A8kr2+Yw+kWboHr5DuVPa7nlwnCvSQ4z21RKqzfKXaxaopUQtYDOzghQCxPrc+m39q
 o4BX+PTkkk3eLCgPkH/rNBCRXhXfCBTLc2n8KR/K7/TSiI4Qj1JI6GKm9sJJdc695m5Y8+To
 xlRrGcDlAGg7ZAGQC3WAk1ehETHAcsj9C9rYXZ0VbtqslB6CbuSAG4kX8NfVdEaGCZLlJaYl
 tEJJJeNBOphUDPC92hPZJXxttIwaxmhww6DZnL3bD86dp9mZgrI5t69IlqxrnZTVHLvuJtsu
 aCk2yPaXYEHGVZoAvHWX/TznVm/in4QxbBpVEzSL9gPI0jhqdA4KyH4gvItDdsLLBHPmmmT2
 wqMX0UHqOOLr4JsqIvFgqWNroGIFepiHxMGTjeBsuvsbXHXpzPxz5VBXeCEeSHmeFn1oKjyN
 /9Iy/zcMeEcmAgYuYRLE4FtkfA06ezpquII1Q9jBnjKMw+mB748cHmL2c5D6v9EyrND4FLkX
 0WS5p9FNL/PNM68SAwdIw8sb+Ki0/AIm2COvKpvfxigvHd6rOidTEFfHxiQkygDfrF7B4MSx
 7tzssAh7QHi2AEhNcyLj3wP+mnQfGYMVb4r6sMTDIPx01N5z1ZffdrDByWw7JzWM4dANUwjI
 zm1gqvehu0AlxSYLCdpTSDAjbhHmJADmBFW11tcdV6HrdrygKNl1hNm9zlqHB9eyQ9K0r4oN
 2VmX6GvyX5iI9u1aAl/s2GQ98VpARqE5gruxlFPmGCxo4xEkIDSBDVVBApP1BlxH6Fgkvxz4
 7ySjmroOdovVN+kxTM8ACaJtNS6JeGcNWT+dASPAMmPWZU3CdYgbmlCekJQwyba7QgNaIEra
 AWkECucqUE2CMLIn5AGNg==
IronPort-HdrOrdr: A9a23:FbUmKqqwQe6onpbSOhVeGb4aV5oPeYIsimQD101hICG9vPbo8P
 xG785rtiMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW3bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaGSS5vyb3ODXKadD/DDKysGVbfy19QYXceiGUdAb0+9BYDzrb3Gfz2R9b6YEKA
 ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,222,1650924000"; 
   d="scan'208";a="17762319"
X-MGA-submission: =?us-ascii?q?MDE89LogsQXu4USeA664TBTGb6jMtzfra0aF0/?=
 =?us-ascii?q?VLYByYIzmSTOQug/GRIcg1VjX40BiQEC8FE3uLXeBD3X77bIO3LY0Ah7?=
 =?us-ascii?q?oRO4RTg5iDqmiZZrYSJp15BooTxs0pdwaR3lTdI+AzmBErSU/Ms06yho?=
 =?us-ascii?q?0zIaClA++Nq0wV1H2ujmV1UQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 18:56:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1656176151;
	bh=5zm5ZhZc1Yr/AUlntFaGWHV74pC5dxFA2idv0aTQypk=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
	b=myI1Rq4nHRCNrnEC+mdtapm3FkR7ZiRN2eOGQpZNXIpEJjb+NDovbww6HWclxuIw/
	 XW9I5P01oFmgX94pcp6AZxMdsXRxRFEzpkLDBr/1Mn92Ef568f5D8H1QrMduJvCpJJ
	 txv4aPV9UYChMdSNfZfU9d4y31bcxYA0tNUYHKKY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([78.48.100.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5UkQ-1nc8rt05SU-016mQb; Sat, 25
 Jun 2022 18:55:51 +0200
Message-ID: <32da2d32-9554-de90-62ca-c4be456ad31a@web.de>
Date: Sat, 25 Jun 2022 18:55:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-GB
To: Ziyang Xuan <william.xuanziyang@huawei.com>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
References: <20220616013253.520310-1-william.xuanziyang@huawei.com>
From: Markus Elfring <Markus.Elfring@web.de>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, Fabian Frederick <fabf@skynet.be>,
 Yajun Deng <yajun.deng@linux.dev>, "David S. Miller" <davem@davemloft.net>,
 Phil Edworthy <phil.edworthy@renesas.com>
In-Reply-To: <20220616013253.520310-1-william.xuanziyang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:jX8+siHPTB4vf2gstqCcEFC2nfclF3zeXbFXuPbsiZ4d/GFcSpn
 lVtxwTymiDHenD5SCNZLIOmNPhqRY7YHMRjxH2GRnaIcRBRbFs0JKu3cVUD2y6lZ8agP9+g
 HY8RsxvDP5okXL+Gw9I2K6C3/TxsYzAhByopplXgw7pOb9oxLNIkSP7LpMjrxLG9qwc7SZl
 BAkNgxnj+b2qv7RP2p44A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sjLEVBv+F2g=:ag5TT+eIQSaw69LehGqSU7
 vy6vwphlb4WIlDYg6oOkS188xx70YknSkw8uQWiFDgaxkFmju9Sdy3NXc4dQPExsHbHV0DGwL
 Szp8Hpib0oFRRT1qVKuZ1KJ8ovg8do3XuNyC5F+1lJhsmUsitSTROVNElnRW/zeHNAIi+ezqK
 tWpcBBeBqG3rR9fgR2Z/e2hGoe09nbxlDDnzMzKIl/FgKbSh8iN1ivVcMUfaECCjmjd/DTOKs
 g42agoTsD39eF0FzZMEhbfFer7AyqAP9D34tJ3bRMTOx0dOTNQAqbvTIkS3wuhrIJu0C52NOf
 hELHRAiJU14dCmMw+Jg751azewmY7At/u2QgXbL74HenwmP4kZ1HpEMSDsFhLAnp4DhoS4xbz
 8Dv6GCwvwn4f0mUFzihfgCBt8DG2cnB5XNtJBKIPvcHknIw0EFkJ5b7YYiR8yUQ5f+IH+iRAx
 KSzO/oZwxC0GrgPHe5atbtZpYymzbP2MSzppe7Hfcty5hTN10B53sSo9NuYljvhBmS0SdFsiu
 yGXKSF0pALCmCnroQBKC8R7A1BFJy5MJAPjtAPeZ0tXuJU+CKP6sT/9ieNP5A7ayXSlYO5YUZ
 1Jtgb8XYVud0zJeBfWNt0k5LjBHNvK8iTUUmgSfK0jhI1B73DLv3xSlWRQEylJFLImAvTdPD2
 VO438g+4kpxSWIqu7dP2/3mOUhzTPM2bFOED6jVpXjG6EkheszVXUyzQtQb1SolZAlVm9eDaT
 F3O3YWS9aYbj4lY6hVS0Hc+g0k23e+roBz6yDLPCVHY/uUt3e2Rojrlu1YQSJp8m1TzvPSTqv
 n+0gX5OCrbUws4Met8lRh85zvth5RLNiz3/RKVI326HJUjHx2Dbzh3B9NXr2y7Z6eN8cXXt/K
 H+tGls7y67uRdKX69tQ1YPx8qXyKzT/9fxAUG11gGOCPwetoCmuZxPqt+xQ4mqvHXJcVgghRU
 HGH6KuEn3JE3OMfuOgc5+mLs2sWvimD88Zt7ZyH8d/f1HscJhpbfDJzIVWgijx7fzCC1XVbmH
 uzU7fkclBrfnyAT6bwpNk0VgLpI0uuZAwj0x8H6G66Sif1IaWH6tjr0mW+z1Irq62S/NUg9/H
 1wg+CJ4TXyzNWWzf9GIypHSvPmPTn0i5OSDXDvqiqaOHy8t0wm06rvyNw==
Subject: Re: [cocci] [PATCH] scripts/coccinelle/free: add NULL test before
 dev_{put, hold} functions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 458
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/32da2d32-9554-de90-62ca-c4be456ad31a%40web.de>

I find the patch subject improvable.
You would like to detect the remaining usage of redundant null pointer checks
before selected function calls.
Thus it would be nice if the corresponding description can become clearer
another bit, wouldn't it?


> Since commit b37a46683739 ("netdevice: add the case if dev is NULL"),
> NULL check before dev_{put, hold} functions is not needed.
>
> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
> ---
>  scripts/coccinelle/free/ifnulldev_put.cocci | 54 +++++++++++++++++++++


How do you think about to achieve further collateral evolution?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b37a466837393af72fe8bcb8f1436410f3f173f3

Will it become feasible to combine any more source code analysis approaches?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/coccinelle/free/ifnullfree.cocci?id=8c23f235a6a8ae43abea215812eb9d8cf4dd165e#n2


> +// Comments: -


Can such a line be omitted?



> +@r2 depends on patch@
> +expression E;
> +@@
> +- if (E != NULL)
> +(
> +  __dev_put(E);
> +|
> +  dev_put(E);
> +|
> +  dev_put_track(E, ...);
> +|
> +  __dev_hold(E);
> +|
> +  dev_hold(E);
> +|
> +  dev_hold_track(E, ...);
> +)


Did you order the case distinctions in the SmPL disjunction according to
the call frequencies of the mentioned function names?

Otherwise, I imagine that another software design option can be considered for
the application of nested disjunctions by the means of the semantic patch language.

Code variant:

@r2 depends on patch@
expression E;
@@
-if (E != NULL)
(
(__dev_put
|dev_put
|__dev_hold
|dev_hold
)(E)
|
(dev_put_track
|dev_hold_track
)(E, ...)
)
;


Regards,
Markus

